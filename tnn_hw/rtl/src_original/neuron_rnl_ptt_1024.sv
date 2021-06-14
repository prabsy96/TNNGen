/*
 * Author: Harideep Nair
 *
 * Implements an SRM0 neuron with ramp-no-leak (RNL) response function.
 * Uses temporal encoding - inputs are provided in terms of spikes and their values are encoded in the corresponding spiketimes.
 * STDP learning mechanism is not implemented as part of neuron here; it's implemented separately in the column.
 *
 * Assumptions : 1) weights are encoded as binary values.
 *               2) bit resolution for synaptic weights is 3, i.e., weights range from 0 to 7 (wmax).
 *               3) input spikes are encoded as pulses having a width of 8 (wmax+1) unit clock cycles.
 *               4) earliest input spike occurs atleast one unit clock period after the posedge of gamma clock, since STDP updates occur at posedge of gamma.
 *
 * Parameters  : INPUT_SIZE    - number of synapses per neuron (equivalent to 'P' in column)
 *               THRESHOLD     - spiking threshold for neuron
 *
 * Inputs      : input_spikes  - input spikes to the neuron encoded as 8-cycle wide pulses
 *               inc           - increment signals from STDP to increase corresponding synaptic weights
 *               dec           - decrement signals from STDP to decrease corresponding synaptic weights
 *               aclk          - unit clock for temporal encoding
 *               gclk          - gamma clock that separates computational waves
 *               grst          - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 *               rst           - system reset (synchronous with gclk)
 * Outputs     : output_spike  - output spike of neuron encoded as an 8-cycle wide pulse
 *               weights       - the 3-bit synaptic weights of neuron to be used later in STDP
 */

module neuron_rnl_ptt (output_spike, weights, input_spikes, inc, dec, weight_update_en, aclk, gclk, grst, rst);

    parameter INPUT_SIZE = 1024;
    parameter THRESHOLD = 13;
    
    genvar i;

    input logic [0:INPUT_SIZE-1] input_spikes;
    input logic [0:INPUT_SIZE-1] inc;
    input logic [0:INPUT_SIZE-1] dec;
    input logic weight_update_en, aclk, gclk, grst, rst;
    output logic output_spike;
    output logic [0:INPUT_SIZE-1][0:2] weights;

    logic [0:INPUT_SIZE-1] up_in;

    // Synaptic weight + readout logic FSM
    generate
    for (i = 0; i < INPUT_SIZE; i = i + 1)
    begin: fsm
    
        fsm_synapse f1 (.out(up_in[i]),
                        .weight(weights[i]),
                        .input_spike(input_spikes[i]),
                        .inc(inc[i]),
                        .dec(dec[i]),
                        .weight_update_en(weight_update_en),
                        .aclk(aclk),
                        .gclk(gclk),
                        .rst(rst)
                       );

    end
    endgenerate

    neuron_body #(INPUT_SIZE, THRESHOLD) p1 (.output_spike(output_spike),
                                             .acc_in(up_in),
                                             .aclk(aclk),
                                             .pac_rst(grst),
                                             .rst(rst)
                                            );


endmodule
