#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# Author: Prabhu Vellaisamy
# python3 script that contains backend utility functions


# In[3]:


from veriloggen import *
import os
import pathlib
import subprocess
import sys
import shlex


# In[4]:


sys.path.append("../")
from synthesis.synth import synth_support
from simulation.sim import sim_support


# In[8]:


def gen_verilog(module = None, path = None, filename = None, print_v = 'no'):

    if module is None:
        raise ValueError("Module is required.")
    else:
        if isinstance(module, Module) is False:
            raise TypeError("Object is not of type Veriloggen.Module")

    if path is None and filename is None:
        path = 'RTL'
        filename = 'default.v'
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
            mod_v = module.to_verilog(path+'/'+filename)

    gen_file = str(pathlib.Path.cwd())+'/'+path+'/'+filename

    if print_v == 'yes':
        print(mod_v)

    return (gen_file)


# In[ ]:


def sim_verilog(obj = None, sim_name = 'simvision', wave = None):

    if obj is None:
        raise ValueError("Module is required.")
    else:
        if isinstance(obj, Module) is False:
            raise TypeError("Object is not of type Veriloggen.Module")

#     if sim_name == 'iverilog':
#         # using veriloggen iverilog support
#         sim = simulation.Simulator(obj, sim = 'iverilog')
#         rslt = sim.run(display = True) 
#         print(rslt)
#         console.print("[bold blue]  -> Simulation dump completed")

#         if wave == 'yes':
#             sim.view_waveform()

#     elif sim_name == 'vcs':
#         #sim = simulation.run_vcs(obj, True)
#         sim = run_sim()
#         print(sim) 

# 		if wave == 'yes':
# 			cmd = []
# 			subprocess.call(shlex.split('dve &'))

    if wave == 'yes':
        subprocess.call(shlex.split('simvision &'))

    
    
    return sim

