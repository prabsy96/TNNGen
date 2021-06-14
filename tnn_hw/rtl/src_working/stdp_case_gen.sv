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
	//stdp_case_gen_macro stdp (.EIN(ein),.EOUT(eout),.stdp_cases_0(stdp_cases[0]),.stdp_cases_1(stdp_cases[1]),.stdp_cases_2(stdp_cases[2]),.stdp_cases_3(stdp_cases[3]));

    logic temp, tboth, tone,eout_bar,eout_bar_bar;

	inhibit_pass DUT_wq(.INHIBIT(eout),.DATA_IN(ein),.OUT(temp));
    ////////////assign temp = ~ein & eout;

    //pulse2edge pe (.edge_out(greater),
      //             .pulse_in(temp),
        /////////           .aclk(aclk),
                 //  .grst(grst)
                  //);
/*
    assign tboth = ein & eout;
    assign tone  = ein ^ eout;

    assign stdp_cases[0] = ~greater & tboth;
    assign stdp_cases[1] =  greater & tboth;
    assign stdp_cases[2] = ~greater & tone;
    assign stdp_cases[3] =  greater & tone;
*/

assign greater = eout & ~temp;

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
