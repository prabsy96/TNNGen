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

	parser.add_argument('--top', type = str, required = True,
						help = "Provide top level modules for verilog generation \n Verilog library: 1. column, 2. neuron_rnl, 3. neuron_body, 4. stdp, 5. pac, 6. stdp_case_gen, 7. wta, 8. flogic, 9. fsm_synapse, 10. fsm_simple, 11. incdec, 12. edge2pulse, 13. adder, 14. less_equal, 15. pulse2edge")

	parser.add_argument('--tb', type = str, default = 'no',
						help = "'yes' for generating testbench; default is 'no'")

	parser.add_argument('--flow', type = str, required = True,
						help = "Select the EDA operation: gen_rtl, rtl_sim, rtl_synth, post_synth_verif")

	parser.add_argument('--sim', type = str, default = 'iverilog',
						help = 'Provide simulator name: iverilog (default), vcs, xrun (provide paths for vcs and xrun)')

	parser.add_argument('--print', type = str, default = 'no',
						help = "'yes' for printing code in command line; default is 'no'")

	parser.add_argument('--wave', type = str, default = 'no', 
						help = "view waveform? ''yes'' or ''no''")
	
	parser.add_argument('--sim_path', type = str, default = 'simv',
						help = "output path in current dir for storing sim variables")

	args = parser.parse_args()

	# argument variables
	top_lvl_mdl = args.top
	tb = args.tb
	sim_name = args.sim
	flow = args.flow
	print_v = args.print
	wave = args.wave
	sim_path = args.sim_path

	# initialize objects
	f = TNN_Functions()
	tb_f = Test_TNN_Functions()

	v_lib = ('column', 'neuron_rnl', 'neuron_body', 'stdp', 'pac', 'stdp_case_gen', 'wta', 'flogic', 'fsm_synapse', 'fsm_simple', 'incdec', 'edge2pulse', 'adder', 'less_equal', 'pulse2edge')
	sim_lib = ('iverilog', 'vcs', 'xrun')
	flow_lib = ('rtl_sim', 'rtl_synth', 'post_synth_verif')

	# handling errors
	if isinstance(print_v, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if print_v not in ('yes', 'no'):
		raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

	if isinstance(tb, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if tb not in ('yes', 'no'):
		raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

	if isinstance(sim_name, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if sim_name not in sim_lib:
		raise ValueError('Invalid entry: sim_name is either ''iverilog'', ''vcs'' or ''xrun''')

	if isinstance(top_lvl_mdl, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if top_lvl_mdl not in v_lib:
		raise ValueError('Incorrect top level module name')

	if isinstance(flow, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if flow not in flow_lib:
		raise ValueError('Incorrect flow name')

	if flow != flow_lib[0] and tb == 'yes':
		raise ValueError('Cannot synthesize a testbench module')

	if isinstance(wave, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if wave not in ('yes', 'no') :
		raise ValueError('Incorrect value provided')
	
	if isinstance(sim_path, str) is False:
		raise TypeError('Incorrect format; provide in %s format')


	# generate verilog for top_level modules
	if top_lvl_mdl == 'column':

		print("Column selected, provide parameters")

		p = int(input('Enter # synapses per neuron ') or 4)
		q = int(input('Enter # output neurons ') or 3)
		thres = int(input('Enter threshold value ') or 13)

		if not isinstance(p, int):
			raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

		if not isinstance(q, int):
			raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

		if not isinstance(thres, int):
			raise TypeError('Invalid type for threshold value; provide in %d format')

		col = TNN_Col(p, q, thres)

		if tb == 'yes':
			obj = col.col_tb()
		else:
			obj = col.col_v()

	else:
		if top_lvl_mdl == 'less_equal':
			if tb == 'yes':
				obj = tb_f.Tb_Less_equal()
			else:
				obj = f.Less_equal()

		elif top_lvl_mdl == 'pulse2edge':
			if tb == 'yes':
				obj = tb_f.Tb_Pulse2edge()
			else:
				obj = f.Pulse2edge()

		elif top_lvl_mdl == 'edge2pulse':
			if tb == 'yes':
				obj = tb_f.Tb_Edge2pulse()
			else:
				obj = f.Edge2pulse()

		elif top_lvl_mdl == 'adder':
			if tb == 'yes':
				obj = tb_f.Tb_Adder()
			else:
				obj = f.Adder()

		elif top_lvl_mdl == 'incdec':
			if tb == 'yes':
				obj = tb_f.Tb_Incdec()
			else:
				obj = f.Incdec()

		elif top_lvl_mdl == 'wta':
			print("WTA selected, provide parameter")
			q = int(input(' Enter # output neurons ') or 4)

			if not isinstance(q, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if tb == 'yes':
				obj = tb_f.Tb_Wta(q)
			else:
				obj = f.Wta(q)

		elif top_lvl_mdl == 'flogic':
			if tb == 'yes':
				obj = tb_f.Tb_Flogic()
			else:
				obj = f.Flogic()

		elif top_lvl_mdl == 'stdp_case_gen':
			if tb == 'yes':
				obj = tb_f.Tb_Stdp_case_gen()
			else:
				obj = f.Stdp_case_gen()

		elif top_lvl_mdl == 'fsm_simple':
			if tb == 'yes':
				obj = tb_f.Tb_Fsm_simple()
			else:
				obj = f.Fsm_simple()

		elif top_lvl_mdl == 'fsm_synapse':
			if tb == 'yes':
				obj = tb_f.Tb_Fsm_synapse()
			else:
				obj = f.Fsm_synapse()

		elif top_lvl_mdl == 'stdp':
			if tb == 'yes':
				obj = tb_f.Tb_Stdp()
			else:
				obj = f.Stdp()

		elif top_lvl_mdl == 'pac':
			print("WTA selected, provide parameters")

			p = int(input(' Enter # synapses per neuron ') or 4)
			thres = int(input('Enter threshold value ') or 13)

			if not isinstance(p, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if not isinstance(thres, int):
				raise TypeError('Invalid type for threshold value; provide in %d format')

			if tb == 'yes':
				obj = tb_f.Tb_Pac(ip_size = p, thres = thres)
			else:
				obj = f.Pac(ip_size = p, thres = thres)

		elif top_lvl_mdl == 'neuron_body':
			print("Neuron body selected, provide parameters")

			p = int(input(' Enter # synapses per neuron ') or 4)
			thres = int(input('Enter threshold value ') or 13)

			if not isinstance(p, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if not isinstance(thres, int):
				raise TypeError('Invalid type for threshold value; provide in %d format')

			if tb == 'yes':
				obj = tb_f.Tb_Neuronbody(ip_size = p, thres = thres)
			else:
				obj = f.Neuronbody(ip_size = p, thres = thres)

		elif top_lvl_mdl == 'neuron_rnl':
			print("Neuron RNL selected, provide parameters")

			p = int(input(' Enter # synapses per neuron ') or 4)
			thres = int(input('Enter threshold value ') or 13)

			if not isinstance(p, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if not isinstance(thres, int):
				raise TypeError('Invalid type for threshold value; provide in %d format')

			if tb == 'yes':
				obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = thres)
			else:
				obj = f.NeuronRNL(ip_size = p, thres = thres)

	# generate verilog
	gen_file = gen_verilog(module = obj, path = 'out_rtl', filename = obj.name+'.v', print_v = print_v)

	# run sim
	if flow == flow_lib[0]:
		sim = sim_support(file = gen_file, outputfile = sim_path)
		
		if sim_name  == 'iverilog':
			# using veriloggen iverilog support
			sim_v = simulation.Simulator(obj, sim = 'iverilog')
			rslt = sim_v.run(display = True) 
			print(rslt)
			
			if wave == 'yes':
				sim.viewform()
		
		elif sim_name == 'vcs':
			sim_v = sim.run_vcs(tb = tb)
			print("\n#### Simulation Dump Completed ####\n")
			if wave == 'yes':
				sim.dve()
			
		elif sim_name == 'xrun':
			sim_v = sim.run_xrun()
			print("\n#### Simulation Dump Completed ####\n")
			if wave == 'yes':
				sim.simvision()
			
			
		

	# synth

	elif flow == flow_lib[1]:
		print('\nProvide the following synthesis parameters - ')
		node = int(input("Specify tech node size in  %d format; \nAvailable node sizes: 45, 7 \t") or 45)

		print("\nSpecify the library model")
		if node == 45:
			model = input("\nAvailable are 1. ccs, 2. ecsm, 3. nldm: \t") or 'ccs'
			corner = input("\nSpecify the corner for the tech node, available are 1. typical, 2. fast, 3. slow, 4. low_temp, 5. worst_low :\t") or 'typical'

		else:
			model = input("\nAvailable are: 1. ccs 2. nldm :\t") or 'ccs'
			corner = input("\nSpecify the corner for the tech node, available are 1. rvt, 2. lvt, 3. slvt, 4. sram :\t") or 'rvt'

		tool = input('\nWhich tool; available are 1. yosys, 2. genus, 3. dc_shell :\t') or 'yosys'

		tcl = input('\nProvide path to tcl file; press Enter otherwise to generate default template :\t') or None

		synth_verilog(obj = obj, node = 45, corner = corner, model = model, tool = tool, tcl = tcl)



















