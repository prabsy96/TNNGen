from column import TNN_Col
from backend.backend import * 
from tnn_mdls.func_mdls import *
from synthesis.synthesis import synth_support
from simulation.simulation import *
import argparse
import os


if __name__ == '__main__':

# parse command line aarguments
	parser = argparse.ArgumentParser(description = 'TNNGen: A Framework for Temporal Neural Network Ecosystem')
	
	subparser = parser.add_subparsers(dest = 'command')
	subparser.required = True
	rtl = subparser.add_parser('rtl')
	sim = subparser.add_parser('sim')
	synth = subparser.add_parser('synth')
	
	rtl.add_argument('--top', type = str, required = True,
						help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
						)
	
	rtl.add_argument('--tb', type = str, default = 'no',
						help = "'yes' for generating testbench; default is 'no'"
						)
						
	rtl.add_argument('--sv' , type = str, default = 'no',
						help = "'yes' for generating .sv files; 'no' for generating for .v files"
						)
					
						
	rtl.add_argument('--print', type = str, default = 'no',
						help = "'yes' for printing code in command line; default is 'no'"
						)
						
	sim.add_argument('--top', type = str, required = True,
						help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
						)
	
	sim.add_argument('--tb', type = str, default = 'no',
						help = "'yes' for generating testbench; default is 'no'"
						)
	
	sim.add_argument('--sv' , type = str, default = 'no',
						help = "'yes' for generating .sv files; 'no' for generating for .v files"
						)
						
	sim.add_argument('--print', type = str, default = 'no',
						help = "'yes' for printing code in command line; default is 'no'"
						)
							
	sim.add_argument('--sim', type = str, required = True,
						help = "Provide simulator name: iverilog (default), vcs, xrun (provide paths for vcs and xrun)"
						)
	
	sim.add_argument('--wave', type = str, default = 'no', 
						help = "view waveform? ''yes'' or ''no''"
						)
	
	sim.add_argument('--sim_path', type = str, default = 'simv',
						help = "output path in current dir for storing sim variables"
						)
						
	synth.add_argument('--top', type = str, required = True,
						help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge"
						)	

	synth.add_argument('--tool', type = str, required = True,
						help = "Select synthesis tool from 1. Yosys [yosys], 2. Genus [genus], 3. Design Compiler [dc]"
						)
						
	synth.add_argument('--tcl', type = str, default = None,
						help = "Provide path to the Tcl file"
						)
	
	synth.add_argument('--sv' , type = str, default = 'no',
						help = "'yes' for generating .sv files; 'no' for generating for .v files"
						)

	args = parser.parse_args()

	# argument variables
	flow = args.command
	top_lvl_mdl = args.top
	sv = args.sv
	
	if flow == 'rtl':
		tb = args.tb
		print_v = args.print
	
	elif flow == 'sim':
		tb = args.tb
		sim_name = args.sim
		wave = args.wave
		sim_path = args.sim_path
		
	elif flow == 'synth':
		tool = args.tool
	
	if flow == 'synth':
		print_v = 'no'
		tcl = args.tcl
	else:
		print_v = args.print
	
	# initialize objects
	f = TNN_Functions()
	tb_f = Test_TNN_Functions()

	v_lib = ('column', 'neuron_rnl_ptt', 'neuron_body', 'stdp', 'pac', 'stdp_case_gen', 'wta', 'flogic', 'fsm_synapse', 'fsm_simple', 'incdec', 'edge2pulse', 'adder', 'less_equal', 'pulse2edge')
	sim_lib = ('iverilog', 'vcs', 'xrun')
	flow_lib = ('rtl', 'sim', 'synth', 'post_synth_verif')

	# handling errors
	
	if isinstance(sv, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if sv not in ('yes', 'no'):
		raise ValueError('Incorrect sv value')
	
	if isinstance(flow, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if flow not in flow_lib:
		raise ValueError('Incorrect flow name')
	
	if isinstance(top_lvl_mdl, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if top_lvl_mdl not in v_lib:
		raise ValueError('Incorrect top level module name')
	
	if flow == 'rtl' or flow == 'sim':
	
		if isinstance(print_v, str) is False:
			raise TypeError('Incorrect type; provide in %s format')
		if print_v not in ('yes', 'no'):
			raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

		if isinstance(tb, str) is False:
			raise TypeError('Incorrect type; provide in %s format')
		if tb not in ('yes', 'no'):
			raise ValueError('Invalid entry: provide either ''yes'' or ''no''')
			
	if flow == 'sim':

		if isinstance(sim_name, str) is False:
			raise TypeError('Incorrect type; provide in %s format')
		if sim_name not in sim_lib:
			raise ValueError('Invalid entry: sim_name is either ''iverilog'', ''vcs'' or ''xrun''')

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
		print("-> Selected # synapse per neuron: "+str(p))
		q = int(input('Enter # output neurons : ') or 3)
		print("-> Selected # output neurons: "+str(q))
		thres = int(input('Enter threshold value ') or 13)
		print("-> Selected threshold value: "+str(thres))

		if not isinstance(p, int):
			raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
		if not isinstance(q, int):
			raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
		if not isinstance(thres, int):
			raise TypeError('Invalid type for threshold value; provide in %d format')

		col = TNN_Col(p, q, thres)
		
		if flow == 'synth':
			obj, clk_name = col.col_v()
		else:
			if tb == 'yes' :
				obj = col.col_tb()
			else:
				obj = col.col_v()
	else:
		if top_lvl_mdl == 'less_equal':
			if flow == 'synth':
				obj, clk_name = f.Less_equal()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Less_equal()
				else:
					obj = f.Less_equal()

		elif top_lvl_mdl == 'pulse2edge':
			if flow == 'synth':
				obj, clk_name = f.Pulse2edge()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Pulse2edge()
				else:
					obj = f.Pulse2edge()

		elif top_lvl_mdl == 'edge2pulse':
			if flow == 'synth':
				obj, clk_name = f.Edge2pulse()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Edge2pulse()
				else:
					obj = f.Edge2pulse()

		elif top_lvl_mdl == 'adder':
			if flow == 'synth':
				obj, clk_name = f.Adder()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Adder()
				else:
					obj = f.Adder()

		elif top_lvl_mdl == 'incdec':
			if flow == 'synth':
				obj, clk_name = f.Incdec()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Incdec()
				else:
					obj = f.Incdec()

		elif top_lvl_mdl == 'wta':
			print("WTA selected, provide parameter")
			q = int(input(' Enter # output neurons ') or 4)
			print("-> Selected # output neurons: "+str(q))
			
			if not isinstance(q, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')
			
			if flow == 'synth':
				obj, clk_name = f.Wta(q)
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Wta(q)
				else:
					obj = f.Wta(q)

		elif top_lvl_mdl == 'flogic':
			if flow == 'synth':
				obj, clk_name = f.Flogic()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Flogic()
				else:
					obj = f.Flogic()

		elif top_lvl_mdl == 'stdp_case_gen':
			if flow == 'synth':
				obj, clk_name = f.Stdp_case_gen()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Stdp_case_gen()
				else:
					obj = f.Stdp_case_gen()

		elif top_lvl_mdl == 'fsm_simple':
			if flow == 'synth':
				obj, clk_name = f.Fsm_simple()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Fsm_simple()
				else:
					obj = f.Fsm_simple()

		elif top_lvl_mdl == 'fsm_synapse':
			if flow == 'synth':
				obj, clk_name = f.Fsm_synapse()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Fsm_synapse()
				else:
					obj = f.Fsm_synapse()

		elif top_lvl_mdl == 'stdp':
			if flow == 'synth':
				obj, clk_name = f.Stdp()
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Stdp()
				else:
					obj = f.Stdp()

		elif top_lvl_mdl == 'pac':
			print("WTA selected, provide parameters")

			p = int(input('Enter # synapses per neuron : ') or 4)
			print("-> Selected # synapse per neuron: "+str(p))
			thres = int(input('Enter threshold value ') or 13)
			print("-> Selected threshold value: "+str(thres))

			if not isinstance(p, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if not isinstance(thres, int):
				raise TypeError('Invalid type for threshold value; provide in %d format')
			
			if flow == 'synth':
				obj, clk_name = f.Pac(ip_size = p, thres = thres)
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Pac(ip_size = p, thres = thres)
				else:
					obj = f.Pac(ip_size = p, thres = thres)

		elif top_lvl_mdl == 'neuron_body':
			print("Neuron body selected, provide parameters")

			p = int(input('Enter # synapses per neuron : ') or 4)
			print("-> Selected # synapse per neuron: "+str(p))
			thres = int(input('Enter threshold value ') or 13)
			print("-> Selected threshold value: "+str(thres))

			if not isinstance(p, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if not isinstance(thres, int):
				raise TypeError('Invalid type for threshold value; provide in %d format')
			
			if flow == 'synth':
				obj, clk_name = f.Neuronbody(ip_size = p, thres = thres)
			else:
				if tb == 'yes':
					obj = tb_f.Tb_Neuronbody(ip_size = p, thres = thres)
				else:
					obj = f.Neuronbody(ip_size = p, thres = thres)

		elif top_lvl_mdl == 'neuron_rnl_ptt':
			print("Neuron RNL selected, provide parameters")

			p = int(input('Enter # synapses per neuron : ') or 4)
			print("-> Selected # synapse per neuron: "+str(p))
			thres = int(input('Enter threshold value ') or 13)
			print("-> Selected threshold value: "+str(thres))

			if not isinstance(p, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if not isinstance(thres, int):
				raise TypeError('Invalid type for threshold value; provide in %d format')
			
			if flow == 'synth':
				obj, clk_name = f.NeuronRNL(ip_size = p, thres = thres)
			else:
				if tb == 'yes':
					obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = thres)
				else:
					obj = f.NeuronRNL(ip_size = p, thres = thres)

	# generate verilog
	if sv == 'yes':
		filename = obj.name+".sv"
	else:
		filename = obj.name+".v"
	
	gen_file = gen_verilog(module = obj, path = 'out_rtl', filename = filename, print_v = print_v)

	# run sim
	if flow == flow_lib[1]:
		sim = sim_support(file = gen_file, output = sim_path)
		
		if sim_name  == 'iverilog':
			# using veriloggen iverilog support
			sim_v = simulation.Simulator(obj, sim = 'iverilog')
			rslt = sim_v.run(display = True) 
			
			if wave == 'yes':
				sim.viewform()
		
		elif sim_name == 'vcs':
			sim_v = sim.run_vcs()
			print("\n#### Simulation Dump Completed ####\n_________________________________________")
			if wave == 'yes':
				sim.dve()
			
		elif sim_name == 'xrun':
			sim_v = sim.run_xrun()
			print("\n#### Simulation Dump Completed ####\n_________________________________________")
			if wave == 'yes':
				sim.simvision()
	# synth
	elif flow == flow_lib[2]:
		print("\nProvide the following synthesis parameters - \n___________________________________________________")
		node = int(input("Specify tech node size in  %d format; Available node sizes: 45, 7 : ") or '45')
		print("-> Selected node: "+str(node))
		print("Specify the library model", end = "")
		if node == 45:
			model = input("ccs, ecsm, nldm : ") or 'ccs'
			print("-> Selected model: "+model)
			corner = input("Specify the process corner for the tech node, available are - typical, fast, slow, low_temp, worst_low : ") or 'typical'
			print("-> Selected process corner: "+corner)

		else:
			model = input("ccs, nldm : ") or 'ccs'
			print("-> Selected model: "+model)
			corner = input("Specify the corner for the tech node, available are rvt, lvt, slvt, sram : ") or 'rvt'
			print("-> Selected process corner: "+corner)
		synth_verilog(obj = obj, node = 45, corner = corner, model = model, tool = tool, tcl = tcl, file_v = gen_file, clk_name = clk_name)



















