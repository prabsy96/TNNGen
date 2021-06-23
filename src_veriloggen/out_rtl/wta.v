

module wta #
(
  parameter Q = 10
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
  wta_pet
  (
    .aclk(aclk),
    .pulse_in(first_spike),
    .grst(grst),
    .edge_out(first_spike_edge)
  );


  less_equal
  l1_0
  (
    .data_in(ec_spikes[0]),
    .inhibit_in(first_spike_edge[0]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[0])
  );


  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike_edge[1]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[1])
  );


  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike_edge[2]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[2])
  );


  less_equal
  l1_3
  (
    .data_in(ec_spikes[3]),
    .inhibit_in(first_spike_edge[3]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[3])
  );


  less_equal
  l1_4
  (
    .data_in(ec_spikes[4]),
    .inhibit_in(first_spike_edge[4]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[4])
  );


  less_equal
  l1_5
  (
    .data_in(ec_spikes[5]),
    .inhibit_in(first_spike_edge[5]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[5])
  );


  less_equal
  l1_6
  (
    .data_in(ec_spikes[6]),
    .inhibit_in(first_spike_edge[6]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[6])
  );


  less_equal
  l1_7
  (
    .data_in(ec_spikes[7]),
    .inhibit_in(first_spike_edge[7]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[7])
  );


  less_equal
  l1_8
  (
    .data_in(ec_spikes[8]),
    .inhibit_in(first_spike_edge[8]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[8])
  );


  less_equal
  l1_9
  (
    .data_in(ec_spikes[9]),
    .inhibit_in(first_spike_edge[9]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[9])
  );


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
  assign temp1 = ~data_in & inhibit_in;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(temp1),
    .grst(rst),
    .edge_out(temp2)
  );

  assign out = data_in & ~temp2;

endmodule

