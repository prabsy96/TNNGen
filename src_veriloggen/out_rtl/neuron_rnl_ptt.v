

module neuron_rnl_ptt #
(
  parameter INPUT_SIZE = 16,
  parameter THRESHOLD = 13
)
(
  input [16-1:0] input_spikes,
  input [16-1:0] inc,
  input [16-1:0] dec,
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] out_spike,
  output [3-1:0] weights_0,
  output [3-1:0] weights_1,
  output [3-1:0] weights_2,
  output [3-1:0] weights_3,
  output [3-1:0] weights_4,
  output [3-1:0] weights_5,
  output [3-1:0] weights_6,
  output [3-1:0] weights_7,
  output [3-1:0] weights_8,
  output [3-1:0] weights_9,
  output [3-1:0] weights_10,
  output [3-1:0] weights_11,
  output [3-1:0] weights_12,
  output [3-1:0] weights_13,
  output [3-1:0] weights_14,
  output [3-1:0] weights_15
);

  wire [16-1:0] up_in;

  fsm_synapse
  f1_0
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[0]),
    .inc(inc[0]),
    .dec(dec[0]),
    .out(up_in[0]),
    .weight(weights_0)
  );


  fsm_synapse
  f1_1
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[1]),
    .inc(inc[1]),
    .dec(dec[1]),
    .out(up_in[1]),
    .weight(weights_1)
  );


  fsm_synapse
  f1_2
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[2]),
    .inc(inc[2]),
    .dec(dec[2]),
    .out(up_in[2]),
    .weight(weights_2)
  );


  fsm_synapse
  f1_3
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[3]),
    .inc(inc[3]),
    .dec(dec[3]),
    .out(up_in[3]),
    .weight(weights_3)
  );


  fsm_synapse
  f1_4
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[4]),
    .inc(inc[4]),
    .dec(dec[4]),
    .out(up_in[4]),
    .weight(weights_4)
  );


  fsm_synapse
  f1_5
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[5]),
    .inc(inc[5]),
    .dec(dec[5]),
    .out(up_in[5]),
    .weight(weights_5)
  );


  fsm_synapse
  f1_6
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[6]),
    .inc(inc[6]),
    .dec(dec[6]),
    .out(up_in[6]),
    .weight(weights_6)
  );


  fsm_synapse
  f1_7
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[7]),
    .inc(inc[7]),
    .dec(dec[7]),
    .out(up_in[7]),
    .weight(weights_7)
  );


  fsm_synapse
  f1_8
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[8]),
    .inc(inc[8]),
    .dec(dec[8]),
    .out(up_in[8]),
    .weight(weights_8)
  );


  fsm_synapse
  f1_9
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[9]),
    .inc(inc[9]),
    .dec(dec[9]),
    .out(up_in[9]),
    .weight(weights_9)
  );


  fsm_synapse
  f1_10
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[10]),
    .inc(inc[10]),
    .dec(dec[10]),
    .out(up_in[10]),
    .weight(weights_10)
  );


  fsm_synapse
  f1_11
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[11]),
    .inc(inc[11]),
    .dec(dec[11]),
    .out(up_in[11]),
    .weight(weights_11)
  );


  fsm_synapse
  f1_12
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[12]),
    .inc(inc[12]),
    .dec(dec[12]),
    .out(up_in[12]),
    .weight(weights_12)
  );


  fsm_synapse
  f1_13
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[13]),
    .inc(inc[13]),
    .dec(dec[13]),
    .out(up_in[13]),
    .weight(weights_13)
  );


  fsm_synapse
  f1_14
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[14]),
    .inc(inc[14]),
    .dec(dec[14]),
    .out(up_in[14]),
    .weight(weights_14)
  );


  fsm_synapse
  f1_15
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[15]),
    .inc(inc[15]),
    .dec(dec[15]),
    .out(up_in[15]),
    .weight(weights_15)
  );


  neuron_body
  #(
    .INPUT_SIZE(16),
    .THRESHOLD(13)
  )
  p1
  (
    .acc_in(up_in),
    .aclk(aclk),
    .pac_rst(grst),
    .rst(rst),
    .out_spike(out_spike)
  );


