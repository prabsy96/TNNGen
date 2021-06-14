// Verilog for library fsm_weight_incdec created by Liberate 19.2.0.100 on Wed Aug  5 22:36:04 EDT 2020 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module fsm_weight_incdec (TDEC, TINC, DEC, GCLK, INC, INPUT_SPIKE, NXT_GCLK, STORE_WEIGHT_0, STORE_WEIGHT_1, STORE_WEIGHT_2);
	output TDEC, TINC;
	input DEC, GCLK, INC, INPUT_SPIKE, NXT_GCLK, STORE_WEIGHT_0, STORE_WEIGHT_1, STORE_WEIGHT_2;

	// Function

    assign TINC = INC & ~INPUT_SPIKE & ~NXT_GCLK & GCLK & ~(STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2);
    assign TDEC = DEC & ~INPUT_SPIKE & ~NXT_GCLK & GCLK & ((STORE_WEIGHT_0 | STORE_WEIGHT_1 | STORE_WEIGHT_2));


endmodule
`endcelldefine

