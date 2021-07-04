

module test_pac
(

);

  reg [4-1:0] dut_in;
  reg [1-1:0] dut_aclk;
  reg [1-1:0] dut_grst;
  wire [1-1:0] dut_out;

  pac
  dut
  (
    .in(dut_in),
    .aclk(dut_aclk),
    .grst(dut_grst),
    .out(dut_out)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_in, dut_aclk, dut_grst, dut_out);
    i = 0;
    dut_in = 0;
    #5;
    dut_in = 1;
    #3;
    dut_in = 9;
    #2;
    dut_in = 8;
    #2;
    dut_in = 12;
    #2;
    dut_in = 8;
    #2;
    dut_in = 0;
    #3;
    dut_in = 0;
    #20;
    dut_in = 0;
    #200;
    $finish;
  end


  initial begin
    dut_aclk = 0;
    forever begin
      #0.5 dut_aclk = !dut_aclk;
    end
  end


  always @(posedge dut_aclk) begin
    i <= i % 23;
    if(i == 0) begin
      dut_grst <= 1;
    end else begin
      dut_grst <= 0;
    end
    i <= i + 1;
  end

  $Display(i);

endmodule



module pac #
(
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 13
)
(
  input [4-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [1-1:0] out
);

  localparam STAGES = 1;
  localparam OUT_RES = 2;
  localparam NUM = 4;
  localparam MAXRES = 4;
  wire [4-1:0] temp;
  wire [2-1:0] tout;
  wire [5-1:0] t2out;
  reg [4-1:0] fout;
  wire [4-1:0] muxout;
  assign temp[0] = in[0];
  assign temp[1] = in[1];
  assign tout = temp[3:2];
  assign muxout = ((out | grst) == 1)? -13 : t2out[4:1];

  always @(posedge aclk) begin
    fout <= muxout;
  end

  assign out = ~t2out[1];

endmodule

