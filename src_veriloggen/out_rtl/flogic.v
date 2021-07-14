

module flogic
(
  input [6-1:0] F,
  input [3-1:0] input_weight,
  output reg [1-1:0] out
);


  always @(*) begin
    if(input_weight == 3'b0) begin
      out <= 0;
    end else if(input_weight == 3'b1) begin
      out <= F[0];
    end else if(input_weight == 3'b10) begin
      out <= F[1];
    end else if(input_weight == 3'b11) begin
      out <= F[2];
    end else if(input_weight == 3'b100) begin
      out <= F[3];
    end else if(input_weight == 3'b101) begin
      out <= F[4];
    end else if(input_weight == 3'b110) begin
      out <= F[5];
    end else if(input_weight == 3'b111) begin
      out <= 1;
    end 
  end


endmodule

