

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


  generate for(0 "LessThan"; Q) begin
  end
  endgenerate


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

