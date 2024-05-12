# Backend support functions
# Authors: Prabhu Vellaisamy, Harideep Nair
# Last modified by: YoungSeok Na

from veriloggen import *
from .tcltemplate import *
import os
import pathlib
import subprocess
import sys
import shlex
import json

#################################################
# Generic functions
#################################################
# args.txt file parser
def text_parser(fname):
    arg = []
    with open(fname, 'r') as f:
        while True:
            line = f.readline()
            if line.strip():
                stline = line.strip()
                if stline[0] != '#':
                    arg.append(stline)
            if not line:
                break

    params = {}
    for elem in arg:
        assign = elem.split('=')
        if len(assign) != 2:
            err_str = f"Malformed line detected in config: \"{elem}\""
            raise ValueError(err_str)
        k = assign[0].strip()
        v = assign[1].split('#')[0].strip()
        params[k] = v

    return params

# Divide the contents of args to appropriate dictionary
def args_divide(args):
    # Verifying the assigned values
    checker = {}
    with open(f'{os.getcwd()}/backend/argcheck.json', 'r') as f:
        checker = json.load(f)

    sim_dict, syn_dict = {}, {}
    for k, v in args.items():
        # Key must be a valid option
        if k not in checker["options"]:
            err_str = f"Item {k} is not one of the available options"
            raise ValueError(err_str)

        # Switch must be on/off
        if (k == "sim_switch") or (k == "syn_switch"):
            if v not in checker["switch_modes"]:
                err_str = "Switch modes must be \"on\" or \"off\""
                raise ValueError(err_str)

        # Divide up appropriately
        if k in checker["common_param"]:
            sim_dict[k] = v
            syn_dict[k] = v
        elif k in checker["sim_only"]:
            sim_dict[k] = v
        elif k in checker["syn_only"]:
            syn_dict[k] = v

    # Check mutual exclusivity of switches
    # - after iterating to ensure that on/off check is performed first
    if (args["sim_switch"] == "on") and (args["syn_switch"] == "on"):
        err_str = "SIM and SYN are mutually exclusive. Change one of them to \"off\""
        raise ValueError(err_str)

    return sim_dict, syn_dict

# Generate verilog file
# - module: veriloggen module
# - path: path to store the outputted verilog to (default - out_rtl)
# - filename: name of the file
def gen_verilog(module=None, path=None, filename=None):
    if module is None:
        raise ValueError("Module is required.")
    else:
        if not isinstance(module, Module):
            raise TypeError("Object is not of type Veriloggen.Module")

    if path is None:
        path = 'out_rtl'
    else:
        if not isinstance(path, str):
            raise TypeError("Path name is required as string.")

    if filename is None:
        filename = 'default.v'
    else:
        if not isinstance(filename, str):
            raise TypeError("File name is required as string.")

    if not os.path.exists(path):
        os.mkdir(path)
    mod_v = module.to_verilog(path+'/'+filename)

    gen_file = str(pathlib.Path.cwd())+'/'+path+'/'+filename

    return gen_file, (os.getcwd()+"/"+path)

# Functional simulation of verilog
def sim_verilog(obj=None, sim_name='simvision', wave=None):
    if obj is None:
        raise ValueError("Module is required.")

    if not isinstance(obj, Module):
        raise TypeError("Object is not of type Veriloggen.Module")

    #if sim_name == 'iverilog':
    #    # using veriloggen iverilog support
    #    sim = simulation.Simulator(obj, sim = 'iverilog')
    #    rslt = sim.run(display = True) 
    #    print(rslt)
    #    console.print("[bold blue]  -> Simulation dump completed")
    #    if wave == 'yes':
    #        sim.view_waveform()

    #elif sim_name == 'vcs':
    #    #sim = simulation.run_vcs(obj, True)
    #    sim = run_sim()
    #    print(sim) 
    #    if wave == 'yes':
    #        cmd = []
    #        subprocess.call(shlex.split('dve &'))

    #   cmd = []
    #   cmd.append('/afs/ece.cmu.edu/support/cds/share/image/usr/cds/xcelium-23.09/tools.lnx86/simvision/bin/simvision.exe')
    #   if sys.maxsize > 2**32:
    #       cmd.append('-64BIT')
    #   cmd = ' '.join(cmd)
    #   proc = subprocess.Popen(cmd, shell = True, cwd = './sim_out', stdout = subprocess.PIPE)
    #   proc.wait()
    #   proc.stdout.close()

    if wave == 'yes':
        subprocess.call(shlex.split('simvision &'))
    return sim

