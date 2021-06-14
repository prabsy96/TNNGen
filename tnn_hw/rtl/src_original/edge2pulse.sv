/*
 * Author: Harideep Nair
 *
 * Implements an edge-to-pulse conversion logic.
 * Input is a 0->1 edge.
 * Output is a pulse with a width of 1 unit clock period.
 * Used here to generate 1-cycle wide reset pulses from gamma clock.
 *
 * Inputs     : edge_in    - input edge signal (posedge of gamma clock here)
 *              clk_in     - unit clock
 * Outputs    : pulse_out  - output 1-cycle wide pulse
 */

module edge2pulse (pulse_out, edge_in, clk_in);

    input logic edge_in, clk_in;
    output logic pulse_out;

    logic temp1, temp2;

    always_ff @ (posedge clk_in)
    begin

        temp1 <= edge_in;
        temp2 <= temp1;
    
    end

    assign pulse_out = edge_in & (~temp2);

endmodule
