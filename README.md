# TNNGen

A framework for generating Temporal Neural Network (TNN) ecosystems with post-synthesis process flow support. As of now, the framework supports the open-source flow for RTL simulation (iVerilog) and RTL synthesis (Yosys). Synthesis support is currently being experimented using the open source Nangate 45nm cell libraries. 

# Instructions -

Till TNNGen is published as a package, please install the following dependencies:

```bash

sudo apt install iverilog

pip3 install pyverilog

sudo apt-get install -y gtkwave

```
Follow Yosys installation from here: http://www.clifford.at/yosys/download.html

# Directories & Files -

- TNNGen
  
  |__ tnn_hw/ -> Original TNN HW framework (https://github.com/hpnair/Neuromorphosis---TNNCMOS) by Harideep Nair
  
  |__ tnn_sw/ -> Pytorch implementation of TNNs (https://github.com/hpnair/Neuromorphosis---TNNSim) by Harideep Nair
  
  |__ veriloggen-develop/ -> Veriloggen dir (https://github.com/PyHDI/veriloggen)
  
  |__ yosys_dev/ -> Yosys experimentation

  |__ tnngen_core/ -> Parent directory for TNNGen 
	
     |__ backend/backend.py
	
     |__ synthesis/synthesis.py 

     |__ tnn_mdls/func_mdls.py

     |__ column.py
	
     |__ main.py 

-------------------------------------------------------------------------------------------------------

# To run script - 

```bash

python3 main.py 

```

Command line arguments: 
                         
			 [--top <top_lvl column module> 
                         
			 --tb <testbench> 
	                 
			 --flow <rtl_sim, rtl_synth, post_synth_verif>, 
                         
			 --run_sim <run sim> 
	                 
			 --simulator <iverilog, vcs, xrun> 
	                 
			 --print <print code in console> ]

--------------------------------------------------------------------------------------------------------
pyverilog - https://pypi.org/project/pyverilog/

veriloggen - https://github.com/PyHDI/veriloggen

post-synthesis -> yosys (has ABC in backend)

RTL to GDSII -> OpenROAD

