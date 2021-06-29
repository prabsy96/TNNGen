

module test_flogic
(

);

  reg [6-1:0] dut_F;
  reg [3-1:0] dut_input_weight;
  wire [1-1:0] dut_out;

  flogic
  dut
  (
    .F(dut_F),
    .input_weight(dut_input_weight),
    .out(dut_out)
  );


  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_F, dut_input_weight, dut_out);
    dut_F = 0;
    dut_input_weight = 0;
    #5;
    dut_F = 63;
    #5;
    dut_input_weight = 1;
    #5;
    dut_F = 31;
    #5;
    dut_input_weight = 2;
    dut_F = 63;
    #5;
    dut_F = 47;
    #5;
    dut_input_weight = 3;
    dut_F = 63;
    #5;
    dut_F = 55;
    #5;
    dut_input_weight = 4;
    #5;
    dut_F = 59;
    #5;
    dut_input_weight = 5;
    #5;
    dut_F = 61;
    #5;
    dut_input_weight = 6;
    #5;
    dut_F = 62;
    #5;
    dut_input_weight = 7;
    #5;
    dut_F = 0;
    #5;
    #100;
    $finish;
  end


endmodule



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

