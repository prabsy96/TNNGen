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
from MNIST_tb import *

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
            if lt not in ['TNN', 'CV', 'Simple', "Place_Cell"]:
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
            # model_name = f"model_{nodestr}_{lt}_{str(synapse_cnt)}"
            # myModel = Model(model_name)

            # Default
            #myModel.add(Layer(layer_type=lt, num_col=nc, num_neurons=nn, num_dend=nd, p_dist=pd, p_prox=pp, num_seg=ns, wres_dist=wd, wres_prox=wp, thres=th, tnn7_en=en_tnn7))

            #--------------------------------------------#
            # Multi-layer simple column MNIST benchmarks #
            #--------------------------------------------#

            # Multi-layer full
            # model_name = f"model_multi_layer_MNIST_full"
            # myModel = Model(model_name)

            # myModel.add(Layer(layer_type="Kernel", rfsize=3, stride=1, nprev=2, inputsize=28, if_corner=True, tnn7_en=en_tnn7))
            # myModel.add(Layer(layer_type="Simple", num_col=676, num_neurons=12, p_dist=8, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            
            # myModel.add(Layer(layer_type="Kernel", rfsize=3, stride=1, nprev=12, inputsize=26, if_corner=True, tnn7_en=en_tnn7))
            # myModel.add(Layer(layer_type="Simple", num_col=576, num_neurons=20, p_dist=48, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            
            # myModel.add(Layer(layer_type="Kernel", rfsize=3, stride=1, nprev=20, inputsize=24, if_corner=True, tnn7_en=en_tnn7))
            # myModel.add(Layer(layer_type="Simple", num_col=484, num_neurons=32, p_dist=80, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # L3 Voter
            # myModel.add(Layer(layer_type="Simple", num_col=484, num_neurons=10, p_dist=32, wres_dist=wd, thres=th, tnn7_en=en_tnn7))

            # Multi-layer reduced size
            # model_name = f"model_multi_layer_MNIST_reduced"
            # myModel = Model(model_name)

            # myModel.add(Layer(layer_type="Kernel", rfsize=3, stride=1, nprev=2, inputsize=7, if_corner=True, tnn7_en=en_tnn7))
            # myModel.add(Layer(layer_type="Simple", num_col=25, num_neurons=12, p_dist=8, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            
            # myModel.add(Layer(layer_type="Kernel", rfsize=3, stride=1, nprev=12, inputsize=5, if_corner=True, tnn7_en=en_tnn7))
            # myModel.add(Layer(layer_type="Simple", num_col=9, num_neurons=20, p_dist=48, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            
            # myModel.add(Layer(layer_type="Kernel", rfsize=3, stride=1, nprev=20, inputsize=3, if_corner=True, tnn7_en=en_tnn7))
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=32, p_dist=80, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # L3 Voter
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=10, p_dist=32, wres_dist=wd, thres=th, tnn7_en=en_tnn7))

            #--------------------------------------------#
            # Active dendrite MNIST benchmarks (CV)      #
            #--------------------------------------------#

            # CV full
            # model_name = f"model_CV_MNIST_full"
            # myModel = Model(model_name)
            # myModel.add(Layer(layer_type="CV", num_col=576, num_neurons=10, num_dend=1, p_dist=18, p_prox=1, num_seg=24, wres_dist=wd, wres_prox=wp, thres=th, tnn7_en=en_tnn7, prox_as_enable=True))

            # CV reduced size
            # model_name = f"model_CV_MNIST_reduced"
            # myModel = Model(model_name)
            #myModel.add(Layer(layer_type="CV", num_col=2, num_neurons=10, num_dend=1, p_dist=18, p_prox=1, num_seg=24, wres_dist=wd, wres_prox=wp, thres=th, tnn7_en=en_tnn7, prox_as_enable=True))

            #--------------------------------------------#
            # Place cell benchmark #
            #--------------------------------------------#

            # Configure in layer.py
            # model_name = f"model_place_cell"
            # myModel = Model(model_name)
            # myModel.add(Layer(layer_type="Place_Cell", tnn7_en=en_tnn7))

            #--------------------------------------------#
            # UCR benchmark                              #
            #--------------------------------------------#
            # model_name = f"model_UCR"
            # myModel = Model(model_name)
            # # 65x2
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=2, p_dist=65, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # 96x2
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=2, p_dist=96, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # 152x2
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=2, p_dist=152, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # 343x2
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=2, p_dist=343, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # 637x2
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=2, p_dist=637, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # 470x5
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=5, p_dist=470, wres_dist=wd, thres=th, tnn7_en=en_tnn7))
            # # 270x25
            # myModel.add(Layer(layer_type="Simple", num_col=1, num_neurons=25, p_dist=270, wres_dist=wd, thres=th, tnn7_en=en_tnn7))


            #--------------------------------------------#
            # Spike sorting                              #
            #--------------------------------------------#
            model_name = f"model_spike_sorting"
            myModel = Model(model_name)
            myModel.add(Layer(layer_type="CV", num_col=1, num_neurons=1, num_dend=1, p_dist=34, p_prox=1, num_seg=13, wres_dist=wd, thres=th, tnn7_en=en_tnn7, prox_as_enable=True))

            
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
    
            if module_name == 'dendrite':
                print("Simulation for active dendrite has not been supported")
                return
            else:
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

        wave = convert_int(args, 'wave')
        inputsize = convert_int(args, 'inputsize')
        rfsize = convert_int(args, 'rfsize')
        stride = convert_int(args, 'stride')
        nprev = convert_int(args, 'nprev')
        neurons = convert_int(args, 'neurons')
        thres = convert_int(args, 'theta')
        tres = convert_int(args, 'tres')
        wres = convert_int(args, 'wres')
        ucapture = convert_int(args, 'ucapture')
        usearch = convert_int(args, 'usearch')
        ubackoff = convert_int(args, 'ubackoff')
        umin = convert_int(args, 'umin')

        MNIST_multi_column(inputsize=inputsize, rfsize=rfsize, stride=stride, nprev=nprev, num_neuron=neurons, num_synapse=int(nprev*(rfsize**2)), thres=thres, tres=tres, wres=wres, wave=wave, ucapture=ucapture, usearch=usearch, ubackoff=ubackoff, umin=umin, extra_delay=8, verbose=False)
        obj = Test_Layers.Tb_Simple(num_col=int(((inputsize-rfsize)/stride + 1)**2), num_neurons=neurons, num_synapse=int(nprev*(rfsize**2)), tres=tres, wres=wres, thres=thres, extra_delay=8)
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