#################################################
# HW Simulation
#################################################
class sim_support:
    def __init__(self, file=None):
        # sim_out: folder to store the resulting sim executables
        # file: filename of testbench .v file to be simulate
        if file is None:
            raise ValueError("Arg .v file not provided")

        if not isinstance(file, str):
            raise TypeError("Arg .v file needs to be of type %s")

        self.file = file

    def run_xrun(self, nospecify='yes', timescale='1ns/1ps'):
        # check if sim_out exists already
        if not os.path.exists('./sim_out'):
            os.makedirs('./sim_out')

        cmd = []
        cmd.append('/afs/ece.cmu.edu/support/cds/share/image/usr/cds/xcelium-23.09/tools.lnx86/bin/xrun')
        cmd.append('-clean')
        if nospecify == 'yes':
            cmd.append('-nospecify')
        cmd.append('-timescale '+timescale)
        cmd.append('-mess')
        cmd.append('-access +rwc')
        cmd.append(self.file)

        cmd = ' '.join(cmd)
        print(cmd)

        proc = subprocess.Popen(cmd, shell = True, cwd = './sim_out', stdout=subprocess.PIPE)
        dis = []

        while True:
            data = proc.stdout.readline()
            out = data.decode(sys.getdefaultencoding())
            dis.append(out)
            print(out, end = '')
            if not data:
                break

        proc.wait()
        proc.stdout.close()
        dis = ''.join(dis)
        return dis

    def run_vcs(self):
        raise ValueError("Not yet supported")

#################################################
# Synthesis
#################################################
class synth_support:
    def __init__(self, mname, obj, aclk_freq, rtl_path, gclk_freq, node):
        self.mname = mname
        self.obj = obj
        self.aclk_freq  = aclk_freq
        self.gclk_freq = gclk_freq
        self.rtl_path = rtl_path
        self.node = node

        if os.path.isdir(rtl_path) is False:
          raise FileNotFoundError('rtl_path does not exist')
        
        # Add all libraries in the library folder
        # self.lib_string = ''
        # lib_list = os.listdir(self.lib_path)

        # for lib in lib_list:
        #   self.lib_string = self.lib_string + self.lib_path + '/' + lib + ' '

        # self.lef_string = ''
        # lef_list = os.listdir(self.lef_path)

        # for lef in lef_list:
        #   self.lib_string = self.lef_string + self.lef_path + '/' + lef + ' '

    def gen_genus_tcl(self):
        # Column specific params
        # -------
        # p: # of synapses per output neuron
        # q: # of output neurons
        # thres: threshold value
              
        # Add the following later ----
        # if_clk: clock is rtl?
        # gen_eff: generic effort value (low, medium, high)
        # map_opt_eff: mapping & optimization effort value (low, medium, high)
        # lp_clk_gate: enable clock gating? yes/no
        # lp_power_eff: low power analysis effort value (low, medium, high)
        # max_cpu: maximum # of CPUs per server
        # lec: produce .lec files for conformal checks? (yes/no)
        
        cwd = os.getcwd()

        # Get rid of previously generated tcl
        try:
            os.remove(cwd+'/templates/syn_gen.tcl')
        except OSError:
            pass
        # Generate Tcl
        with open(cwd+'/templates/syn_gen.tcl', 'a') as f:
            f.write(prologue_str)
            if self.node == 45:
                f.write(lib_str_nangate45)
            elif self.node == 7:
                f.write(lib_str_asap7)
            # TODO
            # elif lset == 't7':
            #     f.write(lib_str_tnn7)
            if self.mname == 'column':
                f.write(constraint_column)
            elif self.mname == 'dendrite':
                f.write(constraint_dendrite)
            f.write(epilogue_str)
        files = cwd+'/templates/syn_gen.tcl'

        work_path = cwd+'/syn_out'
        if (self.node == 7):
            lib_path = cwd+'/lib_7/'
            lef_path = cwd+'/lef_7/'
        else:
            lib_path = cwd+'/lib_45/'
            lef_path = cwd+'/lef_45/'

        if not os.path.exists(work_path):
            os.makedirs(work_path)
        os.chdir(work_path)
        
        print("\nInitiating Genus Synthesis")
        print("\n--------------------------")
        cmd = []
        cmd.append("/afs/ece.cmu.edu/support/cds/share/image/usr/cds/genus-20.11/tools.lnx86/bin/genus")
        cmd.append("-del_scale")
        cmd.append(str(10))
        cmd.append("-execute")

        cmd.append("\"set HOME_DIR ")
        cmd.append(str(cwd))

        cmd.append("; set ACLKP ")
        cmd.append(str(self.aclk_freq))

        cmd.append("; set GCLKP ")
        cmd.append(str(self.gclk_freq))

        cmd.append("; set DESIGN ")
        cmd.append(str(self.obj.name))

        cmd.append("; set LIB_PATH ")
        cmd.append(str(lib_path))

        cmd.append("; set LEF_PATH ")
        cmd.append(str(lef_path))

        cmd.append("; set RTL_PATH ")
        cmd.append(str(self.rtl_path)+"\"")

        cmd.append(" -f ")
        cmd.append(files)

        cmd = ' '.join(cmd)
        print(cmd)
        subprocess.run(cmd, shell=True)

        netlist_path = os.path.join(work_path, self.obj.name, "out", self.obj.name+"_m.v")

        return netlist_path

    def gen_dc_tcl(self):
        raise ValueError("Not yet supported")

