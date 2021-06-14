// Verilog for library incdec_macro created by Liberate 19.2.0.100 on Wed Aug  5 22:34:55 EDT 2020 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module incdec_macro (DEC, INC, BACKOFF, CAPTURE, F, MIN, MINUS, SEARCH, STDP_CASES_0, STDP_CASES_1, STDP_CASES_2, STDP_CASES_3);
	output DEC, INC;
	input BACKOFF, CAPTURE, F, MIN, MINUS, SEARCH, STDP_CASES_0, STDP_CASES_1, STDP_CASES_2, STDP_CASES_3;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;
	wire int_fwire_3, int_fwire_4, int_fwire_5;
	wire int_fwire_6;

	and (int_fwire_0, MIN, MINUS, STDP_CASES_1);
	and (int_fwire_1, F, MINUS, STDP_CASES_1);
	and (int_fwire_2, BACKOFF, MIN, STDP_CASES_3);
	and (int_fwire_3, BACKOFF, F, STDP_CASES_3);
	or (DEC, int_fwire_3, int_fwire_2, int_fwire_1, int_fwire_0);
	and (int_fwire_4, SEARCH, STDP_CASES_2);
	and (int_fwire_5, CAPTURE, MIN, STDP_CASES_0);
	and (int_fwire_6, CAPTURE, F, STDP_CASES_0);
	or (INC, int_fwire_6, int_fwire_5, int_fwire_4);

	// Timing
	specify
		if ((F & MINUS & ~STDP_CASES_1 & STDP_CASES_3) | (~F & MIN & MINUS & ~STDP_CASES_1 & STDP_CASES_3))
			(BACKOFF => DEC) = 0;
		if ((F & ~MINUS & STDP_CASES_1 & STDP_CASES_3) | (~F & MIN & ~MINUS & STDP_CASES_1 & STDP_CASES_3))
			(BACKOFF => DEC) = 0;
		if ((F & ~MINUS & ~STDP_CASES_1 & STDP_CASES_3) | (~F & MIN & ~MINUS & ~STDP_CASES_1 & STDP_CASES_3))
			(BACKOFF => DEC) = 0;
		ifnone (BACKOFF => DEC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & ~MIN & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~MIN & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~MIN & ~MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~MIN & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & ~MIN & MINUS & SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~MIN & MINUS & SEARCH & ~STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~MIN & ~MINUS & SEARCH & ~STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~MIN & MINUS & SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & ~MIN & MINUS & ~STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & ~MIN & MINUS & ~STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~MIN & ~MINUS & ~STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~MIN & MINUS & ~STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & ~MIN & MINUS & ~SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~MIN & MINUS & ~SEARCH & ~STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~MIN & ~MINUS & ~SEARCH & ~STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~MIN & MINUS & ~SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & ~CAPTURE & ~MIN & MINUS & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & ~CAPTURE & ~MIN & MINUS & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~CAPTURE & ~MIN & ~MINUS & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~CAPTURE & ~MIN & MINUS & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(F => DEC) = 0;
		if ((BACKOFF & ~CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(F => DEC) = 0;
		ifnone (F => DEC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & ~F & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~F & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~F & ~MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~F & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & ~F & MINUS & SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~F & MINUS & SEARCH & ~STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~F & ~MINUS & SEARCH & ~STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~F & MINUS & SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & ~F & MINUS & ~STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & ~F & MINUS & ~STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~F & ~MINUS & ~STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~F & MINUS & ~STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & ~F & MINUS & ~SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~F & MINUS & ~SEARCH & ~STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~F & ~MINUS & ~SEARCH & ~STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~F & MINUS & ~SEARCH & ~STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & ~CAPTURE & ~F & MINUS & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & ~CAPTURE & ~F & MINUS & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~CAPTURE & ~F & ~MINUS & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~CAPTURE & ~F & MINUS & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(MIN => DEC) = 0;
		if ((BACKOFF & ~CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & ~CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & ~CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & ~CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(MIN => DEC) = 0;
		ifnone (MIN => DEC) = 0;
		if ((BACKOFF & F & STDP_CASES_1 & ~STDP_CASES_3) | (BACKOFF & ~F & MIN & STDP_CASES_1 & ~STDP_CASES_3))
			(MINUS => DEC) = 0;
		if ((~BACKOFF & F & STDP_CASES_1 & STDP_CASES_3) | (~BACKOFF & ~F & MIN & STDP_CASES_1 & STDP_CASES_3))
			(MINUS => DEC) = 0;
		if ((~BACKOFF & F & STDP_CASES_1 & ~STDP_CASES_3) | (~BACKOFF & ~F & MIN & STDP_CASES_1 & ~STDP_CASES_3))
			(MINUS => DEC) = 0;
		ifnone (MINUS => DEC) = 0;
		if ((BACKOFF & F & MINUS & ~STDP_CASES_3) | (BACKOFF & ~F & MIN & MINUS & ~STDP_CASES_3))
			(STDP_CASES_1 => DEC) = 0;
		if ((~BACKOFF & F & MINUS & STDP_CASES_3) | (~BACKOFF & ~F & MIN & MINUS & STDP_CASES_3))
			(STDP_CASES_1 => DEC) = 0;
		if ((~BACKOFF & F & MINUS & ~STDP_CASES_3) | (~BACKOFF & ~F & MIN & MINUS & ~STDP_CASES_3))
			(STDP_CASES_1 => DEC) = 0;
		ifnone (STDP_CASES_1 => DEC) = 0;
		if ((BACKOFF & F & MINUS & ~STDP_CASES_1) | (BACKOFF & ~F & MIN & MINUS & ~STDP_CASES_1))
			(STDP_CASES_3 => DEC) = 0;
		if ((BACKOFF & F & ~MINUS & STDP_CASES_1) | (BACKOFF & ~F & MIN & ~MINUS & STDP_CASES_1))
			(STDP_CASES_3 => DEC) = 0;
		if ((BACKOFF & F & ~MINUS & ~STDP_CASES_1) | (BACKOFF & ~F & MIN & ~MINUS & ~STDP_CASES_1))
			(STDP_CASES_3 => DEC) = 0;
		ifnone (STDP_CASES_3 => DEC) = 0;
		if ((F & SEARCH & STDP_CASES_0 & ~STDP_CASES_2) | (~F & MIN & SEARCH & STDP_CASES_0 & ~STDP_CASES_2))
			(CAPTURE => INC) = 0;
		if ((F & ~SEARCH & STDP_CASES_0 & STDP_CASES_2) | (~F & MIN & ~SEARCH & STDP_CASES_0 & STDP_CASES_2))
			(CAPTURE => INC) = 0;
		if ((F & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2) | (~F & MIN & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2))
			(CAPTURE => INC) = 0;
		ifnone (CAPTURE => INC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(F => INC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & ~STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & ~STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2) | (~BACKOFF & CAPTURE & ~MIN & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2))
			(F => INC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(F => INC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(F => INC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & ~STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & ~STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2) | (~BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2))
			(F => INC) = 0;
		if ((BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & ~STDP_CASES_3) | (BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & ~STDP_CASES_3) | (~BACKOFF & CAPTURE & ~MIN & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2) | (~BACKOFF & CAPTURE & ~MIN & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2))
			(F => INC) = 0;
		ifnone (F => INC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(MIN => INC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & ~STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & ~STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2) | (~BACKOFF & CAPTURE & ~F & ~MINUS & SEARCH & STDP_CASES_0 & ~STDP_CASES_2))
			(MIN => INC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2) | (BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & STDP_CASES_2))
			(MIN => INC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2) | (BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_1 & ~STDP_CASES_2))
			(MIN => INC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2 & ~STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2 & ~STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & STDP_CASES_2) | (~BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & STDP_CASES_2))
			(MIN => INC) = 0;
		if ((BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2 & ~STDP_CASES_3) | (BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2 & ~STDP_CASES_3) | (~BACKOFF & CAPTURE & ~F & MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_1 & ~STDP_CASES_2) | (~BACKOFF & CAPTURE & ~F & ~MINUS & ~SEARCH & STDP_CASES_0 & ~STDP_CASES_2))
			(MIN => INC) = 0;
		ifnone (MIN => INC) = 0;
		if ((CAPTURE & F & ~STDP_CASES_0 & STDP_CASES_2) | (CAPTURE & ~F & MIN & ~STDP_CASES_0 & STDP_CASES_2))
			(SEARCH => INC) = 0;
		if ((CAPTURE & ~F & ~MIN & STDP_CASES_0 & STDP_CASES_2))
			(SEARCH => INC) = 0;
		if ((CAPTURE & ~F & ~MIN & ~STDP_CASES_0 & STDP_CASES_2) | (~CAPTURE & ~F & ~MIN & STDP_CASES_0 & STDP_CASES_2))
			(SEARCH => INC) = 0;
		if ((~CAPTURE & F & STDP_CASES_0 & STDP_CASES_2) | (~CAPTURE & ~F & MIN & STDP_CASES_0 & STDP_CASES_2))
			(SEARCH => INC) = 0;
		if ((~CAPTURE & F & ~STDP_CASES_0 & STDP_CASES_2) | (~CAPTURE & ~F & MIN & ~STDP_CASES_0 & STDP_CASES_2))
			(SEARCH => INC) = 0;
		if ((~CAPTURE & ~F & ~MIN & ~STDP_CASES_0 & STDP_CASES_2))
			(SEARCH => INC) = 0;
		ifnone (SEARCH => INC) = 0;
		if ((CAPTURE & F & SEARCH & ~STDP_CASES_2) | (CAPTURE & ~F & MIN & SEARCH & ~STDP_CASES_2))
			(STDP_CASES_0 => INC) = 0;
		if ((CAPTURE & F & ~SEARCH & STDP_CASES_2) | (CAPTURE & ~F & MIN & ~SEARCH & STDP_CASES_2))
			(STDP_CASES_0 => INC) = 0;
		if ((CAPTURE & F & ~SEARCH & ~STDP_CASES_2) | (CAPTURE & ~F & MIN & ~SEARCH & ~STDP_CASES_2))
			(STDP_CASES_0 => INC) = 0;
		ifnone (STDP_CASES_0 => INC) = 0;
		if ((CAPTURE & F & SEARCH & ~STDP_CASES_0) | (CAPTURE & ~F & MIN & SEARCH & ~STDP_CASES_0))
			(STDP_CASES_2 => INC) = 0;
		if ((CAPTURE & ~F & ~MIN & SEARCH & STDP_CASES_0))
			(STDP_CASES_2 => INC) = 0;
		if ((CAPTURE & ~F & ~MIN & SEARCH & ~STDP_CASES_0) | (~CAPTURE & ~F & ~MIN & SEARCH & STDP_CASES_0))
			(STDP_CASES_2 => INC) = 0;
		if ((~CAPTURE & F & SEARCH & STDP_CASES_0) | (~CAPTURE & ~F & MIN & SEARCH & STDP_CASES_0))
			(STDP_CASES_2 => INC) = 0;
		if ((~CAPTURE & F & SEARCH & ~STDP_CASES_0) | (~CAPTURE & ~F & MIN & SEARCH & ~STDP_CASES_0))
			(STDP_CASES_2 => INC) = 0;
		if ((~CAPTURE & ~F & ~MIN & SEARCH & ~STDP_CASES_0))
			(STDP_CASES_2 => INC) = 0;
		ifnone (STDP_CASES_2 => INC) = 0;
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
