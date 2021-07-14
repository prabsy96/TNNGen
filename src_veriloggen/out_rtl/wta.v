

module wta #
(
  parameter Q = 10
)
(
  input [10-1:0] ec_spikes,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [10-1:0] li_out
);

  wire first_spike;
  wire first_spike_edge;
  wire [10-1:0] temp;
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

  reg [1-1:0] l1_4_pulse_in;
  reg [1-1:0] l1_4_grst;
  wire [1-1:0] l1_4_edge_out;

  less_equal
  l1_4
  (
    .data_in(ec_spikes[4]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[4]),
    .pulse_in(l1_4_pulse_in),
    .grst(l1_4_grst),
    .edge_out(l1_4_edge_out)
  );

  reg [1-1:0] l1_5_pulse_in;
  reg [1-1:0] l1_5_grst;
  wire [1-1:0] l1_5_edge_out;

  less_equal
  l1_5
  (
    .data_in(ec_spikes[5]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[5]),
    .pulse_in(l1_5_pulse_in),
    .grst(l1_5_grst),
    .edge_out(l1_5_edge_out)
  );

  reg [1-1:0] l1_6_pulse_in;
  reg [1-1:0] l1_6_grst;
  wire [1-1:0] l1_6_edge_out;

  less_equal
  l1_6
  (
    .data_in(ec_spikes[6]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[6]),
    .pulse_in(l1_6_pulse_in),
    .grst(l1_6_grst),
    .edge_out(l1_6_edge_out)
  );

  reg [1-1:0] l1_7_pulse_in;
  reg [1-1:0] l1_7_grst;
  wire [1-1:0] l1_7_edge_out;

  less_equal
  l1_7
  (
    .data_in(ec_spikes[7]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[7]),
    .pulse_in(l1_7_pulse_in),
    .grst(l1_7_grst),
    .edge_out(l1_7_edge_out)
  );

  reg [1-1:0] l1_8_pulse_in;
  reg [1-1:0] l1_8_grst;
  wire [1-1:0] l1_8_edge_out;

  less_equal
  l1_8
  (
    .data_in(ec_spikes[8]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[8]),
    .pulse_in(l1_8_pulse_in),
    .grst(l1_8_grst),
    .edge_out(l1_8_edge_out)
  );

  reg [1-1:0] l1_9_pulse_in;
  reg [1-1:0] l1_9_grst;
  wire [1-1:0] l1_9_edge_out;

  less_equal
  l1_9
  (
    .data_in(ec_spikes[9]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .rst(grst),
    .out(temp[9]),
    .pulse_in(l1_9_pulse_in),
    .grst(l1_9_grst),
    .edge_out(l1_9_edge_out)
  );

  assign li_out[0] = temp[0];
  assign li_out[1] = temp[1] & ~(|temp[0:0]);
  assign li_out[2] = temp[2] & ~(|temp[1:0]);
  assign li_out[3] = temp[3] & ~(|temp[2:0]);
  assign li_out[4] = temp[4] & ~(|temp[3:0]);
  assign li_out[5] = temp[5] & ~(|temp[4:0]);
  assign li_out[6] = temp[6] & ~(|temp[5:0]);
  assign li_out[7] = temp[7] & ~(|temp[6:0]);
  assign li_out[8] = temp[8] & ~(|temp[7:0]);
  assign li_out[9] = temp[9] & ~(|temp[8:0]);

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

