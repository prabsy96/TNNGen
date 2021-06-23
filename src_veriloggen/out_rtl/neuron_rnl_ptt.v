

module neuron_rnl_ptt #
(
  parameter INPUT_SIZE = 64,
  parameter THRESHOLD = 13
)
(
  input [64-1:0] input_spikes,
  input [64-1:0] inc,
  input [64-1:0] dec,
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] out_spike,
  output [64-1:0] weights [0:3-1]
);

  wire [64-1:0] up_in;

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
    .weight(weights[0])
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
    .weight(weights[1])
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
    .weight(weights[2])
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
    .weight(weights[3])
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
    .weight(weights[4])
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
    .weight(weights[5])
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
    .weight(weights[6])
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
    .weight(weights[7])
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
    .weight(weights[8])
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
    .weight(weights[9])
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
    .weight(weights[10])
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
    .weight(weights[11])
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
    .weight(weights[12])
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
    .weight(weights[13])
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
    .weight(weights[14])
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
    .weight(weights[15])
  );


  fsm_synapse
  f1_16
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[16]),
    .inc(inc[16]),
    .dec(dec[16]),
    .out(up_in[16]),
    .weight(weights[16])
  );


  fsm_synapse
  f1_17
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[17]),
    .inc(inc[17]),
    .dec(dec[17]),
    .out(up_in[17]),
    .weight(weights[17])
  );


  fsm_synapse
  f1_18
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[18]),
    .inc(inc[18]),
    .dec(dec[18]),
    .out(up_in[18]),
    .weight(weights[18])
  );


  fsm_synapse
  f1_19
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[19]),
    .inc(inc[19]),
    .dec(dec[19]),
    .out(up_in[19]),
    .weight(weights[19])
  );


  fsm_synapse
  f1_20
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[20]),
    .inc(inc[20]),
    .dec(dec[20]),
    .out(up_in[20]),
    .weight(weights[20])
  );


  fsm_synapse
  f1_21
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[21]),
    .inc(inc[21]),
    .dec(dec[21]),
    .out(up_in[21]),
    .weight(weights[21])
  );


  fsm_synapse
  f1_22
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[22]),
    .inc(inc[22]),
    .dec(dec[22]),
    .out(up_in[22]),
    .weight(weights[22])
  );


  fsm_synapse
  f1_23
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[23]),
    .inc(inc[23]),
    .dec(dec[23]),
    .out(up_in[23]),
    .weight(weights[23])
  );


  fsm_synapse
  f1_24
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[24]),
    .inc(inc[24]),
    .dec(dec[24]),
    .out(up_in[24]),
    .weight(weights[24])
  );


  fsm_synapse
  f1_25
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[25]),
    .inc(inc[25]),
    .dec(dec[25]),
    .out(up_in[25]),
    .weight(weights[25])
  );


  fsm_synapse
  f1_26
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[26]),
    .inc(inc[26]),
    .dec(dec[26]),
    .out(up_in[26]),
    .weight(weights[26])
  );


  fsm_synapse
  f1_27
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[27]),
    .inc(inc[27]),
    .dec(dec[27]),
    .out(up_in[27]),
    .weight(weights[27])
  );


  fsm_synapse
  f1_28
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[28]),
    .inc(inc[28]),
    .dec(dec[28]),
    .out(up_in[28]),
    .weight(weights[28])
  );


  fsm_synapse
  f1_29
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[29]),
    .inc(inc[29]),
    .dec(dec[29]),
    .out(up_in[29]),
    .weight(weights[29])
  );


  fsm_synapse
  f1_30
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[30]),
    .inc(inc[30]),
    .dec(dec[30]),
    .out(up_in[30]),
    .weight(weights[30])
  );


  fsm_synapse
  f1_31
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[31]),
    .inc(inc[31]),
    .dec(dec[31]),
    .out(up_in[31]),
    .weight(weights[31])
  );


  fsm_synapse
  f1_32
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[32]),
    .inc(inc[32]),
    .dec(dec[32]),
    .out(up_in[32]),
    .weight(weights[32])
  );


  fsm_synapse
  f1_33
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[33]),
    .inc(inc[33]),
    .dec(dec[33]),
    .out(up_in[33]),
    .weight(weights[33])
  );


  fsm_synapse
  f1_34
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[34]),
    .inc(inc[34]),
    .dec(dec[34]),
    .out(up_in[34]),
    .weight(weights[34])
  );


  fsm_synapse
  f1_35
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[35]),
    .inc(inc[35]),
    .dec(dec[35]),
    .out(up_in[35]),
    .weight(weights[35])
  );


  fsm_synapse
  f1_36
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[36]),
    .inc(inc[36]),
    .dec(dec[36]),
    .out(up_in[36]),
    .weight(weights[36])
  );


  fsm_synapse
  f1_37
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[37]),
    .inc(inc[37]),
    .dec(dec[37]),
    .out(up_in[37]),
    .weight(weights[37])
  );


  fsm_synapse
  f1_38
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[38]),
    .inc(inc[38]),
    .dec(dec[38]),
    .out(up_in[38]),
    .weight(weights[38])
  );


  fsm_synapse
  f1_39
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[39]),
    .inc(inc[39]),
    .dec(dec[39]),
    .out(up_in[39]),
    .weight(weights[39])
  );


  fsm_synapse
  f1_40
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[40]),
    .inc(inc[40]),
    .dec(dec[40]),
    .out(up_in[40]),
    .weight(weights[40])
  );


  fsm_synapse
  f1_41
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[41]),
    .inc(inc[41]),
    .dec(dec[41]),
    .out(up_in[41]),
    .weight(weights[41])
  );


  fsm_synapse
  f1_42
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[42]),
    .inc(inc[42]),
    .dec(dec[42]),
    .out(up_in[42]),
    .weight(weights[42])
  );


  fsm_synapse
  f1_43
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[43]),
    .inc(inc[43]),
    .dec(dec[43]),
    .out(up_in[43]),
    .weight(weights[43])
  );


  fsm_synapse
  f1_44
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[44]),
    .inc(inc[44]),
    .dec(dec[44]),
    .out(up_in[44]),
    .weight(weights[44])
  );


  fsm_synapse
  f1_45
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[45]),
    .inc(inc[45]),
    .dec(dec[45]),
    .out(up_in[45]),
    .weight(weights[45])
  );


  fsm_synapse
  f1_46
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[46]),
    .inc(inc[46]),
    .dec(dec[46]),
    .out(up_in[46]),
    .weight(weights[46])
  );


  fsm_synapse
  f1_47
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[47]),
    .inc(inc[47]),
    .dec(dec[47]),
    .out(up_in[47]),
    .weight(weights[47])
  );


  fsm_synapse
  f1_48
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[48]),
    .inc(inc[48]),
    .dec(dec[48]),
    .out(up_in[48]),
    .weight(weights[48])
  );


  fsm_synapse
  f1_49
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[49]),
    .inc(inc[49]),
    .dec(dec[49]),
    .out(up_in[49]),
    .weight(weights[49])
  );


  fsm_synapse
  f1_50
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[50]),
    .inc(inc[50]),
    .dec(dec[50]),
    .out(up_in[50]),
    .weight(weights[50])
  );


  fsm_synapse
  f1_51
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[51]),
    .inc(inc[51]),
    .dec(dec[51]),
    .out(up_in[51]),
    .weight(weights[51])
  );


  fsm_synapse
  f1_52
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[52]),
    .inc(inc[52]),
    .dec(dec[52]),
    .out(up_in[52]),
    .weight(weights[52])
  );


  fsm_synapse
  f1_53
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[53]),
    .inc(inc[53]),
    .dec(dec[53]),
    .out(up_in[53]),
    .weight(weights[53])
  );


  fsm_synapse
  f1_54
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[54]),
    .inc(inc[54]),
    .dec(dec[54]),
    .out(up_in[54]),
    .weight(weights[54])
  );


  fsm_synapse
  f1_55
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[55]),
    .inc(inc[55]),
    .dec(dec[55]),
    .out(up_in[55]),
    .weight(weights[55])
  );


  fsm_synapse
  f1_56
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[56]),
    .inc(inc[56]),
    .dec(dec[56]),
    .out(up_in[56]),
    .weight(weights[56])
  );


  fsm_synapse
  f1_57
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[57]),
    .inc(inc[57]),
    .dec(dec[57]),
    .out(up_in[57]),
    .weight(weights[57])
  );


  fsm_synapse
  f1_58
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[58]),
    .inc(inc[58]),
    .dec(dec[58]),
    .out(up_in[58]),
    .weight(weights[58])
  );


  fsm_synapse
  f1_59
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[59]),
    .inc(inc[59]),
    .dec(dec[59]),
    .out(up_in[59]),
    .weight(weights[59])
  );


  fsm_synapse
  f1_60
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[60]),
    .inc(inc[60]),
    .dec(dec[60]),
    .out(up_in[60]),
    .weight(weights[60])
  );


  fsm_synapse
  f1_61
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[61]),
    .inc(inc[61]),
    .dec(dec[61]),
    .out(up_in[61]),
    .weight(weights[61])
  );


  fsm_synapse
  f1_62
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[62]),
    .inc(inc[62]),
    .dec(dec[62]),
    .out(up_in[62]),
    .weight(weights[62])
  );


  fsm_synapse
  f1_63
  (
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .input_spike(input_spikes[63]),
    .inc(inc[63]),
    .dec(dec[63]),
    .out(up_in[63]),
    .weight(weights[63])
  );


  neuron_body
  #(
    .INPUT_SIZE(64),
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
  input [INPUT_SIZE-1:0] acc_in,
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
  parameter INPUT_SIZE = 32,
  parameter THRESHOLD = 13
)
(
  input [10-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [1-1:0] out
);

  localparam OUT_RES = 5;
  localparam IN_SIZE = 10;
  localparam STAGES = 9;
  localparam NUM = 13;
  localparam MAXRES = 14;
  wire [10-1:0] tin;
  wire [13-1:0] temp;
  wire [5-1:0] tout;
  wire [14-1:0] t2out;
  reg [14-1:0] fout;
  wire [14-1:0] maxout;
  assign tin = IN_SIZE'(in);
  assign temp[0] = tin[0];
  assign temp[1] = tin[1];
  assign temp[2] = tin[2];
  assign temp[3] = tin[3];
  assign temp[4] = tin[4];

  adder
  #(
    .RES(1)
  )
  a1_10
  (
    .a(temp[(10>>1)*((1<<2)-1-3+0):(10>>1)*((1<<2)-1-2)+0+1]),
    .b(temp[(10>>1)*((1<<2)-1-2)+1:(10>>1)*((1<<2)-1-2)+2+1]),
    .cin(tin[5 + ((10 >> 2) * ((1 << 1) - 1) + 0)]),
    .out(temp[(10>>2)*((1<<3)-1-3+0):(10>>2)*((1<<3)-1-3+0)+2])
  );


  adder
  #(
    .RES(2)
  )
  a1_20
  (
    .a(temp[(10>>2)*((1<<3)-2-3+0):(10>>2)*((1<<3)-2-2)+0+2]),
    .b(temp[(10>>2)*((1<<3)-2-2)+1:(10>>2)*((1<<3)-2-2)+3+2]),
    .cin(tin[5 + ((10 >> 3) * ((1 << 2) - 1) + 0)]),
    .out(temp[(10>>3)*((1<<4)-2-3+0):(10>>3)*((1<<4)-2-3+0)+3])
  );


  adder
  #(
    .RES(2)
  )
  a1_21
  (
    .a(temp[(10>>2)*((1<<3)-2-3+6):(10>>2)*((1<<3)-2-2)+6+2]),
    .b(temp[(10>>2)*((1<<3)-2-2)+3:(10>>2)*((1<<3)-2-2)+9+2]),
    .cin(tin[5 + ((10 >> 3) * ((1 << 2) - 1) + 1)]),
    .out(temp[(10>>3)*((1<<4)-2-3+4):(10>>3)*((1<<4)-2-3+4)+3])
  );


  adder
  #(
    .RES(3)
  )
  a1_30
  (
    .a(temp[(10>>3)*((1<<4)-3-3+0):(10>>3)*((1<<4)-3-2)+0+3]),
    .b(temp[(10>>3)*((1<<4)-3-2)+1:(10>>3)*((1<<4)-3-2)+4+3]),
    .cin(tin[5 + ((10 >> 4) * ((1 << 3) - 1) + 0)]),
    .out(temp[(10>>4)*((1<<5)-3-3+0):(10>>4)*((1<<5)-3-3+0)+4])
  );


  adder
  #(
    .RES(3)
  )
  a1_31
  (
    .a(temp[(10>>3)*((1<<4)-3-3+8):(10>>3)*((1<<4)-3-2)+8+3]),
    .b(temp[(10>>3)*((1<<4)-3-2)+3:(10>>3)*((1<<4)-3-2)+12+3]),
    .cin(tin[5 + ((10 >> 4) * ((1 << 3) - 1) + 1)]),
    .out(temp[(10>>4)*((1<<5)-3-3+5):(10>>4)*((1<<5)-3-3+5)+4])
  );


  adder
  #(
    .RES(3)
  )
  a1_32
  (
    .a(temp[(10>>3)*((1<<4)-3-3+16):(10>>3)*((1<<4)-3-2)+16+3]),
    .b(temp[(10>>3)*((1<<4)-3-2)+5:(10>>3)*((1<<4)-3-2)+20+3]),
    .cin(tin[5 + ((10 >> 4) * ((1 << 3) - 1) + 2)]),
    .out(temp[(10>>4)*((1<<5)-3-3+10):(10>>4)*((1<<5)-3-3+10)+4])
  );


  adder
  #(
    .RES(4)
  )
  a1_40
  (
    .a(temp[(10>>4)*((1<<5)-4-3+0):(10>>4)*((1<<5)-4-2)+0+4]),
    .b(temp[(10>>4)*((1<<5)-4-2)+1:(10>>4)*((1<<5)-4-2)+5+4]),
    .cin(tin[5 + ((10 >> 5) * ((1 << 4) - 1) + 0)]),
    .out(temp[(10>>5)*((1<<6)-4-3+0):(10>>5)*((1<<6)-4-3+0)+5])
  );


  adder
  #(
    .RES(4)
  )
  a1_41
  (
    .a(temp[(10>>4)*((1<<5)-4-3+10):(10>>4)*((1<<5)-4-2)+10+4]),
    .b(temp[(10>>4)*((1<<5)-4-2)+3:(10>>4)*((1<<5)-4-2)+15+4]),
    .cin(tin[5 + ((10 >> 5) * ((1 << 4) - 1) + 1)]),
    .out(temp[(10>>5)*((1<<6)-4-3+6):(10>>5)*((1<<6)-4-3+6)+5])
  );


  adder
  #(
    .RES(4)
  )
  a1_42
  (
    .a(temp[(10>>4)*((1<<5)-4-3+20):(10>>4)*((1<<5)-4-2)+20+4]),
    .b(temp[(10>>4)*((1<<5)-4-2)+5:(10>>4)*((1<<5)-4-2)+25+4]),
    .cin(tin[5 + ((10 >> 5) * ((1 << 4) - 1) + 2)]),
    .out(temp[(10>>5)*((1<<6)-4-3+12):(10>>5)*((1<<6)-4-3+12)+5])
  );


  adder
  #(
    .RES(4)
  )
  a1_43
  (
    .a(temp[(10>>4)*((1<<5)-4-3+30):(10>>4)*((1<<5)-4-2)+30+4]),
    .b(temp[(10>>4)*((1<<5)-4-2)+7:(10>>4)*((1<<5)-4-2)+35+4]),
    .cin(tin[5 + ((10 >> 5) * ((1 << 4) - 1) + 3)]),
    .out(temp[(10>>5)*((1<<6)-4-3+18):(10>>5)*((1<<6)-4-3+18)+5])
  );


  adder
  #(
    .RES(5)
  )
  a1_50
  (
    .a(temp[(10>>5)*((1<<6)-5-3+0):(10>>5)*((1<<6)-5-2)+0+5]),
    .b(temp[(10>>5)*((1<<6)-5-2)+1:(10>>5)*((1<<6)-5-2)+6+5]),
    .cin(tin[5 + ((10 >> 6) * ((1 << 5) - 1) + 0)]),
    .out(temp[(10>>6)*((1<<7)-5-3+0):(10>>6)*((1<<7)-5-3+0)+6])
  );


  adder
  #(
    .RES(5)
  )
  a1_51
  (
    .a(temp[(10>>5)*((1<<6)-5-3+12):(10>>5)*((1<<6)-5-2)+12+5]),
    .b(temp[(10>>5)*((1<<6)-5-2)+3:(10>>5)*((1<<6)-5-2)+18+5]),
    .cin(tin[5 + ((10 >> 6) * ((1 << 5) - 1) + 1)]),
    .out(temp[(10>>6)*((1<<7)-5-3+7):(10>>6)*((1<<7)-5-3+7)+6])
  );


  adder
  #(
    .RES(5)
  )
  a1_52
  (
    .a(temp[(10>>5)*((1<<6)-5-3+24):(10>>5)*((1<<6)-5-2)+24+5]),
    .b(temp[(10>>5)*((1<<6)-5-2)+5:(10>>5)*((1<<6)-5-2)+30+5]),
    .cin(tin[5 + ((10 >> 6) * ((1 << 5) - 1) + 2)]),
    .out(temp[(10>>6)*((1<<7)-5-3+14):(10>>6)*((1<<7)-5-3+14)+6])
  );


  adder
  #(
    .RES(5)
  )
  a1_53
  (
    .a(temp[(10>>5)*((1<<6)-5-3+36):(10>>5)*((1<<6)-5-2)+36+5]),
    .b(temp[(10>>5)*((1<<6)-5-2)+7:(10>>5)*((1<<6)-5-2)+42+5]),
    .cin(tin[5 + ((10 >> 6) * ((1 << 5) - 1) + 3)]),
    .out(temp[(10>>6)*((1<<7)-5-3+21):(10>>6)*((1<<7)-5-3+21)+6])
  );


  adder
  #(
    .RES(5)
  )
  a1_54
  (
    .a(temp[(10>>5)*((1<<6)-5-3+48):(10>>5)*((1<<6)-5-2)+48+5]),
    .b(temp[(10>>5)*((1<<6)-5-2)+9:(10>>5)*((1<<6)-5-2)+54+5]),
    .cin(tin[5 + ((10 >> 6) * ((1 << 5) - 1) + 4)]),
    .out(temp[(10>>6)*((1<<7)-5-3+28):(10>>6)*((1<<7)-5-3+28)+6])
  );


  adder
  #(
    .RES(6)
  )
  a1_60
  (
    .a(temp[(10>>6)*((1<<7)-6-3+0):(10>>6)*((1<<7)-6-2)+0+6]),
    .b(temp[(10>>6)*((1<<7)-6-2)+1:(10>>6)*((1<<7)-6-2)+7+6]),
    .cin(tin[5 + ((10 >> 7) * ((1 << 6) - 1) + 0)]),
    .out(temp[(10>>7)*((1<<8)-6-3+0):(10>>7)*((1<<8)-6-3+0)+7])
  );


  adder
  #(
    .RES(6)
  )
  a1_61
  (
    .a(temp[(10>>6)*((1<<7)-6-3+14):(10>>6)*((1<<7)-6-2)+14+6]),
    .b(temp[(10>>6)*((1<<7)-6-2)+3:(10>>6)*((1<<7)-6-2)+21+6]),
    .cin(tin[5 + ((10 >> 7) * ((1 << 6) - 1) + 1)]),
    .out(temp[(10>>7)*((1<<8)-6-3+8):(10>>7)*((1<<8)-6-3+8)+7])
  );


  adder
  #(
    .RES(6)
  )
  a1_62
  (
    .a(temp[(10>>6)*((1<<7)-6-3+28):(10>>6)*((1<<7)-6-2)+28+6]),
    .b(temp[(10>>6)*((1<<7)-6-2)+5:(10>>6)*((1<<7)-6-2)+35+6]),
    .cin(tin[5 + ((10 >> 7) * ((1 << 6) - 1) + 2)]),
    .out(temp[(10>>7)*((1<<8)-6-3+16):(10>>7)*((1<<8)-6-3+16)+7])
  );


  adder
  #(
    .RES(6)
  )
  a1_63
  (
    .a(temp[(10>>6)*((1<<7)-6-3+42):(10>>6)*((1<<7)-6-2)+42+6]),
    .b(temp[(10>>6)*((1<<7)-6-2)+7:(10>>6)*((1<<7)-6-2)+49+6]),
    .cin(tin[5 + ((10 >> 7) * ((1 << 6) - 1) + 3)]),
    .out(temp[(10>>7)*((1<<8)-6-3+24):(10>>7)*((1<<8)-6-3+24)+7])
  );


  adder
  #(
    .RES(6)
  )
  a1_64
  (
    .a(temp[(10>>6)*((1<<7)-6-3+56):(10>>6)*((1<<7)-6-2)+56+6]),
    .b(temp[(10>>6)*((1<<7)-6-2)+9:(10>>6)*((1<<7)-6-2)+63+6]),
    .cin(tin[5 + ((10 >> 7) * ((1 << 6) - 1) + 4)]),
    .out(temp[(10>>7)*((1<<8)-6-3+32):(10>>7)*((1<<8)-6-3+32)+7])
  );


  adder
  #(
    .RES(6)
  )
  a1_65
  (
    .a(temp[(10>>6)*((1<<7)-6-3+70):(10>>6)*((1<<7)-6-2)+70+6]),
    .b(temp[(10>>6)*((1<<7)-6-2)+11:(10>>6)*((1<<7)-6-2)+77+6]),
    .cin(tin[5 + ((10 >> 7) * ((1 << 6) - 1) + 5)]),
    .out(temp[(10>>7)*((1<<8)-6-3+40):(10>>7)*((1<<8)-6-3+40)+7])
  );


  adder
  #(
    .RES(7)
  )
  a1_70
  (
    .a(temp[(10>>7)*((1<<8)-7-3+0):(10>>7)*((1<<8)-7-2)+0+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+1:(10>>7)*((1<<8)-7-2)+8+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 0)]),
    .out(temp[(10>>8)*((1<<9)-7-3+0):(10>>8)*((1<<9)-7-3+0)+8])
  );


  adder
  #(
    .RES(7)
  )
  a1_71
  (
    .a(temp[(10>>7)*((1<<8)-7-3+16):(10>>7)*((1<<8)-7-2)+16+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+3:(10>>7)*((1<<8)-7-2)+24+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 1)]),
    .out(temp[(10>>8)*((1<<9)-7-3+9):(10>>8)*((1<<9)-7-3+9)+8])
  );


  adder
  #(
    .RES(7)
  )
  a1_72
  (
    .a(temp[(10>>7)*((1<<8)-7-3+32):(10>>7)*((1<<8)-7-2)+32+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+5:(10>>7)*((1<<8)-7-2)+40+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 2)]),
    .out(temp[(10>>8)*((1<<9)-7-3+18):(10>>8)*((1<<9)-7-3+18)+8])
  );


  adder
  #(
    .RES(7)
  )
  a1_73
  (
    .a(temp[(10>>7)*((1<<8)-7-3+48):(10>>7)*((1<<8)-7-2)+48+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+7:(10>>7)*((1<<8)-7-2)+56+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 3)]),
    .out(temp[(10>>8)*((1<<9)-7-3+27):(10>>8)*((1<<9)-7-3+27)+8])
  );


  adder
  #(
    .RES(7)
  )
  a1_74
  (
    .a(temp[(10>>7)*((1<<8)-7-3+64):(10>>7)*((1<<8)-7-2)+64+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+9:(10>>7)*((1<<8)-7-2)+72+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 4)]),
    .out(temp[(10>>8)*((1<<9)-7-3+36):(10>>8)*((1<<9)-7-3+36)+8])
  );


  adder
  #(
    .RES(7)
  )
  a1_75
  (
    .a(temp[(10>>7)*((1<<8)-7-3+80):(10>>7)*((1<<8)-7-2)+80+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+11:(10>>7)*((1<<8)-7-2)+88+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 5)]),
    .out(temp[(10>>8)*((1<<9)-7-3+45):(10>>8)*((1<<9)-7-3+45)+8])
  );


  adder
  #(
    .RES(7)
  )
  a1_76
  (
    .a(temp[(10>>7)*((1<<8)-7-3+96):(10>>7)*((1<<8)-7-2)+96+7]),
    .b(temp[(10>>7)*((1<<8)-7-2)+13:(10>>7)*((1<<8)-7-2)+104+7]),
    .cin(tin[5 + ((10 >> 8) * ((1 << 7) - 1) + 6)]),
    .out(temp[(10>>8)*((1<<9)-7-3+54):(10>>8)*((1<<9)-7-3+54)+8])
  );


  adder
  #(
    .RES(8)
  )
  a1_80
  (
    .a(temp[(10>>8)*((1<<9)-8-3+0):(10>>8)*((1<<9)-8-2)+0+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+1:(10>>8)*((1<<9)-8-2)+9+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 0)]),
    .out(temp[(10>>9)*((1<<10)-8-3+0):(10>>9)*((1<<10)-8-3+0)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_81
  (
    .a(temp[(10>>8)*((1<<9)-8-3+18):(10>>8)*((1<<9)-8-2)+18+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+3:(10>>8)*((1<<9)-8-2)+27+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 1)]),
    .out(temp[(10>>9)*((1<<10)-8-3+10):(10>>9)*((1<<10)-8-3+10)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_82
  (
    .a(temp[(10>>8)*((1<<9)-8-3+36):(10>>8)*((1<<9)-8-2)+36+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+5:(10>>8)*((1<<9)-8-2)+45+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 2)]),
    .out(temp[(10>>9)*((1<<10)-8-3+20):(10>>9)*((1<<10)-8-3+20)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_83
  (
    .a(temp[(10>>8)*((1<<9)-8-3+54):(10>>8)*((1<<9)-8-2)+54+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+7:(10>>8)*((1<<9)-8-2)+63+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 3)]),
    .out(temp[(10>>9)*((1<<10)-8-3+30):(10>>9)*((1<<10)-8-3+30)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_84
  (
    .a(temp[(10>>8)*((1<<9)-8-3+72):(10>>8)*((1<<9)-8-2)+72+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+9:(10>>8)*((1<<9)-8-2)+81+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 4)]),
    .out(temp[(10>>9)*((1<<10)-8-3+40):(10>>9)*((1<<10)-8-3+40)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_85
  (
    .a(temp[(10>>8)*((1<<9)-8-3+90):(10>>8)*((1<<9)-8-2)+90+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+11:(10>>8)*((1<<9)-8-2)+99+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 5)]),
    .out(temp[(10>>9)*((1<<10)-8-3+50):(10>>9)*((1<<10)-8-3+50)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_86
  (
    .a(temp[(10>>8)*((1<<9)-8-3+108):(10>>8)*((1<<9)-8-2)+108+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+13:(10>>8)*((1<<9)-8-2)+117+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 6)]),
    .out(temp[(10>>9)*((1<<10)-8-3+60):(10>>9)*((1<<10)-8-3+60)+9])
  );


  adder
  #(
    .RES(8)
  )
  a1_87
  (
    .a(temp[(10>>8)*((1<<9)-8-3+126):(10>>8)*((1<<9)-8-2)+126+8]),
    .b(temp[(10>>8)*((1<<9)-8-2)+15:(10>>8)*((1<<9)-8-2)+135+8]),
    .cin(tin[5 + ((10 >> 9) * ((1 << 8) - 1) + 7)]),
    .out(temp[(10>>9)*((1<<10)-8-3+70):(10>>9)*((1<<10)-8-3+70)+9])
  );

  assign tout = temp[8:12];

  always @(posedge aclk) begin
    fout <= maxout;
  end

  assign out = ~t2out[1];
  assign muxout = (out | grst) ? -1*THRESHOLD : t2out[1:MAXRES];

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

