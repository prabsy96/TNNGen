

module less_equal
(
  input [1-1:0] data_in,
  input [1-1:0] inhibit_in,
  input [1-1:0] aclk,
  input [1-1:0] rst,
  output [1-1:0] out
);

  wire [1-1:0] temp1;
  wire [1-1:0] temp2;
  assign temp1 = ~data_in & inhibit_in;
  assign out = data_in & ~temp2;
  reg [1-1:0] aclk;
  reg [1-1:0] pulse_in;
  reg [1-1:0] grst;
  wire [1-1:0] edge_out;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(pulse_in),
    .grst(grst),
    .edge_out(edge_out)
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

