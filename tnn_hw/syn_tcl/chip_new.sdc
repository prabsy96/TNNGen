create_clock [get_ports aclk]  -period 10000.00  -waveform {0 5} -name aclk
create_clock [get_ports gclk]  -period 150000.00  -waveform {0 5} -name gclk

set_clock_uncertainty 0.1  [get_clocks aclk]
set_clock_transition -fall 0.15 [get_clocks aclk]
set_clock_transition -rise 0.15 [get_clocks aclk]

set_input_delay 2 -clock aclk [remove_from_collection [all_inputs] aclk]
set_output_delay 2 -clock aclk [all_outputs]
set_load 15 [all_outputs]

