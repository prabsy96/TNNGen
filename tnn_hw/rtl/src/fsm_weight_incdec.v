// Verilog for library fsm_weight_incdec created by Liberate 19.2.0.100 on Wed Aug  5 22:36:04 EDT 2020 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module fsm_weight_incdec (TDEC, TINC, DEC, GCLK, INC, INPUT_SPIKE, NXT_GCLK, STORE_WEIGHT_0, STORE_WEIGHT_1, STORE_WEIGHT_2);
	output TDEC, TINC;
	input DEC, GCLK, INC, INPUT_SPIKE, NXT_GCLK, STORE_WEIGHT_0, STORE_WEIGHT_1, STORE_WEIGHT_2;

	// Function
	wire INPUT_SPIKE__bar, int_fwire_0, int_fwire_1;
	wire int_fwire_2, int_fwire_3, int_fwire_4;
	wire int_fwire_5, NXT_GCLK__bar, STORE_WEIGHT_0__bar;
	wire STORE_WEIGHT_1__bar, STORE_WEIGHT_2__bar;

	not (NXT_GCLK__bar, NXT_GCLK);
	not (INPUT_SPIKE__bar, INPUT_SPIKE);
	and (int_fwire_0, DEC, GCLK, INPUT_SPIKE__bar, NXT_GCLK__bar, STORE_WEIGHT_2);
	and (int_fwire_1, DEC, GCLK, INPUT_SPIKE__bar, NXT_GCLK__bar, STORE_WEIGHT_1);
	and (int_fwire_2, DEC, GCLK, INPUT_SPIKE__bar, NXT_GCLK__bar, STORE_WEIGHT_0);
	or (TDEC, int_fwire_2, int_fwire_1, int_fwire_0);
	not (STORE_WEIGHT_2__bar, STORE_WEIGHT_2);
	and (int_fwire_3, GCLK, INC, INPUT_SPIKE__bar, NXT_GCLK__bar, STORE_WEIGHT_2__bar);
	not (STORE_WEIGHT_1__bar, STORE_WEIGHT_1);
	and (int_fwire_4, GCLK, INC, INPUT_SPIKE__bar, NXT_GCLK__bar, STORE_WEIGHT_1__bar);
	not (STORE_WEIGHT_0__bar, STORE_WEIGHT_0);
	and (int_fwire_5, GCLK, INC, INPUT_SPIKE__bar, NXT_GCLK__bar, STORE_WEIGHT_0__bar);
	or (TINC, int_fwire_5, int_fwire_4, int_fwire_3);

	// Timing
	specify
		if ((GCLK & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(DEC => TDEC) = 0;
		if ((GCLK & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(DEC => TDEC) = 0;
		if ((GCLK & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (GCLK & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(DEC => TDEC) = 0;
		if ((GCLK & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(DEC => TDEC) = 0;
		if ((GCLK & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(DEC => TDEC) = 0;
		if ((GCLK & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(DEC => TDEC) = 0;
		ifnone (DEC => TDEC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & ~INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & ~INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & ~INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & ~INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & ~INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		if ((DEC & ~INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TDEC) = 0;
		ifnone (GCLK => TDEC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & GCLK & ~INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TDEC) = 0;
		ifnone (INPUT_SPIKE => TDEC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & ~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & GCLK & ~INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		if ((DEC & GCLK & ~INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TDEC) = 0;
		ifnone (NXT_GCLK => TDEC) = 0;
		(STORE_WEIGHT_0 => TDEC) = 0;
		(STORE_WEIGHT_1 => TDEC) = 0;
		(STORE_WEIGHT_2 => TDEC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((~DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((~DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		if ((~DEC & INC & ~INPUT_SPIKE & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2))
			(GCLK => TINC) = 0;
		ifnone (GCLK => TINC) = 0;
		(INC => TINC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((~DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((~DEC & GCLK & INC & ~NXT_GCLK & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		if ((~DEC & GCLK & INC & ~NXT_GCLK & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2))
			(INPUT_SPIKE => TINC) = 0;
		ifnone (INPUT_SPIKE => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((~DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((~DEC & GCLK & INC & ~INPUT_SPIKE & STORE_WEIGHT_0 & ~STORE_WEIGHT_1 & STORE_WEIGHT_2) | (~DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		if ((~DEC & GCLK & INC & ~INPUT_SPIKE & ~STORE_WEIGHT_0 & ~STORE_WEIGHT_2))
			(NXT_GCLK => TINC) = 0;
		ifnone (NXT_GCLK => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(STORE_WEIGHT_0 => TINC) = 0;
		if ((~DEC & GCLK & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_1 & STORE_WEIGHT_2))
			(STORE_WEIGHT_0 => TINC) = 0;
		ifnone (STORE_WEIGHT_0 => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_2))
			(STORE_WEIGHT_1 => TINC) = 0;
		if ((~DEC & GCLK & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_2))
			(STORE_WEIGHT_1 => TINC) = 0;
		ifnone (STORE_WEIGHT_1 => TINC) = 0;
		if ((DEC & GCLK & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1))
			(STORE_WEIGHT_2 => TINC) = 0;
		if ((~DEC & GCLK & INC & ~INPUT_SPIKE & ~NXT_GCLK & STORE_WEIGHT_0 & STORE_WEIGHT_1))
			(STORE_WEIGHT_2 => TINC) = 0;
		ifnone (STORE_WEIGHT_2 => TINC) = 0;
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
