/*
 * Author: Harideep Nair
 *
 * Top-level module
 *
 * Implements a TNN column consisting of Excitatory Column (EC) and Lateral Inhibition (LI), capable of online learning.
 * EC consists of SRM0 neurons implementing ramp-no-leak (RNL) response function.
 * LI implements a 1 winner-take-all (WTA) mechanism, wherein the earliest spiking neuron is the winner.
 * Among multiple winners, LI breaks ties by choosing the winning neuron with the lowest index.
 * Uses temporal encoding - inputs are provided in terms of spikes and their values are encoded in the corresponding spiketimes.
 * The learning mechanism implemented is Spike Timing Dependent Plasticity (STDP), which performs online, local, unsupervised clustering.
 * STDP implements four cases: 1) capture, 2) minus, 3) search, and 4) backoff and performs stochastic updates using Bernoulli random variables (BRVs).
 *
 * Assumptions : 1) weights are encoded as binary values.
 *               2) bit resolution for synaptic weights is 3, i.e., weights range from 0 to 7 (wmax).
 *               3) input spikes are encoded as pulses having a width of 8 (wmax+1) unit clock cycles.
 *               4) earliest input spike occurs atleast one unit clock period after the posedge of gamma clock, since STDP updates occur at posedge of gamma.
 *
 * Parameters  : P             - number of synapses per neuron
 *               Q             - number of neurons in EC
 *               THRESHOLD     - spiking threshold for neuron
 *
 * Inputs      : input_spikes  - input spikes to the column encoded as 8-cycle wide pulses
 *               capture       - BRVs for STDP's 'capture' case
 *               minus         - BRVs for STDP's 'minus' case
 *               search        - BRVs for STDP's 'search' case
 *               backoff       - BRVs for STDP's 'backoff' case
 *               min           - BRVs for enforcing a minimum probability for update
 *               F             - BRVs for stabilizing weights towards 0 and 7
 *               aclk          - unit clock for temporal encoding
 *               gclk          - gamma clock that separates computational waves
 *               rst           - system reset (synchronous with gclk)
 * Outputs     : output_spikes - output spikes of LI encoded as 8-cycle wide pulses
 */

module column (output_spikes, input_spikes, capture, minus, search, backoff, min, F, aclk, gclk, rst);

    parameter P          = 4;
    parameter Q          = 3;
    parameter THRESHOLD  = 11;
    
    genvar i, j;

    input logic [0:P-1] input_spikes;
    input logic [0:Q-1][0:P-1] capture;
    input logic [0:Q-1][0:P-1] minus;
    input logic [0:Q-1][0:P-1] search;
    input logic [0:Q-1][0:P-1] backoff;
    input logic [0:Q-1][0:P-1] min;
    input logic [0:Q-1][0:5] F;
    input logic aclk, gclk, rst;
    output logic [0:Q-1] output_spikes;

    logic [0:P-1] ein;
    logic [0:Q-1] eout;
    logic [0:Q-1] ec_spikes;
    logic [0:Q-1][0:P-1][0:2] weights;
    logic [0:Q-1][0:P-1] inc;
    logic [0:Q-1][0:P-1] dec;
    logic gclk_pulse_1,gclk_pulse_next,gclk_pulse;

    edge2pulse ep (.pulse_out(gclk_pulse_1),
                   .edge_in(gclk),
                   .clk_in(aclk),
			.rst(rst)
                  );
	register #(.WL(1)) weight_1_reg(.clk(aclk),.rst_b(~rst),.d(gclk_pulse_1),.q(gclk_pulse_next),.wen(1));
	assign gclk_pulse = gclk_pulse_1 | gclk_pulse_next;

    generate
    for (i = 0; i < P; i = i+ 1)
    begin: edge_input_gen
    
        pulse2edge pe (.edge_out(ein[i]),
                       .pulse_in(input_spikes[i]),
                       .aclk(aclk),
                       .grst(gclk_pulse)
                      );

    end
    endgenerate

    generate
    for (i = 0; i < Q; i = i + 1)
    begin: ec

        neuron_rnl_ptt #(P, THRESHOLD) ec (.output_spike(ec_spikes[i]),
                                           .weights(weights[i]),
                                           .input_spikes(input_spikes),
                                           .inc(inc[i]),
                                           .dec(dec[i]),
                                           .aclk(aclk),
                                           .gclk(gclk),
                                           .grst(gclk_pulse),
                                           .rst(rst)
                                          );

    end
    endgenerate

    wta #(Q) li (.li_out(output_spikes),
                 .ec_spikes(ec_spikes),
                 .aclk(aclk),
                 .grst(gclk_pulse)
                );

    generate
    for (i = 0; i < Q; i = i+ 1)
    begin: edge_output_gen
    
        pulse2edge pe (.edge_out(eout[i]),
                       .pulse_in(output_spikes[i]),
                       .aclk(aclk),
                       .grst(gclk_pulse)
                      );

    end
    endgenerate
    
    generate
    for (i = 0; i < Q; i = i + 1)
    begin: stdplogic1

        for (j = 0; j < P; j = j + 1)
        begin: stdplogic2
    
            stdp s0 (.inc(inc[i][j]),
                     .dec(dec[i][j]),
                     .input_weight(weights[i][j]),
                     .ein(ein[j]),
                     .eout(eout[i]),
                     .capture(capture[i][j]),
                     .minus(minus[i][j]),
                     .search(search[i][j]),
                     .backoff(backoff[i][j]),
                     .min(min[i][j]),
                     .F(F[i]),
                     .aclk(aclk),
                     .grst(gclk_pulse)
                    );

        end

    end
    endgenerate

endmodule
