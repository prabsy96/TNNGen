/*
 * Author: Harideep Nair
 *
 * Implements the FSM used to generate 8-cycles wide output spike pulses.
 *
 * Assumptions : 1) input is a pulse with a width of 1 unit clock period.
 *
 * Inputs      : in            - 1-cycle wide pulse to be converted to 8-cycles wide
 *               aclk          - unit clock for temporal encoding
 *               rst           - system reset (synchronous with gclk)
 * Outputs     : out           - 8-cycles wide pulse output
 */

module fsm_simple (out, in, aclk, rst);

    input logic aclk, rst;
    input logic in;
    output logic out;

    typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7} state_t;
    state_t state;

    logic temp;

    always_ff @ (posedge aclk)
    begin

        if (rst)
        begin

            state <= S0;
        
        end
        else
        begin

            case(state)
            
                S0:
                begin
                    if (out) 
                    begin
                        state <= S1;
                    end
                    else
                    begin
                        state <= S0;
                    end
                end

                S1:
                begin
                    state <= S2;
                end

                S2:
                begin
                    state <= S3;
                end

                S3:
                begin
                    state <= S4;
                end
            
                S4:
                begin
                    state <= S5;
                end
            
                S5:
                begin
                    state <= S6;
                end

                S6:
                begin
                    state <= S7;
                end

                S7:
                begin
                    state <= S0;
                end
            
            endcase

        end

    end

    assign temp = ~(state[2] | state[1] | state[0]);
    assign out = (~temp) | (temp & in);

endmodule
