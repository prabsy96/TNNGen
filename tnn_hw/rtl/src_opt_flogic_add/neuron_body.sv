/*
 * Author: Harideep Nair
 *
 * Implements the body (soma) of an SRM0 neuron with ramp-no-leak (RNL) response function.
 * Accumulates response functions from all synapses and generates an output spike when threshold is crossed.
 *
 * Parameters  : INPUT_SIZE    - number of synapses per neuron (equivalent to 'P' in column)
 *               THRESHOLD     - spiking threshold for neuron
 *
 * Inputs      : acc_in        - unary outputs from synapses (1 bit output per synapse)
 *               aclk          - unit clock for temporal encoding
 *               pac_rst       - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 *               rst           - system reset (synchronous with gclk)
 * Outputs     : output_spike  - output spike of neuron encoded as an 8-cycle wide pulse
 */

`timescale 1ns / 1ps

module neuron_body (output_spike, acc_in, aclk, pac_rst, rst);

    parameter INPUT_SIZE = 16;
    parameter THRESHOLD = 13;

    input logic [0:INPUT_SIZE-1] acc_in;
    input logic aclk, pac_rst, rst;
    output logic output_spike;

    logic temp_spike;

    pac #(INPUT_SIZE, THRESHOLD) p1 (.out(temp_spike),
                                     .in(acc_in),
                                     .aclk(aclk),
                                     .grst(pac_rst)
                                    );
 
    fsm_simple fs (.out(output_spike),
                   .in(temp_spike),
                   .aclk(aclk),
                   .rst(rst)
                  );

endmodule
