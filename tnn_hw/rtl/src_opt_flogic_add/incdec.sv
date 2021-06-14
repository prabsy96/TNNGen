// Author: Harideep Nair

// Inc/Dec Logic to generate inc/dec signals for STDP based on cases and BRVs
// Assumes inputs from LFSR (doesn't implement LFSR)

module incdec (inc, dec, stdp_cases, capture, minus, search, backoff, min, F);

    input logic [0:3] stdp_cases;
    input logic capture, minus, search, backoff, min, F;
    output logic inc, dec;

    logic temp;

    assign temp = F | min;

    assign inc = (stdp_cases[0] & capture & temp) | (stdp_cases[2] & search);
    assign dec = (stdp_cases[1] & minus & temp) | (stdp_cases[3] & backoff & temp);

endmodule
