from veriloggen import *
import numpy as np
import os
import sys
import subprocess
import shlex

# Author: Prabhu Vellaisamy
# Backend functions built from veriloggen


def gen_verilog(module = None, path = None, filename = None, print_v = 'no'):

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

def sim_verilog(obj = None, waveform = False):

	if obj is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(obj, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	sim = simulation.Simulator(obj, sim = 'iverilog')
	rslt = sim.run(display = True) #outputfile = str(obj.name)+'.out')
	print(rslt)
	
	if waveform is True:
		sim.view_waveform()

def source_sh (file = None):
	cmnd = shlex.split('bash -c source '+file)
	proc = subprocess.Popen(cmnd, shell=True)
	stdout, stderr = proc.communicate()

	pprint.pprint(stdout)







