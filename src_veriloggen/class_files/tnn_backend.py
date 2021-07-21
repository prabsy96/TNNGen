from veriloggen import *
import numpy as np
import os
import pathlib
import sys
import subprocess
import shlex

# Author: Prabhu Vellaisamy
# Backend functions built from veriloggen

def is_file(file = None, path = None):
	curr = pathlib.Path.cwd()
	file_path = os.path.join(curr, path, file)
	print(file_path)
	if os.path.exists(file_path):
		return True, file_path
	else: 
		raise FileNotFoundError

def gen_verilog( module = None, path = None, filename = None, print_v = 'no'):

	if module is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(module, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	if path is None and filename is None:
		path = 'out_rtl'
		filename = 'default.v'
		print('file generated at ./'+path+filename)
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
			col_v = module.to_verilog(path+'//'+filename)

	if print_v == 'yes':
		print(col_v)

	return col_v

def sim_verilog(obj = None, sim_name = 'iverilog'):

	if obj is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(obj, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	sim = simulation.Simulator(obj, sim = 'iverilog')
	rslt = sim.run(display = True) 
	print(rslt)
	
	return sim

def source_sh (file = None):
	cmnd = shlex.split('bash -c source '+file)
	proc = subprocess.Popen(cmnd, shell=True)
	stdout, stderr = proc.communicate()

	pprint.pprint(stdout)

def synth_verilog(obj = None, node = 45, corner = 'typical', model = 'ccs', tool = 'yosys', tcl = None):

	node_list = (7, 45)
	corner_nangate = ('typical', 'fast', 'slow', 'low_temp', 'worst_low')
	corner_asap7 = ('tt', 'ff', 'ss')
	vt_asap7 = ('rvt', 'slvt', 'lvt', 'sram')
	model_lib = ('ccs', 'ecsm', 'ndlm')
	tool_list = ('yosys', 'genus', 'dc_shell')

	# Can expand to ECSM and NLDM

	std_lib = {'nangate': {'ccs':['NangateOpenCellLibrary_typical_ccs.lib', 'NangateOpenCellLibrary_fast_ccs.lib', 'NangateOpenCellLibrary_slow_ccs',
						'NangateOpenCellLibrary_low_temp_ccs', 'NangateOpenCellLibrary_worst_low_ccs'],
						'ecsm':['NangateOpenCellLibrary_typical_ecsm.lib', 'NangateOpenCellLibrary_fast_ecsm.lib', 'NangateOpenCellLibrary_slow_ecsm',
						'NangateOpenCellLibrary_low_temp_ecsm', 'NangateOpenCellLibrary_worst_low_ecsm'],
						'nldm':['NangateOpenCellLibrary_typical_nldm.lib', 'NangateOpenCellLibrary_fast_ndlm.lib', 'NangateOpenCellLibrary_slow_nldm',
						'NangateOpenCellLibrary_low_temp_nldm', 'NangateOpenCellLibrary_worst_low_nldm']},
				'asap7': {'ccs':'Asap7_rvt_tt_ccs.lib',
						'nldm':	{'rvt': ['Asap7_rvt_tt_nldm.lib', 'Asap7_rvt_ff_ccs.lib', 'Asap7_rvt_ss_ccs.lib'],
								'lvt': ['Asap7_lvt_tt_nldm.lib', 'Asap7_lvt_ff_ccs.lib', 'Asap7_lvt_ss_ccs.lib'],
								'slvt': ['Asap7_slvt_tt_nldm.lib', 'Asap7_slvt_ff_ccs.lib', 'Asap7_slvt_ss_ccs.lib'],
								'sram': ['Asap7_sram_tt_nldm.lib', 'Asap7_sram_ff_ccs.lib', 'Asap7_sram_ss_ccs.lib'],
								}
							}
				}

	# Handle errors and exceptions

	if isinstance(obj, Module) is False:
		TypeError('Wrong type: arg obj is not of type Veriloggen.Module')

	if isinstance(node, int) is False:
		TypeError('Wrong type: arg corner is of type %d')
	elif node not in node_list:
		raise ValueError('Invalid tech_node size entry')

	if isinstance(corner, str) is False:
		TypeError('Wrong type: arg corner is of type %s')
	elif node not in node_list:
		raise ValueError('Invalid tech_node size entry')
	elif node == node_list[1] and corner not in corner_nangate:
		ValueError('Incorrect value for Nangate process corner')
	elif node == node_list[0]:
		if corner not in corner_asap7:
			ValueError('Incorrect value for asap7 process corner')
		elif vt not in vt_asap7:
			ValueError('Incorrect value for asap7 threshold voltage')

	if isinstance(model, str) is False:
		TypeError('Wrong type: arg model is of type %s')
	elif model not in model_lib:
		ValueError('Incorrect value for library model')

	if isinstance(tool, str) is False:
		TypeError('Wrong type: arg tool is of type %s')
	elif tool not in tool_list:
		ValueError('Incorrect value for synthesis tool')

	# check if file exists
	if node == node_list[1]:
		std_file = std_lib['nangate'][model][corner_nangate.index(corner)]

	elif node == node_list[0]:
		std_file = std_lib['asap7'][model][corner_nangate.index(corner)]

	chk_std, std_path = is_file(std_file, 'std_lib')

	if chk_std is False:
		raise FileNotFoundError('File '+std_file+' not present in the directory')

	# initiate synth

	chk_v, file_v = is_file(obj.name+'.v', 'out_rtl')

	if chk_v is False:
		raise FileNotFoundError('File '+file_v+' not present in the directory')

	synth = synth_support(file_v, std_path, obj.name)
	
	if tcl is None:
		if tool == tool_list[0]:
			synth.gen_ys_template()
			synth_res = synth._exec_ys()
		elif tool == tool_list[1] or tool_list[2]:
			synth.gen_tcl()
			synth_res = synth_support._exec_ys()
	elif isinstance(tcl, str) is False:
		raise TypeError('Wrong type: arg tool is of type %s')





class synth_support:

	def __init__(self, file_v = None, std_lib = None, name = None ):

		self.file_v = file_v
		self.std_lib = std_lib
		self.name = name

		self.op_path = './yosys_synth/'

	def gen_ys_template(self):


		if not os.path.exists(self.op_path):
				os.mkdir(self.op_path)

		# yosys script
		l1 = "\nread_verilog "+self.file_v
		l2 = "\nhierarchy --top "+self.name
		l3 = "\nproc; fsm; opt; memory; opt"
		l4 = "\ntechmap; opt"
		l5 = "\ndfflibmap -liberty "+self.std_lib
		l6 = "\nabc -liberty "+self.std_lib
		l7 = "\nwrite_verilog "+os.path.join(self.op_path,'out_synth.v')
		l8 = "\nclean \nexit"

		# file io
		f = open(os.path.join(self.op_path,'out_synth.ys'), 'w')
		f.writelines([l1, l2, l3, l4, l5, l6, l7, l8])
		f.close() 

	def _exec_ys(self):
		print('\n Initiating Yosys synthesis')

		# bash cmnd
		synth = shlex.split('yosys '+os.path.join(self.op_path,'synth.ys'))
		res = subprocess.Popen(synth, shell=True)

		return res

	# expand later

	def gen_tcl(self, name = None, std_lib = None, file_v = None):
		pass




















