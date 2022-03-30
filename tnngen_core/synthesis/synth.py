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
    
    def __init__(self, file=None, synth_out='SYNTH'):# name = None):
        
        if file is None:
            raise ValueError("Arg .tcl file is missing")
        else:
            self.file = file
            
#         if file is None:
#             raise ValueError("Arg 'name' is missing")
#         elif isinstance(name, str) is False:
#             raise TypeError("Arg 'synth_out' needs to be type %s")
#         else:
#             self.name = name
            
        if isinstance(synth_out, str) is False:
            raise TypeError("Arg output synth directory needs to be type %s")
        else:
            self.synth_out = synth_out
            self.synth_out = os.path.join(pathlib.Path.cwd(), self.synth_out)


# In[3]:


def gen_genus_tcl(self, p, q, thres, freq, if_clk=None, gen_eff='medium', map_opt_eff='medium', lp_clk_gate='yes',
                 lp_power_eff='medium', max_cpu= 8, lec='yes'):
    
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
    
    
    if not os.path.exists(self.synth_out):
        os.makedirs(self.synth_out)
        
    print("\nInitiating Genus Synthesis")
    cmd = []
    cmd.append("genus -del_scale 10 -execute \"set P\" ")
    cmd.append(p)
    cmd.append("; set Q ")
    cmd.append(q)
    cmd.append("; set THRESHOLD ")
    cmd.append(thres)
    cmd.append("; set ACLKP ")
    cmd.append(freq)
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




