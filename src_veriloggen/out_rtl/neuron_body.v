

module neuron_body #
(
  parameter INPUT_SIZE = 16,
  parameter THRESHOLD = 13
)
(
  input [16-1:0] acc_in,
  input [1-1:0] aclk,
  input [1-1:0] pac_rst,
  input [1-1:0] rst,
  output [1-1:0] out_spike
);

  wire [1-1:0] temp_spike;

  pac
  #(
    .INPUT_SIZE(16),
    .THRESHOLD(13)
  )
  p1
  (
    .in(acc_in),
    .aclk(aclk),
    .grst(pac_rst),
    .out(temp_spike)
  );


  fsm_simple
  fs
  (
    .aclk(aclk),
    .rst(rst),
    .in(temp_spike),
    .out(out_spike)
  );


endmodule



module pac #
(
  parameter INPUT_SIZE = 16,
  parameter THRESHOLD = 13
)
(
  input [16-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [1-1:0] out
);

  localparam STAGES = 3;
  localparam OUT_RES = 4;
  localparam NUM = 26;
  localparam MAXRES = 5;
  wire [26-1:0] temp;
  wire [4-1:0] tout;
  wire [6-1:0] t2out;
  reg [5-1:0] fout;
  wire [5-1:0] muxout;
  assign temp[0] = in[0];
  assign temp[1] = in[1];
  assign temp[2] = in[2];
  assign temp[3] = in[3];
  assign temp[4] = in[4];
  assign temp[5] = in[5];
  assign temp[6] = in[6];
  assign temp[7] = in[7];

  adder
  #(
    .RES(1)
  )
  a1_10
  (
    .a(temp[(16>>1)*((1<<2)-1-2)+0+1:(16>>1)*((1<<2)-1-2)+0]),
    .b(temp[(16>>1)*((1<<2)-1-2)+2+1:(16>>1)*((1<<2)-1-2)+2]),
    .cin(in[8 + ((16 >> 2) * ((1 << 1) - 1) + 0)]),
    .out(temp[(16>>2)*((1<<3)-1-3+0)+2:(16>>2)*((1<<3)-1-3+0)])
  );


  adder
  #(
    .RES(2)
  )
  a1_20
  (
    .a(temp[(16>>2)*((1<<3)-2-2)+0+2:(16>>2)*((1<<3)-2-2)+0]),
    .b(temp[(16>>2)*((1<<3)-2-2)+3+2:(16>>2)*((1<<3)-2-2)+3]),
    .cin(in[8 + ((16 >> 3) * ((1 << 2) - 1) + 0)]),
    .out(temp[(16>>3)*((1<<4)-2-3+0)+3:(16>>3)*((1<<4)-2-3+0)])
  );


  adder
  #(
    .RES(2)
  )
  a1_21
  (
    .a(temp[(16>>2)*((1<<3)-2-2)+6+2:(16>>2)*((1<<3)-2-2)+6]),
    .b(temp[(16>>2)*((1<<3)-2-2)+9+2:(16>>2)*((1<<3)-2-2)+9]),
    .cin(in[8 + ((16 >> 3) * ((1 << 2) - 1) + 1)]),
    .out(temp[(16>>3)*((1<<4)-2-3+4)+3:(16>>3)*((1<<4)-2-3+4)])
  );

  assign tout = temp[25:22];
  assign muxout = ((out | grst) == 1)? -13 : t2out[5:1];

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



module fsm_simple
(
  input [1-1:0] aclk,
  input [1-1:0] rst,
  input [1-1:0] in,
  output [1-1:0] out
);

  wire [1-1:0] temp;
  reg [32-1:0] fsm;
  localparam fsm_init = 0;
  assign out = ~temp | temp & in;
  assign temp = ~fsm[2] | fsm[1] | fsm[0];
  localparam fsm_1 = 1;
  localparam fsm_2 = 2;
  localparam fsm_3 = 3;
  localparam fsm_4 = 4;
  localparam fsm_5 = 5;
  localparam fsm_6 = 6;
  localparam fsm_7 = 7;
  localparam fsm_8 = 8;

  always @(posedge aclk) begin
    if(rst) begin
      fsm <= fsm_init;
    end else begin
      case(fsm)
        fsm_init: begin
          if(out == 1) begin
            fsm <= fsm_1;
          end 
        end
        fsm_1: begin
          fsm <= fsm_2;
        end
        fsm_2: begin
          fsm <= fsm_3;
        end
        fsm_3: begin
          fsm <= fsm_4;
        end
        fsm_4: begin
          fsm <= fsm_5;
        end
        fsm_5: begin
          fsm <= fsm_6;
        end
        fsm_6: begin
          fsm <= fsm_7;
        end
        fsm_7: begin
          fsm <= fsm_8;
        end
      endcase
    end
  end


endmodule

