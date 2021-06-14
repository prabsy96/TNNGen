/*
 * Author: Harideep Nair
 *
 * Implements the logic used to generate STDP's inc/dec signals for incrementing/decrementing synaptic weights.
 * Uses the STDP cases and input BRVs to generate inc/dec signals appropriately.
 *
 * Inputs      : stdp_cases    - input bits corresponding to the four stdp cases, namely, capture, minus, search and backoff 
 *               capture       - BRV for STDP's 'capture' case
 *               minus         - BRV for STDP's 'minus' case
 *               search        - BRV for STDP's 'search' case
 *               backoff       - BRV for STDP's 'backoff' case
 *               min           - BRV for enforcing a minimum probability for update
 *               F             - BRV for stabilizing weights towards 0 and 7
 * Outputs     : inc           - increment signal to increase the synaptic weight
 *               dec           - decrement signal to decrease the synaptic weight
 */

module incdec (inc, dec, stdp_cases, capture, minus, search, backoff, min, F);

    input logic [0:3] stdp_cases;
    input logic capture, minus, search, backoff, min, F;
    output logic inc, dec;

     logic temp;
/*
    assign temp = F | min;

    assign inc = (stdp_cases[0] & capture & temp) | (stdp_cases[2] & search);
    assign dec = (stdp_cases[1] & minus & temp) | (stdp_cases[3] & backoff & temp); 
*/	
	incdec_macro macro_init (.MIN(min), .F(F), .BACKOFF(backoff), .STDP_CASES_3(stdp_cases[3]), 
	                     .STDP_CASES_1(stdp_cases[1]), .MINUS(minus), .CAPTURE(capture), 
						 .STDP_CASES_0(stdp_cases[0]), .STDP_CASES_2(stdp_cases[2]), 
						 .SEARCH(search), .DEC(dec), .INC(inc));

endmodule
