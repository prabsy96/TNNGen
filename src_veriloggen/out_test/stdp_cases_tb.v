

module test_stdp_case_gen
(

);

  reg [1-1:0] dut_ein;
  reg [1-1:0] dut_eout;
  reg [1-1:0] dut_aclk;
  reg [1-1:0] dut_grst;
  wire [4-1:0] dut_stdp_cases;

  stdp_case_gen
  dut
  (
    .ein(dut_ein),
    .eout(dut_eout),
    .aclk(dut_aclk),
    .grst(dut_grst),
    .stdp_cases(dut_stdp_cases)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_ein, dut_eout, dut_aclk, dut_grst);
    dut_ein = 0;
    dut_eout = 0;
    #5;
    dut_ein = 1;
    #2;
    dut_eout = 1;
    #16;
    dut_ein = 0;
    dut_eout = 0;
    #5;
    dut_eout = 1;
    #2;
    dut_ein = 1;
    #16;
    dut_ein = 0;
    dut_eout = 0;
    #5;
    dut_ein = 1;
    #18;
    dut_ein = 0;
    #16;
    dut_eout = 1;
    #7;
    dut_eout = 0;
    #5;
    dut_ein = 0;
    #2;
    dut_eout = 0;
    #6;
    dut_ein = 0;
    #9;
    dut_eout = 0;
    #10;
    dut_ein = 0;
    dut_eout = 0;
    #10;
    #100;
    $finish;
  end


  initial begin
    dut_aclk = 0;
    forever begin
      #0.5 dut_aclk = !dut_aclk;
    end
  end


  always @(dut_aclk) begin
    i <= i % 23;
    if(i == 0) begin
      dut_grst <= 1;
    end else begin
      dut_grst <= 0;
    end
    i <= i + 1;
  end


endmodule



module stdp_case_gen
(
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [4-1:0] stdp_cases
);

  wire [1-1:0] temp;
  wire [1-1:0] tboth;
  wire [1-1:0] tone;
  wire [1-1:0] greater;
  assign temp = ~ein & eout;

  pulse2edge
  pe
  (
    .aclk(aclk),
    .pulse_in(temp),
    .grst(grst),
    .edge_out(greater)
  );

  assign tboth = ein & eout;
  assign tone = ein ^ eout;
  assign stdp_cases[0] = ~greater & tboth;
  assign stdp_cases[1] = greater & tboth;
  assign stdp_cases[2] = ~greater & tone;
  assign stdp_cases[3] = greater & tone;

endmodule



module pulse2edge
(
  input [1-1:0] aclk,
  input [1-1:0] pulse_in,
  input [1-1:0] grst,
  output [1-1:0] edge_out
);

  reg [1-1:0] temp;

  always @(posedge aclk or posedge grst) begin
    if(grst) begin
      temp <= 0;
    end else begin
      temp <= edge_out;
    end
  end

  assign edge_out = pulse_in | temp;

endmodule

