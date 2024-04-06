from column import TNN_Col
from dendrite import ActiveDendrite
# from dendrite_new import ActiveDendrite
from backend.backend import * 
import argparse
import os
from rich.console import Console
from tnn_mdls.func_mdls import *
from tnn_mdls.tb_func_mdls import *
import time

FLOW = ('rtl', 'sim', 'syn', 'pnr')
TOOL = ('synopsys', 'cadence')
NODE = (45, 7)

def tnn_syn(module_name, args):
    console = Console()
    console.print("[bold magenta]   --> Starting TNN Syn!")

    flow = args['flow']

    if isinstance(flow, str) is False:
        raise TypeError('Incorrect format; provide in %s format')
    if flow not in FLOW:
        raise ValueError('Incorrect flow name')

    if flow == 'rtl':
        pass
    elif flow == 'sim':
        tb = 'yes'
    elif flow  == 'syn' or flow == 'pnr': 
        aclk_freq= args['aclk_freq']
        gclk_freq= args['gclk_freq']	
    else:
        raise ValueError('Need flow value to be (rtl, sim, syn, pnr)')

    # initialize objects
    f = TNN_Functions()
    tb_f = Test_TNN_Functions()

    p, q, theta, wres = 4, 3, 6, 3

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
      col = ActiveDendrite(num_neurons=10, num_dend=16, p_dist=p, p_prox=1, q=q, wres_dist=wres, wres_prox=wres, thres=theta)
    # default to column
    else:
      col = TNN_Col(p, q, theta, wres)

    if flow == 'syn' or flow == 'pnr': 
        obj, clk_name = col.Comp_column()
    elif flow == 'sim':
        obj = col.col_tb()
    elif flow == 'rtl':
        obj, clk_name = col.Comp_column()

    """ Commenting out submodule support
    else:
        if top_lvl_mdl == 'less_equal':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Less_equal(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Less_equal()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Less_equal()
                else:
                    obj, clk_name = f.Less_equal(default)

        elif top_lvl_mdl == 'pulse2edge':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Pulse2edge(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Pulse2edge()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Pulse2edge()
            else:
                obj, clk_name = f.Pulse2edge(default)

        elif top_lvl_mdl == 'edge2pulse':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Edge2pulse(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Edge2pulse()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Edge2pulse()
            else:
                obj, clk_name = f.Edge2pulse(default)

        elif top_lvl_mdl == 'adder':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Adder(defaut)
            elif flow == 'sim':
                obj = tb_f.Tb_Adder()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Adder()
            else:
                obj, clk_name = f.Adder(default)

        elif top_lvl_mdl == 'incdec':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Incdec(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Incdec()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Incdec()
            else:
                obj, clk_name = f.Incdec(default)

        elif top_lvl_mdl == 'wta':
            for i in args:
                if i == 'rfsize':
                    q = int(args[i])
                    console.print("[bold blue]  -> Selected # output neurons: "+str(q))

                if flow == 'syn' or flow == 'pnr':
                    obj, clk_name = f.Wta(q)
                elif flow == 'sim':
                    obj = tb_f.Tb_Wta(q)
                else:
                    if tb == 'yes':
                        obj = tb_f.Tb_Wta(q)
                    else:
                        obj, clk_name = f.Wta(q)

        elif top_lvl_mdl == 'flogic':
            for i in args:
                if i == 'wres':
                    wres = int(args[i])

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Flogic(default, wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Flogic()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Flogic()
                else:
                    obj, clk_name = f.Flogic(default, wres)

        elif top_lvl_mdl == 'stdp_case_gen':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Stdp_case_gen()
            elif flow == 'sim':
                obj = tb_f.Tb_Stdp_case_gen()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Stdp_case_gen()
                else:
                    obj, clk_name = f.Stdp_case_gen()

        elif top_lvl_mdl == 'fsm_convert':
            for i in args:
                if i == 'wres':
                    wres = int(args[i])

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Fsm_convert(default,wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Fsm_simple()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Fsm_simple()
                else:
                    obj, clk_name = f.Fsm_convert(default, wres)

        elif top_lvl_mdl == 'fsm_synapse':
            for i in args:
                if i == 'wres':
                wres = int(args[i])

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Fsm_synapse(default, wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Fsm_synapse()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Fsm_synapse()
                else:
                    obj, clk_name = f.Fsm_synapse(default, wres)

        elif top_lvl_mdl == 'stdp':
            for i in args:
                if i == 'wres':
                    wres = int(args[i])

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Stdp(default, wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Stdp()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Stdp()
                else:
                    obj, clk_name = f.Stdp(default, wres)

        elif top_lvl_mdl == 'pac':
            for i in args:
                if i == 'neurons':
                    p = int(args[i])
                    console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
                elif i == 'theta':
                    theta = int(args[i])
                    console.print("[bold blue]  -> Selected threshold value: "+str(theta))

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(theta, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Pac(ip_size = p, thres = theta)
            elif flow == 'sim':
                obj = tb_f.Tb_Pac(ip_size = p, thres = theta)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Pac(ip_size = p, thres = theta)
                else:
                    obj, clk_name = f.Pac(ip_size = p, thres = theta)

        elif top_lvl_mdl == 'neuron_body':			
            for i in args:
                if i == 'neurons':
                    p = int(args[i])
                    console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
                elif i == 'theta':
                    theta = int(args[i])
                    console.print("[bold blue]  -> Selected threshold value: "+str(theta))
                elif i == 'wres':
                    wres = int(args[i])

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(theta, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Neuronbody(ip_size = p, thres = theta, wres = wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Neuronbody(ip_size = p, thres = theta)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Neuronbody(ip_size = p, thres = theta)
                else:
                    obj, clk_name = f.Neuronbody(ip_size = p, thres = theta, wres = wres)

    elif top_lvl_mdl == 'neuron_rnl_ptt':
        for i in args:
            if i == 'neurons':
                p = int(args[i])
                console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
            elif i == 'theta':
                theta = int(args[i])
                console.print("[bold blue]  -> Selected threshold value: "+str(theta))
            elif i == 'wres':
                wres = int(args[i])

        if not isinstance(p, int):
            raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

        if not isinstance(theta, int):
            raise TypeError('Invalid type for threshold value; provide in %d format')

        if not isinstance(wres, int):
            raise TypeError('Invalid type for wres value; provide in %d format')

        if flow == 'syn' or flow == 'pnr':
            obj, clk_name = f.NeuronRNL(ip_size = p, thres = theta, wres = wres)
        elif flow == 'sim':
            obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = theta)
        else:
            if tb == 'yes':
                obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = theta)
            else:
                obj, clk_name = f.NeuronRNL(ip_size = p, thres = theta, wres = wres)

    """	
    # generate verilog

    # Column
    if module_name == 'column':
        filename = 'column_'+str(p)+'_'+str(q)+'_'+str(theta)+'.v'
    # Active Dendrite
    elif module_name == 'dendrite':
        # - TODO: fix parameters later
        #filename = 'dendrite_'+str(p)+'_'+str(q)+'_'+str(theta)+'.v'
        filename = 'comp_column.v'
    # default to column
    else:
        filename = 'column_'+str(p)+'_'+str(q)+'_'+str(theta)+'.v'

    gen_file, rtl_path = gen_verilog(module = obj, filename = filename)
    console.print("\n[bold blue]  -> RTL Generated! \n  -----------------------------------------")

    # run sim
    if flow == FLOW[1]:
        # sim = sim_support(file = gen_file, args['tool'])
        sim = sim_support(file = gen_file)
        
        if args['tool'] == 'cadence':
          sim_v = sim.run_xrun()
          console.print("\n[bold blue]  -> Simulation Dump Completed \n -----------------------------------------")
        elif args['tool'] == 'synopsys':
          sim_v = sim.run_vcs()
          console.print("\n[bold blue]  -> Simulation Dump Completed \n -----------------------------------------")

    # synth
    elif flow == FLOW[2]:
        console.print("[bold magenta]   --> Starting TNN Synthesis")

        start_time = time.process_time()

        # syn = synth_support(obj, aclk_freq, rtl_path, gclk_freq, lib_path, lef_path, qrc_file, cap_file)
        syn = synth_support(module_name, obj, aclk_freq, rtl_path, gclk_freq)
        
        if args['tool'] == 'Cadence':
          netlist_path = syn.gen_genus_tcl()
        elif args['tool'] == 'synopsys':
          netlist_path = syn.gen_dc_tcl()
          
        end_time = time.process_time()

        console.print("[bold magenta]   --> Ending TNN Synthesis!, Total Time: {}".format(end_time - start_time))

    elif flow == FLOW[3]:
        
        console.print("[bold magenta]   --> Starting TNN Synthesis")

        start_time = time.process_time()

        # syn = synth_support(obj, aclk_freq, rtl_path, gclk_freq, lib_path, lef_path, qrc_file, cap_file)
        syn = synth_support(module_name, obj, aclk_freq, rtl_path, gclk_freq)
        
        if args['tool'] == 'Cadence':
          netlist_path = syn.gen_genus_tcl()
        elif args['tool'] == 'synopsys':
          netlist_path = syn.gen_dc_tcl()

        end_time = time.process_time()

        console.print("[bold magenta]   --> Ending TNN Synthesis!, Total Time: {}".format(end_time - start_time))    
    
        console.print("[bold magenta]   --> Starting TNN Place And Route!")

        start_time = time.process_time()
        

        # pnr = pnr_support(obj, aclk_freq, gclk_freq, netlist_path,  lib_path, lef_path, qrc_file, cap_file)
        pnr = pnr_support(obj, aclk_freq, gclk_freq, netlist_path)
        
        if args['tool'] == 'cadence':
          pnr.gen_innovus_tcl()
        elif args['tool'] == 'synopsys':
          pnr.gen_primetime_tcl()
          
        end_time = time.process_time()

        console.print("[bold magenta]   --> Ending TNN Place And Route!, Total Time: {}".format(end_time - start_time))

