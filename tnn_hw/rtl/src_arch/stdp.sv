// Author: Harideep Nair

// STDP Logic to generate inc and dec signals for weights
// Implements five cases: capture, minus, search, backoff and no change
// Assumes inputs from LFSR (doesn't implement LFSR)
/*
 * Author: Harideep Nair
 *
 * Implements the STDP logic for each synapse.
 * Generates control signals for incrementing/decrementing the corresponding synaptic weight based on four cases as below.
 * capture - both input and output spikes are present; input spike arrives before or at the same time as output spike.
 * minus   - both input and output spikes are present; output spike arrives before input spike.
 * search  - only input spike is present.
 * backoff - only output spike is present.
 * Case when both input and output spikes are absent is implicit; elicits no change.
 *
 * Inputs      : input_weight  - corresponding synaptic weight 
 *               ein           - input spike for the corresponding synapses encoded as 0->1 edge
 *               eout          - output spike of the neuron encoded as 0->1 edge
 *               capture       - BRV for STDP's 'capture' case
 *               minus         - BRV for STDP's 'minus' case
 *               search        - BRV for STDP's 'search' case
 *               backoff       - BRV for STDP's 'backoff' case
 *               min           - BRV for enforcing a minimum probability for update
 *               F             - BRV for stabilizing weights towards 0 and 7
 *               aclk          - unit clock for temporal encoding
 *               grst          - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 * Outputs     : inc           - increment signal to increase the synaptic weight
 *               dec           - decrement signal to decrease the synaptic weight
 */

module stdp (inc, dec, input_weight, ein, eout, capture, minus, search, backoff, min, F, aclk, grst);

    input logic ein, eout, capture, minus, search, backoff, min, aclk, grst;
    input logic [0:2] input_weight;
    input logic [0:5] F;
    output logic inc, dec;

    logic [0:3] stdp_cases;
    logic fout;

    stdp_case_gen s1 (.stdp_cases(stdp_cases),
                      .ein(ein),
                      .eout(eout),
                      .aclk(aclk),
                      .grst(grst)
                     );

    flogic s2 (.out(fout),
               .input_weight(input_weight),
               .F(F)
              );

    incdec s3 (.inc(inc),
               .dec(dec),
               .stdp_cases(stdp_cases),
               .capture(capture),
               .minus(minus),
               .search(search),
               .backoff(backoff),
               .min(min),
               .F(fout)
              );
    
endmodule
