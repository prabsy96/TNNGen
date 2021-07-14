

module stdp
(
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] capture,
  input [1-1:0] minus,
  input [1-1:0] search,
  input [1-1:0] backoff,
  input [1-1:0] min,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [3-1:0] input_weight,
  input [6-1:0] F,
  output [1-1:0] inc,
  output [1-1:0] dec
);

  wire [4-1:0] stdp_cases;
  wire [1-1:0] fout;

  pulse2edge
  s1
  (
    .aclk(ein),
    .pulse_in(eout),
    .grst(aclk),
    .edge_out(grst)
  );


  flogic
  s2
  (
    .F(F),
    .input_weight(input_weight),
    .out(fout)
  );


  incdec
  s3
  (
    .stdp_cases(stdp_cases),
    .capture(capture),
    .minus(minus),
    .search(search),
    .backoff(backoff),
    .min(min),
    .F(fout),
    .inc(inc),
    .dec(dec)
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



module flogic
(
  input [6-1:0] F,
  input [3-1:0] input_weight,
  output reg [1-1:0] out
);


  always @(*) begin
    if(input_weight == 3'b0) begin
      out <= 0;
    end else if(input_weight == 3'b1) begin
      out <= F[0];
    end else if(input_weight == 3'b10) begin
      out <= F[1];
    end else if(input_weight == 3'b11) begin
      out <= F[2];
    end else if(input_weight == 3'b100) begin
      out <= F[3];
    end else if(input_weight == 3'b101) begin
      out <= F[4];
    end else if(input_weight == 3'b110) begin
      out <= F[5];
    end else if(input_weight == 3'b111) begin
      out <= 1;
    end 
  end


endmodule



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

