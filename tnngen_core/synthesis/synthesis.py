import os
import subprocess
import shlex 

class synth_support:

	def __init__(self, file_v = None, std_lib = None, name = None, output = 'synth'):

		self.file_v = file_v
		self.std_lib = std_lib
		self.name = name
		self.output = output

	def gen_ys_template(self):

		if not os.path.exists(self.output):
				os.mkdir(self.output)

		graph = input("Show design netlist graph; select ''yes'' or ''no'' ") or 'yes'

		# yosys script
		l1 = "\nread_verilog "+self.file_v
		l2 = "\nhierarchy -top "+self.name
		if graph == 'yes':
			l3 = "\nproc; fsm; opt; memory; opt"+"\nshow"
		else:
			l3 = "\nproc; fsm; opt; memory; opt"
		l4 = "\ntechmap; opt"
		l5 = "\ndfflibmap -liberty "+self.std_lib
		l6 = "\nabc -liberty "+self.std_lib
		l7 = "\nstat -liberty "+self.std_lib
		l8 = "\nwrite_verilog "+os.path.join(self.op_path,'out_synth.v')
		l9 = "\nclean"

		# file io
		f = open(os.path.join(self.op_path,'out_synth.ys'), 'w')
		f.writelines([l1, l2, l3, l4, l5, l6, l7, l8, l9])
		f.close() 

	def _exec_ys(self):
		print('\nInitiating Yosys Synthesis')
		subprocess.call(shlex.split('yosys '+os.path.join(self.op_path,'out_synth.ys')))

	# expand later

	def gen_tcl(self, name = None, std_lib = None, file_v = None):
		pass
	
	def _exec_genus(self):
		pass
		# print('\nInitiating Genus Synthesis')
		# subprocess.call(shlex.split('genus '+os.path.))
		
		
		
		
		