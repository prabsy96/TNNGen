/*
 * Author: Harideep Nair
 *
 * Implements a 'less than or equal' temporal operator.
 * Data input is allowed to pass only if it arrives before or at the same time as inhibit input.
 * Data input can be an edge or a pulse signal of any width.
 *
 * Assumptions : 1) inhibit input is a 0->1 edge signal.
 *
 * Inputs     : data_in    - data input
 *              inhibit_in - inhibit input
 *              aclk       - unit clock for temporal encoding
 *              rst_in     - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 * Outputs    : out        - output signal (either equal to data input or null)
 */

module less_equal (out, data_in, inhibit_in, aclk, rst_in);

    input logic data_in, inhibit_in, aclk, rst_in;
    output logic out;

    logic temp1, temp2,inhibit_in_bar,inhibit_in_bar_bar;
	/*
    assign temp1 = ~data_in & inhibit_in;

    pulse2edge pe (.edge_out(temp2),
                   .pulse_in(temp1),
                   .aclk(aclk),
                   .grst(rst_in)
                  );
	*/

	inhibit_pass DUT_wq(.INHIBIT(inhibit_in),.DATA_IN(data_in),.OUT(temp2));
 
    assign out = data_in & temp2;

endmodule
