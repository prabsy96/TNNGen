/*
 * Author: Harideep Nair
 *
 * Implements a pulse-to-edge conversion logic.
 * Input pulse could be of any width.
 * Output is a 0->1 edge signal.
 *
 * Inputs     : pulse_in    - input pulse signal
 *              aclk        - unit clock for temporal encoding
 *              grst        - 1-cycle wide pulse generated from gclk to reset intermediate signals between computational waves
 * Outputs    : edge_out    - output 0->1 edge signal
 */

module pulse2edge (edge_out, pulse_in, aclk, grst);

    input logic pulse_in, aclk, grst;
    output logic edge_out;

    logic temp;

    assign edge_out = pulse_in | temp;

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

endmodule