#################################################
# PNR
#################################################
class pnr_support:
    def __init__(self, obj, aclk_freq, gclk_freq, netlist_path, node):
        self.obj = obj
        self.aclk_freq = aclk_freq
        self.gclk_freq = gclk_freq
        self.netlist_path = netlist_path
        self.node = node

    def gen_innovus_tcl(self):
        os.chdir("../")
        cwd = os.getcwd()
        work_path = cwd+'/pnr_out'

        if self.node == 7:
            files = cwd+'/templates/pnr_7_new.tcl'
            lib_path = cwd+'/lib_7/'
            lef_path = cwd+'/lef_7/'
        else:
            files = cwd+'/templates/pnr_45.tcl'
            lib_path = cwd+'/lib_45/'
            lef_path = cwd+'/lef_45/'

        mmmc_file = os.path.join(cwd, "templates/column-mmmc.tcl")
        m2_file = os.path.join(cwd, "templates/m2followRail.tcl")

        if not os.path.exists(work_path):
            os.makedirs(work_path)
        os.chdir(work_path)

        f = open("cmd.tcl", "w")
        f.write("set HOME_DIR "+str(cwd))
        f.close()

        print("\nInitiating Innovus Layout")
        print("\n--------------------------")

        cmd = []
        cmd.append("/afs/ece.cmu.edu/support/cds/share/image/usr/cds/innovus-21.16/tools.lnx86/bin/innovus")

        cmd.append(" -execute")

        cmd.append("\"set HOME_DIR ")
        cmd.append(str(cwd))

        cmd.append("; set OUT_DIR ")
        cmd.append(str(self.obj.name)+"_pnrout")

        cmd.append("; set ACLKP ")
        cmd.append(str(self.aclk_freq))

        cmd.append("; set GCLKP ")
        cmd.append(str(self.gclk_freq))

        cmd.append("; set DESIGN ")
        cmd.append(str(self.obj.name))

        cmd.append("; set MMMC_FILE ")
        cmd.append(str(mmmc_file))

        cmd.append("; set M2_FILE ")
        cmd.append(str(m2_file))

        cmd.append("; set LIB_PATH ")
        cmd.append(str(lib_path))

        cmd.append("; set LEF_PATH ")
        cmd.append(str(lef_path))

        cmd.append("; set RTL_PATH ")
        cmd.append(str(self.netlist_path)+" \"")

        cmd.append(" -files ")
        cmd.append(files)

        cmd.append(" -no_gui ")
        cmd.append(" -no_cmd ")
        cmd.append(" -overwrite ")
        cmd = ' '.join(cmd)
        print(cmd)
        subprocess.run(cmd, shell=True)

        os.chdir(cwd)

    def gen_primetime_tcl(self):
        raise ValueError("Not yet supported")

