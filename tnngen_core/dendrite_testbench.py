# A testbench script to test submodules defined in dendrite.py
# Author: Yuyang Kang

from veriloggen import *
from dendrite import ActiveDendrite
import random

# Function to create a testbench for Comp_column module
def create_comp_column_testbench():
    # Create the testbench module
    tb = Module('comp_column_testbench')

    # Define clock and reset signals
    clk = tb.Reg('clk', initval=0)
    rst = tb.Reg('rst', initval=0)

    # Define parameters for the Comp_column method
    num_neurons = 10
    num_dend = 16
    p_dist = 3
    p_prox = 1
    q = 2
    wres_dist = 3
    wres_prox = 3
    thres = 13

    # Create an instance of the ActiveDendrite class
    active_dendrite = ActiveDendrite(num_neurons, num_dend, p_dist, p_prox, q, wres_dist, wres_prox, thres)

    # Get the Comp_column module from ActiveDendrite
    comp_column_module, _ = active_dendrite.Comp_column()

    # Instantiate the Comp_column module in the testbench
    tb.Instance(comp_column_module, 'comp_column_instance',
                 ports={'clk': clk, 'grst': rst, 'rstb': rst})

    # Clock generation
    tb.Initial(
        clk(0),
        rst(1),
        Delay(10),
        rst(0),
        Forever(Delay(1), clk(~clk))
    )

    return tb

# Function to create a testbench for Dendrite module
def create_dendrite_testbench():
    # Create the testbench module
    tb = Module('dendrite_testbench')

    # Define clock and reset signals
    clk = tb.Reg('clk', initval=0)
    rst = tb.Reg('rst', initval=0)

    # Define parameters for the Dendrite module
    p_dist = 3
    p_prox = 1
    q = 2
    wres_dist = 3
    wres_prox = 3
    thres = 13

    # Create an instance of the ActiveDendrite class
    active_dendrite = ActiveDendrite()

    # Get the Dendrite module from ActiveDendrite
    dendrite_module, _ = active_dendrite.Dendrite(p_dist, p_prox, q, wres_dist, wres_prox, thres)

    # Instantiate the Dendrite module in the testbench
    tb.Instance(dendrite_module, 'dendrite_instance',
                 ports={'clk': clk, 'grst': rst, 'rstb': rst})

    # Clock generation
    tb.Initial(
        clk(0),
        rst(1),
        Delay(10),
        rst(0),
        Forever(Delay(1), clk(~clk))
    )

    return tb

# Function to create a testbench for Neuron Computation module
def create_neuron_computation_testbench():
    # Create the testbench module
    tb = Module('neuron_computation_testbench')

    # Define clock and reset signals
    clk = tb.Reg('clk', initval=0)
    rst = tb.Reg('rst', initval=0)

    # Create an instance of ActiveDendrite and get the neuron module
    active_dendrite = ActiveDendrite()
    neuron_module, clk_name = active_dendrite.Comp_neuron()

    # Instantiate the neuron module in the testbench
    tb.Instance(neuron_module, 'neuron_instance',
                 ports={'clk': clk, 'grst': rst, 'rstb': rst})

    # Define inputs and expected outputs
    input_data = [random.randint(0, 1) for _ in range(5)]
    expected_output = [1 if x == 1 else 0 for x in input_data]

    # Stimulus generation
    stimulus = []
    for i, data in enumerate(input_data):
        stimulus.extend([
            Delay(1),
            clk(1),
            Delay(1),
            clk(0)
        ])

    # Setup initial conditions and clock generation
    tb.Initial(
        clk(0),
        rst(1),
        Delay(10),
        rst(0),
        *stimulus,
        Delay(10),
        Forever(Delay(1), clk(~clk))
    )

    return tb

# Generate and save Verilog files for each testbench
if __name__ == "__main__":
    comp_column_tb = create_comp_column_testbench()
    comp_column_tb.to_verilog('comp_column_testbench.v')

    dendrite_tb = create_dendrite_testbench()
    dendrite_tb.to_verilog('dendrite_testbench.v')

    neuron_tb = create_neuron_computation_testbench()
    neuron_tb.to_verilog('neuron_computation_testbench.v')
