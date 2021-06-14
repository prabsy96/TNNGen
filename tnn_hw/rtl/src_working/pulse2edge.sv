// Author: Harideep Nair
//
// Models a pulse to edge conversion logic
// Input pulse could be of any width
// Input clock is typically the gamma clock

module pulse2edge (edge_out, pulse_in, aclk, grst);

    input logic pulse_in, aclk, grst;
    output logic edge_out;

    logic temp;

    assign edge_out = pulse_in | temp;
/*	
    always_ff @ (posedge aclk or posedge grst)
    begin

        if (grst)
        begin

            temp <= 0;

        end
        else
        begin

            temp <= edge_out;

        end

    end
*/
    register #(1) inst_state_reg(.clk(aclk),.rst_b(~grst),.d(edge_out),.q(temp),.wen(1));
    //assign edge_out = pulse_in | out;

endmodule
