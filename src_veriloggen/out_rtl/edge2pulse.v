

module edge2pulse
(
  input [1-1:0] edge_in,
  input [1-1:0] clk_in,
  output [1-1:0] pulse_out
);

  reg [1-1:0] temp1;
  reg [1-1:0] temp2;

  always @(posedge clk_in) begin
    temp1 <= edge_in;
    temp2 <= temp1;
  end

  assign pulse_out = edge_in & ~temp2;

endmodule

