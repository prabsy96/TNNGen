# C3SGen - Core
The core infrastructure for C3SGen. To use it, run
```
python3 main.py -f args.txt
```
The `args.txt` file is required.

## Arg file formatting
To use the infrastructure, you must provide a text file that contains the following sets of arguments
* Mode Parameters (**KEY**)
  * Options: `on` or `off`
  * `sim_switch` : Simulation
  * `syn_switch` : Synthesis
* Common Parameters
  * `neurons` : Number of neurons per TNN Column (first layer)
  * `theta`   : Spiking threshold of neurons (first layer)
  * `rfsize`  : Size of receptive field (first layer)
  * `nprev`   : Previous neurons
  * `wres`    : Bit resolution for weights
* Sim-specific parameters
  * See below
* Frequency
  * **Key** `flow` : Hardware process flow
    * Options: `rtl` for RTL-generation only, `sim` for functional simulation, `syn`/`pnr` for synthesis until PNR

_Example_
---
```
### Parameters ###

# Modes
sim_switch	= off		  # Turn on/off TNNSim
syn_switch	= on		  # Turn on/off TNNSyn

# Common params
neurons         = 3               # Number of neurons per TNN Column (first layer)
theta           = 6               # Spiking threshold of neurons (first layer)
rfsize          = 2               # Size of receptive field (first layer)
nprev           = 1               # Previous Neurons
wres            = 3 	          # Bit resolution for weights

# TNNSim-specific parameters
imgsize         = 28          	  # Size of input image
stride          = 1               # Stride for sliding the receptive field (first layer)
num_classes     = 10        	  # Number of labels or classes (first layer)
resize		= 0		  # Resize image
resize_param	= (15,15)	  # Output size after resizing
filter		= 1		  # Choose if On-Off filter needed
crop		= 1		  # Crop image
crop_size	= (3,3)		  # Output size after cropping
crop_pos	= (12,12)	  # Top left corner of crop position
pn_thresh	= 0.5		  # Fraction of pixel values that are considered black
timeres         = 3	          # Bit resolution for maximum input spiketime
ntype           = rnl  	          # SRM0 neuron response function model
ramp            = 1	          # Slope of ramp-no-leak response function
w_init          = zero		  # Weight initialization
k               = 1               # For k-WTA
stoch           = low             # Level of stochasticity for STDP
ucapture        = 640             # STDP's "capture" Bernoulli random variable probability
usearch         = 2               # STDP's "search" Bernoulli random variable probability
ubackoff        = 952             # STDP's "backoff" Bernoulli random variable probability
ubackoff_simp   = 512      	  # STDP's "backoff_simp" Bernoulli random variable probability
umin            = 70              # STDP's "min" Bernoulli random variable probability
inc_learn       = 0          	  # Enable/disable unsupervised STDP incremental learning during testing
#nprev          = 1               # Number of channels in the first layer
weights_save    = 1               # Save weights after training

### Frequency
flow            = pnr             # Hardware process flow
aclk_freq       = 10000000.00     # System Clock period in ps
gclk_freq       = 240000000.00    # Gamma Clock period in ps
tool            = Cadence         # Synopsys/Cadence
lib_path        =                 # path to cell library
lef_path        =                 # path to lef files
qrc_file        =
cap_file        = 
```

