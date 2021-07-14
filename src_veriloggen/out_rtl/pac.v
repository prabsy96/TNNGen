

module pac #
(
  parameter INPUT_SIZE = 32,
  parameter THRESHOLD = 13
)
(
  input [32-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [1-1:0] out
);

  localparam STAGES = 4;
  localparam OUT_RES = 5;
  localparam NUM = 57;
  localparam MAXRES = 6;
  wire [57-1:0] temp;
  wire [5-1:0] tout;
  wire [7-1:0] t2out;
  reg [6-1:0] fout;
  wire [6-1:0] muxout;
  assign temp[0] = in[0];
  assign temp[1] = in[1];
  assign temp[2] = in[2];
  assign temp[3] = in[3];
  assign temp[4] = in[4];
  assign temp[5] = in[5];
  assign temp[6] = in[6];
  assign temp[7] = in[7];
  assign temp[8] = in[8];
  assign temp[9] = in[9];
  assign temp[10] = in[10];
  assign temp[11] = in[11];
  assign temp[12] = in[12];
  assign temp[13] = in[13];
  assign temp[14] = in[14];
  assign temp[15] = in[15];

  adder
  #(
    .RES(1)
  )
  a1_10
  (
    .a(temp[(32>>1)*((1<<2)-1-2)+0+1:(32>>1)*((1<<2)-1-2)+0]),
    .b(temp[(32>>1)*((1<<2)-1-2)+2+1:(32>>1)*((1<<2)-1-2)+2]),
    .cin(in[16 + ((32 >> 2) * ((1 << 1) - 1) + 0)]),
    .out(temp[(32>>2)*((1<<3)-1-3+0)+2:(32>>2)*((1<<3)-1-3+0)])
  );


  adder
  #(
    .RES(2)
  )
  a1_20
  (
    .a(temp[(32>>2)*((1<<3)-2-2)+0+2:(32>>2)*((1<<3)-2-2)+0]),
    .b(temp[(32>>2)*((1<<3)-2-2)+3+2:(32>>2)*((1<<3)-2-2)+3]),
    .cin(in[16 + ((32 >> 3) * ((1 << 2) - 1) + 0)]),
    .out(temp[(32>>3)*((1<<4)-2-3+0)+3:(32>>3)*((1<<4)-2-3+0)])
  );


  adder
  #(
    .RES(2)
  )
  a1_21
  (
    .a(temp[(32>>2)*((1<<3)-2-2)+6+2:(32>>2)*((1<<3)-2-2)+6]),
    .b(temp[(32>>2)*((1<<3)-2-2)+9+2:(32>>2)*((1<<3)-2-2)+9]),
    .cin(in[16 + ((32 >> 3) * ((1 << 2) - 1) + 1)]),
    .out(temp[(32>>3)*((1<<4)-2-3+4)+3:(32>>3)*((1<<4)-2-3+4)])
  );


  adder
  #(
    .RES(3)
  )
  a1_30
  (
    .a(temp[(32>>3)*((1<<4)-3-2)+0+3:(32>>3)*((1<<4)-3-2)+0]),
    .b(temp[(32>>3)*((1<<4)-3-2)+4+3:(32>>3)*((1<<4)-3-2)+4]),
    .cin(in[16 + ((32 >> 4) * ((1 << 3) - 1) + 0)]),
    .out(temp[(32>>4)*((1<<5)-3-3+0)+4:(32>>4)*((1<<5)-3-3+0)])
  );


  adder
  #(
    .RES(3)
  )
  a1_31
  (
    .a(temp[(32>>3)*((1<<4)-3-2)+8+3:(32>>3)*((1<<4)-3-2)+8]),
    .b(temp[(32>>3)*((1<<4)-3-2)+12+3:(32>>3)*((1<<4)-3-2)+12]),
    .cin(in[16 + ((32 >> 4) * ((1 << 3) - 1) + 1)]),
    .out(temp[(32>>4)*((1<<5)-3-3+5)+4:(32>>4)*((1<<5)-3-3+5)])
  );


  adder
  #(
    .RES(3)
  )
  a1_32
  (
    .a(temp[(32>>3)*((1<<4)-3-2)+16+3:(32>>3)*((1<<4)-3-2)+16]),
    .b(temp[(32>>3)*((1<<4)-3-2)+20+3:(32>>3)*((1<<4)-3-2)+20]),
    .cin(in[16 + ((32 >> 4) * ((1 << 3) - 1) + 2)]),
    .out(temp[(32>>4)*((1<<5)-3-3+10)+4:(32>>4)*((1<<5)-3-3+10)])
  );

  assign tout = temp[56:52];
  assign muxout = ((out | grst) == 1)? -13 : t2out[6:1];

  always @(posedge aclk) begin
    fout <= muxout;
  end

  assign out = ~t2out[1];

endmodule



module adder #
(
  parameter RES = 4
)
(
  input [RES-1:0] a,
  input [RES-1:0] b,
  input cin,
  output [RES-1:0] out
);

  assign out = a + b + cin;

endmodule

