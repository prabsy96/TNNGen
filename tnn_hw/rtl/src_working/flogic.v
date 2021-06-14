// Verilog for library flogic created by Liberate 19.2.0.100 on Sat Jul 18 17:24:31 EDT 2020 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module flogic_8x1 (OUT, F_0, F_1, F_2, F_3, F_4, F_5, F_6, F_7, SEL_0, SEL_1, SEL_2);
	output OUT;
	input F_0, F_1, F_2, F_3, F_4, F_5, F_6, F_7, SEL_0, SEL_1;
	input SEL_2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;
	wire int_fwire_3, int_fwire_4, int_fwire_5;
	wire int_fwire_6, int_fwire_7, SEL_0__bar;
	wire SEL_1__bar, SEL_2__bar;

	and (int_fwire_0, F_7, SEL_0, SEL_1, SEL_2);
	not (SEL_2__bar, SEL_2);
	and (int_fwire_1, F_6, SEL_0, SEL_1, SEL_2__bar);
	not (SEL_1__bar, SEL_1);
	and (int_fwire_2, F_5, SEL_0, SEL_1__bar, SEL_2);
	and (int_fwire_3, F_4, SEL_0, SEL_1__bar, SEL_2__bar);
	not (SEL_0__bar, SEL_0);
	and (int_fwire_4, F_3, SEL_0__bar, SEL_1, SEL_2);
	and (int_fwire_5, F_2, SEL_0__bar, SEL_1, SEL_2__bar);
	and (int_fwire_6, F_1, SEL_0__bar, SEL_1__bar, SEL_2);
	and (int_fwire_7, F_0, SEL_0__bar, SEL_1__bar, SEL_2__bar);
	or (OUT, int_fwire_7, int_fwire_6, int_fwire_5, int_fwire_4, int_fwire_3, int_fwire_2, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(F_0 => OUT) = 0;
		(F_1 => OUT) = 0;
		(F_2 => OUT) = 0;
		(F_3 => OUT) = 0;
		(F_4 => OUT) = 0;
		(F_5 => OUT) = 0;
		(F_6 => OUT) = 0;
		(F_7 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		ifnone (SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & ~SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & ~SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_1 & SEL_2))
			(SEL_0 => OUT) = 0;
		if ((F_4 & ~F_5 & F_6 & F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_4 & ~F_5 & ~F_6 & F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & ~F_1 & F_2 & F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & F_5 & F_6 & F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & F_5 & F_6 & ~F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & ~F_5 & F_6 & F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & ~F_5 & F_6 & F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & ~F_5 & F_6 & ~F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & ~F_5 & ~F_6 & F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & ~F_1 & F_2 & ~F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & ~F_1 & ~F_2 & F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		ifnone (SEL_1 => OUT) = 0;
		if ((F_4 & F_5 & F_6 & ~F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_4 & F_5 & ~F_6 & F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_4 & F_5 & ~F_6 & ~F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_4 & F_5 & ~F_6 & ~F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_4 & ~F_5 & ~F_6 & F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_4 & ~F_5 & ~F_6 & ~F_7 & SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & F_1 & F_2 & ~F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & F_1 & ~F_2 & ~F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((F_0 & ~F_1 & ~F_2 & ~F_3 & ~SEL_0 & ~SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & F_5 & F_6 & ~F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_4 & F_5 & ~F_6 & ~F_7 & SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & F_1 & F_2 & ~F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_0 & F_1 & ~F_2 & ~F_3 & ~SEL_0 & SEL_2))
			(SEL_1 => OUT) = 0;
		if ((~F_6 & F_7 & SEL_0 & SEL_1))
			(SEL_2 => OUT) = 0;
		if ((~F_4 & F_5 & SEL_0 & ~SEL_1))
			(SEL_2 => OUT) = 0;
		if ((~F_2 & F_3 & ~SEL_0 & SEL_1))
			(SEL_2 => OUT) = 0;
		if ((~F_0 & F_1 & ~SEL_0 & ~SEL_1))
			(SEL_2 => OUT) = 0;
		ifnone (SEL_2 => OUT) = 0;
		if ((F_6 & ~F_7 & SEL_0 & SEL_1))
			(SEL_2 => OUT) = 0;
		if ((F_4 & ~F_5 & SEL_0 & ~SEL_1))
			(SEL_2 => OUT) = 0;
		if ((F_2 & ~F_3 & ~SEL_0 & SEL_1))
			(SEL_2 => OUT) = 0;
		if ((F_0 & ~F_1 & ~SEL_0 & ~SEL_1))
			(SEL_2 => OUT) = 0;
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
