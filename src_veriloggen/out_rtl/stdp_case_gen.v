

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

