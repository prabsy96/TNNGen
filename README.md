# TNNGen

Framework for generating Temporal Neural Network ecosystems with support for predictive 7 nm post-synthesis PPA metric results

# Instructions -

```bash
sudo apt install iverilog

pip3 install pyverilog numpy

sudo apt install verilator

sudo apt-get install -y gtkwave
```

# Directories & Files -

- TNNGen

  |__ asap7/ -> contains all the standard cell .lib files
  
  |__ tnn_hw/ -> original TNN HW framework (https://github.com/hpnair/Neuromorphosis---TNNCMOS)
  
  |__ tnn_sw/ -> Pytorch implementation of TNNs (https://github.com/hpnair/Neuromorphosis---TNNSim)
  
  |__ Pyverilog-develop -> Pyverilog dir (https://github.com/PyHDI/Pyverilog)
  
  |__ veriloggen-develop -> Veriloggen dir (https://github.com/PyHDI/veriloggen)

src_veriloggen/tnn_func_mdls.py -> contains veriloggen function scripts for generating all the TNN column submodules

src_veriloggen/column.py -> veriloggen function script for top level TNN column 

-------------------------------------------------------------------------------------------------------

pyverilog - https://pypi.org/project/pyverilog/

veriloggen - https://github.com/PyHDI/veriloggen

post-synthesis -> yosys (has ABC in backend)

RTL to GDSII -> OpenROAD

