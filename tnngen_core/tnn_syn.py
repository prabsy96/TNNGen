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

FLOW = ('rtl', 'sim', 'syn', 'pnr')
# TOOL = ('synopsys', 'cadence')
NODE = (45, 7)

def tnn_syn(module_name, submodule_name, args):
    console = Console()
    console.print("[bold magenta]   --> Starting TNN Syn!")

    # Flow specification check
    flow = args['flow']

    if isinstance(flow, str) is False:
        raise TypeError('Incorrect format; provide in %s format')
    if flow not in FLOW:
        raise ValueError('Incorrect flow name')

    # Get clk frequencies if synthesis or PNR
    if flow  == 'syn' or flow == 'pnr': 
        aclk_freq = args['aclk_freq']
        gclk_freq = args['gclk_freq']	

    # Large modules
    if module_name != None:
        # Default parameter values
        p, q, theta, wres = 18, 8, 6, 3

        # generate verilog
        for i in args:
            if i == 'neurons':
                q = int(args[i])
                console.print("[bold blue]  -> Selected # of Neurons: "+str(q))
            elif i == 'rfsize':
                p = int(args[i])*int(args[i])
            elif i == 'theta':
                theta = int(args[i])
                console.print("[bold blue]  -> Selected threshold value: "+str(theta))
            elif i == 'nprev':
                p = int(args[i])*p
                console.print("[bold blue]  -> Selected # Synapses per Neuron: "+str(p))
            elif i == 'wres':
                wres = int(args[i])

        if not isinstance(p, int):
            raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
        if not isinstance(q, int):
            raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
        if not isinstance(theta, int):
            raise TypeError('Invalid type for threshold value; provide in %d format')
        if not isinstance(wres, int):
            raise TypeError('Invalid type for wres value; provide in %d format')

        # Column
        if module_name == 'column':
          col = TNN_Col(p, q, theta, wres)
        # Active Dendrite
        elif module_name == 'dendrite':
            myModel = Model()
            myModel.add(Layer(layer_type="TNN", num_col=2, num_neurons=4, num_dend=2, p_dist=2, p_prox=1, num_seg=3, wres_dist=3, wres_prox=3, thres=6))
            myModel.add(Layer(layer_type="TNN", num_col=1, num_neurons=4, num_dend=1, p_dist=2, p_prox=1, num_seg=1, wres_dist=3, wres_prox=3, thres=6))
            myModel.add(Layer(layer_type="TNN", num_col=1, num_neurons=1, num_dend=1, p_dist=4, p_prox=1, num_seg=1, wres_dist=3, wres_prox=3, thres=6))
            myModel.summary()
            myModel.compile()
          #col = ActiveDendrite(num_col=2, num_neurons=10, num_dend=10, p_dist=18, p_prox=1, num_seg=8, wres_dist=wres, wres_prox=wres, thres=theta)
        # default to column
        else:
          col = TNN_Col(p, q, theta, wres)

        if flow == 'syn' or flow == 'pnr': 
            if module_name == 'dendrite':
                #obj, clk_name = col.CV_Layer()
                obj = myModel.model
            else:
                obj, clk_name = col.col_v()
        elif flow == 'sim':
            obj = col.col_tb()
        elif flow == 'rtl':
            if module_name == 'dendrite':
                #obj, clk_name = col.CV_Layer()
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
            # - TODO: fix parameters later
            #filename = 'dendrite_'+str(p)+'_'+str(q)+'_'+str(theta)+'.v'
            filename = 'model.v'
    # Submodule
    elif submodule_name != None:
        filename = submodule_name+'.sv'
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
        syn = synth_support(module_name, obj, aclk_freq, rtl_path, gclk_freq)
        
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
        syn = synth_support(module_name, obj, aclk_freq, rtl_path, gclk_freq)

        if args['tool'] == 'Cadence':
            netlist_path = syn.gen_genus_tcl()
        elif args['tool'] == 'Synopsys':
            netlist_path = syn.gen_dc_tcl()

        end_time = time.process_time()
        console.print("[bold magenta]   --> Ending TNN Synthesis!, Total Time: {}".format(end_time - start_time))    
    
        console.print("[bold magenta]   --> Starting TNN Place And Route!")
        start_time = time.process_time()
        pnr = pnr_support(obj, aclk_freq, gclk_freq, netlist_path)

        if args['tool'] == 'Cadence':
            pnr.gen_innovus_tcl()
        elif args['tool'] == 'Synopsys':
            pnr.gen_primetime_tcl()

        end_time = time.process_time()
        console.print("[bold magenta]   --> Ending TNN Place And Route!, Total Time: {}".format(end_time - start_time))

