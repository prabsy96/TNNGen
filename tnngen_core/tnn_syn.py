# TNNSyn main framework
# Authors: Prabhu Vellaisamy, Harideep Nair
# Last modified by: YoungSeok Na, Wei-Che Huang

from column import TNN_Col
from layer import Layer
from submodule import *
from backend.backend import * 
import argparse
import os
from rich.console import Console
from tnn_mdls.func_mdls import *
from tnn_mdls.tb_func_mdls import *
import time
from model import Model
from layer_tb import Test_Layers

FLOW = ('rtl', 'sim', 'syn', 'pnr')
TOOL = ('Synopsys', 'Cadence')
NODE = (45, 7, 77)

# Try converting a parameter to an int. Handle errors appropriately
def convert_int(args, vid):
    try:
        return int(args[vid])
    except:
        err_str = f"Value of {vid} must be provided in integer format"
        raise TypeError(err_str)

# Main procedure
def tnn_syn(module_name, submodule_name, layer_name, args):
    console = Console()
    console.print("[bold magenta]   --> Starting TNN Syn!")

    # Flow specification check
    flow = args['flow']
    if isinstance(flow, str) is False:
        raise TypeError('Incorrect format; provide in %s format')
    if flow not in FLOW:
        raise ValueError('Incorrect flow name')

    # Tool check
    tool = args['tool']
    if not isinstance(tool, str):
        raise TypeError('Incorrect format; provide in %s format')
    if tool not in TOOL:
        raise ValueError('Unsupported tool - choose from Synopsys or Cadence')

    # Node specification check
    node = int(args['node'])
    if node not in NODE:
        raise ValueError('Unsupported node - must be 45, 7, or 77 (ASAP7+TNN7)')
    nodestr = ''
    if node == 45:
        nodestr = 'n45'
    elif node == 7:
        nodestr = 'a7'
    elif node == 77:
        nodestr = 't7'
    en_tnn7 = (node == 77)

    # Get clk frequencies if synthesis or PNR
    if flow  == 'syn' or flow == 'pnr': 
        aclk_freq = args['aclk_freq']
        gclk_freq = args['gclk_freq']	

    # Large modules
    if module_name != None:
        # Column
        if module_name == 'column':
            # Default parameter values
            p, q, theta, wres = 18, 8, 6, 3

            # Parameter parsing
            rf = convert_int(args['rfsize'], 'rfsize')
            np = convert_int(args['nprev'], 'nprev')
            p = rf * rf * np
            console.print("[bold blue]  -> Selected # Synapses per Neuron: "+str(p))

            q = convert_int(args['neurons'], 'neurons')
            console.print("[bold blue]  -> Selected # of Neurons: "+str(q))

            theta = convert_int(args['theta'], 'theta')
            console.print("[bold blue]  -> Selected threshold value: "+str(theta))

            wres = convert_int(args['wres'], 'wres')

            # generate verilog
            col = TNN_Col(p, q, theta, wres)

        # Active Dendrite
        elif module_name == 'dendrite':
            # Parameter parsing
            lt = args['ltype']
            if lt not in ['TNN', 'CV', 'Simple']:
                raise ValueError("Layer type must be \"TNN\" or \"CV\" for dendrite")
            nc = convert_int(args, 'col_cnt') 
            nn = convert_int(args, 'neuron_cnt')
            nd = convert_int(args, 'dend_cnt')
            ns = convert_int(args, 'segment_cnt')
            pd = convert_int(args, 'p_dist')
            pp = convert_int(args, 'p_prox')
            wd = convert_int(args, 'wres_dist')
            wp = convert_int(args, 'wres_prox')
            th = convert_int(args, 'threshold')

            # generate verilog
            synapse_cnt = (pd + pp) * ns * nn * nc * nd
            model_name = f"model_{nodestr}_{lt}_{str(synapse_cnt)}"
            myModel = Model(model_name)

            myModel.add(Layer(layer_type=lt, num_col=nc, num_neurons=nn, num_dend=nd, p_dist=pd, p_prox=pp, num_seg=ns, wres_dist=wd, wres_prox=wp, thres=th, tnn7_en=en_tnn7))

            myModel.summary()
            myModel.compile()

        # default to column
        else:
          col = TNN_Col(p, q, theta, wres)

        # Generate model objects
        if flow == 'syn' or flow == 'pnr': 
            if module_name == 'dendrite':
                obj = myModel.model
            else:
                obj, clk_name = col.col_v()
        elif flow == 'sim':
            obj = col.col_tb()
        elif flow == 'rtl':
            if module_name == 'dendrite':
                obj = myModel.model
            else:
                obj, clk_name = col.col_v()
    # Submodules
    elif submodule_name != None:
        tnn_sm = TNN_Submod(args)
        if flow == 'sim':
            obj = tnn_sm.sm_testbench(submodule_name)
        else:
            obj, clk_name = tnn_sm.sm_rtl(submodule_name)
    # Layers
    elif layer_name != None:
        obj = Test_Layers.Tb_Simple(num_col=4, num_neurons=4, num_synapse=18, tres=1, wres=3, thres=11, extra_delay=8)
    else:
        raise ValueError('No valid model name to generate RTL for')

    #############################################
    # generate verilog
    #############################################
    # Large modules
    if module_name != None:
        # Column
        if module_name == 'column':
            filename = 'column_'+str(p)+'_'+str(q)+'_'+str(theta)+'.sv'
        # Active Dendrite
        elif module_name == 'dendrite':
            filename = f"{model_name}.v"
    # Submodule
    elif submodule_name != None:
        if flow == 'sim':
            filename = submodule_name+'_tb.sv'
        else:
            filename = submodule_name+'.sv'
    # Layers
    elif layer_name != None:
        filename = layer_name+'_tb'+'.sv'
        module_name = 'simple'
    else:
        raise ValueError('No valid model name to generate RTL for')

    gen_file, rtl_path = gen_verilog(module = obj, filename = filename)
    console.print("\n[bold blue]  -> RTL Generated! \n  -----------------------------------------")

    #############################################
    # run sim
    #############################################
    if flow == FLOW[1]:
        sim = sim_support(file = gen_file)

        if args['tool'] == 'Cadence':
            sim_v = sim.run_xrun()
        elif args['tool'] == 'Synopsys':
            sim_v = sim.run_vcs()
        console.print("\n[bold blue]  -> Simulation Dump Completed \n -----------------------------------------")

    #############################################
    # run synth
    #############################################
    elif flow == FLOW[2]:
        console.print("[bold magenta]   --> Starting TNN Synthesis")
        start_time = time.process_time()
        syn = synth_support(module_name, obj, aclk_freq, rtl_path, gclk_freq, node)

        if args['tool'] == 'Cadence':
            netlist_path = syn.gen_genus_tcl()
        elif args['tool'] == 'Synopsys':
            netlist_path = syn.gen_dc_tcl()

        end_time = time.process_time()
        console.print("[bold magenta]   --> Ending TNN Synthesis!, Total Time: {}".format(end_time - start_time))

    #############################################
    # run synth + PNR
    #############################################
    elif flow == FLOW[3]:
        console.print("[bold magenta]   --> Starting TNN Synthesis")
        start_time = time.process_time()
        syn = synth_support(module_name, obj, aclk_freq, rtl_path, gclk_freq, node)

        if args['tool'] == 'Cadence':
            netlist_path = syn.gen_genus_tcl()
        elif args['tool'] == 'Synopsys':
            netlist_path = syn.gen_dc_tcl()

        end_time = time.process_time()
        console.print("[bold magenta]   --> Ending TNN Synthesis!, Total Time: {}".format(end_time - start_time))

        console.print("[bold magenta]   --> Starting TNN Place And Route!")
        start_time = time.process_time()
        pnr = pnr_support(obj, aclk_freq, gclk_freq, netlist_path, node)

        if args['tool'] == 'Cadence':
            pnr.gen_innovus_tcl()
        elif args['tool'] == 'Synopsys':
            pnr.gen_primetime_tcl()

        end_time = time.process_time()
        console.print("[bold magenta]   --> Ending TNN Place And Route!, Total Time: {}".format(end_time - start_time))

