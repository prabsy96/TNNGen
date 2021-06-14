/*
 * Author: Harideep Nair
 *
 * Implements the logic used to generate control signals corresponding to four STDP cases as below:
 * capture - both input and output spikes are present; input spike arrives before or at the same time as output spike.
 * minus   - both input and output spikes are present; output spike arrives before input spike.
 * search  - only input spike is present.
 * backoff - only output spike is present.
 * Case when both input and output spikes are absent is implicit; elicits no change.
 *
 * Inputs      : ein           - input spike for the corresponding synapses encoded as 0->1 edge
 *               eout          - output spike of the neuron encoded as 0->1 edge
 *               aclk          - unit clock for temporal encoding
 *               grst          - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 * Outputs     : stdp_cases    - output bits corresponding to the four stdp cases, asserted until gamma clock arrives
 */

module stdp_case_gen (stdp_cases, ein, eout, aclk, grst);

    input logic ein, eout, aclk, grst;
    output logic [0:3] stdp_cases; 
    logic temp, tboth, tone;

    assign temp = ~ein & eout;

    pulse2edge pe (.edge_out(greater),
                   .pulse_in(temp),
                   .aclk(aclk),
                   .grst(grst)
                  );
always_comb begin
      stdp_cases = 4'd0;
	  if ({ein,eout}==2'd2)
	    stdp_cases[2] = 1;
	  else if ({ein,eout}==2'd1)
	    stdp_cases[3] = 1;
      else if ({ein,eout}==2'd3) begin
        if (greater)
		  stdp_cases[1] = 1;
		else
		  stdp_cases[0] = 1;
	   end
	end 


endmodule
