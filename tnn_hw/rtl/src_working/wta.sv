/*
 * Author: Harideep Nair
 *
 * Implements 1-Winner Take All (WTA) Lateral Inhibition, wherein the earliest spiking neuron is the winner.
 * Among multiple winners, it breaks ties by choosing the winning neuron with the lowest index.
 *
 * Parameters  : Q             - number of neurons in EC
 *
 * Inputs      : ec_spikes     - output spikes of excitatory column encoded as 8-cycle wide pulses
 *               aclk          - unit clock for temporal encoding
 *               grst          - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 * Outputs     : li_out        - output spikes of LI encoded as 8-cycle wide pulses
 */

module wta (li_out, ec_spikes, aclk, grst);

    parameter Q = 4;

    genvar i, j;
    
    input logic [0:Q-1] ec_spikes;
    input logic aclk, grst;
    output logic [0:Q-1] li_out;

    logic first_spike, first_spike_edge;
    logic [0:Q-1] temp;

    assign first_spike = |ec_spikes;

    pulse2edge wta_pe (.edge_out(first_spike_edge),
                       .pulse_in(first_spike),
                       .aclk(aclk),
                       .grst(grst)
                      );
    
    generate
    for (i = 0; i < Q; i = i + 1)
    begin: less_than_or_equal
    
        less_equal l1 (.out(temp[i]),
                       .data_in(ec_spikes[i]),
                       .inhibit_in(first_spike_edge),
                       .aclk(aclk),
                       .rst_in(grst)
                      );

    end
    endgenerate

    assign li_out[0] = temp[0];
    
    generate
    for (j = 1; j < Q; j = j + 1)
    begin: tie_break
    
        assign li_out[j] = temp[j] & ~(|temp[0:j-1]); 
    
    end
    endgenerate

endmodule
