// Author: Harideep Nair
//
// Models an edge to pulse conversion logic
// Input edge is assumed to be 0->1
// Output pulse is 1 cycle wide
// Edge in is typically the posedge of gamma clock and clk_in is typically the unit clock

module edge2pulse (pulse_out, edge_in, clk_in,rst);

    input logic edge_in, clk_in,rst;
    output logic pulse_out;

    logic temp1, temp2;
    // always_ff @ (posedge clk_in)
    // begin

    //     temp1 <= edge_in;
    //     temp2 <= temp1;
    
    // end


    register edge_pulse_reg(.clk(clk_in),.rst_b(~rst),.d(edge_in),.q(temp2),.wen(1));
    assign pulse_out = edge_in & (~temp2);

endmodule
