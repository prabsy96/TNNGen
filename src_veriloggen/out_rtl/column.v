

module column #
(
  parameter P = 32,
  parameter Q = 12,
  parameter THRESHOLD = 13
)
(
  input [32-1:0] input_spike,
  input [12-1:0] capture [0:32-1],
  input [12-1:0] minus [0:32-1],
  input [12-1:0] search [0:32-1],
  input [12-1:0] backoff [0:32-1],
  input [12-1:0] min [0:32-1],
  input [12-1:0] F [0:6-1],
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] rst,
  output [12-1:0] output_spikes,
  output [12-1:0] eout
);

  wire [32-1:0] ein;
  wire [12-1:0] ec_spikes;
  wire [12-1:0] weights [0:32-1][0:3-1];
  wire [12-1:0] inc [0:32-1][0:2-1];
  wire [12-1:0] dec [0:32-1];
  wire [1-1:0] gclk_pulse;

  edge2pulse
  ep
  (
    .edge_in(gclk),
    .clk_in(aclk),
    .pulse_out(gclk_pulse)
  );


  pulse2edge
  in_pe_0
  (
    .aclk(aclk),
    .pulse_in(input_spike[0]),
    .grst(gclk_pulse),
    .edge_out(ein[0])
  );


  pulse2edge
  in_pe_1
  (
    .aclk(aclk),
    .pulse_in(input_spike[1]),
    .grst(gclk_pulse),
    .edge_out(ein[1])
  );


  pulse2edge
  in_pe_2
  (
    .aclk(aclk),
    .pulse_in(input_spike[2]),
    .grst(gclk_pulse),
    .edge_out(ein[2])
  );


  pulse2edge
  in_pe_3
  (
    .aclk(aclk),
    .pulse_in(input_spike[3]),
    .grst(gclk_pulse),
    .edge_out(ein[3])
  );


  pulse2edge
  in_pe_4
  (
    .aclk(aclk),
    .pulse_in(input_spike[4]),
    .grst(gclk_pulse),
    .edge_out(ein[4])
  );


  pulse2edge
  in_pe_5
  (
    .aclk(aclk),
    .pulse_in(input_spike[5]),
    .grst(gclk_pulse),
    .edge_out(ein[5])
  );


  pulse2edge
  in_pe_6
  (
    .aclk(aclk),
    .pulse_in(input_spike[6]),
    .grst(gclk_pulse),
    .edge_out(ein[6])
  );


  pulse2edge
  in_pe_7
  (
    .aclk(aclk),
    .pulse_in(input_spike[7]),
    .grst(gclk_pulse),
    .edge_out(ein[7])
  );


  pulse2edge
  in_pe_8
  (
    .aclk(aclk),
    .pulse_in(input_spike[8]),
    .grst(gclk_pulse),
    .edge_out(ein[8])
  );


  pulse2edge
  in_pe_9
  (
    .aclk(aclk),
    .pulse_in(input_spike[9]),
    .grst(gclk_pulse),
    .edge_out(ein[9])
  );


  pulse2edge
  in_pe_10
  (
    .aclk(aclk),
    .pulse_in(input_spike[10]),
    .grst(gclk_pulse),
    .edge_out(ein[10])
  );


  pulse2edge
  in_pe_11
  (
    .aclk(aclk),
    .pulse_in(input_spike[11]),
    .grst(gclk_pulse),
    .edge_out(ein[11])
  );


  pulse2edge
  in_pe_12
  (
    .aclk(aclk),
    .pulse_in(input_spike[12]),
    .grst(gclk_pulse),
    .edge_out(ein[12])
  );


  pulse2edge
  in_pe_13
  (
    .aclk(aclk),
    .pulse_in(input_spike[13]),
    .grst(gclk_pulse),
    .edge_out(ein[13])
  );


  pulse2edge
  in_pe_14
  (
    .aclk(aclk),
    .pulse_in(input_spike[14]),
    .grst(gclk_pulse),
    .edge_out(ein[14])
  );


  pulse2edge
  in_pe_15
  (
    .aclk(aclk),
    .pulse_in(input_spike[15]),
    .grst(gclk_pulse),
    .edge_out(ein[15])
  );


  pulse2edge
  in_pe_16
  (
    .aclk(aclk),
    .pulse_in(input_spike[16]),
    .grst(gclk_pulse),
    .edge_out(ein[16])
  );


  pulse2edge
  in_pe_17
  (
    .aclk(aclk),
    .pulse_in(input_spike[17]),
    .grst(gclk_pulse),
    .edge_out(ein[17])
  );


  pulse2edge
  in_pe_18
  (
    .aclk(aclk),
    .pulse_in(input_spike[18]),
    .grst(gclk_pulse),
    .edge_out(ein[18])
  );


  pulse2edge
  in_pe_19
  (
    .aclk(aclk),
    .pulse_in(input_spike[19]),
    .grst(gclk_pulse),
    .edge_out(ein[19])
  );


  pulse2edge
  in_pe_20
  (
    .aclk(aclk),
    .pulse_in(input_spike[20]),
    .grst(gclk_pulse),
    .edge_out(ein[20])
  );


  pulse2edge
  in_pe_21
  (
    .aclk(aclk),
    .pulse_in(input_spike[21]),
    .grst(gclk_pulse),
    .edge_out(ein[21])
  );


  pulse2edge
  in_pe_22
  (
    .aclk(aclk),
    .pulse_in(input_spike[22]),
    .grst(gclk_pulse),
    .edge_out(ein[22])
  );


  pulse2edge
  in_pe_23
  (
    .aclk(aclk),
    .pulse_in(input_spike[23]),
    .grst(gclk_pulse),
    .edge_out(ein[23])
  );


  pulse2edge
  in_pe_24
  (
    .aclk(aclk),
    .pulse_in(input_spike[24]),
    .grst(gclk_pulse),
    .edge_out(ein[24])
  );


  pulse2edge
  in_pe_25
  (
    .aclk(aclk),
    .pulse_in(input_spike[25]),
    .grst(gclk_pulse),
    .edge_out(ein[25])
  );


  pulse2edge
  in_pe_26
  (
    .aclk(aclk),
    .pulse_in(input_spike[26]),
    .grst(gclk_pulse),
    .edge_out(ein[26])
  );


  pulse2edge
  in_pe_27
  (
    .aclk(aclk),
    .pulse_in(input_spike[27]),
    .grst(gclk_pulse),
    .edge_out(ein[27])
  );


  pulse2edge
  in_pe_28
  (
    .aclk(aclk),
    .pulse_in(input_spike[28]),
    .grst(gclk_pulse),
    .edge_out(ein[28])
  );


  pulse2edge
  in_pe_29
  (
    .aclk(aclk),
    .pulse_in(input_spike[29]),
    .grst(gclk_pulse),
    .edge_out(ein[29])
  );


  pulse2edge
  in_pe_30
  (
    .aclk(aclk),
    .pulse_in(input_spike[30]),
    .grst(gclk_pulse),
    .edge_out(ein[30])
  );


  pulse2edge
  in_pe_31
  (
    .aclk(aclk),
    .pulse_in(input_spike[31]),
    .grst(gclk_pulse),
    .edge_out(ein[31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_0
  (
    .input_spikes(aclk),
    .inc(input_spike[0]),
    .dec(gclk_pulse),
    .weight_update_en(ein[0])
  );


  pulse2edge
  out_pe_0
  (
    .aclk(aclk),
    .pulse_in(output_spikes[0]),
    .grst(gclk_pulse),
    .edge_out(eout[0])
  );


  stdp.v
  s0_000
  (
    .ein(ein[0]),
    .eout(eout[0]),
    .capture(capture[0][0]),
    .minus(minus[0][0]),
    .search(search[0][0]),
    .backoff(backoff[0][0]),
    .min(min[0][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][0]),
    .F(F[0][0]),
    .inc(inc[0][0]),
    .dec(dec[0][0])
  );


  stdp.v
  s0_101
  (
    .ein(ein[1]),
    .eout(eout[0]),
    .capture(capture[0][1]),
    .minus(minus[0][1]),
    .search(search[0][1]),
    .backoff(backoff[0][1]),
    .min(min[0][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][1]),
    .F(F[0][1]),
    .inc(inc[0][1]),
    .dec(dec[0][1])
  );


  stdp.v
  s0_202
  (
    .ein(ein[2]),
    .eout(eout[0]),
    .capture(capture[0][2]),
    .minus(minus[0][2]),
    .search(search[0][2]),
    .backoff(backoff[0][2]),
    .min(min[0][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][2]),
    .F(F[0][2]),
    .inc(inc[0][2]),
    .dec(dec[0][2])
  );


  stdp.v
  s0_303
  (
    .ein(ein[3]),
    .eout(eout[0]),
    .capture(capture[0][3]),
    .minus(minus[0][3]),
    .search(search[0][3]),
    .backoff(backoff[0][3]),
    .min(min[0][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][3]),
    .F(F[0][3]),
    .inc(inc[0][3]),
    .dec(dec[0][3])
  );


  stdp.v
  s0_404
  (
    .ein(ein[4]),
    .eout(eout[0]),
    .capture(capture[0][4]),
    .minus(minus[0][4]),
    .search(search[0][4]),
    .backoff(backoff[0][4]),
    .min(min[0][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][4]),
    .F(F[0][4]),
    .inc(inc[0][4]),
    .dec(dec[0][4])
  );


  stdp.v
  s0_505
  (
    .ein(ein[5]),
    .eout(eout[0]),
    .capture(capture[0][5]),
    .minus(minus[0][5]),
    .search(search[0][5]),
    .backoff(backoff[0][5]),
    .min(min[0][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][5]),
    .F(F[0][5]),
    .inc(inc[0][5]),
    .dec(dec[0][5])
  );


  stdp.v
  s0_606
  (
    .ein(ein[6]),
    .eout(eout[0]),
    .capture(capture[0][6]),
    .minus(minus[0][6]),
    .search(search[0][6]),
    .backoff(backoff[0][6]),
    .min(min[0][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][6]),
    .F(F[0][6]),
    .inc(inc[0][6]),
    .dec(dec[0][6])
  );


  stdp.v
  s0_707
  (
    .ein(ein[7]),
    .eout(eout[0]),
    .capture(capture[0][7]),
    .minus(minus[0][7]),
    .search(search[0][7]),
    .backoff(backoff[0][7]),
    .min(min[0][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][7]),
    .F(F[0][7]),
    .inc(inc[0][7]),
    .dec(dec[0][7])
  );


  stdp.v
  s0_808
  (
    .ein(ein[8]),
    .eout(eout[0]),
    .capture(capture[0][8]),
    .minus(minus[0][8]),
    .search(search[0][8]),
    .backoff(backoff[0][8]),
    .min(min[0][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][8]),
    .F(F[0][8]),
    .inc(inc[0][8]),
    .dec(dec[0][8])
  );


  stdp.v
  s0_909
  (
    .ein(ein[9]),
    .eout(eout[0]),
    .capture(capture[0][9]),
    .minus(minus[0][9]),
    .search(search[0][9]),
    .backoff(backoff[0][9]),
    .min(min[0][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][9]),
    .F(F[0][9]),
    .inc(inc[0][9]),
    .dec(dec[0][9])
  );


  stdp.v
  s0_10010
  (
    .ein(ein[10]),
    .eout(eout[0]),
    .capture(capture[0][10]),
    .minus(minus[0][10]),
    .search(search[0][10]),
    .backoff(backoff[0][10]),
    .min(min[0][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][10]),
    .F(F[0][10]),
    .inc(inc[0][10]),
    .dec(dec[0][10])
  );


  stdp.v
  s0_11011
  (
    .ein(ein[11]),
    .eout(eout[0]),
    .capture(capture[0][11]),
    .minus(minus[0][11]),
    .search(search[0][11]),
    .backoff(backoff[0][11]),
    .min(min[0][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][11]),
    .F(F[0][11]),
    .inc(inc[0][11]),
    .dec(dec[0][11])
  );


  stdp.v
  s0_12012
  (
    .ein(ein[12]),
    .eout(eout[0]),
    .capture(capture[0][12]),
    .minus(minus[0][12]),
    .search(search[0][12]),
    .backoff(backoff[0][12]),
    .min(min[0][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][12]),
    .F(F[0][12]),
    .inc(inc[0][12]),
    .dec(dec[0][12])
  );


  stdp.v
  s0_13013
  (
    .ein(ein[13]),
    .eout(eout[0]),
    .capture(capture[0][13]),
    .minus(minus[0][13]),
    .search(search[0][13]),
    .backoff(backoff[0][13]),
    .min(min[0][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][13]),
    .F(F[0][13]),
    .inc(inc[0][13]),
    .dec(dec[0][13])
  );


  stdp.v
  s0_14014
  (
    .ein(ein[14]),
    .eout(eout[0]),
    .capture(capture[0][14]),
    .minus(minus[0][14]),
    .search(search[0][14]),
    .backoff(backoff[0][14]),
    .min(min[0][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][14]),
    .F(F[0][14]),
    .inc(inc[0][14]),
    .dec(dec[0][14])
  );


  stdp.v
  s0_15015
  (
    .ein(ein[15]),
    .eout(eout[0]),
    .capture(capture[0][15]),
    .minus(minus[0][15]),
    .search(search[0][15]),
    .backoff(backoff[0][15]),
    .min(min[0][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][15]),
    .F(F[0][15]),
    .inc(inc[0][15]),
    .dec(dec[0][15])
  );


  stdp.v
  s0_16016
  (
    .ein(ein[16]),
    .eout(eout[0]),
    .capture(capture[0][16]),
    .minus(minus[0][16]),
    .search(search[0][16]),
    .backoff(backoff[0][16]),
    .min(min[0][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][16]),
    .F(F[0][16]),
    .inc(inc[0][16]),
    .dec(dec[0][16])
  );


  stdp.v
  s0_17017
  (
    .ein(ein[17]),
    .eout(eout[0]),
    .capture(capture[0][17]),
    .minus(minus[0][17]),
    .search(search[0][17]),
    .backoff(backoff[0][17]),
    .min(min[0][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][17]),
    .F(F[0][17]),
    .inc(inc[0][17]),
    .dec(dec[0][17])
  );


  stdp.v
  s0_18018
  (
    .ein(ein[18]),
    .eout(eout[0]),
    .capture(capture[0][18]),
    .minus(minus[0][18]),
    .search(search[0][18]),
    .backoff(backoff[0][18]),
    .min(min[0][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][18]),
    .F(F[0][18]),
    .inc(inc[0][18]),
    .dec(dec[0][18])
  );


  stdp.v
  s0_19019
  (
    .ein(ein[19]),
    .eout(eout[0]),
    .capture(capture[0][19]),
    .minus(minus[0][19]),
    .search(search[0][19]),
    .backoff(backoff[0][19]),
    .min(min[0][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][19]),
    .F(F[0][19]),
    .inc(inc[0][19]),
    .dec(dec[0][19])
  );


  stdp.v
  s0_20020
  (
    .ein(ein[20]),
    .eout(eout[0]),
    .capture(capture[0][20]),
    .minus(minus[0][20]),
    .search(search[0][20]),
    .backoff(backoff[0][20]),
    .min(min[0][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][20]),
    .F(F[0][20]),
    .inc(inc[0][20]),
    .dec(dec[0][20])
  );


  stdp.v
  s0_21021
  (
    .ein(ein[21]),
    .eout(eout[0]),
    .capture(capture[0][21]),
    .minus(minus[0][21]),
    .search(search[0][21]),
    .backoff(backoff[0][21]),
    .min(min[0][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][21]),
    .F(F[0][21]),
    .inc(inc[0][21]),
    .dec(dec[0][21])
  );


  stdp.v
  s0_22022
  (
    .ein(ein[22]),
    .eout(eout[0]),
    .capture(capture[0][22]),
    .minus(minus[0][22]),
    .search(search[0][22]),
    .backoff(backoff[0][22]),
    .min(min[0][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][22]),
    .F(F[0][22]),
    .inc(inc[0][22]),
    .dec(dec[0][22])
  );


  stdp.v
  s0_23023
  (
    .ein(ein[23]),
    .eout(eout[0]),
    .capture(capture[0][23]),
    .minus(minus[0][23]),
    .search(search[0][23]),
    .backoff(backoff[0][23]),
    .min(min[0][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][23]),
    .F(F[0][23]),
    .inc(inc[0][23]),
    .dec(dec[0][23])
  );


  stdp.v
  s0_24024
  (
    .ein(ein[24]),
    .eout(eout[0]),
    .capture(capture[0][24]),
    .minus(minus[0][24]),
    .search(search[0][24]),
    .backoff(backoff[0][24]),
    .min(min[0][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][24]),
    .F(F[0][24]),
    .inc(inc[0][24]),
    .dec(dec[0][24])
  );


  stdp.v
  s0_25025
  (
    .ein(ein[25]),
    .eout(eout[0]),
    .capture(capture[0][25]),
    .minus(minus[0][25]),
    .search(search[0][25]),
    .backoff(backoff[0][25]),
    .min(min[0][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][25]),
    .F(F[0][25]),
    .inc(inc[0][25]),
    .dec(dec[0][25])
  );


  stdp.v
  s0_26026
  (
    .ein(ein[26]),
    .eout(eout[0]),
    .capture(capture[0][26]),
    .minus(minus[0][26]),
    .search(search[0][26]),
    .backoff(backoff[0][26]),
    .min(min[0][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][26]),
    .F(F[0][26]),
    .inc(inc[0][26]),
    .dec(dec[0][26])
  );


  stdp.v
  s0_27027
  (
    .ein(ein[27]),
    .eout(eout[0]),
    .capture(capture[0][27]),
    .minus(minus[0][27]),
    .search(search[0][27]),
    .backoff(backoff[0][27]),
    .min(min[0][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][27]),
    .F(F[0][27]),
    .inc(inc[0][27]),
    .dec(dec[0][27])
  );


  stdp.v
  s0_28028
  (
    .ein(ein[28]),
    .eout(eout[0]),
    .capture(capture[0][28]),
    .minus(minus[0][28]),
    .search(search[0][28]),
    .backoff(backoff[0][28]),
    .min(min[0][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][28]),
    .F(F[0][28]),
    .inc(inc[0][28]),
    .dec(dec[0][28])
  );


  stdp.v
  s0_29029
  (
    .ein(ein[29]),
    .eout(eout[0]),
    .capture(capture[0][29]),
    .minus(minus[0][29]),
    .search(search[0][29]),
    .backoff(backoff[0][29]),
    .min(min[0][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][29]),
    .F(F[0][29]),
    .inc(inc[0][29]),
    .dec(dec[0][29])
  );


  stdp.v
  s0_30030
  (
    .ein(ein[30]),
    .eout(eout[0]),
    .capture(capture[0][30]),
    .minus(minus[0][30]),
    .search(search[0][30]),
    .backoff(backoff[0][30]),
    .min(min[0][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][30]),
    .F(F[0][30]),
    .inc(inc[0][30]),
    .dec(dec[0][30])
  );


  stdp.v
  s0_31031
  (
    .ein(ein[31]),
    .eout(eout[0]),
    .capture(capture[0][31]),
    .minus(minus[0][31]),
    .search(search[0][31]),
    .backoff(backoff[0][31]),
    .min(min[0][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[0][31]),
    .F(F[0][31]),
    .inc(inc[0][31]),
    .dec(dec[0][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_1
  (
    .input_spikes(aclk),
    .inc(input_spike[1]),
    .dec(gclk_pulse),
    .weight_update_en(ein[1])
  );


  pulse2edge
  out_pe_1
  (
    .aclk(aclk),
    .pulse_in(output_spikes[1]),
    .grst(gclk_pulse),
    .edge_out(eout[1])
  );


  stdp.v
  s0_010
  (
    .ein(ein[0]),
    .eout(eout[1]),
    .capture(capture[1][0]),
    .minus(minus[1][0]),
    .search(search[1][0]),
    .backoff(backoff[1][0]),
    .min(min[1][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][0]),
    .F(F[1][0]),
    .inc(inc[1][0]),
    .dec(dec[1][0])
  );


  stdp.v
  s0_111
  (
    .ein(ein[1]),
    .eout(eout[1]),
    .capture(capture[1][1]),
    .minus(minus[1][1]),
    .search(search[1][1]),
    .backoff(backoff[1][1]),
    .min(min[1][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][1]),
    .F(F[1][1]),
    .inc(inc[1][1]),
    .dec(dec[1][1])
  );


  stdp.v
  s0_212
  (
    .ein(ein[2]),
    .eout(eout[1]),
    .capture(capture[1][2]),
    .minus(minus[1][2]),
    .search(search[1][2]),
    .backoff(backoff[1][2]),
    .min(min[1][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][2]),
    .F(F[1][2]),
    .inc(inc[1][2]),
    .dec(dec[1][2])
  );


  stdp.v
  s0_313
  (
    .ein(ein[3]),
    .eout(eout[1]),
    .capture(capture[1][3]),
    .minus(minus[1][3]),
    .search(search[1][3]),
    .backoff(backoff[1][3]),
    .min(min[1][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][3]),
    .F(F[1][3]),
    .inc(inc[1][3]),
    .dec(dec[1][3])
  );


  stdp.v
  s0_414
  (
    .ein(ein[4]),
    .eout(eout[1]),
    .capture(capture[1][4]),
    .minus(minus[1][4]),
    .search(search[1][4]),
    .backoff(backoff[1][4]),
    .min(min[1][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][4]),
    .F(F[1][4]),
    .inc(inc[1][4]),
    .dec(dec[1][4])
  );


  stdp.v
  s0_515
  (
    .ein(ein[5]),
    .eout(eout[1]),
    .capture(capture[1][5]),
    .minus(minus[1][5]),
    .search(search[1][5]),
    .backoff(backoff[1][5]),
    .min(min[1][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][5]),
    .F(F[1][5]),
    .inc(inc[1][5]),
    .dec(dec[1][5])
  );


  stdp.v
  s0_616
  (
    .ein(ein[6]),
    .eout(eout[1]),
    .capture(capture[1][6]),
    .minus(minus[1][6]),
    .search(search[1][6]),
    .backoff(backoff[1][6]),
    .min(min[1][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][6]),
    .F(F[1][6]),
    .inc(inc[1][6]),
    .dec(dec[1][6])
  );


  stdp.v
  s0_717
  (
    .ein(ein[7]),
    .eout(eout[1]),
    .capture(capture[1][7]),
    .minus(minus[1][7]),
    .search(search[1][7]),
    .backoff(backoff[1][7]),
    .min(min[1][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][7]),
    .F(F[1][7]),
    .inc(inc[1][7]),
    .dec(dec[1][7])
  );


  stdp.v
  s0_818
  (
    .ein(ein[8]),
    .eout(eout[1]),
    .capture(capture[1][8]),
    .minus(minus[1][8]),
    .search(search[1][8]),
    .backoff(backoff[1][8]),
    .min(min[1][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][8]),
    .F(F[1][8]),
    .inc(inc[1][8]),
    .dec(dec[1][8])
  );


  stdp.v
  s0_919
  (
    .ein(ein[9]),
    .eout(eout[1]),
    .capture(capture[1][9]),
    .minus(minus[1][9]),
    .search(search[1][9]),
    .backoff(backoff[1][9]),
    .min(min[1][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][9]),
    .F(F[1][9]),
    .inc(inc[1][9]),
    .dec(dec[1][9])
  );


  stdp.v
  s0_10110
  (
    .ein(ein[10]),
    .eout(eout[1]),
    .capture(capture[1][10]),
    .minus(minus[1][10]),
    .search(search[1][10]),
    .backoff(backoff[1][10]),
    .min(min[1][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][10]),
    .F(F[1][10]),
    .inc(inc[1][10]),
    .dec(dec[1][10])
  );


  stdp.v
  s0_11111
  (
    .ein(ein[11]),
    .eout(eout[1]),
    .capture(capture[1][11]),
    .minus(minus[1][11]),
    .search(search[1][11]),
    .backoff(backoff[1][11]),
    .min(min[1][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][11]),
    .F(F[1][11]),
    .inc(inc[1][11]),
    .dec(dec[1][11])
  );


  stdp.v
  s0_12112
  (
    .ein(ein[12]),
    .eout(eout[1]),
    .capture(capture[1][12]),
    .minus(minus[1][12]),
    .search(search[1][12]),
    .backoff(backoff[1][12]),
    .min(min[1][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][12]),
    .F(F[1][12]),
    .inc(inc[1][12]),
    .dec(dec[1][12])
  );


  stdp.v
  s0_13113
  (
    .ein(ein[13]),
    .eout(eout[1]),
    .capture(capture[1][13]),
    .minus(minus[1][13]),
    .search(search[1][13]),
    .backoff(backoff[1][13]),
    .min(min[1][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][13]),
    .F(F[1][13]),
    .inc(inc[1][13]),
    .dec(dec[1][13])
  );


  stdp.v
  s0_14114
  (
    .ein(ein[14]),
    .eout(eout[1]),
    .capture(capture[1][14]),
    .minus(minus[1][14]),
    .search(search[1][14]),
    .backoff(backoff[1][14]),
    .min(min[1][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][14]),
    .F(F[1][14]),
    .inc(inc[1][14]),
    .dec(dec[1][14])
  );


  stdp.v
  s0_15115
  (
    .ein(ein[15]),
    .eout(eout[1]),
    .capture(capture[1][15]),
    .minus(minus[1][15]),
    .search(search[1][15]),
    .backoff(backoff[1][15]),
    .min(min[1][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][15]),
    .F(F[1][15]),
    .inc(inc[1][15]),
    .dec(dec[1][15])
  );


  stdp.v
  s0_16116
  (
    .ein(ein[16]),
    .eout(eout[1]),
    .capture(capture[1][16]),
    .minus(minus[1][16]),
    .search(search[1][16]),
    .backoff(backoff[1][16]),
    .min(min[1][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][16]),
    .F(F[1][16]),
    .inc(inc[1][16]),
    .dec(dec[1][16])
  );


  stdp.v
  s0_17117
  (
    .ein(ein[17]),
    .eout(eout[1]),
    .capture(capture[1][17]),
    .minus(minus[1][17]),
    .search(search[1][17]),
    .backoff(backoff[1][17]),
    .min(min[1][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][17]),
    .F(F[1][17]),
    .inc(inc[1][17]),
    .dec(dec[1][17])
  );


  stdp.v
  s0_18118
  (
    .ein(ein[18]),
    .eout(eout[1]),
    .capture(capture[1][18]),
    .minus(minus[1][18]),
    .search(search[1][18]),
    .backoff(backoff[1][18]),
    .min(min[1][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][18]),
    .F(F[1][18]),
    .inc(inc[1][18]),
    .dec(dec[1][18])
  );


  stdp.v
  s0_19119
  (
    .ein(ein[19]),
    .eout(eout[1]),
    .capture(capture[1][19]),
    .minus(minus[1][19]),
    .search(search[1][19]),
    .backoff(backoff[1][19]),
    .min(min[1][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][19]),
    .F(F[1][19]),
    .inc(inc[1][19]),
    .dec(dec[1][19])
  );


  stdp.v
  s0_20120
  (
    .ein(ein[20]),
    .eout(eout[1]),
    .capture(capture[1][20]),
    .minus(minus[1][20]),
    .search(search[1][20]),
    .backoff(backoff[1][20]),
    .min(min[1][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][20]),
    .F(F[1][20]),
    .inc(inc[1][20]),
    .dec(dec[1][20])
  );


  stdp.v
  s0_21121
  (
    .ein(ein[21]),
    .eout(eout[1]),
    .capture(capture[1][21]),
    .minus(minus[1][21]),
    .search(search[1][21]),
    .backoff(backoff[1][21]),
    .min(min[1][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][21]),
    .F(F[1][21]),
    .inc(inc[1][21]),
    .dec(dec[1][21])
  );


  stdp.v
  s0_22122
  (
    .ein(ein[22]),
    .eout(eout[1]),
    .capture(capture[1][22]),
    .minus(minus[1][22]),
    .search(search[1][22]),
    .backoff(backoff[1][22]),
    .min(min[1][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][22]),
    .F(F[1][22]),
    .inc(inc[1][22]),
    .dec(dec[1][22])
  );


  stdp.v
  s0_23123
  (
    .ein(ein[23]),
    .eout(eout[1]),
    .capture(capture[1][23]),
    .minus(minus[1][23]),
    .search(search[1][23]),
    .backoff(backoff[1][23]),
    .min(min[1][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][23]),
    .F(F[1][23]),
    .inc(inc[1][23]),
    .dec(dec[1][23])
  );


  stdp.v
  s0_24124
  (
    .ein(ein[24]),
    .eout(eout[1]),
    .capture(capture[1][24]),
    .minus(minus[1][24]),
    .search(search[1][24]),
    .backoff(backoff[1][24]),
    .min(min[1][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][24]),
    .F(F[1][24]),
    .inc(inc[1][24]),
    .dec(dec[1][24])
  );


  stdp.v
  s0_25125
  (
    .ein(ein[25]),
    .eout(eout[1]),
    .capture(capture[1][25]),
    .minus(minus[1][25]),
    .search(search[1][25]),
    .backoff(backoff[1][25]),
    .min(min[1][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][25]),
    .F(F[1][25]),
    .inc(inc[1][25]),
    .dec(dec[1][25])
  );


  stdp.v
  s0_26126
  (
    .ein(ein[26]),
    .eout(eout[1]),
    .capture(capture[1][26]),
    .minus(minus[1][26]),
    .search(search[1][26]),
    .backoff(backoff[1][26]),
    .min(min[1][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][26]),
    .F(F[1][26]),
    .inc(inc[1][26]),
    .dec(dec[1][26])
  );


  stdp.v
  s0_27127
  (
    .ein(ein[27]),
    .eout(eout[1]),
    .capture(capture[1][27]),
    .minus(minus[1][27]),
    .search(search[1][27]),
    .backoff(backoff[1][27]),
    .min(min[1][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][27]),
    .F(F[1][27]),
    .inc(inc[1][27]),
    .dec(dec[1][27])
  );


  stdp.v
  s0_28128
  (
    .ein(ein[28]),
    .eout(eout[1]),
    .capture(capture[1][28]),
    .minus(minus[1][28]),
    .search(search[1][28]),
    .backoff(backoff[1][28]),
    .min(min[1][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][28]),
    .F(F[1][28]),
    .inc(inc[1][28]),
    .dec(dec[1][28])
  );


  stdp.v
  s0_29129
  (
    .ein(ein[29]),
    .eout(eout[1]),
    .capture(capture[1][29]),
    .minus(minus[1][29]),
    .search(search[1][29]),
    .backoff(backoff[1][29]),
    .min(min[1][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][29]),
    .F(F[1][29]),
    .inc(inc[1][29]),
    .dec(dec[1][29])
  );


  stdp.v
  s0_30130
  (
    .ein(ein[30]),
    .eout(eout[1]),
    .capture(capture[1][30]),
    .minus(minus[1][30]),
    .search(search[1][30]),
    .backoff(backoff[1][30]),
    .min(min[1][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][30]),
    .F(F[1][30]),
    .inc(inc[1][30]),
    .dec(dec[1][30])
  );


  stdp.v
  s0_31131
  (
    .ein(ein[31]),
    .eout(eout[1]),
    .capture(capture[1][31]),
    .minus(minus[1][31]),
    .search(search[1][31]),
    .backoff(backoff[1][31]),
    .min(min[1][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[1][31]),
    .F(F[1][31]),
    .inc(inc[1][31]),
    .dec(dec[1][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_2
  (
    .input_spikes(aclk),
    .inc(input_spike[2]),
    .dec(gclk_pulse),
    .weight_update_en(ein[2])
  );


  pulse2edge
  out_pe_2
  (
    .aclk(aclk),
    .pulse_in(output_spikes[2]),
    .grst(gclk_pulse),
    .edge_out(eout[2])
  );


  stdp.v
  s0_020
  (
    .ein(ein[0]),
    .eout(eout[2]),
    .capture(capture[2][0]),
    .minus(minus[2][0]),
    .search(search[2][0]),
    .backoff(backoff[2][0]),
    .min(min[2][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][0]),
    .F(F[2][0]),
    .inc(inc[2][0]),
    .dec(dec[2][0])
  );


  stdp.v
  s0_121
  (
    .ein(ein[1]),
    .eout(eout[2]),
    .capture(capture[2][1]),
    .minus(minus[2][1]),
    .search(search[2][1]),
    .backoff(backoff[2][1]),
    .min(min[2][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][1]),
    .F(F[2][1]),
    .inc(inc[2][1]),
    .dec(dec[2][1])
  );


  stdp.v
  s0_222
  (
    .ein(ein[2]),
    .eout(eout[2]),
    .capture(capture[2][2]),
    .minus(minus[2][2]),
    .search(search[2][2]),
    .backoff(backoff[2][2]),
    .min(min[2][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][2]),
    .F(F[2][2]),
    .inc(inc[2][2]),
    .dec(dec[2][2])
  );


  stdp.v
  s0_323
  (
    .ein(ein[3]),
    .eout(eout[2]),
    .capture(capture[2][3]),
    .minus(minus[2][3]),
    .search(search[2][3]),
    .backoff(backoff[2][3]),
    .min(min[2][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][3]),
    .F(F[2][3]),
    .inc(inc[2][3]),
    .dec(dec[2][3])
  );


  stdp.v
  s0_424
  (
    .ein(ein[4]),
    .eout(eout[2]),
    .capture(capture[2][4]),
    .minus(minus[2][4]),
    .search(search[2][4]),
    .backoff(backoff[2][4]),
    .min(min[2][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][4]),
    .F(F[2][4]),
    .inc(inc[2][4]),
    .dec(dec[2][4])
  );


  stdp.v
  s0_525
  (
    .ein(ein[5]),
    .eout(eout[2]),
    .capture(capture[2][5]),
    .minus(minus[2][5]),
    .search(search[2][5]),
    .backoff(backoff[2][5]),
    .min(min[2][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][5]),
    .F(F[2][5]),
    .inc(inc[2][5]),
    .dec(dec[2][5])
  );


  stdp.v
  s0_626
  (
    .ein(ein[6]),
    .eout(eout[2]),
    .capture(capture[2][6]),
    .minus(minus[2][6]),
    .search(search[2][6]),
    .backoff(backoff[2][6]),
    .min(min[2][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][6]),
    .F(F[2][6]),
    .inc(inc[2][6]),
    .dec(dec[2][6])
  );


  stdp.v
  s0_727
  (
    .ein(ein[7]),
    .eout(eout[2]),
    .capture(capture[2][7]),
    .minus(minus[2][7]),
    .search(search[2][7]),
    .backoff(backoff[2][7]),
    .min(min[2][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][7]),
    .F(F[2][7]),
    .inc(inc[2][7]),
    .dec(dec[2][7])
  );


  stdp.v
  s0_828
  (
    .ein(ein[8]),
    .eout(eout[2]),
    .capture(capture[2][8]),
    .minus(minus[2][8]),
    .search(search[2][8]),
    .backoff(backoff[2][8]),
    .min(min[2][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][8]),
    .F(F[2][8]),
    .inc(inc[2][8]),
    .dec(dec[2][8])
  );


  stdp.v
  s0_929
  (
    .ein(ein[9]),
    .eout(eout[2]),
    .capture(capture[2][9]),
    .minus(minus[2][9]),
    .search(search[2][9]),
    .backoff(backoff[2][9]),
    .min(min[2][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][9]),
    .F(F[2][9]),
    .inc(inc[2][9]),
    .dec(dec[2][9])
  );


  stdp.v
  s0_10210
  (
    .ein(ein[10]),
    .eout(eout[2]),
    .capture(capture[2][10]),
    .minus(minus[2][10]),
    .search(search[2][10]),
    .backoff(backoff[2][10]),
    .min(min[2][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][10]),
    .F(F[2][10]),
    .inc(inc[2][10]),
    .dec(dec[2][10])
  );


  stdp.v
  s0_11211
  (
    .ein(ein[11]),
    .eout(eout[2]),
    .capture(capture[2][11]),
    .minus(minus[2][11]),
    .search(search[2][11]),
    .backoff(backoff[2][11]),
    .min(min[2][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][11]),
    .F(F[2][11]),
    .inc(inc[2][11]),
    .dec(dec[2][11])
  );


  stdp.v
  s0_12212
  (
    .ein(ein[12]),
    .eout(eout[2]),
    .capture(capture[2][12]),
    .minus(minus[2][12]),
    .search(search[2][12]),
    .backoff(backoff[2][12]),
    .min(min[2][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][12]),
    .F(F[2][12]),
    .inc(inc[2][12]),
    .dec(dec[2][12])
  );


  stdp.v
  s0_13213
  (
    .ein(ein[13]),
    .eout(eout[2]),
    .capture(capture[2][13]),
    .minus(minus[2][13]),
    .search(search[2][13]),
    .backoff(backoff[2][13]),
    .min(min[2][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][13]),
    .F(F[2][13]),
    .inc(inc[2][13]),
    .dec(dec[2][13])
  );


  stdp.v
  s0_14214
  (
    .ein(ein[14]),
    .eout(eout[2]),
    .capture(capture[2][14]),
    .minus(minus[2][14]),
    .search(search[2][14]),
    .backoff(backoff[2][14]),
    .min(min[2][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][14]),
    .F(F[2][14]),
    .inc(inc[2][14]),
    .dec(dec[2][14])
  );


  stdp.v
  s0_15215
  (
    .ein(ein[15]),
    .eout(eout[2]),
    .capture(capture[2][15]),
    .minus(minus[2][15]),
    .search(search[2][15]),
    .backoff(backoff[2][15]),
    .min(min[2][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][15]),
    .F(F[2][15]),
    .inc(inc[2][15]),
    .dec(dec[2][15])
  );


  stdp.v
  s0_16216
  (
    .ein(ein[16]),
    .eout(eout[2]),
    .capture(capture[2][16]),
    .minus(minus[2][16]),
    .search(search[2][16]),
    .backoff(backoff[2][16]),
    .min(min[2][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][16]),
    .F(F[2][16]),
    .inc(inc[2][16]),
    .dec(dec[2][16])
  );


  stdp.v
  s0_17217
  (
    .ein(ein[17]),
    .eout(eout[2]),
    .capture(capture[2][17]),
    .minus(minus[2][17]),
    .search(search[2][17]),
    .backoff(backoff[2][17]),
    .min(min[2][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][17]),
    .F(F[2][17]),
    .inc(inc[2][17]),
    .dec(dec[2][17])
  );


  stdp.v
  s0_18218
  (
    .ein(ein[18]),
    .eout(eout[2]),
    .capture(capture[2][18]),
    .minus(minus[2][18]),
    .search(search[2][18]),
    .backoff(backoff[2][18]),
    .min(min[2][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][18]),
    .F(F[2][18]),
    .inc(inc[2][18]),
    .dec(dec[2][18])
  );


  stdp.v
  s0_19219
  (
    .ein(ein[19]),
    .eout(eout[2]),
    .capture(capture[2][19]),
    .minus(minus[2][19]),
    .search(search[2][19]),
    .backoff(backoff[2][19]),
    .min(min[2][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][19]),
    .F(F[2][19]),
    .inc(inc[2][19]),
    .dec(dec[2][19])
  );


  stdp.v
  s0_20220
  (
    .ein(ein[20]),
    .eout(eout[2]),
    .capture(capture[2][20]),
    .minus(minus[2][20]),
    .search(search[2][20]),
    .backoff(backoff[2][20]),
    .min(min[2][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][20]),
    .F(F[2][20]),
    .inc(inc[2][20]),
    .dec(dec[2][20])
  );


  stdp.v
  s0_21221
  (
    .ein(ein[21]),
    .eout(eout[2]),
    .capture(capture[2][21]),
    .minus(minus[2][21]),
    .search(search[2][21]),
    .backoff(backoff[2][21]),
    .min(min[2][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][21]),
    .F(F[2][21]),
    .inc(inc[2][21]),
    .dec(dec[2][21])
  );


  stdp.v
  s0_22222
  (
    .ein(ein[22]),
    .eout(eout[2]),
    .capture(capture[2][22]),
    .minus(minus[2][22]),
    .search(search[2][22]),
    .backoff(backoff[2][22]),
    .min(min[2][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][22]),
    .F(F[2][22]),
    .inc(inc[2][22]),
    .dec(dec[2][22])
  );


  stdp.v
  s0_23223
  (
    .ein(ein[23]),
    .eout(eout[2]),
    .capture(capture[2][23]),
    .minus(minus[2][23]),
    .search(search[2][23]),
    .backoff(backoff[2][23]),
    .min(min[2][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][23]),
    .F(F[2][23]),
    .inc(inc[2][23]),
    .dec(dec[2][23])
  );


  stdp.v
  s0_24224
  (
    .ein(ein[24]),
    .eout(eout[2]),
    .capture(capture[2][24]),
    .minus(minus[2][24]),
    .search(search[2][24]),
    .backoff(backoff[2][24]),
    .min(min[2][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][24]),
    .F(F[2][24]),
    .inc(inc[2][24]),
    .dec(dec[2][24])
  );


  stdp.v
  s0_25225
  (
    .ein(ein[25]),
    .eout(eout[2]),
    .capture(capture[2][25]),
    .minus(minus[2][25]),
    .search(search[2][25]),
    .backoff(backoff[2][25]),
    .min(min[2][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][25]),
    .F(F[2][25]),
    .inc(inc[2][25]),
    .dec(dec[2][25])
  );


  stdp.v
  s0_26226
  (
    .ein(ein[26]),
    .eout(eout[2]),
    .capture(capture[2][26]),
    .minus(minus[2][26]),
    .search(search[2][26]),
    .backoff(backoff[2][26]),
    .min(min[2][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][26]),
    .F(F[2][26]),
    .inc(inc[2][26]),
    .dec(dec[2][26])
  );


  stdp.v
  s0_27227
  (
    .ein(ein[27]),
    .eout(eout[2]),
    .capture(capture[2][27]),
    .minus(minus[2][27]),
    .search(search[2][27]),
    .backoff(backoff[2][27]),
    .min(min[2][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][27]),
    .F(F[2][27]),
    .inc(inc[2][27]),
    .dec(dec[2][27])
  );


  stdp.v
  s0_28228
  (
    .ein(ein[28]),
    .eout(eout[2]),
    .capture(capture[2][28]),
    .minus(minus[2][28]),
    .search(search[2][28]),
    .backoff(backoff[2][28]),
    .min(min[2][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][28]),
    .F(F[2][28]),
    .inc(inc[2][28]),
    .dec(dec[2][28])
  );


  stdp.v
  s0_29229
  (
    .ein(ein[29]),
    .eout(eout[2]),
    .capture(capture[2][29]),
    .minus(minus[2][29]),
    .search(search[2][29]),
    .backoff(backoff[2][29]),
    .min(min[2][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][29]),
    .F(F[2][29]),
    .inc(inc[2][29]),
    .dec(dec[2][29])
  );


  stdp.v
  s0_30230
  (
    .ein(ein[30]),
    .eout(eout[2]),
    .capture(capture[2][30]),
    .minus(minus[2][30]),
    .search(search[2][30]),
    .backoff(backoff[2][30]),
    .min(min[2][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][30]),
    .F(F[2][30]),
    .inc(inc[2][30]),
    .dec(dec[2][30])
  );


  stdp.v
  s0_31231
  (
    .ein(ein[31]),
    .eout(eout[2]),
    .capture(capture[2][31]),
    .minus(minus[2][31]),
    .search(search[2][31]),
    .backoff(backoff[2][31]),
    .min(min[2][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[2][31]),
    .F(F[2][31]),
    .inc(inc[2][31]),
    .dec(dec[2][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_3
  (
    .input_spikes(aclk),
    .inc(input_spike[3]),
    .dec(gclk_pulse),
    .weight_update_en(ein[3])
  );


  pulse2edge
  out_pe_3
  (
    .aclk(aclk),
    .pulse_in(output_spikes[3]),
    .grst(gclk_pulse),
    .edge_out(eout[3])
  );


  stdp.v
  s0_030
  (
    .ein(ein[0]),
    .eout(eout[3]),
    .capture(capture[3][0]),
    .minus(minus[3][0]),
    .search(search[3][0]),
    .backoff(backoff[3][0]),
    .min(min[3][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][0]),
    .F(F[3][0]),
    .inc(inc[3][0]),
    .dec(dec[3][0])
  );


  stdp.v
  s0_131
  (
    .ein(ein[1]),
    .eout(eout[3]),
    .capture(capture[3][1]),
    .minus(minus[3][1]),
    .search(search[3][1]),
    .backoff(backoff[3][1]),
    .min(min[3][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][1]),
    .F(F[3][1]),
    .inc(inc[3][1]),
    .dec(dec[3][1])
  );


  stdp.v
  s0_232
  (
    .ein(ein[2]),
    .eout(eout[3]),
    .capture(capture[3][2]),
    .minus(minus[3][2]),
    .search(search[3][2]),
    .backoff(backoff[3][2]),
    .min(min[3][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][2]),
    .F(F[3][2]),
    .inc(inc[3][2]),
    .dec(dec[3][2])
  );


  stdp.v
  s0_333
  (
    .ein(ein[3]),
    .eout(eout[3]),
    .capture(capture[3][3]),
    .minus(minus[3][3]),
    .search(search[3][3]),
    .backoff(backoff[3][3]),
    .min(min[3][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][3]),
    .F(F[3][3]),
    .inc(inc[3][3]),
    .dec(dec[3][3])
  );


  stdp.v
  s0_434
  (
    .ein(ein[4]),
    .eout(eout[3]),
    .capture(capture[3][4]),
    .minus(minus[3][4]),
    .search(search[3][4]),
    .backoff(backoff[3][4]),
    .min(min[3][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][4]),
    .F(F[3][4]),
    .inc(inc[3][4]),
    .dec(dec[3][4])
  );


  stdp.v
  s0_535
  (
    .ein(ein[5]),
    .eout(eout[3]),
    .capture(capture[3][5]),
    .minus(minus[3][5]),
    .search(search[3][5]),
    .backoff(backoff[3][5]),
    .min(min[3][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][5]),
    .F(F[3][5]),
    .inc(inc[3][5]),
    .dec(dec[3][5])
  );


  stdp.v
  s0_636
  (
    .ein(ein[6]),
    .eout(eout[3]),
    .capture(capture[3][6]),
    .minus(minus[3][6]),
    .search(search[3][6]),
    .backoff(backoff[3][6]),
    .min(min[3][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][6]),
    .F(F[3][6]),
    .inc(inc[3][6]),
    .dec(dec[3][6])
  );


  stdp.v
  s0_737
  (
    .ein(ein[7]),
    .eout(eout[3]),
    .capture(capture[3][7]),
    .minus(minus[3][7]),
    .search(search[3][7]),
    .backoff(backoff[3][7]),
    .min(min[3][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][7]),
    .F(F[3][7]),
    .inc(inc[3][7]),
    .dec(dec[3][7])
  );


  stdp.v
  s0_838
  (
    .ein(ein[8]),
    .eout(eout[3]),
    .capture(capture[3][8]),
    .minus(minus[3][8]),
    .search(search[3][8]),
    .backoff(backoff[3][8]),
    .min(min[3][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][8]),
    .F(F[3][8]),
    .inc(inc[3][8]),
    .dec(dec[3][8])
  );


  stdp.v
  s0_939
  (
    .ein(ein[9]),
    .eout(eout[3]),
    .capture(capture[3][9]),
    .minus(minus[3][9]),
    .search(search[3][9]),
    .backoff(backoff[3][9]),
    .min(min[3][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][9]),
    .F(F[3][9]),
    .inc(inc[3][9]),
    .dec(dec[3][9])
  );


  stdp.v
  s0_10310
  (
    .ein(ein[10]),
    .eout(eout[3]),
    .capture(capture[3][10]),
    .minus(minus[3][10]),
    .search(search[3][10]),
    .backoff(backoff[3][10]),
    .min(min[3][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][10]),
    .F(F[3][10]),
    .inc(inc[3][10]),
    .dec(dec[3][10])
  );


  stdp.v
  s0_11311
  (
    .ein(ein[11]),
    .eout(eout[3]),
    .capture(capture[3][11]),
    .minus(minus[3][11]),
    .search(search[3][11]),
    .backoff(backoff[3][11]),
    .min(min[3][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][11]),
    .F(F[3][11]),
    .inc(inc[3][11]),
    .dec(dec[3][11])
  );


  stdp.v
  s0_12312
  (
    .ein(ein[12]),
    .eout(eout[3]),
    .capture(capture[3][12]),
    .minus(minus[3][12]),
    .search(search[3][12]),
    .backoff(backoff[3][12]),
    .min(min[3][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][12]),
    .F(F[3][12]),
    .inc(inc[3][12]),
    .dec(dec[3][12])
  );


  stdp.v
  s0_13313
  (
    .ein(ein[13]),
    .eout(eout[3]),
    .capture(capture[3][13]),
    .minus(minus[3][13]),
    .search(search[3][13]),
    .backoff(backoff[3][13]),
    .min(min[3][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][13]),
    .F(F[3][13]),
    .inc(inc[3][13]),
    .dec(dec[3][13])
  );


  stdp.v
  s0_14314
  (
    .ein(ein[14]),
    .eout(eout[3]),
    .capture(capture[3][14]),
    .minus(minus[3][14]),
    .search(search[3][14]),
    .backoff(backoff[3][14]),
    .min(min[3][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][14]),
    .F(F[3][14]),
    .inc(inc[3][14]),
    .dec(dec[3][14])
  );


  stdp.v
  s0_15315
  (
    .ein(ein[15]),
    .eout(eout[3]),
    .capture(capture[3][15]),
    .minus(minus[3][15]),
    .search(search[3][15]),
    .backoff(backoff[3][15]),
    .min(min[3][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][15]),
    .F(F[3][15]),
    .inc(inc[3][15]),
    .dec(dec[3][15])
  );


  stdp.v
  s0_16316
  (
    .ein(ein[16]),
    .eout(eout[3]),
    .capture(capture[3][16]),
    .minus(minus[3][16]),
    .search(search[3][16]),
    .backoff(backoff[3][16]),
    .min(min[3][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][16]),
    .F(F[3][16]),
    .inc(inc[3][16]),
    .dec(dec[3][16])
  );


  stdp.v
  s0_17317
  (
    .ein(ein[17]),
    .eout(eout[3]),
    .capture(capture[3][17]),
    .minus(minus[3][17]),
    .search(search[3][17]),
    .backoff(backoff[3][17]),
    .min(min[3][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][17]),
    .F(F[3][17]),
    .inc(inc[3][17]),
    .dec(dec[3][17])
  );


  stdp.v
  s0_18318
  (
    .ein(ein[18]),
    .eout(eout[3]),
    .capture(capture[3][18]),
    .minus(minus[3][18]),
    .search(search[3][18]),
    .backoff(backoff[3][18]),
    .min(min[3][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][18]),
    .F(F[3][18]),
    .inc(inc[3][18]),
    .dec(dec[3][18])
  );


  stdp.v
  s0_19319
  (
    .ein(ein[19]),
    .eout(eout[3]),
    .capture(capture[3][19]),
    .minus(minus[3][19]),
    .search(search[3][19]),
    .backoff(backoff[3][19]),
    .min(min[3][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][19]),
    .F(F[3][19]),
    .inc(inc[3][19]),
    .dec(dec[3][19])
  );


  stdp.v
  s0_20320
  (
    .ein(ein[20]),
    .eout(eout[3]),
    .capture(capture[3][20]),
    .minus(minus[3][20]),
    .search(search[3][20]),
    .backoff(backoff[3][20]),
    .min(min[3][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][20]),
    .F(F[3][20]),
    .inc(inc[3][20]),
    .dec(dec[3][20])
  );


  stdp.v
  s0_21321
  (
    .ein(ein[21]),
    .eout(eout[3]),
    .capture(capture[3][21]),
    .minus(minus[3][21]),
    .search(search[3][21]),
    .backoff(backoff[3][21]),
    .min(min[3][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][21]),
    .F(F[3][21]),
    .inc(inc[3][21]),
    .dec(dec[3][21])
  );


  stdp.v
  s0_22322
  (
    .ein(ein[22]),
    .eout(eout[3]),
    .capture(capture[3][22]),
    .minus(minus[3][22]),
    .search(search[3][22]),
    .backoff(backoff[3][22]),
    .min(min[3][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][22]),
    .F(F[3][22]),
    .inc(inc[3][22]),
    .dec(dec[3][22])
  );


  stdp.v
  s0_23323
  (
    .ein(ein[23]),
    .eout(eout[3]),
    .capture(capture[3][23]),
    .minus(minus[3][23]),
    .search(search[3][23]),
    .backoff(backoff[3][23]),
    .min(min[3][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][23]),
    .F(F[3][23]),
    .inc(inc[3][23]),
    .dec(dec[3][23])
  );


  stdp.v
  s0_24324
  (
    .ein(ein[24]),
    .eout(eout[3]),
    .capture(capture[3][24]),
    .minus(minus[3][24]),
    .search(search[3][24]),
    .backoff(backoff[3][24]),
    .min(min[3][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][24]),
    .F(F[3][24]),
    .inc(inc[3][24]),
    .dec(dec[3][24])
  );


  stdp.v
  s0_25325
  (
    .ein(ein[25]),
    .eout(eout[3]),
    .capture(capture[3][25]),
    .minus(minus[3][25]),
    .search(search[3][25]),
    .backoff(backoff[3][25]),
    .min(min[3][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][25]),
    .F(F[3][25]),
    .inc(inc[3][25]),
    .dec(dec[3][25])
  );


  stdp.v
  s0_26326
  (
    .ein(ein[26]),
    .eout(eout[3]),
    .capture(capture[3][26]),
    .minus(minus[3][26]),
    .search(search[3][26]),
    .backoff(backoff[3][26]),
    .min(min[3][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][26]),
    .F(F[3][26]),
    .inc(inc[3][26]),
    .dec(dec[3][26])
  );


  stdp.v
  s0_27327
  (
    .ein(ein[27]),
    .eout(eout[3]),
    .capture(capture[3][27]),
    .minus(minus[3][27]),
    .search(search[3][27]),
    .backoff(backoff[3][27]),
    .min(min[3][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][27]),
    .F(F[3][27]),
    .inc(inc[3][27]),
    .dec(dec[3][27])
  );


  stdp.v
  s0_28328
  (
    .ein(ein[28]),
    .eout(eout[3]),
    .capture(capture[3][28]),
    .minus(minus[3][28]),
    .search(search[3][28]),
    .backoff(backoff[3][28]),
    .min(min[3][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][28]),
    .F(F[3][28]),
    .inc(inc[3][28]),
    .dec(dec[3][28])
  );


  stdp.v
  s0_29329
  (
    .ein(ein[29]),
    .eout(eout[3]),
    .capture(capture[3][29]),
    .minus(minus[3][29]),
    .search(search[3][29]),
    .backoff(backoff[3][29]),
    .min(min[3][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][29]),
    .F(F[3][29]),
    .inc(inc[3][29]),
    .dec(dec[3][29])
  );


  stdp.v
  s0_30330
  (
    .ein(ein[30]),
    .eout(eout[3]),
    .capture(capture[3][30]),
    .minus(minus[3][30]),
    .search(search[3][30]),
    .backoff(backoff[3][30]),
    .min(min[3][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][30]),
    .F(F[3][30]),
    .inc(inc[3][30]),
    .dec(dec[3][30])
  );


  stdp.v
  s0_31331
  (
    .ein(ein[31]),
    .eout(eout[3]),
    .capture(capture[3][31]),
    .minus(minus[3][31]),
    .search(search[3][31]),
    .backoff(backoff[3][31]),
    .min(min[3][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[3][31]),
    .F(F[3][31]),
    .inc(inc[3][31]),
    .dec(dec[3][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_4
  (
    .input_spikes(aclk),
    .inc(input_spike[4]),
    .dec(gclk_pulse),
    .weight_update_en(ein[4])
  );


  pulse2edge
  out_pe_4
  (
    .aclk(aclk),
    .pulse_in(output_spikes[4]),
    .grst(gclk_pulse),
    .edge_out(eout[4])
  );


  stdp.v
  s0_040
  (
    .ein(ein[0]),
    .eout(eout[4]),
    .capture(capture[4][0]),
    .minus(minus[4][0]),
    .search(search[4][0]),
    .backoff(backoff[4][0]),
    .min(min[4][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][0]),
    .F(F[4][0]),
    .inc(inc[4][0]),
    .dec(dec[4][0])
  );


  stdp.v
  s0_141
  (
    .ein(ein[1]),
    .eout(eout[4]),
    .capture(capture[4][1]),
    .minus(minus[4][1]),
    .search(search[4][1]),
    .backoff(backoff[4][1]),
    .min(min[4][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][1]),
    .F(F[4][1]),
    .inc(inc[4][1]),
    .dec(dec[4][1])
  );


  stdp.v
  s0_242
  (
    .ein(ein[2]),
    .eout(eout[4]),
    .capture(capture[4][2]),
    .minus(minus[4][2]),
    .search(search[4][2]),
    .backoff(backoff[4][2]),
    .min(min[4][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][2]),
    .F(F[4][2]),
    .inc(inc[4][2]),
    .dec(dec[4][2])
  );


  stdp.v
  s0_343
  (
    .ein(ein[3]),
    .eout(eout[4]),
    .capture(capture[4][3]),
    .minus(minus[4][3]),
    .search(search[4][3]),
    .backoff(backoff[4][3]),
    .min(min[4][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][3]),
    .F(F[4][3]),
    .inc(inc[4][3]),
    .dec(dec[4][3])
  );


  stdp.v
  s0_444
  (
    .ein(ein[4]),
    .eout(eout[4]),
    .capture(capture[4][4]),
    .minus(minus[4][4]),
    .search(search[4][4]),
    .backoff(backoff[4][4]),
    .min(min[4][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][4]),
    .F(F[4][4]),
    .inc(inc[4][4]),
    .dec(dec[4][4])
  );


  stdp.v
  s0_545
  (
    .ein(ein[5]),
    .eout(eout[4]),
    .capture(capture[4][5]),
    .minus(minus[4][5]),
    .search(search[4][5]),
    .backoff(backoff[4][5]),
    .min(min[4][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][5]),
    .F(F[4][5]),
    .inc(inc[4][5]),
    .dec(dec[4][5])
  );


  stdp.v
  s0_646
  (
    .ein(ein[6]),
    .eout(eout[4]),
    .capture(capture[4][6]),
    .minus(minus[4][6]),
    .search(search[4][6]),
    .backoff(backoff[4][6]),
    .min(min[4][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][6]),
    .F(F[4][6]),
    .inc(inc[4][6]),
    .dec(dec[4][6])
  );


  stdp.v
  s0_747
  (
    .ein(ein[7]),
    .eout(eout[4]),
    .capture(capture[4][7]),
    .minus(minus[4][7]),
    .search(search[4][7]),
    .backoff(backoff[4][7]),
    .min(min[4][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][7]),
    .F(F[4][7]),
    .inc(inc[4][7]),
    .dec(dec[4][7])
  );


  stdp.v
  s0_848
  (
    .ein(ein[8]),
    .eout(eout[4]),
    .capture(capture[4][8]),
    .minus(minus[4][8]),
    .search(search[4][8]),
    .backoff(backoff[4][8]),
    .min(min[4][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][8]),
    .F(F[4][8]),
    .inc(inc[4][8]),
    .dec(dec[4][8])
  );


  stdp.v
  s0_949
  (
    .ein(ein[9]),
    .eout(eout[4]),
    .capture(capture[4][9]),
    .minus(minus[4][9]),
    .search(search[4][9]),
    .backoff(backoff[4][9]),
    .min(min[4][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][9]),
    .F(F[4][9]),
    .inc(inc[4][9]),
    .dec(dec[4][9])
  );


  stdp.v
  s0_10410
  (
    .ein(ein[10]),
    .eout(eout[4]),
    .capture(capture[4][10]),
    .minus(minus[4][10]),
    .search(search[4][10]),
    .backoff(backoff[4][10]),
    .min(min[4][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][10]),
    .F(F[4][10]),
    .inc(inc[4][10]),
    .dec(dec[4][10])
  );


  stdp.v
  s0_11411
  (
    .ein(ein[11]),
    .eout(eout[4]),
    .capture(capture[4][11]),
    .minus(minus[4][11]),
    .search(search[4][11]),
    .backoff(backoff[4][11]),
    .min(min[4][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][11]),
    .F(F[4][11]),
    .inc(inc[4][11]),
    .dec(dec[4][11])
  );


  stdp.v
  s0_12412
  (
    .ein(ein[12]),
    .eout(eout[4]),
    .capture(capture[4][12]),
    .minus(minus[4][12]),
    .search(search[4][12]),
    .backoff(backoff[4][12]),
    .min(min[4][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][12]),
    .F(F[4][12]),
    .inc(inc[4][12]),
    .dec(dec[4][12])
  );


  stdp.v
  s0_13413
  (
    .ein(ein[13]),
    .eout(eout[4]),
    .capture(capture[4][13]),
    .minus(minus[4][13]),
    .search(search[4][13]),
    .backoff(backoff[4][13]),
    .min(min[4][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][13]),
    .F(F[4][13]),
    .inc(inc[4][13]),
    .dec(dec[4][13])
  );


  stdp.v
  s0_14414
  (
    .ein(ein[14]),
    .eout(eout[4]),
    .capture(capture[4][14]),
    .minus(minus[4][14]),
    .search(search[4][14]),
    .backoff(backoff[4][14]),
    .min(min[4][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][14]),
    .F(F[4][14]),
    .inc(inc[4][14]),
    .dec(dec[4][14])
  );


  stdp.v
  s0_15415
  (
    .ein(ein[15]),
    .eout(eout[4]),
    .capture(capture[4][15]),
    .minus(minus[4][15]),
    .search(search[4][15]),
    .backoff(backoff[4][15]),
    .min(min[4][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][15]),
    .F(F[4][15]),
    .inc(inc[4][15]),
    .dec(dec[4][15])
  );


  stdp.v
  s0_16416
  (
    .ein(ein[16]),
    .eout(eout[4]),
    .capture(capture[4][16]),
    .minus(minus[4][16]),
    .search(search[4][16]),
    .backoff(backoff[4][16]),
    .min(min[4][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][16]),
    .F(F[4][16]),
    .inc(inc[4][16]),
    .dec(dec[4][16])
  );


  stdp.v
  s0_17417
  (
    .ein(ein[17]),
    .eout(eout[4]),
    .capture(capture[4][17]),
    .minus(minus[4][17]),
    .search(search[4][17]),
    .backoff(backoff[4][17]),
    .min(min[4][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][17]),
    .F(F[4][17]),
    .inc(inc[4][17]),
    .dec(dec[4][17])
  );


  stdp.v
  s0_18418
  (
    .ein(ein[18]),
    .eout(eout[4]),
    .capture(capture[4][18]),
    .minus(minus[4][18]),
    .search(search[4][18]),
    .backoff(backoff[4][18]),
    .min(min[4][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][18]),
    .F(F[4][18]),
    .inc(inc[4][18]),
    .dec(dec[4][18])
  );


  stdp.v
  s0_19419
  (
    .ein(ein[19]),
    .eout(eout[4]),
    .capture(capture[4][19]),
    .minus(minus[4][19]),
    .search(search[4][19]),
    .backoff(backoff[4][19]),
    .min(min[4][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][19]),
    .F(F[4][19]),
    .inc(inc[4][19]),
    .dec(dec[4][19])
  );


  stdp.v
  s0_20420
  (
    .ein(ein[20]),
    .eout(eout[4]),
    .capture(capture[4][20]),
    .minus(minus[4][20]),
    .search(search[4][20]),
    .backoff(backoff[4][20]),
    .min(min[4][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][20]),
    .F(F[4][20]),
    .inc(inc[4][20]),
    .dec(dec[4][20])
  );


  stdp.v
  s0_21421
  (
    .ein(ein[21]),
    .eout(eout[4]),
    .capture(capture[4][21]),
    .minus(minus[4][21]),
    .search(search[4][21]),
    .backoff(backoff[4][21]),
    .min(min[4][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][21]),
    .F(F[4][21]),
    .inc(inc[4][21]),
    .dec(dec[4][21])
  );


  stdp.v
  s0_22422
  (
    .ein(ein[22]),
    .eout(eout[4]),
    .capture(capture[4][22]),
    .minus(minus[4][22]),
    .search(search[4][22]),
    .backoff(backoff[4][22]),
    .min(min[4][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][22]),
    .F(F[4][22]),
    .inc(inc[4][22]),
    .dec(dec[4][22])
  );


  stdp.v
  s0_23423
  (
    .ein(ein[23]),
    .eout(eout[4]),
    .capture(capture[4][23]),
    .minus(minus[4][23]),
    .search(search[4][23]),
    .backoff(backoff[4][23]),
    .min(min[4][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][23]),
    .F(F[4][23]),
    .inc(inc[4][23]),
    .dec(dec[4][23])
  );


  stdp.v
  s0_24424
  (
    .ein(ein[24]),
    .eout(eout[4]),
    .capture(capture[4][24]),
    .minus(minus[4][24]),
    .search(search[4][24]),
    .backoff(backoff[4][24]),
    .min(min[4][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][24]),
    .F(F[4][24]),
    .inc(inc[4][24]),
    .dec(dec[4][24])
  );


  stdp.v
  s0_25425
  (
    .ein(ein[25]),
    .eout(eout[4]),
    .capture(capture[4][25]),
    .minus(minus[4][25]),
    .search(search[4][25]),
    .backoff(backoff[4][25]),
    .min(min[4][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][25]),
    .F(F[4][25]),
    .inc(inc[4][25]),
    .dec(dec[4][25])
  );


  stdp.v
  s0_26426
  (
    .ein(ein[26]),
    .eout(eout[4]),
    .capture(capture[4][26]),
    .minus(minus[4][26]),
    .search(search[4][26]),
    .backoff(backoff[4][26]),
    .min(min[4][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][26]),
    .F(F[4][26]),
    .inc(inc[4][26]),
    .dec(dec[4][26])
  );


  stdp.v
  s0_27427
  (
    .ein(ein[27]),
    .eout(eout[4]),
    .capture(capture[4][27]),
    .minus(minus[4][27]),
    .search(search[4][27]),
    .backoff(backoff[4][27]),
    .min(min[4][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][27]),
    .F(F[4][27]),
    .inc(inc[4][27]),
    .dec(dec[4][27])
  );


  stdp.v
  s0_28428
  (
    .ein(ein[28]),
    .eout(eout[4]),
    .capture(capture[4][28]),
    .minus(minus[4][28]),
    .search(search[4][28]),
    .backoff(backoff[4][28]),
    .min(min[4][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][28]),
    .F(F[4][28]),
    .inc(inc[4][28]),
    .dec(dec[4][28])
  );


  stdp.v
  s0_29429
  (
    .ein(ein[29]),
    .eout(eout[4]),
    .capture(capture[4][29]),
    .minus(minus[4][29]),
    .search(search[4][29]),
    .backoff(backoff[4][29]),
    .min(min[4][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][29]),
    .F(F[4][29]),
    .inc(inc[4][29]),
    .dec(dec[4][29])
  );


  stdp.v
  s0_30430
  (
    .ein(ein[30]),
    .eout(eout[4]),
    .capture(capture[4][30]),
    .minus(minus[4][30]),
    .search(search[4][30]),
    .backoff(backoff[4][30]),
    .min(min[4][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][30]),
    .F(F[4][30]),
    .inc(inc[4][30]),
    .dec(dec[4][30])
  );


  stdp.v
  s0_31431
  (
    .ein(ein[31]),
    .eout(eout[4]),
    .capture(capture[4][31]),
    .minus(minus[4][31]),
    .search(search[4][31]),
    .backoff(backoff[4][31]),
    .min(min[4][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[4][31]),
    .F(F[4][31]),
    .inc(inc[4][31]),
    .dec(dec[4][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_5
  (
    .input_spikes(aclk),
    .inc(input_spike[5]),
    .dec(gclk_pulse),
    .weight_update_en(ein[5])
  );


  pulse2edge
  out_pe_5
  (
    .aclk(aclk),
    .pulse_in(output_spikes[5]),
    .grst(gclk_pulse),
    .edge_out(eout[5])
  );


  stdp.v
  s0_050
  (
    .ein(ein[0]),
    .eout(eout[5]),
    .capture(capture[5][0]),
    .minus(minus[5][0]),
    .search(search[5][0]),
    .backoff(backoff[5][0]),
    .min(min[5][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][0]),
    .F(F[5][0]),
    .inc(inc[5][0]),
    .dec(dec[5][0])
  );


  stdp.v
  s0_151
  (
    .ein(ein[1]),
    .eout(eout[5]),
    .capture(capture[5][1]),
    .minus(minus[5][1]),
    .search(search[5][1]),
    .backoff(backoff[5][1]),
    .min(min[5][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][1]),
    .F(F[5][1]),
    .inc(inc[5][1]),
    .dec(dec[5][1])
  );


  stdp.v
  s0_252
  (
    .ein(ein[2]),
    .eout(eout[5]),
    .capture(capture[5][2]),
    .minus(minus[5][2]),
    .search(search[5][2]),
    .backoff(backoff[5][2]),
    .min(min[5][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][2]),
    .F(F[5][2]),
    .inc(inc[5][2]),
    .dec(dec[5][2])
  );


  stdp.v
  s0_353
  (
    .ein(ein[3]),
    .eout(eout[5]),
    .capture(capture[5][3]),
    .minus(minus[5][3]),
    .search(search[5][3]),
    .backoff(backoff[5][3]),
    .min(min[5][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][3]),
    .F(F[5][3]),
    .inc(inc[5][3]),
    .dec(dec[5][3])
  );


  stdp.v
  s0_454
  (
    .ein(ein[4]),
    .eout(eout[5]),
    .capture(capture[5][4]),
    .minus(minus[5][4]),
    .search(search[5][4]),
    .backoff(backoff[5][4]),
    .min(min[5][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][4]),
    .F(F[5][4]),
    .inc(inc[5][4]),
    .dec(dec[5][4])
  );


  stdp.v
  s0_555
  (
    .ein(ein[5]),
    .eout(eout[5]),
    .capture(capture[5][5]),
    .minus(minus[5][5]),
    .search(search[5][5]),
    .backoff(backoff[5][5]),
    .min(min[5][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][5]),
    .F(F[5][5]),
    .inc(inc[5][5]),
    .dec(dec[5][5])
  );


  stdp.v
  s0_656
  (
    .ein(ein[6]),
    .eout(eout[5]),
    .capture(capture[5][6]),
    .minus(minus[5][6]),
    .search(search[5][6]),
    .backoff(backoff[5][6]),
    .min(min[5][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][6]),
    .F(F[5][6]),
    .inc(inc[5][6]),
    .dec(dec[5][6])
  );


  stdp.v
  s0_757
  (
    .ein(ein[7]),
    .eout(eout[5]),
    .capture(capture[5][7]),
    .minus(minus[5][7]),
    .search(search[5][7]),
    .backoff(backoff[5][7]),
    .min(min[5][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][7]),
    .F(F[5][7]),
    .inc(inc[5][7]),
    .dec(dec[5][7])
  );


  stdp.v
  s0_858
  (
    .ein(ein[8]),
    .eout(eout[5]),
    .capture(capture[5][8]),
    .minus(minus[5][8]),
    .search(search[5][8]),
    .backoff(backoff[5][8]),
    .min(min[5][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][8]),
    .F(F[5][8]),
    .inc(inc[5][8]),
    .dec(dec[5][8])
  );


  stdp.v
  s0_959
  (
    .ein(ein[9]),
    .eout(eout[5]),
    .capture(capture[5][9]),
    .minus(minus[5][9]),
    .search(search[5][9]),
    .backoff(backoff[5][9]),
    .min(min[5][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][9]),
    .F(F[5][9]),
    .inc(inc[5][9]),
    .dec(dec[5][9])
  );


  stdp.v
  s0_10510
  (
    .ein(ein[10]),
    .eout(eout[5]),
    .capture(capture[5][10]),
    .minus(minus[5][10]),
    .search(search[5][10]),
    .backoff(backoff[5][10]),
    .min(min[5][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][10]),
    .F(F[5][10]),
    .inc(inc[5][10]),
    .dec(dec[5][10])
  );


  stdp.v
  s0_11511
  (
    .ein(ein[11]),
    .eout(eout[5]),
    .capture(capture[5][11]),
    .minus(minus[5][11]),
    .search(search[5][11]),
    .backoff(backoff[5][11]),
    .min(min[5][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][11]),
    .F(F[5][11]),
    .inc(inc[5][11]),
    .dec(dec[5][11])
  );


  stdp.v
  s0_12512
  (
    .ein(ein[12]),
    .eout(eout[5]),
    .capture(capture[5][12]),
    .minus(minus[5][12]),
    .search(search[5][12]),
    .backoff(backoff[5][12]),
    .min(min[5][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][12]),
    .F(F[5][12]),
    .inc(inc[5][12]),
    .dec(dec[5][12])
  );


  stdp.v
  s0_13513
  (
    .ein(ein[13]),
    .eout(eout[5]),
    .capture(capture[5][13]),
    .minus(minus[5][13]),
    .search(search[5][13]),
    .backoff(backoff[5][13]),
    .min(min[5][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][13]),
    .F(F[5][13]),
    .inc(inc[5][13]),
    .dec(dec[5][13])
  );


  stdp.v
  s0_14514
  (
    .ein(ein[14]),
    .eout(eout[5]),
    .capture(capture[5][14]),
    .minus(minus[5][14]),
    .search(search[5][14]),
    .backoff(backoff[5][14]),
    .min(min[5][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][14]),
    .F(F[5][14]),
    .inc(inc[5][14]),
    .dec(dec[5][14])
  );


  stdp.v
  s0_15515
  (
    .ein(ein[15]),
    .eout(eout[5]),
    .capture(capture[5][15]),
    .minus(minus[5][15]),
    .search(search[5][15]),
    .backoff(backoff[5][15]),
    .min(min[5][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][15]),
    .F(F[5][15]),
    .inc(inc[5][15]),
    .dec(dec[5][15])
  );


  stdp.v
  s0_16516
  (
    .ein(ein[16]),
    .eout(eout[5]),
    .capture(capture[5][16]),
    .minus(minus[5][16]),
    .search(search[5][16]),
    .backoff(backoff[5][16]),
    .min(min[5][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][16]),
    .F(F[5][16]),
    .inc(inc[5][16]),
    .dec(dec[5][16])
  );


  stdp.v
  s0_17517
  (
    .ein(ein[17]),
    .eout(eout[5]),
    .capture(capture[5][17]),
    .minus(minus[5][17]),
    .search(search[5][17]),
    .backoff(backoff[5][17]),
    .min(min[5][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][17]),
    .F(F[5][17]),
    .inc(inc[5][17]),
    .dec(dec[5][17])
  );


  stdp.v
  s0_18518
  (
    .ein(ein[18]),
    .eout(eout[5]),
    .capture(capture[5][18]),
    .minus(minus[5][18]),
    .search(search[5][18]),
    .backoff(backoff[5][18]),
    .min(min[5][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][18]),
    .F(F[5][18]),
    .inc(inc[5][18]),
    .dec(dec[5][18])
  );


  stdp.v
  s0_19519
  (
    .ein(ein[19]),
    .eout(eout[5]),
    .capture(capture[5][19]),
    .minus(minus[5][19]),
    .search(search[5][19]),
    .backoff(backoff[5][19]),
    .min(min[5][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][19]),
    .F(F[5][19]),
    .inc(inc[5][19]),
    .dec(dec[5][19])
  );


  stdp.v
  s0_20520
  (
    .ein(ein[20]),
    .eout(eout[5]),
    .capture(capture[5][20]),
    .minus(minus[5][20]),
    .search(search[5][20]),
    .backoff(backoff[5][20]),
    .min(min[5][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][20]),
    .F(F[5][20]),
    .inc(inc[5][20]),
    .dec(dec[5][20])
  );


  stdp.v
  s0_21521
  (
    .ein(ein[21]),
    .eout(eout[5]),
    .capture(capture[5][21]),
    .minus(minus[5][21]),
    .search(search[5][21]),
    .backoff(backoff[5][21]),
    .min(min[5][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][21]),
    .F(F[5][21]),
    .inc(inc[5][21]),
    .dec(dec[5][21])
  );


  stdp.v
  s0_22522
  (
    .ein(ein[22]),
    .eout(eout[5]),
    .capture(capture[5][22]),
    .minus(minus[5][22]),
    .search(search[5][22]),
    .backoff(backoff[5][22]),
    .min(min[5][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][22]),
    .F(F[5][22]),
    .inc(inc[5][22]),
    .dec(dec[5][22])
  );


  stdp.v
  s0_23523
  (
    .ein(ein[23]),
    .eout(eout[5]),
    .capture(capture[5][23]),
    .minus(minus[5][23]),
    .search(search[5][23]),
    .backoff(backoff[5][23]),
    .min(min[5][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][23]),
    .F(F[5][23]),
    .inc(inc[5][23]),
    .dec(dec[5][23])
  );


  stdp.v
  s0_24524
  (
    .ein(ein[24]),
    .eout(eout[5]),
    .capture(capture[5][24]),
    .minus(minus[5][24]),
    .search(search[5][24]),
    .backoff(backoff[5][24]),
    .min(min[5][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][24]),
    .F(F[5][24]),
    .inc(inc[5][24]),
    .dec(dec[5][24])
  );


  stdp.v
  s0_25525
  (
    .ein(ein[25]),
    .eout(eout[5]),
    .capture(capture[5][25]),
    .minus(minus[5][25]),
    .search(search[5][25]),
    .backoff(backoff[5][25]),
    .min(min[5][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][25]),
    .F(F[5][25]),
    .inc(inc[5][25]),
    .dec(dec[5][25])
  );


  stdp.v
  s0_26526
  (
    .ein(ein[26]),
    .eout(eout[5]),
    .capture(capture[5][26]),
    .minus(minus[5][26]),
    .search(search[5][26]),
    .backoff(backoff[5][26]),
    .min(min[5][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][26]),
    .F(F[5][26]),
    .inc(inc[5][26]),
    .dec(dec[5][26])
  );


  stdp.v
  s0_27527
  (
    .ein(ein[27]),
    .eout(eout[5]),
    .capture(capture[5][27]),
    .minus(minus[5][27]),
    .search(search[5][27]),
    .backoff(backoff[5][27]),
    .min(min[5][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][27]),
    .F(F[5][27]),
    .inc(inc[5][27]),
    .dec(dec[5][27])
  );


  stdp.v
  s0_28528
  (
    .ein(ein[28]),
    .eout(eout[5]),
    .capture(capture[5][28]),
    .minus(minus[5][28]),
    .search(search[5][28]),
    .backoff(backoff[5][28]),
    .min(min[5][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][28]),
    .F(F[5][28]),
    .inc(inc[5][28]),
    .dec(dec[5][28])
  );


  stdp.v
  s0_29529
  (
    .ein(ein[29]),
    .eout(eout[5]),
    .capture(capture[5][29]),
    .minus(minus[5][29]),
    .search(search[5][29]),
    .backoff(backoff[5][29]),
    .min(min[5][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][29]),
    .F(F[5][29]),
    .inc(inc[5][29]),
    .dec(dec[5][29])
  );


  stdp.v
  s0_30530
  (
    .ein(ein[30]),
    .eout(eout[5]),
    .capture(capture[5][30]),
    .minus(minus[5][30]),
    .search(search[5][30]),
    .backoff(backoff[5][30]),
    .min(min[5][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][30]),
    .F(F[5][30]),
    .inc(inc[5][30]),
    .dec(dec[5][30])
  );


  stdp.v
  s0_31531
  (
    .ein(ein[31]),
    .eout(eout[5]),
    .capture(capture[5][31]),
    .minus(minus[5][31]),
    .search(search[5][31]),
    .backoff(backoff[5][31]),
    .min(min[5][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[5][31]),
    .F(F[5][31]),
    .inc(inc[5][31]),
    .dec(dec[5][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_6
  (
    .input_spikes(aclk),
    .inc(input_spike[6]),
    .dec(gclk_pulse),
    .weight_update_en(ein[6])
  );


  pulse2edge
  out_pe_6
  (
    .aclk(aclk),
    .pulse_in(output_spikes[6]),
    .grst(gclk_pulse),
    .edge_out(eout[6])
  );


  stdp.v
  s0_060
  (
    .ein(ein[0]),
    .eout(eout[6]),
    .capture(capture[6][0]),
    .minus(minus[6][0]),
    .search(search[6][0]),
    .backoff(backoff[6][0]),
    .min(min[6][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][0]),
    .F(F[6][0]),
    .inc(inc[6][0]),
    .dec(dec[6][0])
  );


  stdp.v
  s0_161
  (
    .ein(ein[1]),
    .eout(eout[6]),
    .capture(capture[6][1]),
    .minus(minus[6][1]),
    .search(search[6][1]),
    .backoff(backoff[6][1]),
    .min(min[6][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][1]),
    .F(F[6][1]),
    .inc(inc[6][1]),
    .dec(dec[6][1])
  );


  stdp.v
  s0_262
  (
    .ein(ein[2]),
    .eout(eout[6]),
    .capture(capture[6][2]),
    .minus(minus[6][2]),
    .search(search[6][2]),
    .backoff(backoff[6][2]),
    .min(min[6][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][2]),
    .F(F[6][2]),
    .inc(inc[6][2]),
    .dec(dec[6][2])
  );


  stdp.v
  s0_363
  (
    .ein(ein[3]),
    .eout(eout[6]),
    .capture(capture[6][3]),
    .minus(minus[6][3]),
    .search(search[6][3]),
    .backoff(backoff[6][3]),
    .min(min[6][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][3]),
    .F(F[6][3]),
    .inc(inc[6][3]),
    .dec(dec[6][3])
  );


  stdp.v
  s0_464
  (
    .ein(ein[4]),
    .eout(eout[6]),
    .capture(capture[6][4]),
    .minus(minus[6][4]),
    .search(search[6][4]),
    .backoff(backoff[6][4]),
    .min(min[6][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][4]),
    .F(F[6][4]),
    .inc(inc[6][4]),
    .dec(dec[6][4])
  );


  stdp.v
  s0_565
  (
    .ein(ein[5]),
    .eout(eout[6]),
    .capture(capture[6][5]),
    .minus(minus[6][5]),
    .search(search[6][5]),
    .backoff(backoff[6][5]),
    .min(min[6][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][5]),
    .F(F[6][5]),
    .inc(inc[6][5]),
    .dec(dec[6][5])
  );


  stdp.v
  s0_666
  (
    .ein(ein[6]),
    .eout(eout[6]),
    .capture(capture[6][6]),
    .minus(minus[6][6]),
    .search(search[6][6]),
    .backoff(backoff[6][6]),
    .min(min[6][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][6]),
    .F(F[6][6]),
    .inc(inc[6][6]),
    .dec(dec[6][6])
  );


  stdp.v
  s0_767
  (
    .ein(ein[7]),
    .eout(eout[6]),
    .capture(capture[6][7]),
    .minus(minus[6][7]),
    .search(search[6][7]),
    .backoff(backoff[6][7]),
    .min(min[6][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][7]),
    .F(F[6][7]),
    .inc(inc[6][7]),
    .dec(dec[6][7])
  );


  stdp.v
  s0_868
  (
    .ein(ein[8]),
    .eout(eout[6]),
    .capture(capture[6][8]),
    .minus(minus[6][8]),
    .search(search[6][8]),
    .backoff(backoff[6][8]),
    .min(min[6][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][8]),
    .F(F[6][8]),
    .inc(inc[6][8]),
    .dec(dec[6][8])
  );


  stdp.v
  s0_969
  (
    .ein(ein[9]),
    .eout(eout[6]),
    .capture(capture[6][9]),
    .minus(minus[6][9]),
    .search(search[6][9]),
    .backoff(backoff[6][9]),
    .min(min[6][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][9]),
    .F(F[6][9]),
    .inc(inc[6][9]),
    .dec(dec[6][9])
  );


  stdp.v
  s0_10610
  (
    .ein(ein[10]),
    .eout(eout[6]),
    .capture(capture[6][10]),
    .minus(minus[6][10]),
    .search(search[6][10]),
    .backoff(backoff[6][10]),
    .min(min[6][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][10]),
    .F(F[6][10]),
    .inc(inc[6][10]),
    .dec(dec[6][10])
  );


  stdp.v
  s0_11611
  (
    .ein(ein[11]),
    .eout(eout[6]),
    .capture(capture[6][11]),
    .minus(minus[6][11]),
    .search(search[6][11]),
    .backoff(backoff[6][11]),
    .min(min[6][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][11]),
    .F(F[6][11]),
    .inc(inc[6][11]),
    .dec(dec[6][11])
  );


  stdp.v
  s0_12612
  (
    .ein(ein[12]),
    .eout(eout[6]),
    .capture(capture[6][12]),
    .minus(minus[6][12]),
    .search(search[6][12]),
    .backoff(backoff[6][12]),
    .min(min[6][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][12]),
    .F(F[6][12]),
    .inc(inc[6][12]),
    .dec(dec[6][12])
  );


  stdp.v
  s0_13613
  (
    .ein(ein[13]),
    .eout(eout[6]),
    .capture(capture[6][13]),
    .minus(minus[6][13]),
    .search(search[6][13]),
    .backoff(backoff[6][13]),
    .min(min[6][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][13]),
    .F(F[6][13]),
    .inc(inc[6][13]),
    .dec(dec[6][13])
  );


  stdp.v
  s0_14614
  (
    .ein(ein[14]),
    .eout(eout[6]),
    .capture(capture[6][14]),
    .minus(minus[6][14]),
    .search(search[6][14]),
    .backoff(backoff[6][14]),
    .min(min[6][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][14]),
    .F(F[6][14]),
    .inc(inc[6][14]),
    .dec(dec[6][14])
  );


  stdp.v
  s0_15615
  (
    .ein(ein[15]),
    .eout(eout[6]),
    .capture(capture[6][15]),
    .minus(minus[6][15]),
    .search(search[6][15]),
    .backoff(backoff[6][15]),
    .min(min[6][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][15]),
    .F(F[6][15]),
    .inc(inc[6][15]),
    .dec(dec[6][15])
  );


  stdp.v
  s0_16616
  (
    .ein(ein[16]),
    .eout(eout[6]),
    .capture(capture[6][16]),
    .minus(minus[6][16]),
    .search(search[6][16]),
    .backoff(backoff[6][16]),
    .min(min[6][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][16]),
    .F(F[6][16]),
    .inc(inc[6][16]),
    .dec(dec[6][16])
  );


  stdp.v
  s0_17617
  (
    .ein(ein[17]),
    .eout(eout[6]),
    .capture(capture[6][17]),
    .minus(minus[6][17]),
    .search(search[6][17]),
    .backoff(backoff[6][17]),
    .min(min[6][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][17]),
    .F(F[6][17]),
    .inc(inc[6][17]),
    .dec(dec[6][17])
  );


  stdp.v
  s0_18618
  (
    .ein(ein[18]),
    .eout(eout[6]),
    .capture(capture[6][18]),
    .minus(minus[6][18]),
    .search(search[6][18]),
    .backoff(backoff[6][18]),
    .min(min[6][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][18]),
    .F(F[6][18]),
    .inc(inc[6][18]),
    .dec(dec[6][18])
  );


  stdp.v
  s0_19619
  (
    .ein(ein[19]),
    .eout(eout[6]),
    .capture(capture[6][19]),
    .minus(minus[6][19]),
    .search(search[6][19]),
    .backoff(backoff[6][19]),
    .min(min[6][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][19]),
    .F(F[6][19]),
    .inc(inc[6][19]),
    .dec(dec[6][19])
  );


  stdp.v
  s0_20620
  (
    .ein(ein[20]),
    .eout(eout[6]),
    .capture(capture[6][20]),
    .minus(minus[6][20]),
    .search(search[6][20]),
    .backoff(backoff[6][20]),
    .min(min[6][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][20]),
    .F(F[6][20]),
    .inc(inc[6][20]),
    .dec(dec[6][20])
  );


  stdp.v
  s0_21621
  (
    .ein(ein[21]),
    .eout(eout[6]),
    .capture(capture[6][21]),
    .minus(minus[6][21]),
    .search(search[6][21]),
    .backoff(backoff[6][21]),
    .min(min[6][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][21]),
    .F(F[6][21]),
    .inc(inc[6][21]),
    .dec(dec[6][21])
  );


  stdp.v
  s0_22622
  (
    .ein(ein[22]),
    .eout(eout[6]),
    .capture(capture[6][22]),
    .minus(minus[6][22]),
    .search(search[6][22]),
    .backoff(backoff[6][22]),
    .min(min[6][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][22]),
    .F(F[6][22]),
    .inc(inc[6][22]),
    .dec(dec[6][22])
  );


  stdp.v
  s0_23623
  (
    .ein(ein[23]),
    .eout(eout[6]),
    .capture(capture[6][23]),
    .minus(minus[6][23]),
    .search(search[6][23]),
    .backoff(backoff[6][23]),
    .min(min[6][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][23]),
    .F(F[6][23]),
    .inc(inc[6][23]),
    .dec(dec[6][23])
  );


  stdp.v
  s0_24624
  (
    .ein(ein[24]),
    .eout(eout[6]),
    .capture(capture[6][24]),
    .minus(minus[6][24]),
    .search(search[6][24]),
    .backoff(backoff[6][24]),
    .min(min[6][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][24]),
    .F(F[6][24]),
    .inc(inc[6][24]),
    .dec(dec[6][24])
  );


  stdp.v
  s0_25625
  (
    .ein(ein[25]),
    .eout(eout[6]),
    .capture(capture[6][25]),
    .minus(minus[6][25]),
    .search(search[6][25]),
    .backoff(backoff[6][25]),
    .min(min[6][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][25]),
    .F(F[6][25]),
    .inc(inc[6][25]),
    .dec(dec[6][25])
  );


  stdp.v
  s0_26626
  (
    .ein(ein[26]),
    .eout(eout[6]),
    .capture(capture[6][26]),
    .minus(minus[6][26]),
    .search(search[6][26]),
    .backoff(backoff[6][26]),
    .min(min[6][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][26]),
    .F(F[6][26]),
    .inc(inc[6][26]),
    .dec(dec[6][26])
  );


  stdp.v
  s0_27627
  (
    .ein(ein[27]),
    .eout(eout[6]),
    .capture(capture[6][27]),
    .minus(minus[6][27]),
    .search(search[6][27]),
    .backoff(backoff[6][27]),
    .min(min[6][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][27]),
    .F(F[6][27]),
    .inc(inc[6][27]),
    .dec(dec[6][27])
  );


  stdp.v
  s0_28628
  (
    .ein(ein[28]),
    .eout(eout[6]),
    .capture(capture[6][28]),
    .minus(minus[6][28]),
    .search(search[6][28]),
    .backoff(backoff[6][28]),
    .min(min[6][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][28]),
    .F(F[6][28]),
    .inc(inc[6][28]),
    .dec(dec[6][28])
  );


  stdp.v
  s0_29629
  (
    .ein(ein[29]),
    .eout(eout[6]),
    .capture(capture[6][29]),
    .minus(minus[6][29]),
    .search(search[6][29]),
    .backoff(backoff[6][29]),
    .min(min[6][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][29]),
    .F(F[6][29]),
    .inc(inc[6][29]),
    .dec(dec[6][29])
  );


  stdp.v
  s0_30630
  (
    .ein(ein[30]),
    .eout(eout[6]),
    .capture(capture[6][30]),
    .minus(minus[6][30]),
    .search(search[6][30]),
    .backoff(backoff[6][30]),
    .min(min[6][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][30]),
    .F(F[6][30]),
    .inc(inc[6][30]),
    .dec(dec[6][30])
  );


  stdp.v
  s0_31631
  (
    .ein(ein[31]),
    .eout(eout[6]),
    .capture(capture[6][31]),
    .minus(minus[6][31]),
    .search(search[6][31]),
    .backoff(backoff[6][31]),
    .min(min[6][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[6][31]),
    .F(F[6][31]),
    .inc(inc[6][31]),
    .dec(dec[6][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_7
  (
    .input_spikes(aclk),
    .inc(input_spike[7]),
    .dec(gclk_pulse),
    .weight_update_en(ein[7])
  );


  pulse2edge
  out_pe_7
  (
    .aclk(aclk),
    .pulse_in(output_spikes[7]),
    .grst(gclk_pulse),
    .edge_out(eout[7])
  );


  stdp.v
  s0_070
  (
    .ein(ein[0]),
    .eout(eout[7]),
    .capture(capture[7][0]),
    .minus(minus[7][0]),
    .search(search[7][0]),
    .backoff(backoff[7][0]),
    .min(min[7][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][0]),
    .F(F[7][0]),
    .inc(inc[7][0]),
    .dec(dec[7][0])
  );


  stdp.v
  s0_171
  (
    .ein(ein[1]),
    .eout(eout[7]),
    .capture(capture[7][1]),
    .minus(minus[7][1]),
    .search(search[7][1]),
    .backoff(backoff[7][1]),
    .min(min[7][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][1]),
    .F(F[7][1]),
    .inc(inc[7][1]),
    .dec(dec[7][1])
  );


  stdp.v
  s0_272
  (
    .ein(ein[2]),
    .eout(eout[7]),
    .capture(capture[7][2]),
    .minus(minus[7][2]),
    .search(search[7][2]),
    .backoff(backoff[7][2]),
    .min(min[7][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][2]),
    .F(F[7][2]),
    .inc(inc[7][2]),
    .dec(dec[7][2])
  );


  stdp.v
  s0_373
  (
    .ein(ein[3]),
    .eout(eout[7]),
    .capture(capture[7][3]),
    .minus(minus[7][3]),
    .search(search[7][3]),
    .backoff(backoff[7][3]),
    .min(min[7][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][3]),
    .F(F[7][3]),
    .inc(inc[7][3]),
    .dec(dec[7][3])
  );


  stdp.v
  s0_474
  (
    .ein(ein[4]),
    .eout(eout[7]),
    .capture(capture[7][4]),
    .minus(minus[7][4]),
    .search(search[7][4]),
    .backoff(backoff[7][4]),
    .min(min[7][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][4]),
    .F(F[7][4]),
    .inc(inc[7][4]),
    .dec(dec[7][4])
  );


  stdp.v
  s0_575
  (
    .ein(ein[5]),
    .eout(eout[7]),
    .capture(capture[7][5]),
    .minus(minus[7][5]),
    .search(search[7][5]),
    .backoff(backoff[7][5]),
    .min(min[7][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][5]),
    .F(F[7][5]),
    .inc(inc[7][5]),
    .dec(dec[7][5])
  );


  stdp.v
  s0_676
  (
    .ein(ein[6]),
    .eout(eout[7]),
    .capture(capture[7][6]),
    .minus(minus[7][6]),
    .search(search[7][6]),
    .backoff(backoff[7][6]),
    .min(min[7][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][6]),
    .F(F[7][6]),
    .inc(inc[7][6]),
    .dec(dec[7][6])
  );


  stdp.v
  s0_777
  (
    .ein(ein[7]),
    .eout(eout[7]),
    .capture(capture[7][7]),
    .minus(minus[7][7]),
    .search(search[7][7]),
    .backoff(backoff[7][7]),
    .min(min[7][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][7]),
    .F(F[7][7]),
    .inc(inc[7][7]),
    .dec(dec[7][7])
  );


  stdp.v
  s0_878
  (
    .ein(ein[8]),
    .eout(eout[7]),
    .capture(capture[7][8]),
    .minus(minus[7][8]),
    .search(search[7][8]),
    .backoff(backoff[7][8]),
    .min(min[7][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][8]),
    .F(F[7][8]),
    .inc(inc[7][8]),
    .dec(dec[7][8])
  );


  stdp.v
  s0_979
  (
    .ein(ein[9]),
    .eout(eout[7]),
    .capture(capture[7][9]),
    .minus(minus[7][9]),
    .search(search[7][9]),
    .backoff(backoff[7][9]),
    .min(min[7][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][9]),
    .F(F[7][9]),
    .inc(inc[7][9]),
    .dec(dec[7][9])
  );


  stdp.v
  s0_10710
  (
    .ein(ein[10]),
    .eout(eout[7]),
    .capture(capture[7][10]),
    .minus(minus[7][10]),
    .search(search[7][10]),
    .backoff(backoff[7][10]),
    .min(min[7][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][10]),
    .F(F[7][10]),
    .inc(inc[7][10]),
    .dec(dec[7][10])
  );


  stdp.v
  s0_11711
  (
    .ein(ein[11]),
    .eout(eout[7]),
    .capture(capture[7][11]),
    .minus(minus[7][11]),
    .search(search[7][11]),
    .backoff(backoff[7][11]),
    .min(min[7][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][11]),
    .F(F[7][11]),
    .inc(inc[7][11]),
    .dec(dec[7][11])
  );


  stdp.v
  s0_12712
  (
    .ein(ein[12]),
    .eout(eout[7]),
    .capture(capture[7][12]),
    .minus(minus[7][12]),
    .search(search[7][12]),
    .backoff(backoff[7][12]),
    .min(min[7][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][12]),
    .F(F[7][12]),
    .inc(inc[7][12]),
    .dec(dec[7][12])
  );


  stdp.v
  s0_13713
  (
    .ein(ein[13]),
    .eout(eout[7]),
    .capture(capture[7][13]),
    .minus(minus[7][13]),
    .search(search[7][13]),
    .backoff(backoff[7][13]),
    .min(min[7][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][13]),
    .F(F[7][13]),
    .inc(inc[7][13]),
    .dec(dec[7][13])
  );


  stdp.v
  s0_14714
  (
    .ein(ein[14]),
    .eout(eout[7]),
    .capture(capture[7][14]),
    .minus(minus[7][14]),
    .search(search[7][14]),
    .backoff(backoff[7][14]),
    .min(min[7][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][14]),
    .F(F[7][14]),
    .inc(inc[7][14]),
    .dec(dec[7][14])
  );


  stdp.v
  s0_15715
  (
    .ein(ein[15]),
    .eout(eout[7]),
    .capture(capture[7][15]),
    .minus(minus[7][15]),
    .search(search[7][15]),
    .backoff(backoff[7][15]),
    .min(min[7][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][15]),
    .F(F[7][15]),
    .inc(inc[7][15]),
    .dec(dec[7][15])
  );


  stdp.v
  s0_16716
  (
    .ein(ein[16]),
    .eout(eout[7]),
    .capture(capture[7][16]),
    .minus(minus[7][16]),
    .search(search[7][16]),
    .backoff(backoff[7][16]),
    .min(min[7][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][16]),
    .F(F[7][16]),
    .inc(inc[7][16]),
    .dec(dec[7][16])
  );


  stdp.v
  s0_17717
  (
    .ein(ein[17]),
    .eout(eout[7]),
    .capture(capture[7][17]),
    .minus(minus[7][17]),
    .search(search[7][17]),
    .backoff(backoff[7][17]),
    .min(min[7][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][17]),
    .F(F[7][17]),
    .inc(inc[7][17]),
    .dec(dec[7][17])
  );


  stdp.v
  s0_18718
  (
    .ein(ein[18]),
    .eout(eout[7]),
    .capture(capture[7][18]),
    .minus(minus[7][18]),
    .search(search[7][18]),
    .backoff(backoff[7][18]),
    .min(min[7][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][18]),
    .F(F[7][18]),
    .inc(inc[7][18]),
    .dec(dec[7][18])
  );


  stdp.v
  s0_19719
  (
    .ein(ein[19]),
    .eout(eout[7]),
    .capture(capture[7][19]),
    .minus(minus[7][19]),
    .search(search[7][19]),
    .backoff(backoff[7][19]),
    .min(min[7][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][19]),
    .F(F[7][19]),
    .inc(inc[7][19]),
    .dec(dec[7][19])
  );


  stdp.v
  s0_20720
  (
    .ein(ein[20]),
    .eout(eout[7]),
    .capture(capture[7][20]),
    .minus(minus[7][20]),
    .search(search[7][20]),
    .backoff(backoff[7][20]),
    .min(min[7][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][20]),
    .F(F[7][20]),
    .inc(inc[7][20]),
    .dec(dec[7][20])
  );


  stdp.v
  s0_21721
  (
    .ein(ein[21]),
    .eout(eout[7]),
    .capture(capture[7][21]),
    .minus(minus[7][21]),
    .search(search[7][21]),
    .backoff(backoff[7][21]),
    .min(min[7][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][21]),
    .F(F[7][21]),
    .inc(inc[7][21]),
    .dec(dec[7][21])
  );


  stdp.v
  s0_22722
  (
    .ein(ein[22]),
    .eout(eout[7]),
    .capture(capture[7][22]),
    .minus(minus[7][22]),
    .search(search[7][22]),
    .backoff(backoff[7][22]),
    .min(min[7][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][22]),
    .F(F[7][22]),
    .inc(inc[7][22]),
    .dec(dec[7][22])
  );


  stdp.v
  s0_23723
  (
    .ein(ein[23]),
    .eout(eout[7]),
    .capture(capture[7][23]),
    .minus(minus[7][23]),
    .search(search[7][23]),
    .backoff(backoff[7][23]),
    .min(min[7][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][23]),
    .F(F[7][23]),
    .inc(inc[7][23]),
    .dec(dec[7][23])
  );


  stdp.v
  s0_24724
  (
    .ein(ein[24]),
    .eout(eout[7]),
    .capture(capture[7][24]),
    .minus(minus[7][24]),
    .search(search[7][24]),
    .backoff(backoff[7][24]),
    .min(min[7][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][24]),
    .F(F[7][24]),
    .inc(inc[7][24]),
    .dec(dec[7][24])
  );


  stdp.v
  s0_25725
  (
    .ein(ein[25]),
    .eout(eout[7]),
    .capture(capture[7][25]),
    .minus(minus[7][25]),
    .search(search[7][25]),
    .backoff(backoff[7][25]),
    .min(min[7][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][25]),
    .F(F[7][25]),
    .inc(inc[7][25]),
    .dec(dec[7][25])
  );


  stdp.v
  s0_26726
  (
    .ein(ein[26]),
    .eout(eout[7]),
    .capture(capture[7][26]),
    .minus(minus[7][26]),
    .search(search[7][26]),
    .backoff(backoff[7][26]),
    .min(min[7][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][26]),
    .F(F[7][26]),
    .inc(inc[7][26]),
    .dec(dec[7][26])
  );


  stdp.v
  s0_27727
  (
    .ein(ein[27]),
    .eout(eout[7]),
    .capture(capture[7][27]),
    .minus(minus[7][27]),
    .search(search[7][27]),
    .backoff(backoff[7][27]),
    .min(min[7][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][27]),
    .F(F[7][27]),
    .inc(inc[7][27]),
    .dec(dec[7][27])
  );


  stdp.v
  s0_28728
  (
    .ein(ein[28]),
    .eout(eout[7]),
    .capture(capture[7][28]),
    .minus(minus[7][28]),
    .search(search[7][28]),
    .backoff(backoff[7][28]),
    .min(min[7][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][28]),
    .F(F[7][28]),
    .inc(inc[7][28]),
    .dec(dec[7][28])
  );


  stdp.v
  s0_29729
  (
    .ein(ein[29]),
    .eout(eout[7]),
    .capture(capture[7][29]),
    .minus(minus[7][29]),
    .search(search[7][29]),
    .backoff(backoff[7][29]),
    .min(min[7][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][29]),
    .F(F[7][29]),
    .inc(inc[7][29]),
    .dec(dec[7][29])
  );


  stdp.v
  s0_30730
  (
    .ein(ein[30]),
    .eout(eout[7]),
    .capture(capture[7][30]),
    .minus(minus[7][30]),
    .search(search[7][30]),
    .backoff(backoff[7][30]),
    .min(min[7][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][30]),
    .F(F[7][30]),
    .inc(inc[7][30]),
    .dec(dec[7][30])
  );


  stdp.v
  s0_31731
  (
    .ein(ein[31]),
    .eout(eout[7]),
    .capture(capture[7][31]),
    .minus(minus[7][31]),
    .search(search[7][31]),
    .backoff(backoff[7][31]),
    .min(min[7][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[7][31]),
    .F(F[7][31]),
    .inc(inc[7][31]),
    .dec(dec[7][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_8
  (
    .input_spikes(aclk),
    .inc(input_spike[8]),
    .dec(gclk_pulse),
    .weight_update_en(ein[8])
  );


  pulse2edge
  out_pe_8
  (
    .aclk(aclk),
    .pulse_in(output_spikes[8]),
    .grst(gclk_pulse),
    .edge_out(eout[8])
  );


  stdp.v
  s0_080
  (
    .ein(ein[0]),
    .eout(eout[8]),
    .capture(capture[8][0]),
    .minus(minus[8][0]),
    .search(search[8][0]),
    .backoff(backoff[8][0]),
    .min(min[8][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][0]),
    .F(F[8][0]),
    .inc(inc[8][0]),
    .dec(dec[8][0])
  );


  stdp.v
  s0_181
  (
    .ein(ein[1]),
    .eout(eout[8]),
    .capture(capture[8][1]),
    .minus(minus[8][1]),
    .search(search[8][1]),
    .backoff(backoff[8][1]),
    .min(min[8][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][1]),
    .F(F[8][1]),
    .inc(inc[8][1]),
    .dec(dec[8][1])
  );


  stdp.v
  s0_282
  (
    .ein(ein[2]),
    .eout(eout[8]),
    .capture(capture[8][2]),
    .minus(minus[8][2]),
    .search(search[8][2]),
    .backoff(backoff[8][2]),
    .min(min[8][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][2]),
    .F(F[8][2]),
    .inc(inc[8][2]),
    .dec(dec[8][2])
  );


  stdp.v
  s0_383
  (
    .ein(ein[3]),
    .eout(eout[8]),
    .capture(capture[8][3]),
    .minus(minus[8][3]),
    .search(search[8][3]),
    .backoff(backoff[8][3]),
    .min(min[8][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][3]),
    .F(F[8][3]),
    .inc(inc[8][3]),
    .dec(dec[8][3])
  );


  stdp.v
  s0_484
  (
    .ein(ein[4]),
    .eout(eout[8]),
    .capture(capture[8][4]),
    .minus(minus[8][4]),
    .search(search[8][4]),
    .backoff(backoff[8][4]),
    .min(min[8][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][4]),
    .F(F[8][4]),
    .inc(inc[8][4]),
    .dec(dec[8][4])
  );


  stdp.v
  s0_585
  (
    .ein(ein[5]),
    .eout(eout[8]),
    .capture(capture[8][5]),
    .minus(minus[8][5]),
    .search(search[8][5]),
    .backoff(backoff[8][5]),
    .min(min[8][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][5]),
    .F(F[8][5]),
    .inc(inc[8][5]),
    .dec(dec[8][5])
  );


  stdp.v
  s0_686
  (
    .ein(ein[6]),
    .eout(eout[8]),
    .capture(capture[8][6]),
    .minus(minus[8][6]),
    .search(search[8][6]),
    .backoff(backoff[8][6]),
    .min(min[8][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][6]),
    .F(F[8][6]),
    .inc(inc[8][6]),
    .dec(dec[8][6])
  );


  stdp.v
  s0_787
  (
    .ein(ein[7]),
    .eout(eout[8]),
    .capture(capture[8][7]),
    .minus(minus[8][7]),
    .search(search[8][7]),
    .backoff(backoff[8][7]),
    .min(min[8][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][7]),
    .F(F[8][7]),
    .inc(inc[8][7]),
    .dec(dec[8][7])
  );


  stdp.v
  s0_888
  (
    .ein(ein[8]),
    .eout(eout[8]),
    .capture(capture[8][8]),
    .minus(minus[8][8]),
    .search(search[8][8]),
    .backoff(backoff[8][8]),
    .min(min[8][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][8]),
    .F(F[8][8]),
    .inc(inc[8][8]),
    .dec(dec[8][8])
  );


  stdp.v
  s0_989
  (
    .ein(ein[9]),
    .eout(eout[8]),
    .capture(capture[8][9]),
    .minus(minus[8][9]),
    .search(search[8][9]),
    .backoff(backoff[8][9]),
    .min(min[8][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][9]),
    .F(F[8][9]),
    .inc(inc[8][9]),
    .dec(dec[8][9])
  );


  stdp.v
  s0_10810
  (
    .ein(ein[10]),
    .eout(eout[8]),
    .capture(capture[8][10]),
    .minus(minus[8][10]),
    .search(search[8][10]),
    .backoff(backoff[8][10]),
    .min(min[8][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][10]),
    .F(F[8][10]),
    .inc(inc[8][10]),
    .dec(dec[8][10])
  );


  stdp.v
  s0_11811
  (
    .ein(ein[11]),
    .eout(eout[8]),
    .capture(capture[8][11]),
    .minus(minus[8][11]),
    .search(search[8][11]),
    .backoff(backoff[8][11]),
    .min(min[8][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][11]),
    .F(F[8][11]),
    .inc(inc[8][11]),
    .dec(dec[8][11])
  );


  stdp.v
  s0_12812
  (
    .ein(ein[12]),
    .eout(eout[8]),
    .capture(capture[8][12]),
    .minus(minus[8][12]),
    .search(search[8][12]),
    .backoff(backoff[8][12]),
    .min(min[8][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][12]),
    .F(F[8][12]),
    .inc(inc[8][12]),
    .dec(dec[8][12])
  );


  stdp.v
  s0_13813
  (
    .ein(ein[13]),
    .eout(eout[8]),
    .capture(capture[8][13]),
    .minus(minus[8][13]),
    .search(search[8][13]),
    .backoff(backoff[8][13]),
    .min(min[8][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][13]),
    .F(F[8][13]),
    .inc(inc[8][13]),
    .dec(dec[8][13])
  );


  stdp.v
  s0_14814
  (
    .ein(ein[14]),
    .eout(eout[8]),
    .capture(capture[8][14]),
    .minus(minus[8][14]),
    .search(search[8][14]),
    .backoff(backoff[8][14]),
    .min(min[8][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][14]),
    .F(F[8][14]),
    .inc(inc[8][14]),
    .dec(dec[8][14])
  );


  stdp.v
  s0_15815
  (
    .ein(ein[15]),
    .eout(eout[8]),
    .capture(capture[8][15]),
    .minus(minus[8][15]),
    .search(search[8][15]),
    .backoff(backoff[8][15]),
    .min(min[8][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][15]),
    .F(F[8][15]),
    .inc(inc[8][15]),
    .dec(dec[8][15])
  );


  stdp.v
  s0_16816
  (
    .ein(ein[16]),
    .eout(eout[8]),
    .capture(capture[8][16]),
    .minus(minus[8][16]),
    .search(search[8][16]),
    .backoff(backoff[8][16]),
    .min(min[8][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][16]),
    .F(F[8][16]),
    .inc(inc[8][16]),
    .dec(dec[8][16])
  );


  stdp.v
  s0_17817
  (
    .ein(ein[17]),
    .eout(eout[8]),
    .capture(capture[8][17]),
    .minus(minus[8][17]),
    .search(search[8][17]),
    .backoff(backoff[8][17]),
    .min(min[8][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][17]),
    .F(F[8][17]),
    .inc(inc[8][17]),
    .dec(dec[8][17])
  );


  stdp.v
  s0_18818
  (
    .ein(ein[18]),
    .eout(eout[8]),
    .capture(capture[8][18]),
    .minus(minus[8][18]),
    .search(search[8][18]),
    .backoff(backoff[8][18]),
    .min(min[8][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][18]),
    .F(F[8][18]),
    .inc(inc[8][18]),
    .dec(dec[8][18])
  );


  stdp.v
  s0_19819
  (
    .ein(ein[19]),
    .eout(eout[8]),
    .capture(capture[8][19]),
    .minus(minus[8][19]),
    .search(search[8][19]),
    .backoff(backoff[8][19]),
    .min(min[8][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][19]),
    .F(F[8][19]),
    .inc(inc[8][19]),
    .dec(dec[8][19])
  );


  stdp.v
  s0_20820
  (
    .ein(ein[20]),
    .eout(eout[8]),
    .capture(capture[8][20]),
    .minus(minus[8][20]),
    .search(search[8][20]),
    .backoff(backoff[8][20]),
    .min(min[8][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][20]),
    .F(F[8][20]),
    .inc(inc[8][20]),
    .dec(dec[8][20])
  );


  stdp.v
  s0_21821
  (
    .ein(ein[21]),
    .eout(eout[8]),
    .capture(capture[8][21]),
    .minus(minus[8][21]),
    .search(search[8][21]),
    .backoff(backoff[8][21]),
    .min(min[8][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][21]),
    .F(F[8][21]),
    .inc(inc[8][21]),
    .dec(dec[8][21])
  );


  stdp.v
  s0_22822
  (
    .ein(ein[22]),
    .eout(eout[8]),
    .capture(capture[8][22]),
    .minus(minus[8][22]),
    .search(search[8][22]),
    .backoff(backoff[8][22]),
    .min(min[8][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][22]),
    .F(F[8][22]),
    .inc(inc[8][22]),
    .dec(dec[8][22])
  );


  stdp.v
  s0_23823
  (
    .ein(ein[23]),
    .eout(eout[8]),
    .capture(capture[8][23]),
    .minus(minus[8][23]),
    .search(search[8][23]),
    .backoff(backoff[8][23]),
    .min(min[8][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][23]),
    .F(F[8][23]),
    .inc(inc[8][23]),
    .dec(dec[8][23])
  );


  stdp.v
  s0_24824
  (
    .ein(ein[24]),
    .eout(eout[8]),
    .capture(capture[8][24]),
    .minus(minus[8][24]),
    .search(search[8][24]),
    .backoff(backoff[8][24]),
    .min(min[8][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][24]),
    .F(F[8][24]),
    .inc(inc[8][24]),
    .dec(dec[8][24])
  );


  stdp.v
  s0_25825
  (
    .ein(ein[25]),
    .eout(eout[8]),
    .capture(capture[8][25]),
    .minus(minus[8][25]),
    .search(search[8][25]),
    .backoff(backoff[8][25]),
    .min(min[8][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][25]),
    .F(F[8][25]),
    .inc(inc[8][25]),
    .dec(dec[8][25])
  );


  stdp.v
  s0_26826
  (
    .ein(ein[26]),
    .eout(eout[8]),
    .capture(capture[8][26]),
    .minus(minus[8][26]),
    .search(search[8][26]),
    .backoff(backoff[8][26]),
    .min(min[8][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][26]),
    .F(F[8][26]),
    .inc(inc[8][26]),
    .dec(dec[8][26])
  );


  stdp.v
  s0_27827
  (
    .ein(ein[27]),
    .eout(eout[8]),
    .capture(capture[8][27]),
    .minus(minus[8][27]),
    .search(search[8][27]),
    .backoff(backoff[8][27]),
    .min(min[8][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][27]),
    .F(F[8][27]),
    .inc(inc[8][27]),
    .dec(dec[8][27])
  );


  stdp.v
  s0_28828
  (
    .ein(ein[28]),
    .eout(eout[8]),
    .capture(capture[8][28]),
    .minus(minus[8][28]),
    .search(search[8][28]),
    .backoff(backoff[8][28]),
    .min(min[8][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][28]),
    .F(F[8][28]),
    .inc(inc[8][28]),
    .dec(dec[8][28])
  );


  stdp.v
  s0_29829
  (
    .ein(ein[29]),
    .eout(eout[8]),
    .capture(capture[8][29]),
    .minus(minus[8][29]),
    .search(search[8][29]),
    .backoff(backoff[8][29]),
    .min(min[8][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][29]),
    .F(F[8][29]),
    .inc(inc[8][29]),
    .dec(dec[8][29])
  );


  stdp.v
  s0_30830
  (
    .ein(ein[30]),
    .eout(eout[8]),
    .capture(capture[8][30]),
    .minus(minus[8][30]),
    .search(search[8][30]),
    .backoff(backoff[8][30]),
    .min(min[8][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][30]),
    .F(F[8][30]),
    .inc(inc[8][30]),
    .dec(dec[8][30])
  );


  stdp.v
  s0_31831
  (
    .ein(ein[31]),
    .eout(eout[8]),
    .capture(capture[8][31]),
    .minus(minus[8][31]),
    .search(search[8][31]),
    .backoff(backoff[8][31]),
    .min(min[8][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[8][31]),
    .F(F[8][31]),
    .inc(inc[8][31]),
    .dec(dec[8][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_9
  (
    .input_spikes(aclk),
    .inc(input_spike[9]),
    .dec(gclk_pulse),
    .weight_update_en(ein[9])
  );


  pulse2edge
  out_pe_9
  (
    .aclk(aclk),
    .pulse_in(output_spikes[9]),
    .grst(gclk_pulse),
    .edge_out(eout[9])
  );


  stdp.v
  s0_090
  (
    .ein(ein[0]),
    .eout(eout[9]),
    .capture(capture[9][0]),
    .minus(minus[9][0]),
    .search(search[9][0]),
    .backoff(backoff[9][0]),
    .min(min[9][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][0]),
    .F(F[9][0]),
    .inc(inc[9][0]),
    .dec(dec[9][0])
  );


  stdp.v
  s0_191
  (
    .ein(ein[1]),
    .eout(eout[9]),
    .capture(capture[9][1]),
    .minus(minus[9][1]),
    .search(search[9][1]),
    .backoff(backoff[9][1]),
    .min(min[9][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][1]),
    .F(F[9][1]),
    .inc(inc[9][1]),
    .dec(dec[9][1])
  );


  stdp.v
  s0_292
  (
    .ein(ein[2]),
    .eout(eout[9]),
    .capture(capture[9][2]),
    .minus(minus[9][2]),
    .search(search[9][2]),
    .backoff(backoff[9][2]),
    .min(min[9][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][2]),
    .F(F[9][2]),
    .inc(inc[9][2]),
    .dec(dec[9][2])
  );


  stdp.v
  s0_393
  (
    .ein(ein[3]),
    .eout(eout[9]),
    .capture(capture[9][3]),
    .minus(minus[9][3]),
    .search(search[9][3]),
    .backoff(backoff[9][3]),
    .min(min[9][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][3]),
    .F(F[9][3]),
    .inc(inc[9][3]),
    .dec(dec[9][3])
  );


  stdp.v
  s0_494
  (
    .ein(ein[4]),
    .eout(eout[9]),
    .capture(capture[9][4]),
    .minus(minus[9][4]),
    .search(search[9][4]),
    .backoff(backoff[9][4]),
    .min(min[9][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][4]),
    .F(F[9][4]),
    .inc(inc[9][4]),
    .dec(dec[9][4])
  );


  stdp.v
  s0_595
  (
    .ein(ein[5]),
    .eout(eout[9]),
    .capture(capture[9][5]),
    .minus(minus[9][5]),
    .search(search[9][5]),
    .backoff(backoff[9][5]),
    .min(min[9][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][5]),
    .F(F[9][5]),
    .inc(inc[9][5]),
    .dec(dec[9][5])
  );


  stdp.v
  s0_696
  (
    .ein(ein[6]),
    .eout(eout[9]),
    .capture(capture[9][6]),
    .minus(minus[9][6]),
    .search(search[9][6]),
    .backoff(backoff[9][6]),
    .min(min[9][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][6]),
    .F(F[9][6]),
    .inc(inc[9][6]),
    .dec(dec[9][6])
  );


  stdp.v
  s0_797
  (
    .ein(ein[7]),
    .eout(eout[9]),
    .capture(capture[9][7]),
    .minus(minus[9][7]),
    .search(search[9][7]),
    .backoff(backoff[9][7]),
    .min(min[9][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][7]),
    .F(F[9][7]),
    .inc(inc[9][7]),
    .dec(dec[9][7])
  );


  stdp.v
  s0_898
  (
    .ein(ein[8]),
    .eout(eout[9]),
    .capture(capture[9][8]),
    .minus(minus[9][8]),
    .search(search[9][8]),
    .backoff(backoff[9][8]),
    .min(min[9][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][8]),
    .F(F[9][8]),
    .inc(inc[9][8]),
    .dec(dec[9][8])
  );


  stdp.v
  s0_999
  (
    .ein(ein[9]),
    .eout(eout[9]),
    .capture(capture[9][9]),
    .minus(minus[9][9]),
    .search(search[9][9]),
    .backoff(backoff[9][9]),
    .min(min[9][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][9]),
    .F(F[9][9]),
    .inc(inc[9][9]),
    .dec(dec[9][9])
  );


  stdp.v
  s0_10910
  (
    .ein(ein[10]),
    .eout(eout[9]),
    .capture(capture[9][10]),
    .minus(minus[9][10]),
    .search(search[9][10]),
    .backoff(backoff[9][10]),
    .min(min[9][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][10]),
    .F(F[9][10]),
    .inc(inc[9][10]),
    .dec(dec[9][10])
  );


  stdp.v
  s0_11911
  (
    .ein(ein[11]),
    .eout(eout[9]),
    .capture(capture[9][11]),
    .minus(minus[9][11]),
    .search(search[9][11]),
    .backoff(backoff[9][11]),
    .min(min[9][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][11]),
    .F(F[9][11]),
    .inc(inc[9][11]),
    .dec(dec[9][11])
  );


  stdp.v
  s0_12912
  (
    .ein(ein[12]),
    .eout(eout[9]),
    .capture(capture[9][12]),
    .minus(minus[9][12]),
    .search(search[9][12]),
    .backoff(backoff[9][12]),
    .min(min[9][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][12]),
    .F(F[9][12]),
    .inc(inc[9][12]),
    .dec(dec[9][12])
  );


  stdp.v
  s0_13913
  (
    .ein(ein[13]),
    .eout(eout[9]),
    .capture(capture[9][13]),
    .minus(minus[9][13]),
    .search(search[9][13]),
    .backoff(backoff[9][13]),
    .min(min[9][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][13]),
    .F(F[9][13]),
    .inc(inc[9][13]),
    .dec(dec[9][13])
  );


  stdp.v
  s0_14914
  (
    .ein(ein[14]),
    .eout(eout[9]),
    .capture(capture[9][14]),
    .minus(minus[9][14]),
    .search(search[9][14]),
    .backoff(backoff[9][14]),
    .min(min[9][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][14]),
    .F(F[9][14]),
    .inc(inc[9][14]),
    .dec(dec[9][14])
  );


  stdp.v
  s0_15915
  (
    .ein(ein[15]),
    .eout(eout[9]),
    .capture(capture[9][15]),
    .minus(minus[9][15]),
    .search(search[9][15]),
    .backoff(backoff[9][15]),
    .min(min[9][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][15]),
    .F(F[9][15]),
    .inc(inc[9][15]),
    .dec(dec[9][15])
  );


  stdp.v
  s0_16916
  (
    .ein(ein[16]),
    .eout(eout[9]),
    .capture(capture[9][16]),
    .minus(minus[9][16]),
    .search(search[9][16]),
    .backoff(backoff[9][16]),
    .min(min[9][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][16]),
    .F(F[9][16]),
    .inc(inc[9][16]),
    .dec(dec[9][16])
  );


  stdp.v
  s0_17917
  (
    .ein(ein[17]),
    .eout(eout[9]),
    .capture(capture[9][17]),
    .minus(minus[9][17]),
    .search(search[9][17]),
    .backoff(backoff[9][17]),
    .min(min[9][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][17]),
    .F(F[9][17]),
    .inc(inc[9][17]),
    .dec(dec[9][17])
  );


  stdp.v
  s0_18918
  (
    .ein(ein[18]),
    .eout(eout[9]),
    .capture(capture[9][18]),
    .minus(minus[9][18]),
    .search(search[9][18]),
    .backoff(backoff[9][18]),
    .min(min[9][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][18]),
    .F(F[9][18]),
    .inc(inc[9][18]),
    .dec(dec[9][18])
  );


  stdp.v
  s0_19919
  (
    .ein(ein[19]),
    .eout(eout[9]),
    .capture(capture[9][19]),
    .minus(minus[9][19]),
    .search(search[9][19]),
    .backoff(backoff[9][19]),
    .min(min[9][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][19]),
    .F(F[9][19]),
    .inc(inc[9][19]),
    .dec(dec[9][19])
  );


  stdp.v
  s0_20920
  (
    .ein(ein[20]),
    .eout(eout[9]),
    .capture(capture[9][20]),
    .minus(minus[9][20]),
    .search(search[9][20]),
    .backoff(backoff[9][20]),
    .min(min[9][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][20]),
    .F(F[9][20]),
    .inc(inc[9][20]),
    .dec(dec[9][20])
  );


  stdp.v
  s0_21921
  (
    .ein(ein[21]),
    .eout(eout[9]),
    .capture(capture[9][21]),
    .minus(minus[9][21]),
    .search(search[9][21]),
    .backoff(backoff[9][21]),
    .min(min[9][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][21]),
    .F(F[9][21]),
    .inc(inc[9][21]),
    .dec(dec[9][21])
  );


  stdp.v
  s0_22922
  (
    .ein(ein[22]),
    .eout(eout[9]),
    .capture(capture[9][22]),
    .minus(minus[9][22]),
    .search(search[9][22]),
    .backoff(backoff[9][22]),
    .min(min[9][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][22]),
    .F(F[9][22]),
    .inc(inc[9][22]),
    .dec(dec[9][22])
  );


  stdp.v
  s0_23923
  (
    .ein(ein[23]),
    .eout(eout[9]),
    .capture(capture[9][23]),
    .minus(minus[9][23]),
    .search(search[9][23]),
    .backoff(backoff[9][23]),
    .min(min[9][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][23]),
    .F(F[9][23]),
    .inc(inc[9][23]),
    .dec(dec[9][23])
  );


  stdp.v
  s0_24924
  (
    .ein(ein[24]),
    .eout(eout[9]),
    .capture(capture[9][24]),
    .minus(minus[9][24]),
    .search(search[9][24]),
    .backoff(backoff[9][24]),
    .min(min[9][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][24]),
    .F(F[9][24]),
    .inc(inc[9][24]),
    .dec(dec[9][24])
  );


  stdp.v
  s0_25925
  (
    .ein(ein[25]),
    .eout(eout[9]),
    .capture(capture[9][25]),
    .minus(minus[9][25]),
    .search(search[9][25]),
    .backoff(backoff[9][25]),
    .min(min[9][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][25]),
    .F(F[9][25]),
    .inc(inc[9][25]),
    .dec(dec[9][25])
  );


  stdp.v
  s0_26926
  (
    .ein(ein[26]),
    .eout(eout[9]),
    .capture(capture[9][26]),
    .minus(minus[9][26]),
    .search(search[9][26]),
    .backoff(backoff[9][26]),
    .min(min[9][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][26]),
    .F(F[9][26]),
    .inc(inc[9][26]),
    .dec(dec[9][26])
  );


  stdp.v
  s0_27927
  (
    .ein(ein[27]),
    .eout(eout[9]),
    .capture(capture[9][27]),
    .minus(minus[9][27]),
    .search(search[9][27]),
    .backoff(backoff[9][27]),
    .min(min[9][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][27]),
    .F(F[9][27]),
    .inc(inc[9][27]),
    .dec(dec[9][27])
  );


  stdp.v
  s0_28928
  (
    .ein(ein[28]),
    .eout(eout[9]),
    .capture(capture[9][28]),
    .minus(minus[9][28]),
    .search(search[9][28]),
    .backoff(backoff[9][28]),
    .min(min[9][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][28]),
    .F(F[9][28]),
    .inc(inc[9][28]),
    .dec(dec[9][28])
  );


  stdp.v
  s0_29929
  (
    .ein(ein[29]),
    .eout(eout[9]),
    .capture(capture[9][29]),
    .minus(minus[9][29]),
    .search(search[9][29]),
    .backoff(backoff[9][29]),
    .min(min[9][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][29]),
    .F(F[9][29]),
    .inc(inc[9][29]),
    .dec(dec[9][29])
  );


  stdp.v
  s0_30930
  (
    .ein(ein[30]),
    .eout(eout[9]),
    .capture(capture[9][30]),
    .minus(minus[9][30]),
    .search(search[9][30]),
    .backoff(backoff[9][30]),
    .min(min[9][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][30]),
    .F(F[9][30]),
    .inc(inc[9][30]),
    .dec(dec[9][30])
  );


  stdp.v
  s0_31931
  (
    .ein(ein[31]),
    .eout(eout[9]),
    .capture(capture[9][31]),
    .minus(minus[9][31]),
    .search(search[9][31]),
    .backoff(backoff[9][31]),
    .min(min[9][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[9][31]),
    .F(F[9][31]),
    .inc(inc[9][31]),
    .dec(dec[9][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_10
  (
    .input_spikes(aclk),
    .inc(input_spike[10]),
    .dec(gclk_pulse),
    .weight_update_en(ein[10])
  );


  pulse2edge
  out_pe_10
  (
    .aclk(aclk),
    .pulse_in(output_spikes[10]),
    .grst(gclk_pulse),
    .edge_out(eout[10])
  );


  stdp.v
  s0_0100
  (
    .ein(ein[0]),
    .eout(eout[10]),
    .capture(capture[10][0]),
    .minus(minus[10][0]),
    .search(search[10][0]),
    .backoff(backoff[10][0]),
    .min(min[10][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][0]),
    .F(F[10][0]),
    .inc(inc[10][0]),
    .dec(dec[10][0])
  );


  stdp.v
  s0_1101
  (
    .ein(ein[1]),
    .eout(eout[10]),
    .capture(capture[10][1]),
    .minus(minus[10][1]),
    .search(search[10][1]),
    .backoff(backoff[10][1]),
    .min(min[10][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][1]),
    .F(F[10][1]),
    .inc(inc[10][1]),
    .dec(dec[10][1])
  );


  stdp.v
  s0_2102
  (
    .ein(ein[2]),
    .eout(eout[10]),
    .capture(capture[10][2]),
    .minus(minus[10][2]),
    .search(search[10][2]),
    .backoff(backoff[10][2]),
    .min(min[10][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][2]),
    .F(F[10][2]),
    .inc(inc[10][2]),
    .dec(dec[10][2])
  );


  stdp.v
  s0_3103
  (
    .ein(ein[3]),
    .eout(eout[10]),
    .capture(capture[10][3]),
    .minus(minus[10][3]),
    .search(search[10][3]),
    .backoff(backoff[10][3]),
    .min(min[10][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][3]),
    .F(F[10][3]),
    .inc(inc[10][3]),
    .dec(dec[10][3])
  );


  stdp.v
  s0_4104
  (
    .ein(ein[4]),
    .eout(eout[10]),
    .capture(capture[10][4]),
    .minus(minus[10][4]),
    .search(search[10][4]),
    .backoff(backoff[10][4]),
    .min(min[10][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][4]),
    .F(F[10][4]),
    .inc(inc[10][4]),
    .dec(dec[10][4])
  );


  stdp.v
  s0_5105
  (
    .ein(ein[5]),
    .eout(eout[10]),
    .capture(capture[10][5]),
    .minus(minus[10][5]),
    .search(search[10][5]),
    .backoff(backoff[10][5]),
    .min(min[10][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][5]),
    .F(F[10][5]),
    .inc(inc[10][5]),
    .dec(dec[10][5])
  );


  stdp.v
  s0_6106
  (
    .ein(ein[6]),
    .eout(eout[10]),
    .capture(capture[10][6]),
    .minus(minus[10][6]),
    .search(search[10][6]),
    .backoff(backoff[10][6]),
    .min(min[10][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][6]),
    .F(F[10][6]),
    .inc(inc[10][6]),
    .dec(dec[10][6])
  );


  stdp.v
  s0_7107
  (
    .ein(ein[7]),
    .eout(eout[10]),
    .capture(capture[10][7]),
    .minus(minus[10][7]),
    .search(search[10][7]),
    .backoff(backoff[10][7]),
    .min(min[10][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][7]),
    .F(F[10][7]),
    .inc(inc[10][7]),
    .dec(dec[10][7])
  );


  stdp.v
  s0_8108
  (
    .ein(ein[8]),
    .eout(eout[10]),
    .capture(capture[10][8]),
    .minus(minus[10][8]),
    .search(search[10][8]),
    .backoff(backoff[10][8]),
    .min(min[10][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][8]),
    .F(F[10][8]),
    .inc(inc[10][8]),
    .dec(dec[10][8])
  );


  stdp.v
  s0_9109
  (
    .ein(ein[9]),
    .eout(eout[10]),
    .capture(capture[10][9]),
    .minus(minus[10][9]),
    .search(search[10][9]),
    .backoff(backoff[10][9]),
    .min(min[10][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][9]),
    .F(F[10][9]),
    .inc(inc[10][9]),
    .dec(dec[10][9])
  );


  stdp.v
  s0_101010
  (
    .ein(ein[10]),
    .eout(eout[10]),
    .capture(capture[10][10]),
    .minus(minus[10][10]),
    .search(search[10][10]),
    .backoff(backoff[10][10]),
    .min(min[10][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][10]),
    .F(F[10][10]),
    .inc(inc[10][10]),
    .dec(dec[10][10])
  );


  stdp.v
  s0_111011
  (
    .ein(ein[11]),
    .eout(eout[10]),
    .capture(capture[10][11]),
    .minus(minus[10][11]),
    .search(search[10][11]),
    .backoff(backoff[10][11]),
    .min(min[10][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][11]),
    .F(F[10][11]),
    .inc(inc[10][11]),
    .dec(dec[10][11])
  );


  stdp.v
  s0_121012
  (
    .ein(ein[12]),
    .eout(eout[10]),
    .capture(capture[10][12]),
    .minus(minus[10][12]),
    .search(search[10][12]),
    .backoff(backoff[10][12]),
    .min(min[10][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][12]),
    .F(F[10][12]),
    .inc(inc[10][12]),
    .dec(dec[10][12])
  );


  stdp.v
  s0_131013
  (
    .ein(ein[13]),
    .eout(eout[10]),
    .capture(capture[10][13]),
    .minus(minus[10][13]),
    .search(search[10][13]),
    .backoff(backoff[10][13]),
    .min(min[10][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][13]),
    .F(F[10][13]),
    .inc(inc[10][13]),
    .dec(dec[10][13])
  );


  stdp.v
  s0_141014
  (
    .ein(ein[14]),
    .eout(eout[10]),
    .capture(capture[10][14]),
    .minus(minus[10][14]),
    .search(search[10][14]),
    .backoff(backoff[10][14]),
    .min(min[10][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][14]),
    .F(F[10][14]),
    .inc(inc[10][14]),
    .dec(dec[10][14])
  );


  stdp.v
  s0_151015
  (
    .ein(ein[15]),
    .eout(eout[10]),
    .capture(capture[10][15]),
    .minus(minus[10][15]),
    .search(search[10][15]),
    .backoff(backoff[10][15]),
    .min(min[10][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][15]),
    .F(F[10][15]),
    .inc(inc[10][15]),
    .dec(dec[10][15])
  );


  stdp.v
  s0_161016
  (
    .ein(ein[16]),
    .eout(eout[10]),
    .capture(capture[10][16]),
    .minus(minus[10][16]),
    .search(search[10][16]),
    .backoff(backoff[10][16]),
    .min(min[10][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][16]),
    .F(F[10][16]),
    .inc(inc[10][16]),
    .dec(dec[10][16])
  );


  stdp.v
  s0_171017
  (
    .ein(ein[17]),
    .eout(eout[10]),
    .capture(capture[10][17]),
    .minus(minus[10][17]),
    .search(search[10][17]),
    .backoff(backoff[10][17]),
    .min(min[10][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][17]),
    .F(F[10][17]),
    .inc(inc[10][17]),
    .dec(dec[10][17])
  );


  stdp.v
  s0_181018
  (
    .ein(ein[18]),
    .eout(eout[10]),
    .capture(capture[10][18]),
    .minus(minus[10][18]),
    .search(search[10][18]),
    .backoff(backoff[10][18]),
    .min(min[10][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][18]),
    .F(F[10][18]),
    .inc(inc[10][18]),
    .dec(dec[10][18])
  );


  stdp.v
  s0_191019
  (
    .ein(ein[19]),
    .eout(eout[10]),
    .capture(capture[10][19]),
    .minus(minus[10][19]),
    .search(search[10][19]),
    .backoff(backoff[10][19]),
    .min(min[10][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][19]),
    .F(F[10][19]),
    .inc(inc[10][19]),
    .dec(dec[10][19])
  );


  stdp.v
  s0_201020
  (
    .ein(ein[20]),
    .eout(eout[10]),
    .capture(capture[10][20]),
    .minus(minus[10][20]),
    .search(search[10][20]),
    .backoff(backoff[10][20]),
    .min(min[10][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][20]),
    .F(F[10][20]),
    .inc(inc[10][20]),
    .dec(dec[10][20])
  );


  stdp.v
  s0_211021
  (
    .ein(ein[21]),
    .eout(eout[10]),
    .capture(capture[10][21]),
    .minus(minus[10][21]),
    .search(search[10][21]),
    .backoff(backoff[10][21]),
    .min(min[10][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][21]),
    .F(F[10][21]),
    .inc(inc[10][21]),
    .dec(dec[10][21])
  );


  stdp.v
  s0_221022
  (
    .ein(ein[22]),
    .eout(eout[10]),
    .capture(capture[10][22]),
    .minus(minus[10][22]),
    .search(search[10][22]),
    .backoff(backoff[10][22]),
    .min(min[10][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][22]),
    .F(F[10][22]),
    .inc(inc[10][22]),
    .dec(dec[10][22])
  );


  stdp.v
  s0_231023
  (
    .ein(ein[23]),
    .eout(eout[10]),
    .capture(capture[10][23]),
    .minus(minus[10][23]),
    .search(search[10][23]),
    .backoff(backoff[10][23]),
    .min(min[10][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][23]),
    .F(F[10][23]),
    .inc(inc[10][23]),
    .dec(dec[10][23])
  );


  stdp.v
  s0_241024
  (
    .ein(ein[24]),
    .eout(eout[10]),
    .capture(capture[10][24]),
    .minus(minus[10][24]),
    .search(search[10][24]),
    .backoff(backoff[10][24]),
    .min(min[10][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][24]),
    .F(F[10][24]),
    .inc(inc[10][24]),
    .dec(dec[10][24])
  );


  stdp.v
  s0_251025
  (
    .ein(ein[25]),
    .eout(eout[10]),
    .capture(capture[10][25]),
    .minus(minus[10][25]),
    .search(search[10][25]),
    .backoff(backoff[10][25]),
    .min(min[10][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][25]),
    .F(F[10][25]),
    .inc(inc[10][25]),
    .dec(dec[10][25])
  );


  stdp.v
  s0_261026
  (
    .ein(ein[26]),
    .eout(eout[10]),
    .capture(capture[10][26]),
    .minus(minus[10][26]),
    .search(search[10][26]),
    .backoff(backoff[10][26]),
    .min(min[10][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][26]),
    .F(F[10][26]),
    .inc(inc[10][26]),
    .dec(dec[10][26])
  );


  stdp.v
  s0_271027
  (
    .ein(ein[27]),
    .eout(eout[10]),
    .capture(capture[10][27]),
    .minus(minus[10][27]),
    .search(search[10][27]),
    .backoff(backoff[10][27]),
    .min(min[10][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][27]),
    .F(F[10][27]),
    .inc(inc[10][27]),
    .dec(dec[10][27])
  );


  stdp.v
  s0_281028
  (
    .ein(ein[28]),
    .eout(eout[10]),
    .capture(capture[10][28]),
    .minus(minus[10][28]),
    .search(search[10][28]),
    .backoff(backoff[10][28]),
    .min(min[10][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][28]),
    .F(F[10][28]),
    .inc(inc[10][28]),
    .dec(dec[10][28])
  );


  stdp.v
  s0_291029
  (
    .ein(ein[29]),
    .eout(eout[10]),
    .capture(capture[10][29]),
    .minus(minus[10][29]),
    .search(search[10][29]),
    .backoff(backoff[10][29]),
    .min(min[10][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][29]),
    .F(F[10][29]),
    .inc(inc[10][29]),
    .dec(dec[10][29])
  );


  stdp.v
  s0_301030
  (
    .ein(ein[30]),
    .eout(eout[10]),
    .capture(capture[10][30]),
    .minus(minus[10][30]),
    .search(search[10][30]),
    .backoff(backoff[10][30]),
    .min(min[10][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][30]),
    .F(F[10][30]),
    .inc(inc[10][30]),
    .dec(dec[10][30])
  );


  stdp.v
  s0_311031
  (
    .ein(ein[31]),
    .eout(eout[10]),
    .capture(capture[10][31]),
    .minus(minus[10][31]),
    .search(search[10][31]),
    .backoff(backoff[10][31]),
    .min(min[10][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[10][31]),
    .F(F[10][31]),
    .inc(inc[10][31]),
    .dec(dec[10][31])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(32),
    .THRESHOLD(13)
  )
  ec_11
  (
    .input_spikes(aclk),
    .inc(input_spike[11]),
    .dec(gclk_pulse),
    .weight_update_en(ein[11])
  );


  pulse2edge
  out_pe_11
  (
    .aclk(aclk),
    .pulse_in(output_spikes[11]),
    .grst(gclk_pulse),
    .edge_out(eout[11])
  );


  stdp.v
  s0_0110
  (
    .ein(ein[0]),
    .eout(eout[11]),
    .capture(capture[11][0]),
    .minus(minus[11][0]),
    .search(search[11][0]),
    .backoff(backoff[11][0]),
    .min(min[11][0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][0]),
    .F(F[11][0]),
    .inc(inc[11][0]),
    .dec(dec[11][0])
  );


  stdp.v
  s0_1111
  (
    .ein(ein[1]),
    .eout(eout[11]),
    .capture(capture[11][1]),
    .minus(minus[11][1]),
    .search(search[11][1]),
    .backoff(backoff[11][1]),
    .min(min[11][1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][1]),
    .F(F[11][1]),
    .inc(inc[11][1]),
    .dec(dec[11][1])
  );


  stdp.v
  s0_2112
  (
    .ein(ein[2]),
    .eout(eout[11]),
    .capture(capture[11][2]),
    .minus(minus[11][2]),
    .search(search[11][2]),
    .backoff(backoff[11][2]),
    .min(min[11][2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][2]),
    .F(F[11][2]),
    .inc(inc[11][2]),
    .dec(dec[11][2])
  );


  stdp.v
  s0_3113
  (
    .ein(ein[3]),
    .eout(eout[11]),
    .capture(capture[11][3]),
    .minus(minus[11][3]),
    .search(search[11][3]),
    .backoff(backoff[11][3]),
    .min(min[11][3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][3]),
    .F(F[11][3]),
    .inc(inc[11][3]),
    .dec(dec[11][3])
  );


  stdp.v
  s0_4114
  (
    .ein(ein[4]),
    .eout(eout[11]),
    .capture(capture[11][4]),
    .minus(minus[11][4]),
    .search(search[11][4]),
    .backoff(backoff[11][4]),
    .min(min[11][4]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][4]),
    .F(F[11][4]),
    .inc(inc[11][4]),
    .dec(dec[11][4])
  );


  stdp.v
  s0_5115
  (
    .ein(ein[5]),
    .eout(eout[11]),
    .capture(capture[11][5]),
    .minus(minus[11][5]),
    .search(search[11][5]),
    .backoff(backoff[11][5]),
    .min(min[11][5]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][5]),
    .F(F[11][5]),
    .inc(inc[11][5]),
    .dec(dec[11][5])
  );


  stdp.v
  s0_6116
  (
    .ein(ein[6]),
    .eout(eout[11]),
    .capture(capture[11][6]),
    .minus(minus[11][6]),
    .search(search[11][6]),
    .backoff(backoff[11][6]),
    .min(min[11][6]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][6]),
    .F(F[11][6]),
    .inc(inc[11][6]),
    .dec(dec[11][6])
  );


  stdp.v
  s0_7117
  (
    .ein(ein[7]),
    .eout(eout[11]),
    .capture(capture[11][7]),
    .minus(minus[11][7]),
    .search(search[11][7]),
    .backoff(backoff[11][7]),
    .min(min[11][7]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][7]),
    .F(F[11][7]),
    .inc(inc[11][7]),
    .dec(dec[11][7])
  );


  stdp.v
  s0_8118
  (
    .ein(ein[8]),
    .eout(eout[11]),
    .capture(capture[11][8]),
    .minus(minus[11][8]),
    .search(search[11][8]),
    .backoff(backoff[11][8]),
    .min(min[11][8]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][8]),
    .F(F[11][8]),
    .inc(inc[11][8]),
    .dec(dec[11][8])
  );


  stdp.v
  s0_9119
  (
    .ein(ein[9]),
    .eout(eout[11]),
    .capture(capture[11][9]),
    .minus(minus[11][9]),
    .search(search[11][9]),
    .backoff(backoff[11][9]),
    .min(min[11][9]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][9]),
    .F(F[11][9]),
    .inc(inc[11][9]),
    .dec(dec[11][9])
  );


  stdp.v
  s0_101110
  (
    .ein(ein[10]),
    .eout(eout[11]),
    .capture(capture[11][10]),
    .minus(minus[11][10]),
    .search(search[11][10]),
    .backoff(backoff[11][10]),
    .min(min[11][10]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][10]),
    .F(F[11][10]),
    .inc(inc[11][10]),
    .dec(dec[11][10])
  );


  stdp.v
  s0_111111
  (
    .ein(ein[11]),
    .eout(eout[11]),
    .capture(capture[11][11]),
    .minus(minus[11][11]),
    .search(search[11][11]),
    .backoff(backoff[11][11]),
    .min(min[11][11]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][11]),
    .F(F[11][11]),
    .inc(inc[11][11]),
    .dec(dec[11][11])
  );


  stdp.v
  s0_121112
  (
    .ein(ein[12]),
    .eout(eout[11]),
    .capture(capture[11][12]),
    .minus(minus[11][12]),
    .search(search[11][12]),
    .backoff(backoff[11][12]),
    .min(min[11][12]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][12]),
    .F(F[11][12]),
    .inc(inc[11][12]),
    .dec(dec[11][12])
  );


  stdp.v
  s0_131113
  (
    .ein(ein[13]),
    .eout(eout[11]),
    .capture(capture[11][13]),
    .minus(minus[11][13]),
    .search(search[11][13]),
    .backoff(backoff[11][13]),
    .min(min[11][13]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][13]),
    .F(F[11][13]),
    .inc(inc[11][13]),
    .dec(dec[11][13])
  );


  stdp.v
  s0_141114
  (
    .ein(ein[14]),
    .eout(eout[11]),
    .capture(capture[11][14]),
    .minus(minus[11][14]),
    .search(search[11][14]),
    .backoff(backoff[11][14]),
    .min(min[11][14]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][14]),
    .F(F[11][14]),
    .inc(inc[11][14]),
    .dec(dec[11][14])
  );


  stdp.v
  s0_151115
  (
    .ein(ein[15]),
    .eout(eout[11]),
    .capture(capture[11][15]),
    .minus(minus[11][15]),
    .search(search[11][15]),
    .backoff(backoff[11][15]),
    .min(min[11][15]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][15]),
    .F(F[11][15]),
    .inc(inc[11][15]),
    .dec(dec[11][15])
  );


  stdp.v
  s0_161116
  (
    .ein(ein[16]),
    .eout(eout[11]),
    .capture(capture[11][16]),
    .minus(minus[11][16]),
    .search(search[11][16]),
    .backoff(backoff[11][16]),
    .min(min[11][16]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][16]),
    .F(F[11][16]),
    .inc(inc[11][16]),
    .dec(dec[11][16])
  );


  stdp.v
  s0_171117
  (
    .ein(ein[17]),
    .eout(eout[11]),
    .capture(capture[11][17]),
    .minus(minus[11][17]),
    .search(search[11][17]),
    .backoff(backoff[11][17]),
    .min(min[11][17]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][17]),
    .F(F[11][17]),
    .inc(inc[11][17]),
    .dec(dec[11][17])
  );


  stdp.v
  s0_181118
  (
    .ein(ein[18]),
    .eout(eout[11]),
    .capture(capture[11][18]),
    .minus(minus[11][18]),
    .search(search[11][18]),
    .backoff(backoff[11][18]),
    .min(min[11][18]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][18]),
    .F(F[11][18]),
    .inc(inc[11][18]),
    .dec(dec[11][18])
  );


  stdp.v
  s0_191119
  (
    .ein(ein[19]),
    .eout(eout[11]),
    .capture(capture[11][19]),
    .minus(minus[11][19]),
    .search(search[11][19]),
    .backoff(backoff[11][19]),
    .min(min[11][19]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][19]),
    .F(F[11][19]),
    .inc(inc[11][19]),
    .dec(dec[11][19])
  );


  stdp.v
  s0_201120
  (
    .ein(ein[20]),
    .eout(eout[11]),
    .capture(capture[11][20]),
    .minus(minus[11][20]),
    .search(search[11][20]),
    .backoff(backoff[11][20]),
    .min(min[11][20]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][20]),
    .F(F[11][20]),
    .inc(inc[11][20]),
    .dec(dec[11][20])
  );


  stdp.v
  s0_211121
  (
    .ein(ein[21]),
    .eout(eout[11]),
    .capture(capture[11][21]),
    .minus(minus[11][21]),
    .search(search[11][21]),
    .backoff(backoff[11][21]),
    .min(min[11][21]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][21]),
    .F(F[11][21]),
    .inc(inc[11][21]),
    .dec(dec[11][21])
  );


  stdp.v
  s0_221122
  (
    .ein(ein[22]),
    .eout(eout[11]),
    .capture(capture[11][22]),
    .minus(minus[11][22]),
    .search(search[11][22]),
    .backoff(backoff[11][22]),
    .min(min[11][22]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][22]),
    .F(F[11][22]),
    .inc(inc[11][22]),
    .dec(dec[11][22])
  );


  stdp.v
  s0_231123
  (
    .ein(ein[23]),
    .eout(eout[11]),
    .capture(capture[11][23]),
    .minus(minus[11][23]),
    .search(search[11][23]),
    .backoff(backoff[11][23]),
    .min(min[11][23]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][23]),
    .F(F[11][23]),
    .inc(inc[11][23]),
    .dec(dec[11][23])
  );


  stdp.v
  s0_241124
  (
    .ein(ein[24]),
    .eout(eout[11]),
    .capture(capture[11][24]),
    .minus(minus[11][24]),
    .search(search[11][24]),
    .backoff(backoff[11][24]),
    .min(min[11][24]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][24]),
    .F(F[11][24]),
    .inc(inc[11][24]),
    .dec(dec[11][24])
  );


  stdp.v
  s0_251125
  (
    .ein(ein[25]),
    .eout(eout[11]),
    .capture(capture[11][25]),
    .minus(minus[11][25]),
    .search(search[11][25]),
    .backoff(backoff[11][25]),
    .min(min[11][25]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][25]),
    .F(F[11][25]),
    .inc(inc[11][25]),
    .dec(dec[11][25])
  );


  stdp.v
  s0_261126
  (
    .ein(ein[26]),
    .eout(eout[11]),
    .capture(capture[11][26]),
    .minus(minus[11][26]),
    .search(search[11][26]),
    .backoff(backoff[11][26]),
    .min(min[11][26]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][26]),
    .F(F[11][26]),
    .inc(inc[11][26]),
    .dec(dec[11][26])
  );


  stdp.v
  s0_271127
  (
    .ein(ein[27]),
    .eout(eout[11]),
    .capture(capture[11][27]),
    .minus(minus[11][27]),
    .search(search[11][27]),
    .backoff(backoff[11][27]),
    .min(min[11][27]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][27]),
    .F(F[11][27]),
    .inc(inc[11][27]),
    .dec(dec[11][27])
  );


  stdp.v
  s0_281128
  (
    .ein(ein[28]),
    .eout(eout[11]),
    .capture(capture[11][28]),
    .minus(minus[11][28]),
    .search(search[11][28]),
    .backoff(backoff[11][28]),
    .min(min[11][28]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][28]),
    .F(F[11][28]),
    .inc(inc[11][28]),
    .dec(dec[11][28])
  );


  stdp.v
  s0_291129
  (
    .ein(ein[29]),
    .eout(eout[11]),
    .capture(capture[11][29]),
    .minus(minus[11][29]),
    .search(search[11][29]),
    .backoff(backoff[11][29]),
    .min(min[11][29]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][29]),
    .F(F[11][29]),
    .inc(inc[11][29]),
    .dec(dec[11][29])
  );


  stdp.v
  s0_301130
  (
    .ein(ein[30]),
    .eout(eout[11]),
    .capture(capture[11][30]),
    .minus(minus[11][30]),
    .search(search[11][30]),
    .backoff(backoff[11][30]),
    .min(min[11][30]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][30]),
    .F(F[11][30]),
    .inc(inc[11][30]),
    .dec(dec[11][30])
  );


  stdp.v
  s0_311131
  (
    .ein(ein[31]),
    .eout(eout[11]),
    .capture(capture[11][31]),
    .minus(minus[11][31]),
    .search(search[11][31]),
    .backoff(backoff[11][31]),
    .min(min[11][31]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights[11][31]),
    .F(F[11][31]),
    .inc(inc[11][31]),
    .dec(dec[11][31])
  );


  wta
  #(
    .Q(12)
  )
  li
  (
    .ec_spikes(ec_spikes),
    .aclk(aclk),
    .grst(gclk_pulse),
    .li_out(output_spikes)
  );


endmodule



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



module stdp.v
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
    .F(F),
    .inc(inc),
    .dec(dec)
  );


endmodule



module flogic
(
  input [6-1:0] F,
  input [3-1:0] input_weight,
  output [1-1:0] out
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


  less_equal
  l1_0
  (
    .data_in(ec_spikes[0]),
    .inhibit_in(first_spike_edge[0]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[0])
  );


  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike_edge[1]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[1])
  );


  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike_edge[2]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[2])
  );


  less_equal
  l1_3
  (
    .data_in(ec_spikes[3]),
    .inhibit_in(first_spike_edge[3]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[3])
  );


  less_equal
  l1_4
  (
    .data_in(ec_spikes[4]),
    .inhibit_in(first_spike_edge[4]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[4])
  );


  less_equal
  l1_5
  (
    .data_in(ec_spikes[5]),
    .inhibit_in(first_spike_edge[5]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[5])
  );


  less_equal
  l1_6
  (
    .data_in(ec_spikes[6]),
    .inhibit_in(first_spike_edge[6]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[6])
  );


  less_equal
  l1_7
  (
    .data_in(ec_spikes[7]),
    .inhibit_in(first_spike_edge[7]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[7])
  );


  less_equal
  l1_8
  (
    .data_in(ec_spikes[8]),
    .inhibit_in(first_spike_edge[8]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[8])
  );


  less_equal
  l1_9
  (
    .data_in(ec_spikes[9]),
    .inhibit_in(first_spike_edge[9]),
    .aclk(aclk),
    .rst(grst),
    .out(temp[9])
  );


endmodule



module less_equal
(
  input [1-1:0] data_in,
  input [1-1:0] inhibit_in,
  input [1-1:0] aclk,
  input [1-1:0] rst,
  output [1-1:0] out,
  input [1-1:0] pulse_in,
  input [1-1:0] grst,
  output [1-1:0] edge_out
);

  wire [1-1:0] temp1;
  wire [1-1:0] temp2;
  assign temp1 = ~data_in & inhibit_in;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(temp1),
    .grst(rst),
    .edge_out(temp2)
  );

  assign out = data_in & ~temp2;

endmodule

