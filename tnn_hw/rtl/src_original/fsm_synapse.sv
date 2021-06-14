/*
 * Author: Harideep Nair
 *
 * Implements the FSM responsible for storing synaptic weight and reading it out into a unary output corresponding to RNL response function.
 * Counts down for the duration of the input pulse, eventually wrapping around resetting the original weights.
 * Output is high only until the FSM counts down to 0; it becomes low after that.
 * STDP increment/decrement occur at the onset of gamma clock.
 *
 * Assumptions : 1) weights are encoded as binary values.
 *               2) bit resolution for synaptic weights is 3, i.e., weights range from 0 to 7 (wmax).
 *               3) input spikes are encoded as pulses having a width of 8 (wmax+1) unit clock cycles.
 *               4) earliest input spike occurs atleast one unit clock period after the posedge of gamma clock, since STDP updates occur at posedge of gamma.
 *
 * Inputs      : input_spike   - input spikes to the synapse encoded as 8-cycle wide pulses
 *               inc           - increment signal from STDP to increase the synaptic weight
 *               dec           - decrement signal from STDP to decrease the synaptic weight
 *               aclk          - unit clock for temporal encoding
 *               gclk          - gamma clock that separates computational waves
 *               rst           - system reset (synchronous with gclk)
 * Outputs     : out           - unary RNL output
 *               weight        - the corresponding 3-bit synaptic weight
 */

module fsm_synapse (out, weight, input_spike, inc, dec, weight_update_en, aclk, gclk, rst);

    input logic weight_update_en, aclk, gclk, rst;
    input logic input_spike, inc, dec;
    output logic out;
    output logic [0:2] weight;

    typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7} state_t;
    state_t state;

    logic dout, din, tclk, tinc, tdec;

    assign tinc = inc & ~input_spike;
    assign tdec = dec & ~input_spike;

    assign tclk = (aclk & input_spike);

    always_ff @ (posedge tclk or posedge gclk)
    begin

        if (tclk)
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
                    if (tclk) 
                    begin
                        state <= S7;
                    end
                    else
                    begin
                        state <= S0;
                    end
                end

                S1:
                begin
                    if (tclk) 
                    begin
                        state <= S0;
                    end
                    else
                    begin
                        state <= S1;
                    end
                end

                S2:
                begin
                    if (tclk) 
                    begin
                        state <= S1;
                    end
                    else
                    begin
                        state <= S2;
                    end
                end

                S3:
                begin
                    if (tclk) 
                    begin
                        state <= S2;
                    end
                    else
                    begin
                        state <= S3;
                    end
                end
            
                S4:
                begin
                    if (tclk) 
                    begin
                        state <= S3;
                    end
                    else
                    begin
                        state <= S4;
                    end
                end
            
                S5:
                begin
                    if (tclk) 
                    begin
                        state <= S4;
                    end
                    else
                    begin
                        state <= S5;
                    end
                end

                S6:
                begin
                    if (tclk) 
                    begin
                        state <= S5;
                    end
                    else
                    begin
                        state <= S6;
                    end
                end

                S7:
                begin
                    if (tclk) 
                    begin
                        state <= S6;
                    end
                    else
                    begin
                        state <= S7;
                    end
                end
            
            endcase
            
            end

        end
        
        else
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
                    if (tinc & weight_update_en)
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
                    if (tdec & weight_update_en) 
                    begin
                        state <= S0;
                    end
                    else if (tinc & weight_update_en)
                    begin
                        state <= S2;
                    end
                    else
                    begin
                        state <= S1;
                    end
                end

                S2:
                begin
                    if (tdec & weight_update_en) 
                    begin
                        state <= S1;
                    end
                    else if (tinc & weight_update_en)
                    begin
                        state <= S3;
                    end
                    else
                    begin
                        state <= S2;
                    end
                end

                S3:
                begin
                    if (tdec & weight_update_en) 
                    begin
                        state <= S2;
                    end
                    else if (tinc & weight_update_en)
                    begin
                        state <= S4;
                    end
                    else
                    begin
                        state <= S3;
                    end
                end
            
                S4:
                begin
                    if (tdec & weight_update_en) 
                    begin
                        state <= S3;
                    end
                    else if (tinc & weight_update_en)
                    begin
                        state <= S5;
                    end
                    else
                    begin
                        state <= S4;
                    end
                end
            
                S5:
                begin
                    if (tdec & weight_update_en) 
                    begin
                        state <= S4;
                    end
                    else if (tinc & weight_update_en)
                    begin
                        state <= S6;
                    end
                    else
                    begin
                        state <= S5;
                    end
                end

                S6:
                begin
                    if (tdec & weight_update_en) 
                    begin
                        state <= S5;
                    end
                    else if (tinc & weight_update_en)
                    begin
                        state <= S7;
                    end
                    else
                    begin
                        state <= S6;
                    end
                end

                S7:
                begin
                    if (tdec & weight_update_en) 
                    begin
                        state <= S6;
                    end
                    else
                    begin
                        state <= S7;
                    end
                end
            
            endcase

            end

        end

    end

    assign din = state[2] & state[1] & state[0];

    always_ff @ (posedge din or posedge gclk)
    begin

        if (din)
        begin
            
            if (input_spike)
            begin
                dout <= 1;
            end
            else
            begin
                dout <= 0;
            end

        end

        else
        begin
        
            dout <= 0;

        end
        
    end
    
    assign out = ~dout & input_spike;
    assign weight = state;

endmodule
