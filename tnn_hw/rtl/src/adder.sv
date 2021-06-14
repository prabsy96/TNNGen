/*
 * Author: Harideep Nair
 *
 * Implements a simple multi-bit 2-input adder.
 *
 * Parameters : RESOLUTION - bit width of inputs
 *
 * Inputs     : a          - first data input
 *              b          - second data input
 *              cin        - 1-bit carry input
 * Outputs    : out        - sum output
 */

`timescale 1ns / 1ps

module adder (out, a, b, cin);

    parameter RESOLUTION = 3;

    input logic [0:RESOLUTION-1] a, b;
    input logic cin;
    output logic [0:RESOLUTION] out;
    
	logic [0:RESOLUTION-1] cout, sum;
	
	add_inv adder_out (.A (a[RESOLUTION-1]), .B (b[RESOLUTION-1]), .CI (cin), .CARRY (cout[RESOLUTION-1]), .SUM (sum[RESOLUTION-1]));
	
	   // assign out = a + b + cin; 
	genvar i;
    generate
	  for(i=1;i<RESOLUTION;i=i+1)
      begin: generate_N_bit_Adder
        add_inv adder_gen (.A(a[RESOLUTION-1-i]),.B(b[RESOLUTION-1-i]),.CI(cout[RESOLUTION-i]), .SUM(sum[RESOLUTION-1-i]), .CARRY(cout[RESOLUTION-1-i]) );
      end
	endgenerate
	
	assign out = {cout[0],sum};
	
	endmodule
   
   
 //  assign out ={cout[RESOLUTION-1]^sum[0], cout[RESOLUTION-1]^sum[1], cout[RESOLUTION-1]}; 
	
	

