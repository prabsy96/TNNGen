import os
import sys
import subprocess
import shlex

class sim_support:
	def __init__(self, outputfile = 'sim_out', libdir = None, sv = False, file = None):
		self.outputfile = outputfile
		self.libdir = libdir
		self.sv = sv
		
		if file == None:
			raise ValueError("File argument is missing")
		else:
			self.file = file
	
		if isinstance(sv, bool) is False:
			raise TypeError("Flag sv should be of type Bool")
			
	def run_vcs(self, notimingcheck = False, tb = 'no', verbose = 'no'):
	# extended from veriloggen.simulation
		
		cmd = []
		cmd.append('vcs')
		
		if self.sv is True:
			cmd.append('-sv')
		
		if tb == 'yes':
			   cmd.append('-debug_all')
		
		if sys.maxsize > 2**32:
			   cmd.append('-full64')
		
		if notimingcheck:
			cmd.append('+notimingcheck')
			
		if verbose not in ['yes', 'no']:
			raise ValueError('Invalid value for verbose flag')
		else:
			if verbose == 'yes':
				cmd.append('-V')
			
		cmd.append(self.file)
			
		cmd = ' '.join(cmd)
		
		if not os.path.exists(self.outputfile):
			os.mkdir(self.outputfile)
		
		proc = subprocess.Popen(cmd, shell = True, cwd = './'+self.outputfile, stdout = subprocess.PIPE)
		dis = []
		
		while True:
			data = proc.stdout.readline()
			out = data.decode(sys.getdefaultencoding())
			dis.append(out)
			print(out, end = '')
			if not data:
				break
				
		proc.wait()
		proc.stdout.close()
		dis = ''.join(dis)
		
		
		
		#sim_res = subprocess.call(shlex.split(cmd), shell = True)
		#return sim_res
	
	def run_xrun(self, nospecify = 'yes', timescale = '1ns/1ps'):
		
		cmd = []
		cmd.append('xrun')
	
		cmd.append('-clean')
		if nospecify == 'yes':
			cmd.append('-nospecify')
		cmd.append('-timescale')
		cmd.append('-mess')
		cmd.append('-access +rwc')
		if self.sv is True:
			cmd.append('-sv')
		cmd.append(self.file)
		
		sim.res = subprocess.call(shlex.split(cmd))
		return sim_res
		

def dve(self):
	
	cmd = []
	cmd 
			
		
