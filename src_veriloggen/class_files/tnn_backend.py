from veriloggen import *
import numpy as np
import os
import sys
import collections
import warnings

# Author: Prabhu Vellaisamy
# Backend functions built from veriloggen


def gen_verilog(module = None, path = None, print_v = False):

	if module is None:
		raise ValueError("Module is required.")
	else:
		if isinstance(module, Module) is False:
			raise TypeError("Object is not of type Veriloggen.Module")

	if path is None:
		print ("Warning: Default output path 'out_rtl/' set.")
		if not os.path.exists('out_rtl'):
			os.mkdir('out_rtl')
		col_v = module.to_verilog('out_rtl/column.v')
	else:
		if isinstance(path, str) is False:
			raise TypeError("Path name is required as string r'%s.")
		else:
			if not os.path.exists(path):
				os.mkdir(path)
		col_v = module.to_verilog(path+'/column.v')

	if print_v is True:
		print(col_v)