endmodule



module fsm_synapse
(
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] rst,
  input [1-1:0] input_spike,
  input [1-1:0] inc,
  input [1-1:0] dec,
  output [1-1:0] out,
  output [3-1:0] weight
);

  reg [3-1:0] state;
  localparam [3-1:0] S0 = 0;
  localparam [3-1:0] S1 = 1;
  localparam [3-1:0] S2 = 2;
  localparam [3-1:0] S3 = 3;
  localparam [3-1:0] S4 = 4;
  localparam [3-1:0] S5 = 5;
  localparam [3-1:0] S6 = 6;
  localparam [3-1:0] S7 = 7;
  reg [1-1:0] dout;
  wire [1-1:0] din;
  wire [1-1:0] tclk;
  wire [1-1:0] tinc;
  wire [1-1:0] tdec;
  assign tinc = inc & ~input_spike;
  assign tdec = dec & ~input_spike;
  assign tclk = aclk & input_spike;

  always @(posedge aclk or posedge gclk) begin
    if(tclk) begin
      if(rst) begin
        state <= S0;
      end else begin
        if(state == S0) begin
          if(tclk) begin
            state <= S7;
          end else begin
            state <= S0;
          end
        end else if(state == S1) begin
          if(tclk == 1) begin
            state <= S0;
          end else begin
            state <= S1;
          end
        end else if(state == S2) begin
          if(tclk) begin
            state <= S1;
          end else begin
            state <= S2;
          end
        end else if(state == S3) begin
          if(tclk) begin
            state <= S2;
          end else begin
            state <= S3;
          end
        end else if(state == S4) begin
          if(tclk) begin
            state <= S3;
          end else begin
            state <= S4;
          end
        end else if(state == S5) begin
          if(tclk) begin
            state <= S4;
          end else begin
            state <= S5;
          end
        end else if(state == S6) begin
          if(tclk) begin
            state <= S5;
          end else begin
            state <= S6;
          end
        end else if(state == S7) begin
          if(tclk) begin
            state <= S6;
          end else begin
            state <= S7;
          end
        end 
      end
    end else if(rst) begin
      state <= S0;
    end else begin
      if(state == S0) begin
        if(tinc & weight_update_en) begin
          state <= S1;
        end else begin
          state <= S0;
        end
      end else if(state == S1) begin
        if(tdec & weight_update_en) begin
          state <= S0;
        end else if(tinc & weight_update_en) begin
          state <= S2;
        end else begin
          state <= S1;
        end
      end else if(state == S2) begin
        if(tdec & weight_update_en) begin
          state <= S1;
        end else if(tinc & weight_update_en) begin
          state <= S3;
        end else begin
          state <= S2;
        end
      end else if(state == S3) begin
        if(tdec & weight_update_en) begin
          state <= S2;
        end else if(tinc & weight_update_en) begin
          state <= S4;
        end else begin
          state <= S3;
        end
      end else if(state == S4) begin
        if(tdec & weight_update_en) begin
          state <= S3;
        end else if(tinc & weight_update_en) begin
          state <= S5;
        end else begin
          state <= S4;
        end
      end else if(state == S5) begin
        if(tdec & weight_update_en) begin
          state <= S4;
        end else if(tinc & weight_update_en) begin
          state <= S6;
        end else begin
          state <= S5;
        end
      end else if(state == S6) begin
        if(tdec & weight_update_en) begin
          state <= S5;
        end else if(tinc & weight_update_en) begin
          state <= S7;
        end else begin
          state <= S6;
        end
      end else if(state == S7) begin
        if(tdec & weight_update_en) begin
          state <= S6;
        end else begin
          state <= S7;
        end
      end 
    end
  end

  assign din = state[2] & state[1] & state[0];

  always @(posedge din or posedge gclk) begin
    if(din) begin
      if(input_spike) begin
        dout <= 1;
      end else begin
        dout <= 0;
      end
    end else begin
      dout <= 0;
    end
  end

  assign out = ~dout | input_spike;
  assign weight = state;

endmodule



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

