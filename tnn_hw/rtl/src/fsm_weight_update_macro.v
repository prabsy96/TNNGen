// Verilog for library fsm_weight_update_macro created by Liberate 19.2.0.100 on Wed Aug  5 22:33:50 EDT 2020 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module fsm_weight_update_macro (NXT_WEIGHT_0, NXT_WEIGHT_1, NXT_WEIGHT_2, INPUT_SPIKE, STORE_WEIGHT_0, STORE_WEIGHT_1, STORE_WEIGHT_2, TDEC, TINC);
	output NXT_WEIGHT_0, NXT_WEIGHT_1, NXT_WEIGHT_2;
	input INPUT_SPIKE, STORE_WEIGHT_0, STORE_WEIGHT_1, STORE_WEIGHT_2, TDEC, TINC;

	// Function
	wire INPUT_SPIKE__bar, int_fwire_0, int_fwire_1;
	wire int_fwire_2, int_fwire_3, int_fwire_4;
	wire int_fwire_5, int_fwire_6, int_fwire_7;
	wire int_fwire_8, int_fwire_9, int_fwire_10;
	wire int_fwire_11, int_fwire_12, int_fwire_13;
	wire int_fwire_14, int_fwire_15, int_fwire_16;
	wire int_fwire_17, STORE_WEIGHT_0__bar, STORE_WEIGHT_1__bar;
	wire STORE_WEIGHT_2__bar, TDEC__bar, TINC__bar;

	not (TINC__bar, TINC);
	not (STORE_WEIGHT_2__bar, STORE_WEIGHT_2);
	not (STORE_WEIGHT_1__bar, STORE_WEIGHT_1);
	not (STORE_WEIGHT_0__bar, STORE_WEIGHT_0);
	and (int_fwire_0, STORE_WEIGHT_0__bar, STORE_WEIGHT_1__bar, STORE_WEIGHT_2__bar, TDEC, TINC__bar);
	and (int_fwire_1, STORE_WEIGHT_0__bar, STORE_WEIGHT_1, STORE_WEIGHT_2, TINC);
	and (int_fwire_2, STORE_WEIGHT_0, STORE_WEIGHT_2__bar, TINC);
	and (int_fwire_3, STORE_WEIGHT_0, STORE_WEIGHT_2, TINC__bar);
	and (int_fwire_4, STORE_WEIGHT_0, STORE_WEIGHT_1__bar, TINC);
	and (int_fwire_5, STORE_WEIGHT_0, STORE_WEIGHT_1, TINC__bar);
	not (TDEC__bar, TDEC);
	not (INPUT_SPIKE__bar, INPUT_SPIKE);
	and (int_fwire_6, INPUT_SPIKE__bar, STORE_WEIGHT_0, TDEC__bar, TINC__bar);
	and (int_fwire_7, INPUT_SPIKE, STORE_WEIGHT_0__bar, STORE_WEIGHT_1__bar, STORE_WEIGHT_2__bar, TINC__bar);
	or (NXT_WEIGHT_0, int_fwire_7, int_fwire_6, int_fwire_5, int_fwire_4, int_fwire_3, int_fwire_2, int_fwire_1, int_fwire_0);
	and (int_fwire_8, STORE_WEIGHT_1__bar, STORE_WEIGHT_2__bar, TDEC, TINC__bar);
	and (int_fwire_9, STORE_WEIGHT_1__bar, STORE_WEIGHT_2, TINC);
	and (int_fwire_10, STORE_WEIGHT_1, STORE_WEIGHT_2__bar, TINC);
	and (int_fwire_11, STORE_WEIGHT_1, STORE_WEIGHT_2, TINC__bar);
	and (int_fwire_12, INPUT_SPIKE__bar, STORE_WEIGHT_1, TDEC__bar, TINC__bar);
	and (int_fwire_13, INPUT_SPIKE, STORE_WEIGHT_1__bar, STORE_WEIGHT_2__bar, TINC__bar);
	or (NXT_WEIGHT_1, int_fwire_13, int_fwire_12, int_fwire_11, int_fwire_10, int_fwire_9, int_fwire_8);
	and (int_fwire_14, STORE_WEIGHT_2__bar, TINC);
	and (int_fwire_15, STORE_WEIGHT_2__bar, TDEC);
	and (int_fwire_16, INPUT_SPIKE__bar, STORE_WEIGHT_2, TDEC__bar, TINC__bar);
	and (int_fwire_17, INPUT_SPIKE, STORE_WEIGHT_2__bar);
	or (NXT_WEIGHT_2, int_fwire_17, int_fwire_16, int_fwire_15, int_fwire_14);

	// Timing
	specify
		if ((~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_0) = 0;
		ifnone (INPUT_SPIKE => NXT_WEIGHT_0) = 0;
		if ((STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TINC) | (INPUT_SPIKE & STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (INPUT_SPIKE & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (INPUT_SPIKE & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TINC) | (~INPUT_SPIKE & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC))
			(STORE_WEIGHT_0 => NXT_WEIGHT_0) = 0;
		ifnone (STORE_WEIGHT_0 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_1 & STORE_WEIGHT_2 & TINC) | (INPUT_SPIKE & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_1 & STORE_WEIGHT_2 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC & ~TINC))
			(STORE_WEIGHT_0 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & TDEC & ~TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_0) = 0;
		if ((~STORE_WEIGHT_0 & STORE_WEIGHT_2 & TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_0) = 0;
		ifnone (STORE_WEIGHT_1 => NXT_WEIGHT_0) = 0;
		if ((STORE_WEIGHT_0 & STORE_WEIGHT_2 & TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & ~TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & TDEC & ~TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		ifnone (STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_0) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_0) = 0;
		ifnone (TDEC => NXT_WEIGHT_0) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_0) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_0) = 0;
		ifnone (TINC => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_0) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_0) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_0) = 0;
		if ((STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_1) = 0;
		if ((~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_1) = 0;
		ifnone (INPUT_SPIKE => NXT_WEIGHT_1) = 0;
		if ((STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_1) = 0;
		if ((STORE_WEIGHT_2 & ~TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_2 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_2 & TDEC & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_2 & ~TDEC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		ifnone (STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		if ((STORE_WEIGHT_0 & STORE_WEIGHT_2 & TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & TDEC & ~TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & ~TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2 & TDEC & ~TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		if ((~STORE_WEIGHT_0 & STORE_WEIGHT_2 & TINC))
			(STORE_WEIGHT_1 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		ifnone (STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_1) = 0;
		ifnone (TDEC => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (~INPUT_SPIKE & STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		ifnone (TINC => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_1) = 0;
		if ((STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_2) = 0;
		if ((STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_2) = 0;
		if ((~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_2) = 0;
		ifnone (INPUT_SPIKE => NXT_WEIGHT_2) = 0;
		if ((STORE_WEIGHT_2 & ~TDEC & ~TINC))
			(INPUT_SPIKE => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_1 & ~TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_1 & ~TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		ifnone (STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~TINC) | (~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & TDEC & ~TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~TDEC & TINC))
			(STORE_WEIGHT_2 => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_2) = 0;
		ifnone (TDEC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_2 & ~TINC))
			(TDEC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_2) = 0;
		ifnone (TINC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_2) = 0;
		if ((~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2 & ~TDEC))
			(TINC => NXT_WEIGHT_2) = 0;
	endspecify
endmodule
`endcelldefine


`ifdef _udp_def_altos_latch_
`else
`define _udp_def_altos_latch_
primitive altos_latch (q, v, clk, d);
	output q;
	reg q;
	input v, clk, d;

	table
		* ? ? : ? : x;
		? 1 0 : ? : 0;
		? 1 1 : ? : 1;
		? x 0 : 0 : -;
		? x 1 : 1 : -;
		? 0 ? : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_err_
`else
`define _udp_def_altos_dff_err_
primitive altos_dff_err (q, clk, d);
	output q;
	reg q;
	input clk, d;

	table
		(0x) ? : ? : 0;
		(1x) ? : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_
`else
`define _udp_def_altos_dff_
primitive altos_dff (q, v, clk, d, xcr);
	output q;
	reg q;
	input v, clk, d, xcr;

	table
		*  ?   ? ? : ? : x;
		? (x1) 0 0 : ? : 0;
		? (x1) 1 0 : ? : 1;
		? (x1) 0 1 : 0 : 0;
		? (x1) 1 1 : 1 : 1;
		? (x1) ? x : ? : -;
		? (bx) 0 ? : 0 : -;
		? (bx) 1 ? : 1 : -;
		? (x0) b ? : ? : -;
		? (x0) ? x : ? : -;
		? (01) 0 ? : ? : 0;
		? (01) 1 ? : ? : 1;
		? (10) ? ? : ? : -;
		?  b   * ? : ? : -;
		?  ?   ? * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_r_err_
`else
`define _udp_def_altos_dff_r_err_
primitive altos_dff_r_err (q, clk, d, r);
	output q;
	reg q;
	input clk, d, r;

	table
		 ?   0 (0x) : ? : -;
		 ?   0 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 0  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 0  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_r_
`else
`define _udp_def_altos_dff_r_
primitive altos_dff_r (q, v, clk, d, r, xcr);
	output q;
	reg q;
	input v, clk, d, r, xcr;

	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 0;
		?  b   ? (1?) ? : 0 : -;
		?  x   0 (1?) ? : 0 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 0 : -;
		? (x1) 0  ?   0 : ? : 0;
		? (x1) 1  0   0 : ? : 1;
		? (x1) 0  ?   1 : 0 : 0;
		? (x1) 1  0   1 : 1 : 1;
		? (x1) ?  ?   x : ? : -;
		? (bx) 0  ?   ? : 0 : -;
		? (bx) 1  0   ? : 1 : -;
		? (x0) 0  ?   ? : ? : -;
		? (x0) 1  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 0  ?   ? : ? : 0;
		? (01) 1  0   ? : ? : 1;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_s_err_
`else
`define _udp_def_altos_dff_s_err_
primitive altos_dff_s_err (q, clk, d, s);
	output q;
	reg q;
	input clk, d, s;

	table
		 ?   1 (0x) : ? : -;
		 ?   1 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 1  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 1  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_s_
`else
`define _udp_def_altos_dff_s_
primitive altos_dff_s (q, v, clk, d, s, xcr);
	output q;
	reg q;
	input v, clk, d, s, xcr;

	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 1;
		?  b   ? (1?) ? : 1 : -;
		?  x   1 (1?) ? : 1 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 1 : -;
		? (x1) 0  0   0 : ? : 0;
		? (x1) 1  ?   0 : ? : 1;
		? (x1) 1  ?   1 : 1 : 1;
		? (x1) 0  0   1 : 0 : 0;
		? (x1) ?  ?   x : ? : -;
		? (bx) 1  ?   ? : 1 : -;
		? (bx) 0  0   ? : 0 : -;
		? (x0) 1  ?   ? : ? : -;
		? (x0) 0  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 1  ?   ? : ? : 1;
		? (01) 0  0   ? : ? : 0;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_err_
`else
`define _udp_def_altos_dff_sr_err_
primitive altos_dff_sr_err (q, clk, d, s, r);
	output q;
	reg q;
	input clk, d, s, r;

	table
		 ?   1 (0x)  ?   : ? : -;
		 ?   0  ?   (0x) : ? : -;
		 ?   0  ?   (x0) : ? : -;
		(0x) ?  0    0   : ? : 0;
		(0x) 1  x    0   : ? : 0;
		(0x) 0  0    x   : ? : 0;
		(1x) ?  0    0   : ? : 1;
		(1x) 1  x    0   : ? : 1;
		(1x) 0  0    x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_0
`else
`define _udp_def_altos_dff_sr_0
primitive altos_dff_sr_0 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   ?   1   ? : ? : 0;
		?  ?   ?   1   0   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_1
`else
`define _udp_def_altos_dff_sr_1
primitive altos_dff_sr_1 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   0   1   ? : ? : 0;
		?  ?   ?   1   ?   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_r_
`else
`define _udp_def_altos_latch_r_
primitive altos_latch_r (q, v, clk, d, r);
	output q;
	reg q;
	input v, clk, d, r;

	table
		* ? ? ? : ? : x;
		? ? ? 1 : ? : 0;
		? 0 ? 0 : ? : -;
		? 0 ? x : 0 : -;
		? 1 0 0 : ? : 0;
		? 1 0 x : ? : 0;
		? 1 1 0 : ? : 1;
		? x 0 0 : 0 : -;
		? x 0 x : 0 : -;
		? x 1 0 : 1 : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_s_
`else
`define _udp_def_altos_latch_s_
primitive altos_latch_s (q, v, clk, d, s);
	output q;
	reg q;
	input v, clk, d, s;

	table
		* ? ? ? : ? : x;
		? ? ? 1 : ? : 1;
		? 0 ? 0 : ? : -;
		? 0 ? x : 1 : -;
		? 1 1 0 : ? : 1;
		? 1 1 x : ? : 1;
		? 1 0 0 : ? : 0;
		? x 1 0 : 1 : -;
		? x 1 x : 1 : -;
		? x 0 0 : 0 : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_sr_0
`else
`define _udp_def_altos_latch_sr_0
primitive altos_latch_sr_0 (q, v, clk, d, s, r);
	output q;
	reg q;
	input v, clk, d, s, r;

	table
		* ? ? ? ? : ? : x;
		? 1 1 ? 0 : ? : 1;
		? 1 0 0 ? : ? : 0;
		? ? ? 1 0 : ? : 1;
		? ? ? ? 1 : ? : 0;
		? 0 * ? ? : ? : -;
		? 0 ? * 0 : 1 : 1;
		? 0 ? 0 * : 0 : 0;
		? * 1 ? 0 : 1 : 1;
		? * 0 0 ? : 0 : 0;
		? ? 1 * 0 : 1 : 1;
		? ? 0 0 * : 0 : 0;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_sr_1
`else
`define _udp_def_altos_latch_sr_1
primitive altos_latch_sr_1 (q, v, clk, d, s, r);
	output q;
	reg q;
	input v, clk, d, s, r;

	table
		* ? ? ? ? : ? : x;
		? 1 1 ? 0 : ? : 1;
		? 1 0 0 ? : ? : 0;
		? ? ? 1 ? : ? : 1;
		? ? ? 0 1 : ? : 0;
		? 0 * ? ? : ? : -;
		? 0 ? * 0 : 1 : 1;
		? 0 ? 0 * : 0 : 0;
		? * 1 ? 0 : 1 : 1;
		? * 0 0 ? : 0 : 0;
		? ? 1 * 0 : 1 : 1;
		? ? 0 0 * : 0 : 0;
	endtable
endprimitive
`endif
