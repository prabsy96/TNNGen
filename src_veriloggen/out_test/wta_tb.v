

module test_wta
(

);

  localparam dut_Q = 4;
  reg [dut_Q-1:0] dut_ec_spikes;
  reg [1-1:0] dut_aclk;
  reg [1-1:0] dut_grst;
  wire [dut_Q-1:0] dut_li_out;

  wta
  dut
  (
    .ec_spikes(dut_ec_spikes),
    .aclk(dut_aclk),
    .grst(dut_grst),
    .li_out(dut_li_out)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_ec_spikes, dut_aclk, dut_grst, dut_li_out);
    dut_ec_spikes = 0;
    #5;
    dut_ec_spikes[2] = 1;
    dut_ec_spikes[1] = 1;
    #1;
    dut_ec_spikes[3] = 1;
    #5;
    dut_ec_spikes[0] = 1;
    #2;
    dut_ec_spikes[2] = 0;
    dut_ec_spikes[1] = 0;
    #1;
    dut_ec_spikes[3] = 0;
    #5;
    dut_ec_spikes[0] = 0;
    #9;
    dut_ec_spikes[2] = 1;
    dut_ec_spikes[1] = 1;
    dut_ec_spikes[0] = 1;
    dut_ec_spikes[3] = 1;
    #8;
    dut_ec_spikes[3] = 0;
    dut_ec_spikes[2] = 0;
    dut_ec_spikes[0] = 0;
    dut_ec_spikes[1] = 0;
    #15;
    dut_ec_spikes[2] = 1;
    dut_ec_spikes[3] = 1;
    #1;
    dut_ec_spikes[1] = 1;
    #5;
    dut_ec_spikes[0] = 1;
    #6;
    dut_ec_spikes[2] = 0;
    dut_ec_spikes[3] = 0;
    #1;
    dut_ec_spikes[1] = 0;
    #5;
    dut_ec_spikes[0] = 0;
    #10;
    dut_ec_spikes = 0;
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



module wta #
(
  parameter Q = 4
)
(
  input [Q-1:0] ec_spikes,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [Q-1:0] li_out
);

  wire first_spike;
  wire first_spike_edge;
  wire [Q-1:0] temp;
  genvar i;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(first_spike),
    .grst(grst),
    .edge_out(first_spike_edge)
  );

  reg [1-1:0] l1_0_pulse_in;
  reg [1-1:0] l1_0_grst;
  wire [1-1:0] l1_0_edge_out;

  less_equal
  l1_0
  (
    .data_in(ec_spikes[0]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[0]),
    .pulse_in(l1_0_pulse_in),
    .grst(l1_0_grst),
    .edge_out(l1_0_edge_out)
  );

  reg [1-1:0] l1_1_pulse_in;
  reg [1-1:0] l1_1_grst;
  wire [1-1:0] l1_1_edge_out;

  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[1]),
    .pulse_in(l1_1_pulse_in),
    .grst(l1_1_grst),
    .edge_out(l1_1_edge_out)
  );

  reg [1-1:0] l1_2_pulse_in;
  reg [1-1:0] l1_2_grst;
  wire [1-1:0] l1_2_edge_out;

  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[2]),
    .pulse_in(l1_2_pulse_in),
    .grst(l1_2_grst),
    .edge_out(l1_2_edge_out)
  );

  reg [1-1:0] l1_3_pulse_in;
  reg [1-1:0] l1_3_grst;
  wire [1-1:0] l1_3_edge_out;

  less_equal
  l1_3
  (
    .data_in(ec_spikes[3]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[3]),
    .pulse_in(l1_3_pulse_in),
    .grst(l1_3_grst),
    .edge_out(l1_3_edge_out)
  );

  assign li_out[0] = temp[0];
  assign li_out[1] = temp[1] & ~(|temp[0:0]);
  assign li_out[2] = temp[2] & ~(|temp[1:0]);
  assign li_out[3] = temp[3] & ~(|temp[2:0]);

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

