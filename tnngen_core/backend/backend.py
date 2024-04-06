from veriloggen import *
import os
import pathlib
import subprocess
import sys
import shlex

class sim_support:
    
  def __init__(self, file=None):
  # sim_out: folder to store the resulting sim executables
  # file: filename of testbench .v file to be simulate
    if file is None:
      raise ValueError("Arg .v file not provided")
    elif isinstance(file, str) is False:
      raise TypeError("Arg .v file needs to be of type %s")
    else:
      self.file = file
 

  def run_xrun (self, nospecify='yes', timescale='1ns/1ps'):
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

#   def simvision(self):
#       cmd = []
#       cmd.append('simvision')
#       if sys.maxsize > 2**32:
#           cmd.append('-64BIT')
#       cmd = ' '.join(cmd)
#       proc = subprocess.Popen(cmd, shell = True, cwd = './sim_out', stdout = subprocess.PIPE)
#       proc.wait()
#       proc.stdout.close()

class synth_support:
	
  def __init__(self, mname, obj, aclk_freq, rtl_path, gclk_freq):
    self.mname = mname
    self.obj = obj
    self.aclk_freq  = aclk_freq
    self.gclk_freq = gclk_freq
    self.rtl_path = rtl_path
    
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
    files = cwd+'/templates/syn.tcl'
    if (self.mname == 'dendrite'):
        files = cwd+'/templates/syn_dendrite.tcl'
    work_path = cwd+'/syn_out'
    lib_path = cwd+'/lib/'
    lef_path = cwd+'/lef/'

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
    cmd.append("\"set HOME_DIR")
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
    cmd.append("; set RTL_PATH")
    cmd.append(str(self.rtl_path)+"\"")
    cmd.append(" -f ")
    cmd.append(files)
    cmd = ' '.join(cmd)
    print(cmd)
    subprocess.run(cmd, shell=True)
    
    netlist_path = os.path.join(work_path, self.obj.name, "out", self.obj.name+"_m.v")
    
    return netlist_path

def gen_verilog(module = None, path = None, filename = None):

	if module is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(module, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	if path is None and filename is None:
		path = 'RTL'
		filename = 'default.v'
	else:
		if path is None:
			path = 'out_rtl'
		if filename is None:
			filename = 'default.v'
		if isinstance(path, str) is False:
			raise TypeError("Path name is required as string r'%s.")
		elif isinstance(filename, str) is False:
			raise TypeError("File name is required as string r'%s.")
		else:
			if not os.path.exists(path):
				os.mkdir(path)
			mod_v = module.to_verilog(path+'/'+filename)

	gen_file = str(pathlib.Path.cwd())+'/'+path+'/'+filename

	return (gen_file), os.getcwd()+"/"+path

def sim_verilog(obj = None, sim_name = 'simvision', wave = None):

	if obj is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(obj, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

#     if sim_name == 'iverilog':
#         # using veriloggen iverilog support
#         sim = simulation.Simulator(obj, sim = 'iverilog')
#         rslt = sim.run(display = True) 
#         print(rslt)
#         console.print("[bold blue]  -> Simulation dump completed")

#         if wave == 'yes':
#             sim.view_waveform()

#     elif sim_name == 'vcs':
#         #sim = simulation.run_vcs(obj, True)
#         sim = run_sim()
#         print(sim) 

# 		if wave == 'yes':
# 			cmd = []
# 			subprocess.call(shlex.split('dve &'))

	if wave == 'yes':
		subprocess.call(shlex.split('simvision &'))

	return sim

def text_parser(file):

	content_dic = {}
	num = 0
	with open(file) as f:
	    
	    while True:
	        line = f.readline()
	        if line.strip(): 
	            content_dic[num] = line
	            num = num+1
	        if not line:
	            break
	        
	arg = []
	for i in content_dic:
	    if content_dic[i][0] != '#':
	        arg.append(content_dic[i])

	params = {}
	new = arg[0].split()
	for i in range(len(arg)):
	    temp = arg[i].split()
	    for j in range(len(temp)):
	        if temp[j] == '#':
	            break
	        else:
	            if j != 0:
	                if temp[j] != '=':
	                    new_temp= temp[j]
	    params[temp[0]] = new_temp

	return params

class pnr_support:

  def __init__(self, obj, aclk_freq, gclk_freq, netlist_path):
    self.obj = obj
    self.aclk_freq = aclk_freq
    self.gclk_freq = gclk_freq
    self.netlist_path = netlist_path
    
  def gen_innovus_tcl(self):
  	
    os.chdir("../")
    cwd = os.getcwd()
    files = cwd+'/templates/pnr.tcl'
    work_path = cwd+'/pnr_out'
    lib_path = cwd+'/lib/'
    lef_path = cwd+'/lef/'
    
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
    
    cmd.append("\"set HOME_DIR")
    cmd.append(str(cwd))

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
    
    cmd.append("; set RTL_PATH")
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
