

module test_less_equal
(

);

  reg [1-1:0] dut_data_in;
  reg [1-1:0] dut_inhibit_in;
  reg [1-1:0] dut_aclk;
  reg [1-1:0] dut_rst;
  wire [1-1:0] dut_out;
  reg [1-1:0] dut_pulse_in;
  reg [1-1:0] dut_grst;
  wire [1-1:0] dut_edge_out;

  less_equal
  dut
  (
    .data_in(dut_data_in),
    .inhibit_in(dut_inhibit_in),
    .aclk(dut_aclk),
    .rst(dut_rst),
    .out(dut_out),
    .pulse_in(dut_pulse_in),
    .grst(dut_grst),
    .edge_out(dut_edge_out)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_data_in, dut_inhibit_in, dut_aclk, dut_rst, dut_out);
    dut_data_in = 0;
    dut_inhibit_in = 1;
    #5;
    dut_data_in = 1;
    #1;
    dut_data_in = 0;
    #5;
    dut_inhibit_in = 1;
    #11;
    dut_inhibit_in = 0;
    #5;
    dut_data_in = 1;
    #3;
    dut_inhibit_in = 1;
    #5;
    dut_data_in = 0;
    #9;
    dut_inhibit_in = 0;
    #5;
    dut_inhibit_in = 1;
    #3;
    dut_data_in = 1;
    #5;
    dut_data_in = 0;
    #9;
    dut_inhibit_in = 0;
    #5;
    dut_data_in = 1;
    dut_inhibit_in = 1;
    #8;
    dut_data_in = 0;
    #9;
    dut_inhibit_in = 0;
    #10;
    dut_data_in = 0;
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
    i = i%23;
    if(i == 0) begin
      dut_rst <= 1;
    end else begin
      dut_rst <= 0;
    end
    i = i+1;
  end


endmodule



module less_equal
(
  input [1-1:0] data_in,
  input [1-1:0] inhibit_in,
  input [1-1:0] aclk,
  input [1-1:0] rst,
  output [1-1:0] out,
  input [1-1:0] pulse_in,
  input [1-1:0] grst,
  output [1-1:0] edge_out
);

  wire [1-1:0] temp1;
  wire [1-1:0] temp2;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(temp1),
    .grst(rst),
    .edge_out(temp2)
  );

  assign temp1 = ~data_in & inhibit_in;
  assign out = data_in & ~temp2;

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

