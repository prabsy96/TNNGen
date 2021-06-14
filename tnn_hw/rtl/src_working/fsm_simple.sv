// Author: Harideep Nair

// A simple FSM to count for 8 cycles at the onset of an input
// Input is assumed to be a 1-cycle wide pulse
// Used for converting 1-cycle wide output of neuron to 8-cycle wide

module fsm_simple (out, in, aclk, rst);

    input logic aclk, rst;
    input logic in;
    output logic out;

    // typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7} state_t;
    // state_t state,next_state;
    logic [2:0] state,next_state;

    // logic temp;

    // always_ff @ (posedge aclk)
    // begin

    //     if (rst)
    //     begin

    //         state <= S0;
        
    //     end
    //     else
    //     begin

    //         case(state)
            
    //             S0:
    //             begin
    //                 if (out) 
    //                 begin
    //                     state <= S1;
    //                 end
    //                 else
    //                 begin
    //                     state <= S0;
    //                 end
    //             end

    //             S1:
    //             begin
    //                 state <= S2;
    //             end

    //             S2:
    //             begin
    //                 state <= S3;
    //             end

    //             S3:
    //             begin
    //                 state <= S4;
    //             end
            
    //             S4:
    //             begin
    //                 state <= S5;
    //             end
            
    //             S5:
    //             begin
    //                 state <= S6;
    //             end

    //             S6:
    //             begin
    //                 state <= S7;
    //             end

    //             S7:
    //             begin
    //                 state <= S0;
    //             end
            
    //         endcase

    //     end

    // end

    always_comb begin : proc_state_logic
        next_state = state+1;
        out = 1;
        if(in !=1 && state == 3'b000) begin
            next_state = 3'b000;
            out = 0;
        end
    end
    register #(3) inst_state_reg(.clk(aclk),.rst_b(~rst),.d(next_state),.q(state),.wen(1));
    // assign temp = ~(state[2] | state[1] | state[0]);
    // assign out = (~temp) | (temp & in);

endmodule
