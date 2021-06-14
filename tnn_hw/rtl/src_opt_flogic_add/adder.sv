// Author: Harideep Nair
// Values are encoded as spiketimes
//
// A simple adder

`timescale 1ns / 1ps

module adder (out, a, b, cin);

    parameter RESOLUTION = 3;

    input logic [0:RESOLUTION-1] a, b;
    input logic cin;
    output logic [0:RESOLUTION] out;
    
	logic [0:RESOLUTION-1] cout, sum;
	
	add_inv adder_out (.A (a[0]), .B (b[0]), .CI (cin), .CARRY (cout[0]), .SUM (sum[0]) );
	
	   // assign out = a + b + cin; 
	genvar i;
    generate
	  for(i=1;i<RESOLUTION;i=i+1)
      begin: generate_N_bit_Adder
        add_inv adder_gen (.A(a[i]),.B(b[i]),.CI(cout[i-1]), .SUM(sum[i]), .CARRY(cout[i]) );
      end
	endgenerate
	
	assign out = {cout[RESOLUTION-1],sum};
	
	endmodule
