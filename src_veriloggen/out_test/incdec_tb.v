

module test_incdec
(

);

  reg [4-1:0] dut_stdp_cases;
  reg [1-1:0] dut_capture;
  reg [1-1:0] dut_minus;
  reg [1-1:0] dut_search;
  reg [1-1:0] dut_backoff;
  reg [1-1:0] dut_min;
  reg [1-1:0] dut_F;
  wire [1-1:0] dut_inc;
  wire [1-1:0] dut_dec;

  incdec
  dut
  (
    .stdp_cases(dut_stdp_cases),
    .capture(dut_capture),
    .minus(dut_minus),
    .search(dut_search),
    .backoff(dut_backoff),
    .min(dut_min),
    .F(dut_F),
    .inc(dut_inc),
    .dec(dut_dec)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_stdp_cases, dut_capture, dut_minus, dut_search, dut_backoff, dut_min, dut_F, dut_inc, dut_dec);
    dut_stdp_cases = 0;
    dut_capture = 0;
    dut_minus = 0;
    dut_search = 0;
    dut_backoff = 0;
    dut_min = 0;
    dut_F = 0;
    #5;
    dut_stdp_cases = 8;
    #5;
    dut_capture = 1;
    #5;
    dut_F = 1;
    #5;
    dut_stdp_cases = 4;
    #5;
    dut_minus = 1;
    dut_F = 0;
    #5;
    dut_F = 1;
    #5;
    dut_stdp_cases = 2;
    #5;
    dut_search = 1;
    dut_F = 0;
    #5;
    dut_F = 1;
    #5;
    dut_stdp_cases = 1;
    #5;
    dut_backoff = 1;
    dut_F = 0;
    #5;
    dut_F = 1;
    #10;
    dut_stdp_cases = 0;
    #200;
    $finish;
  end


endmodule



module incdec
(
  input [4-1:0] stdp_cases,
  input [1-1:0] capture,
  input [1-1:0] minus,
  input [1-1:0] search,
  input [1-1:0] backoff,
  input [1-1:0] min,
  input [1-1:0] F,
  output [1-1:0] inc,
  output [1-1:0] dec
);

  wire [1-1:0] temp;
  assign temp = F | min;
  assign inc = stdp_cases[0] & capture & temp | stdp_cases[2] & search;
  assign dec = stdp_cases[1] & minus & temp | stdp_cases[3] & backoff & temp;

endmodule

