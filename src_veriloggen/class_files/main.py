from tnn_backend import *
from tnn_col import TNN_Col
from func_mdls import TNN_Functions, Test_TNN_Functions
import argparse

if __name__ == '__main__':

# parse command line aarguments
	parser = argparse.ArgumentParser(description = 'TNNGen: A Framework for Temporal Neural Network Ecosystem')

	parser.add_argument('--top_lvl_mdl', type = str, default= 'column', 
						help = "Provide top level modules for verilog generation \n verilog library: column, neuron_rnl, neuron_body, stdp, pac, stdp_case_gen, wta, flogic, fsm_synapse, fsm_simple, incdec, edge2pulse, adder, less_equal, pulse2edge")

	parser.add_argument('--testbench', type = str, default = 'no',
						help = "'yes' for generating testbench; default is 'no")

	parser.add_argument('--flow', type = str, default = 'pre-synthesis',
						help = "Choose the EDA flow from ''pre-synthesis'' and ''post-synthesis'' ")

	parser.add_argument('--run_sim', type = str, default = 'no',
						help = "'yes' for running RTL sim; default is 'no")

	parser.add_argument('--simulater', type = str, default = 'verilator',
						help = 'Provide simulator name: \n verilator(default), vcs, xrun (provide paths for vcs and xrun)')

	parser.add_argument('--sim_script', type = str, default = None,
						help = 'Provide filename of shell script with sim path (for vcs or xrun); None for verilator')

	parser.add_argument('--print', type = str, default = 'no',
						help = "'yes' for printing code in command line; default is 'no")

	args = parser.parse_args()

	# # argument variables
	top_lvl_mdl = args.top_lvl_mdl
	tb = args.testbench
	run_sim = args.run_sim
	sim_name = args.simulater
	sim_script = args.sim_script
	print_v = args.print

	v_lib = ['column', 'neuron_rnl', 'neuron_body', 'stdp', 'pac', 'stdp_case_gen', 'wta', 'flogic', 'fsm_synapse', 'fsm_simple', 'incdec', 'edge2pulse', 'adder', 'less_equal', 'pulse2edge']
	sim_lib = ['verilator', 'vcs', 'xrun']

	# initialize objects
	f = TNN_Functions()
	tb_f = Test_TNN_Functions()

	# handling errors
	if isinstance(print_v, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if print_v not in ['yes', 'no']:
		raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

	if isinstance(tb, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if tb not in ['yes', 'no']:
		raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

	if isinstance(run_sim, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if run_sim not in ['yes', 'no']:
		raise ValueError('Invalid entry: provide either ''yes'' or ''no''')

	if isinstance(sim_name, str) is False:
		raise TypeError('Incorrect type; provide in %s format')
	if sim_name not in sim_lib:
		raise ValueError('Invalid entry: sim_name is either ''verilator'', ''vcs'' or ''xrun''')

	if sim_script is None:
		if sim_name in ['vcs', 'xrun']:
			raise ValueError('Missing .sh file')
	else:
		if isinstance(sim_script, str) is False:
			raise TypeError('Incorrect type; provide in %s format')
		source_sh(sim_script)

	if isinstance(top_lvl_mdl, str) is False:
		raise TypeError('Incorrect format; provide in %s format')
	if top_lvl_mdl not in v_lib:
		raise ValueError('Incorrect top level module name')

	# generate verilog for top_level modules
	if top_lvl_mdl == 'column':

		print("Column selected, provide parameters")

		p = int(input(' Enter # synapses per neuron ') or 4)
		q = int(input(' Enter # output neurons ') or 3)
		thres = int(input('Enter threshold value ') or 13)

		if not isinstance(p, int):
			raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

		if not isinstance(q, int):
			raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

		if not isinstance(thres, int):
			raise TypeError('Invalid type for threshold value; provide in %d format')

		col = TNN_Col(p, q, thres)

		if tb == 'yes':
			obj = col.constr_tb()
		else:
			obj = col.constr_v()

		gen_verilog(module = obj, path = 'out_rtl', filename = 'column.v', print_v = print_v)

	else:
		if top_lvl_mdl == 'less_equal':
			if tb == 'yes':
				obj = tb_f.Tb_Less_equal()
			else:
				obj = f.Less_equal()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'less_equal.v', print_v = print_v)

		elif top_lvl_mdl == 'pulse2edge':
			if tb == 'yes':
				obj = tb_f.Tb_Pulse2edge()
			else:
				obj = f.Pulse2edge()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'pulse2edge.v', print_v = print_v)

		elif top_lvl_mdl == 'edge2pulse':
			if tb == 'yes':
				obj = tb_f.Tb_Edge2pulse()
			else:
				obj = f.Edge2pulse()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'edge2pulse.v', print_v = print_v)

		elif top_lvl_mdl == 'adder':
			if tb == 'yes':
				obj = tb_f.Tb_Adder()
			else:
				obj = f.Adder()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'adder.v', print_v = print_v)

		elif top_lvl_mdl == 'incdec':
			if tb == 'yes':
				obj = tb_f.Tb_Incdec()
			else:
				obj = f.Incdec()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'incdec.v', print_v = print_v)

		elif top_lvl_mdl == 'wta':
			print("WTA selected, provide parameter")
			q = int(input(' Enter # output neurons ') or 3)

			if not isinstance(q, int):
				raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

			if tb == 'yes':
				obj = tb_f.Tb_Wta(q)
			else:
				obj = f.Wta(q)

			gen_verilog(module = obj, path = 'out_rtl', filename = 'wta.v', print_v = print_v)

		elif top_lvl_mdl == 'flogic':
			if tb == 'yes':
				obj = tb_f.Tb_Flogic()
			else:
				obj = f.Flogic()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'flogic.v', print_v = print_v)

		elif top_lvl_mdl == 'stdp_case_gen':
			if tb == 'yes':
				obj = tb_f.Tb_Stdp_case_gen()
			else:
				obj = f.Stdp_case_gen()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'stdp_case_gen.v', print_v = print_v)

		elif top_lvl_mdl == 'fsm_simple':
			if tb == 'yes':
				obj = tb_f.Tb_Fsm_simple()
			else:
				obj = f.Fsm_simple()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'fsm_simple.v', print_v = print_v)

		elif top_lvl_mdl == 'fsm_synapse':
			if tb == 'yes':
				obj = tb_f.Tb_Fsm_synapse()
			else:
				obj = f.Fsm_synapse()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'fsm_synapse.v', print_v = print_v)

		elif top_lvl_mdl == 'stdp':
			if tb == 'yes':
				obj = tb_f.Tb_Stdp()
			else:
				obj = f.Stdp()

			gen_verilog(module = obj, path = 'out_rtl', filename = 'stdp.v', print_v = print_v)

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

			gen_verilog(module = obj, path = 'out_rtl', filename = 'pac.v', print_v = print_v)

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

			gen_verilog(module = obj, path = 'out_rtl', filename = 'neuron_body.v', print_v = print_v)

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

			gen_verilog(module = obj, path = 'out_rtl', filename = 'neuron_rnl.v', print_v = print_v)

	# run sim
	if run_sim == 'yes':
		if sim_name == 'verilator':
			gtk = input("Run GTKWave Waveform Viewer? Enter ''yes'' or ''no'' ") or 'no' 

		if isinstance(gtk, str) is False:
			raise TypeError('Provide ''yes'' or ''no'' in %s format')

		if gtk == 'yes':
			sim_verilog(obj, True)
		elif gtk == 'no':
			sim_verilog(obj, False)
		else:
			raise ValueError('Invalid entry for GTKWave value; choose ''yes'' or ''no''')














