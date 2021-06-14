/*
 * Author: Harideep Nair
 *
 * Implements the logic used to select appropriate weight stabilization BRVs for STDP based on synaptic weights.
 * LFSR is not implemented.
 * Inputs are assumed to come from LFSRs.
 *
 * Inputs     : input_weight - corresponding synaptic weight
 *              F            - BRVs corresponding to weight values of 1 to 6; BRV for w = 0 is 0 and for w = 7 is 1
 * Outputs    : out          - selected BRV output
 */

module flogic (out, input_weight, F);

    input logic [0:5] F;
    input logic [0:2] input_weight;
    output logic out;

    always_comb
    begin
    
    case (input_weight)
    
    3'b000:
    begin
    
        out = 0; 

    end
    
    3'b001:
    begin
    
        out = F[0]; 

    end
    3'b010:
    begin
    
        out = F[1]; 

    end
    3'b011:
    begin
    
        out = F[2]; 

    end
    3'b100:
    begin
    
        out = F[3]; 

    end
    3'b101:
    begin
    
        out = F[4]; 

    end
    3'b110:
    begin
    
        out = F[5]; 

    end
    3'b111:
    begin
    
        out = 1; 

    end

    endcase

    end

endmodule
