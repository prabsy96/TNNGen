#!/usr/bin/env python
# coding: utf-8

# In[5]:


# Author: Prabhu Vellaisamy
# Script to invoke EDA simulators


# In[1]:


# import libraries
import os
import subprocess
import sys


# In[2]:


class sim_support:
    
    def __init__(self, sim_out='SIM', file=None):
        
        # sim_out: folder to store the resulting sim executables
        # file: filename of testbench .v file to be simulated
        
        if isinstance(sim_out, str) is False:
            raise TypeError("Arg 'sim_out' needs to be of type %s")
        else:
            self.sim_out = sim_out
        
        
        if file is None:
            raise ValueError("Arg .v file not provided")
        elif isinstance(file, str) is False:
            raise TypeError("Arg .v file needs to be of type %s")
        else:
            self.file = file
 


# In[3]:


    def run_xrun (self, nospecify='yes', timescale='1ns/1ps'):
        
        # check if sim_out exists already
        if not os.path.exists(self.sim_out):
            os.mkdir(self.sim_out)
        
        cmd = []
        cmd.append('xrun')
        cmd.append('-clean')
        
        if nospecify == 'yes':
            cmd.append('-nospecify')
        
        cmd.append('-timescale '+timescale)
        cmd.append('-mess')
        cmd.append('-access +rwc')
        cmd.append(self.file)
        
        cmd = ' '.join(cmd)
        print(cmd)
        
        proc = subprocess.Popen(cmd, shell = True, cwd = './'+self.sim_out, stdout=subprocess.PIPE)
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
        
        return dis


# In[4]:


    def simvision(self):
        cmd = []
        cmd.append('simvision')
        
        if sys.maxsize > 2**32:
            cmd.append('-64BIT')
        
        cmd = ' '.join(cmd)
        
        proc = subprocess.Popen(cmd, shell = True, cwd = './'+self.outputfile, stdout = subprocess.PIPE)
        
        proc.wait()
        proc.stdout.close()


# In[ ]:





# In[ ]:




