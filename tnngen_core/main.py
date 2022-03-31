from column import TNN_Col
from backend.backend import * 
from tnn_mdls.func_mdls import *
from synthesis.synth import synth_support
from simulation.sim import sim_support
import argparse
import os
from rich.console import Console
from rich.progress import track
from rich.table import Table

if __name__ == '__main__':

    console = Console()
    console.print("[bold magenta]        /------------------------------------------------------------\\")
    console.print("[bold magenta]        |                                                            |")
    console.print("[bold magenta]        |  Welcome to TNNGen (Temporal Neural Network Generator)!    |")
    console.print("[bold magenta]        |  TNNGen is a Python framework for building TNN ecosystems  |")
    console.print("[bold magenta]        |                                                            |")
    console.print("[bold magenta]        |  Prabhu Vellaisamy <pvellais@andrew.cmu.edu>               |")
    console.print("[bold magenta]        |  CMU-NCAL, Carnegie Mellon University                      |")
    console.print("[bold magenta]        |                                                            |")
    console.print("[bold magenta]        \\-----------------------------------------------------------/")

    # help table print
    table1 = Table(show_header=True, header_style="bold magenta")
    table1.add_column("TNN Module List", justify="center")
    table1.add_row("1.edge2pulse 2.pulse2edge 3.less_equal 4.adder 5.incdec 6.wta 7.flogic 8.stdp_case_gen")
    table1.add_row("9.fsm_simple 10.fsm_synapse 11.stdp 12.pac 13.neuron_body 14.neuron_rnl_ptt 15.column")
    console.print(table1)

    table2 = Table(show_header=True, header_style="bold magenta")
    table2.add_column("Cadence Tools")
    table2.add_column("Flow")
    table2.add_row("Xcelium", "RTL Simulation")
    table2.add_row("Genus", "RTL Synthesis")
    table2.add_row("Innovus", "Place-&-Route")
    console.print(table2)

    # parse command line aarguments
    parser = argparse.ArgumentParser(description = 'TNNGen: A Framework for Temporal Neural Network Ecosystem')
    
    subparser = parser.add_subparsers(dest = 'command')
    subparser.required = True
    rtl = subparser.add_parser('rtl')
    sim = subparser.add_parser('sim')
    synth = subparser.add_parser('synth')
    pnr = subparser.add_parser('pnr')
    
    rtl.add_argument('--top', type = str, required = True,
                        help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
                        )
    
    rtl.add_argument('--tb', type = str, default = 'no',
                        help = "'yes' for generating testbench; default is 'no'"
                        )
                    
    rtl.add_argument('--print', type = str, default = 'no',
                        help = "'yes' for printing code in command line; default is 'no'"
                        )
                        
    sim.add_argument('--top', type = str, required = True,
                        help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
                        )
                        
    sim.add_argument('--print', type = str, default = 'no',
                        help = "'yes' for printing code in command line; default is 'no'"
                        )
                                
    sim.add_argument('--wave', type = str, default = 'no', 
                        help = "view waveform? ''yes'' or ''no''"
                        )
    
    sim.add_argument('--path', type = str, default = 'simv',
                        help = "output path in current dir for storing sim variables"
                        )
                        
    synth.add_argument('--top', type = str, required = True,
                        help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
                        )
                        
    pnr.add_argument('--top', type = str, required = True,
                        help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
                        )

    args = parser.parse_args()

    # argument variables
    
    flow = args.command
    top_lvl_mdl = args.top
    
    if flow == 'rtl':
        tb = args.tb
        print_v = args.print
    
    elif flow == 'sim':
        print_v = args.print
        wave = args.wave
        sim_path = args.path
            
        
    # initialize objects
    
    f = TNN_Functions()
    tb_f = Test_TNN_Functions()

    v_lib = ('column', 'neuron_rnl_ptt', 'neuron_body', 'stdp', 'pac', 'stdp_case_gen', 'wta', 'flogic', 'fsm_synapse', 'fsm_simple', 'incdec', 'edge2pulse', 'adder', 'less_equal', 'pulse2edge')
    sim_lib = ('xrun')
    flow_lib = ('rtl', 'sim', 'synth', 'pnr')

    # handling errors
    
    if isinstance(flow, str) is False:
        raise TypeError('Incorrect format; provide in %s format')
    if flow not in flow_lib:
        raise ValueError('Incorrect flow name')
    
    if isinstance(top_lvl_mdl, str) is False:
        raise TypeError('Incorrect format; provide in %s format')
    if top_lvl_mdl not in v_lib:
        raise ValueError('Incorrect top level module name')
    
    if flow == 'rtl':
        if isinstance(tb, str) is False:
            raise TypeError('Incorrect type; provide in %s format')
        if tb not in ('yes', 'no'):
            raise ValueError('Invalid entry: provide either ''yes'' or ''no''')
            
    if flow == 'rtl' or flow == 'sim':
        if isinstance(print_v, str) is False:
            raise TypeError('Incorrect type; provide in %s format')
        if print_v not in ('yes', 'no'):
            raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

            
    if flow == 'sim':

        if isinstance(wave, str) is False:
            raise TypeError('Incorrect format; provide in %s format')
        if wave not in ('yes', 'no') :
            raise ValueError('Incorrect value provided')
        
        if isinstance(sim_path, str) is False:
            raise TypeError('Incorrect format; provide in %s format')


    # generate verilog for top_level modules
    if top_lvl_mdl == 'column':
        print("Column selected, provide parameters")
        p = int(input('Enter # synapses per neuron : ') or 4)
        console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
        q = int(input('Enter # output neurons : ') or 3)
        console.print("[bold blue]  -> Selected # output neurons: "+str(q))
        thres = int(input('Enter threshold value ') or 13)
        console.print("[bold blue]  -> Selected threshold value: "+str(thres))

        if not isinstance(p, int):
            raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
        if not isinstance(q, int):
            raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
        if not isinstance(thres, int):
            raise TypeError('Invalid type for threshold value; provide in %d format')

        col = TNN_Col(p, q, thres)
        
        if flow == 'synth' or flow == 'pnr': 
            obj, clk_name = col.col_v()
        elif flow == 'sim':
            obj = col.col_tb()
        elif flow == 'rtl':
            if tb == 'yes':
                obj = col.col_tb()
            else:
                obj, clk_name = col.col_v()

    else:
        if top_lvl_mdl == 'less_equal':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Less_equal()
            elif flow == 'sim':
                obj = tb_f.Tb_Less_equal()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Less_equal()
                else:
                    obj, clk_name = f.Less_equal()

        elif top_lvl_mdl == 'pulse2edge':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Pulse2edge()
            elif flow == 'sim':
                obj = tb_f.Tb_Pulse2edge()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Pulse2edge()
                else:
                    obj, clk_name = f.Pulse2edge()

        elif top_lvl_mdl == 'edge2pulse':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Edge2pulse()
            elif flow == 'sim':
                obj = tb_f.Tb_Edge2pulse()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Edge2pulse()
                else:
                    obj, clk_name = f.Edge2pulse()

        elif top_lvl_mdl == 'adder':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Adder()
            elif flow == 'sim':
                obj = tb_f.Tb_Adder()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Adder()
                else:
                    obj, clk_name = f.Adder()

        elif top_lvl_mdl == 'incdec':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Incdec()
            elif flow == 'sim':
                obj = tb_f.Tb_Incdec()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Incdec()
                else:
                    obj, clk_name = f.Incdec()

        elif top_lvl_mdl == 'wta':
            print("WTA selected, provide parameter")
            q = int(input(' Enter # output neurons ') or 4)
            console.print("[bold blue]  -> Selected # output neurons: "+str(q))
            
            if not isinstance(q, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
            
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Wta(q)
            elif flow == 'sim':
                obj = tb_f.Tb_Wta(q)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Wta(q)
                else:
                    obj, clk_name = f.Wta(q)

        elif top_lvl_mdl == 'flogic':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Flogic()
            elif flow == 'sim':
                obj = tb_f.Tb_Flogic()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Flogic()
                else:
                    obj, clk_name = f.Flogic()

        elif top_lvl_mdl == 'stdp_case_gen':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Stdp_case_gen()
            elif flow == 'sim':
                obj = tb_f.Tb_Stdp_case_gen()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Stdp_case_gen()
                else:
                    obj, clk_name = f.Stdp_case_gen()

        elif top_lvl_mdl == 'fsm_simple':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Fsm_simple()
            elif flow == 'sim':
                obj = tb_f.Tb_Fsm_simple()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Fsm_simple()
                else:
                    obj, clk_name = f.Fsm_simple()

        elif top_lvl_mdl == 'fsm_synapse':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Fsm_synapse()
            elif flow == 'sim':
                obj = tb_f.Tb_Fsm_synapse()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Fsm_synapse()
                else:
                    obj, clk_name = f.Fsm_synapse()

        elif top_lvl_mdl == 'stdp':
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Stdp()
            elif flow == 'sim':
                obj = tb_f.Tb_Stdp()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Stdp()
                else:
                    obj, clk_name = f.Stdp()

        elif top_lvl_mdl == 'pac':
            print("Pac selected, provide parameters")

            p = int(input('Enter # synapses per neuron : ') or 4)
            console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
            thres = int(input('Enter threshold value ') or 13)
            console.print("[bold blue]  -> Selected threshold value: "+str(thres))

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(thres, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')
            
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Pac(ip_size = p, thres = thres)
            elif flow == 'sim':
                obj = tb_f.Tb_Pac(ip_size = p, thres = thres)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Pac(ip_size = p, thres = thres)
                else:
                    obj, clk_name = f.Pac(ip_size = p, thres = thres)

        elif top_lvl_mdl == 'neuron_body':
            print("Neuron body selected, provide parameters")

            p = int(input('Enter # synapses per neuron : ') or 4)
            console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
            thres = int(input('Enter threshold value ') or 13)
            console.print("[bold blue]  -> Selected threshold value: "+str(thres))

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(thres, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')
            
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.Neuronbody(ip_size = p, thres = thres)
            elif flow == 'sim':
                bj = tb_f.Tb_Neuronbody(ip_size = p, thres = thres)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Neuronbody(ip_size = p, thres = thres)
                else:
                    obj, clk_name = f.Neuronbody(ip_size = p, thres = thres)

        elif top_lvl_mdl == 'neuron_rnl_ptt':
            print("Neuron RNL selected, provide parameters")

            p = int(input('Enter # synapses per neuron : ') or 4)
            console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
            thres = int(input('Enter threshold value ') or 13)
            console.print("[bold blue]  -> Selected threshold value: "+str(thres))

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(thres, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')
            
            if flow == 'synth' or flow == 'pnr':
                obj, clk_name = f.NeuronRNL(ip_size = p, thres = thres)
            elif flow == 'sim':
                obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = thres)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = thres)
                else:
                    obj, clk_name = f.NeuronRNL(ip_size = p, thres = thres)

    # generate verilog
    
    filename = obj.name+".v"
    
    gen_file = gen_verilog(module = obj, path = 'out_rtl', filename = filename, print_v = print_v)
    console.print("\n[bold blue]  -> RTL Generated! \n  -----------------------------------------")
    
    # run sim
    if flow == flow_lib[1]:
        sim = sim_support(sim_out = sim_path, file = gen_file)
        
        # if sim_name  == 'iverilog':
        #     # using veriloggen iverilog support
        #     sim_v = simulation.Simulator(obj, sim = 'iverilog')
        #     rslt = sim_v.run(display = True) 
            
        #     if wave == 'yes':
        #         sim.viewform()
        
        # elif sim_name == 'vcs':
        #     sim_v = sim.run_vcs()
        #     console.print("\n[bold blue]  -> Simulation Dump Completed \n  -----------------------------------------")
        #     if wave == 'yes':
        #         sim.dve()
            
        
        sim_v = sim.run_xrun()
        console.print("\n[bold blue]  -> Simulation Dump Completed \n -----------------------------------------")
        if wave == 'yes':
            sim.simvision()
            
    # synth
    elif flow == flow_lib[2]:
        print("\nProvide the following synthesis parameters - \n-----------------------------------------")
        node = int(input("Specify tech node size in  %d format; Available node sizes: 45, 7 : ") or '45')
        console.print("[bold blue]-> Selected node: "+str(node))
        print("Specify the library model", end = "")
        if node == 45:
            model = input(" ccs, ecsm, nldm : ") or 'ccs'
            console.print("[bold blue]-> Selected model: "+model)
            corner = input("Specify the process corner for the tech node, available are - typical, fast, slow, low_temp, worst_low : ") or 'typical'
            console.print("[bold blue]-> Selected process corner: "+corner)

        else:
            model = input("ccs, nldm : ") or 'ccs'
            console.print("[bold blue]-> Selected model: "+model)
            corner = input("Specify the corner for the tech node, available are rvt, lvt, slvt, sram : ") or 'rvt'
            console.print("[bold blue]-> Selected process corner: "+corner)
        synth_verilog(obj = obj, node = 45, corner = corner, model = model, tool = tool, tcl = tcl, file_v = gen_file, clk_name = clk_name)



















