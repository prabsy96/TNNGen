#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Author: Prabhu Vellaisamy
# Python3 script to provide synthesis support using EDA tools


# In[2]:


import os
import sys
import subprocess
import pathlib
import shlex


# In[4]:


class synth_support:
	
	
	def __init__(self, obj, file_v, clk, p, q, thres,  freq, gen_eff, map_opt_eff, lib_path, tcl_path, hdl_path):# name = None):
	
		self.obj = obj
		self.clk = clk
		self.p = p
		self.q = q
		self.thres = thres
		self.freq  = freq
		
        
		if isinstance(file_v, str) is False:
			raise TypeError("verilog file should be of type %s")
		else:
			self.file_v = file_v
			
		if gen_eff, map_opt_eff not in ('low', 'medium', 'high'):
			raise ValueError ("Effort variables have to be low, medium or high")
		else:
			self.gen_eff = gen_eff
			self.map_opt_eff = map_opt_eff
		
		if isinstance(lib_path, str) or isinstance(tcl_path, str) or isinstance(hdl_path, str) is False:
			raise TypeError("Paths should be of type %s")
		else:
			self.lib_path = lib_path
			self.tcl_path = tcl_path
			self.hdl_path = hdl_path
            
		# if isinstance(synth_out, str) is False:
			# raise TypeError("Arg output synth directory needs to be type %s")
		# else:
			# self.synth_out = synth_out
			# self.synth_out = os.path.join(pathlib.Path.cwd(), self.synth_out)
			
		gen_genus_tcl()


# In[3]:


def gen_genus_tcl():
    
    # Column specific params
    # -------
    # p: # of synapses per output neuron
    # q: # of output neurons
    # thres: threshold value
    
    # Add the following later ----
    # if_clk: clock is rtl?
    # gen_eff: generic effort value (low, medium, high)
    # map_opt_eff: mapping & optimization effort value (low, medium, high)
    # lp_clk_gate: enable clock gating? yes/no
    # lp_power_eff: low power analysis effort value (low, medium, high)
    # max_cpu: maximum # of CPUs per server
    # lec: produce .lec files for conformal checks? (yes/no)
    
	
	s
	
	if not os.path.exists('./SYNTH'):
		os.makedirs('./SYNTH')
        
	print("\nInitiating Genus Synthesis")
	cmd = []
	cmd.append("genus -del_scale 10 -execute \"set P\" ")
	cmd.append(self.p)
	cmd.append("; set Q ")
	cmd.append(self.q)
	cmd.append("; set THRESHOLD ")
	cmd.append(self.thres)
	cmd.append("; set ACLKP ")
	cmd.append(self.freq)
	cmd.append("; set TOP ")
	cmd.append(self.obj.name)
	cmd.append("; set GEN_EFF ")
	cmd.append(self.gen_eff)
	cmd.append("; set MAP_OPT_EFF ")
	cmd.append(self.map_opt_eff)
	cmd.append("; set LIB_PATH ")
	cmd.append(self.lib_path)
	cmd.append("; set TCL_PATH ")
	cmd.append(self.tcl_path)
	cmd.append("; set HDL_PATH ")
	cmd.append(self.hdl_path)
	cmd.append(" -f ")
	cmd.append(self.files)
	cmd = ' '.join(cmd)
	proc = subprocess.Popen(cmd, shell = True, cwd = self.output, stdout = subprocess.PIPE)
	dis = []
    
    while True:
        data = proc.stdout.readline()
        out = data.decode(sys.getdefaultencoding())
        dis.append(out)
        print(out, end = '')
        if not data:
            break
    proc.communicate()
    proc.stdout.close()
    dis = ''.join(dis)
    
    
        
    
    
    


# In[ ]:




