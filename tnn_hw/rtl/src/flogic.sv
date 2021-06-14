// Author: Harideep Nair

// F Logic to select weight stabilization BRVs based on weights
// Assumes inputs from LFSR (doesn't implement LFSR)

module flogic (out, input_weight, F);

    input logic [0:5] F;
    input logic [0:2] input_weight;
    output logic out;

    logic l10,l11,l12,l13,l20,l21;

    // always_comb
    // begin
    
    // // // case (input_weight)
    
    // // // 3'b000:
    // // // begin
    
    // // //     out = 0; 

    // // // end
    
    // // // 3'b001:
    // // // begin
    
    // // //     out = F[0]; 

    // // // end
    // // // 3'b010:
    // // // begin
    
    // // //     out = F[1]; 

    // // // end
    // // // 3'b011:
    // // // begin
    
    // // //     out = F[2]; 

    // // // end
    // // // 3'b100:
    // // // begin
    
    // // //     out = F[3]; 

    // // // end
    // // // 3'b101:
    // // // begin
    
    // // //     out = F[4]; 

    // // // end
    // // // 3'b110:
    // // // begin
    
    // // //     out = F[5]; 

    // // // end
    // // // 3'b111:
    // // // begin
    
    // // //     out = 1; 

    // // // end

    // // // endcase
    // // // 
    // if(input_weight == 3'b000)
    //     out = 0;
    // else if(input_weight == 3'b001)
    //     out = F[0];
    // else if(input_weight == 3'b010)
    //     out = F[1];
    // else if(input_weight == 3'd3)
    //     out = F[2]; 
    // else if(input_weight == 3'd4)
    //     out = F[3];
    // else if(input_weight == 3'd5)
    //     out = F[4];
    // else if(input_weight == 3'd6)
    //     out = F[5];
    // else
    //     out = 1;
    // end
    // register #(6) A_reg(.clk(clk),.rst_b(1),.d(reg_F),.q(F),.wen(1));
    // // register #(1) B_reg(.clk(clk_in),.rst_b(1),.d(pulse_in),.q(out),.wen(pulse_in));
    // register #(3) SEL_reg(.clk(clk),.rst_b(1),.d(reg_input_weight),.q(input_weight),.wen(1));
    // register #(1) out_reg(.clk(clk),.rst_b(1),.d(out),.q(reg_out),.wen(1));

	flogic_8x1 DUT (.OUT(out), .F_0(0), .F_1(F[0]), .F_2(F[1]), .F_3(F[2]), .F_4(F[3]), .F_5(F[4]), .F_6(F[5]), .F_7(1), .SEL_0(input_weight[0]), .SEL_1(input_weight[1]), .SEL_2(input_weight[2]));    

    //MUX2x2_ASAP7_75t_R g33__8780 (.B(F[6]),.A(F[3]),.SEL(input_weight[0]),.Y(l10));
    //MUX2x2_ASAP7_75t_R g33__8781 (.B(F[1]),.A(F[5]),.SEL(input_weight[0]),.Y(l11));
    //MUX2x2_ASAP7_75t_R g33__8782 (.B(F[0]),.A(F[4]),.SEL(input_weight[0]),.Y(l12));
    //MUX2x2_ASAP7_75t_R g33__8783 (.B(F[2]),.A(F[7]),.SEL(input_weight[0]),.Y(l13));
    //MUX2x2_ASAP7_75t_R g33__8784 (.B(l10),.A(l11),.SEL(input_weight[1]),.Y(l20));
    //MUX2x2_ASAP7_75t_R g33__8785 (.B(l12),.A(l13),.SEL(input_weight[1]),.Y(l21));
    //MUX2x2_ASAP7_75t_R g33__8786 (.B(l20),.A(l21),.SEL(input_weight[2]),.Y(out));
endmodule
