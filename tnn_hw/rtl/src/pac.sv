/*
 * Author: Harideep Nair
 *
 * Implements a parallel accumulative counter as part of the neuron body (soma).
 * Accumulates response functions from all synapses into the body potential.
 * Threshold comparison is also integrated into it.
 *
 * Parameters  : INPUT_SIZE    - number of synapses per neuron (equivalent to 'P' in column)
 *               THRESHOLD     - spiking threshold for neuron
 *
 * Inputs      : in            - unary outputs from synapses (1 bit output per synapse)
 *               aclk          - unit clock for temporal encoding
 *               grst          - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 * Outputs     : out           - 1-cycle wide output pulse that is generated when body potential crosses threshold
 */

`timescale 1ns / 1ps

`define max(v1, v2) ((v1) > (v2) ? (v1) : (v2))

module pac (out, in, aclk, grst);

    parameter INPUT_SIZE = 1024;
    parameter THRESHOLD = 13;
    
    localparam OUT_RES = $clog2(INPUT_SIZE);
    localparam IN_SIZE = (1<<OUT_RES);
    localparam STAGES = $clog2(IN_SIZE)-1;
    localparam NUM = 2*IN_SIZE - OUT_RES-2;
    localparam MAXRES = `max(OUT_RES+1,$clog2(THRESHOLD)+1);

    genvar i, j;

    input logic [0:INPUT_SIZE-1] in;
    input logic aclk, grst;
    output logic out;
   
    logic [0:IN_SIZE-1] tin;
    wire logic [0:NUM-1] temp;
    wire logic [0:OUT_RES-1] tout;
    wire logic [0:MAXRES] t2out;
    logic [0:MAXRES-1] fout;
    logic [0:MAXRES-1] muxout;

    assign tin = IN_SIZE'(in);

    for (i = 0; i < IN_SIZE/2; i = i + 1)
    begin

        assign temp[i] = tin[i];

    end

    generate
        
        for (i = 0; i < STAGES; i = i + 1)
        begin: stages

            for (j = 0; j < IN_SIZE/(1<<(i+2)); j = j + 1)
            begin: adders
                
                adder #(i+1) a1 (.out(temp[(IN_SIZE>>(i+1))*((1<<(i+2))-i-3) + j*(i+2) : (IN_SIZE>>(i+1))*((1<<(i+2))-i-3) + j*(i+2) + (i+1)]),
                                 .a(temp[(IN_SIZE>>i)*((1<<(i+1))-i-2) + 2*j*(i+1) : (IN_SIZE>>i)*((1<<(i+1))-i-2) + 2*j*(i+1) + i]),
                                 .b(temp[(IN_SIZE>>i)*((1<<(i+1))-i-2) + (2*j+1)*(i+1) : (IN_SIZE>>i)*((1<<(i+1))-i-2) + (2*j+1)*(i+1) + i]),
                                 .cin(tin[IN_SIZE/2 + (IN_SIZE>>(i+1))*((1<<i)-1) + j])
                                );
            
            end

        end

    endgenerate

    assign tout = temp[NUM-OUT_RES:NUM-1];

    adder #(MAXRES) b1 (.out(t2out),
                        .a(MAXRES'(tout)),
                        .b(fout),
                        .cin(tin[IN_SIZE-1])
                       );

    always_ff @(posedge aclk)
    begin
        
        fout <= muxout;

    end

    assign out = ~t2out[1];

    assign muxout = (out | grst) ? -1*THRESHOLD : t2out[1:MAXRES];

endmodule
