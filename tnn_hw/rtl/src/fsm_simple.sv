// Author: Harideep Nair

// A simple FSM to count for 8 cycles at the onset of an input
// Input is assumed to be a 1-cycle wide pulse
// Used for converting 1-cycle wide output of neuron to 8-cycle wide

module fsm_simple (out, in, aclk, rst);

     input logic aclk, rst;
     input logic in;
     output logic out;
     logic [2:0] state;
     logic [2:0] next_state;
     fsm_simple_macro fsm_simple_inst(.IN(in),.OUT(out),.STATE_0(state[0]),.STATE_1(state[1]),.STATE_2(state[2]),.NEXT_STATE_0(next_state[0]),.NEXT_STATE_1(next_state[1]),.NEXT_STATE_2(next_state[2]));
     register #(3) inst_state_reg(.clk(aclk),.rst_b(~rst),.d(next_state),.q(state),.wen(1));

endmodule
