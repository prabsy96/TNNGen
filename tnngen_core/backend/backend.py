from veriloggen import *
import os
import pathlib
import subprocess
import sys
import shlex
from rich.console import Console 

sys.path.append("../")
from synthesis.synthesis import synth_support
from simulation.simulation import sim_support

console = Console()

def gen_verilog( module = None, path = None, filename = None, print_v = 'no', sv = 'no'):

	if module is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(module, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	if path is None and filename is None:
		path = 'out_rtl'
		if sv == 'no':
			filename = 'default.v'
		else:
			filename = 'default.sv'
			console.print('[bold blue]  -> file generated at ./'+path+filename)
	else:
		if path is None:
			path = 'out_rtl'
		if filename is None:
			if sv == 'no':
				filename = 'default.v'
			else:
				filename = 'default.sv'
		if isinstance(path, str) is False:
			raise TypeError("Path name is required as string r'%s.")
		elif isinstance(filename, str) is False:
			raise TypeError("File name is required as string r'%s.")
		else:
			if not os.path.exists(path):
				os.mkdir(path)
			mod_v = module.to_verilog(path+'/'+filename)

	gen_file = str(pathlib.Path.cwd())+'/'+path+'/'+filename

	if print_v == 'yes':
		print(mod_v)

	return gen_file

def sim_verilog(obj = None, sim_name = 'iverilog', wave = None):

	if obj is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(obj, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	if sim_name == 'iverilog':
		# using veriloggen iverilog support
		sim = simulation.Simulator(obj, sim = 'iverilog')
		rslt = sim.run(display = True) 
		print(rslt)
		console.print("[bold blue]  -> Simulation dump completed")

		if wave == 'yes':
			sim.view_waveform()

	elif sim_name == 'vcs':
		#sim = simulation.run_vcs(obj, True)
		sim = run_sim()
		print(sim) 

		if wave == 'yes':
			cmd = []
			subprocess.call(shlex.split('dve &'))
	
	return sim

def source_sh (file = None):
	cmnd = shlex.split('bash -c source '+file)
	proc = subprocess.Popen(cmnd, shell=True)
	stdout, stderr = proc.communicate()

	pprint.pprint(stdout)

def synth_verilog(obj = None, node = 45, corner = 'typical', model = 'ccs', tool = 'yosys', tcl = None, file_v = None, clk_name = None):

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
				'asap7': {'ccs':('asap7sc7p5t_SEQ_RVT_TT_ccs_191031.lib', 'asap7sc7p5t_SIMPLE_RVT_TT_ccs_191031.lib',
								'asap7sc7p5t_INVBUF_RVT_TT_ccs_191031.lib', 'asap7sc7p5t_OA_RVT_TT_ccs_191031.lib',
								'asap7sc7p5t_AO_RVT_TT_ccs_191031.lib')  ,
						'nldm':	{'rvt': {'ff':(),
								#'lvt': ,
								#'slvt': ,
								#'sram': 
								}
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
	
	lib_path = []
	# check if file exists
	curr = pathlib.Path.cwd()
	if node == node_list[1]:
		std_file = std_lib['nangate'][model][corner_nangate.index(corner)]
		lef_file = [os.path.join(curr, 'Nangate45/lef/NangateOpenCellLibrary.lef'), os.path.join(curr,'Nangate45/lef/NangateOpenCellLibrary.macro.lef'), os.path.join(curr,'Nangate45/lef/NangateOpenCellLibrary.tech.lef')]
		qrc_file = None
		
	elif node == node_list[0]:
		std_file = std_lib['asap7'][model][corner_nangate.index(corner)]

	std_file = [os.path.join(curr, 'Nangate45/Liberty',model.upper(),std_file)]
	if std_file is not None:
		lib_path.append(os.path.join('Nangate45/Liberty',model.upper()))
		for file in std_file:
			if os.path.exists(os.path.join(curr, file)) is False:
				raise FileNotFoundError("File "+os.path.join(curr, file)+"not found")
	elif lef_file is not None:
		lib_path.append(os.path.join(curr, "Nangate45/lef"))
		for file in lef_file:
			if os.path.exists(os.path.join(curr, lef_file)) is False:
				raise FileNotFoundError("File "+os.path.join(curr, file)+"not found")
	elif file_v is not None:
		if file_v is False:
			raise FileNotFoundError("File "+os.path.join(curr, file_v)+"not found")
	elif qrc_file is not None:
		lib_path.append(os.path.join(curr, "Nangate45/qrc"))
		if os.path.exists(os.path.join(curr, qrc_file)) is False:
			raise FileNotFoundError("File "+os.path.join(curr, qrc_file)+"not found")
	
	synth = synth_support(file_v = file_v, sv = False, name = obj.name, output = None, std_lib = std_file, std_lef = lef_file, std_qrc = qrc_file, lib_path = lib_path)
	
	if tcl is None:
		if tool == tool_list[0]:
			synth.gen_ys_template()
			synth_res = synth._exec_ys()
		elif tool == tool_list[1] or tool_list[2]:
				if tcl is None:
					synth.gen_genus_sdf(clk_name = clk_name)
					tcl_file = synth.gen_genus_tcl()
					synth_res = synth._exec_genus(tcl_file)
				else:
					synth_res = synth._exec_genus(file = tcl)

	elif isinstance(tcl, str) is False:
		raise TypeError('Wrong type: arg tool is of type %s')




















