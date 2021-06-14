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



module adder (out, a, b, cin);

    parameter RESOLUTION = 4;

    input logic [0:RESOLUTION-1] a, b;
    input logic cin;
    output logic [0:RESOLUTION] out;

    assign out = a + b + cin;

endmodule
