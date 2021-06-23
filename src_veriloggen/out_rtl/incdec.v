

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

