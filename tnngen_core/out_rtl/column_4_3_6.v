

module column_4_6_13 #
(
  parameter P_DIST = 4,
  parameter P_PROX = 3,
  parameter Q = 6,
  parameter THRESHOLD = 13
)
(
  input [4-1:0] input_spikes_dist,
  input [3-1:0] input_spikes_prox,
  input [3-1:0] w_init_dist_0_0,
  input [3-1:0] w_init_dist_0_1,
  input [3-1:0] w_init_dist_0_2,
  input [3-1:0] w_init_dist_0_3,
  input [4-1:0] capture_brv_dist_0,
  input [4-1:0] minus_brv_dist0,
  input [4-1:0] search_brv_dist0,
  input [4-1:0] backoff_brv_dist0,
  input [4-1:0] min_brv_dist0,
  input [6-1:0] F_brv_dist0,
  input [3-1:0] w_init_dist_1_0,
  input [3-1:0] w_init_dist_1_1,
  input [3-1:0] w_init_dist_1_2,
  input [3-1:0] w_init_dist_1_3,
  input [4-1:0] capture_brv_dist_1,
  input [4-1:0] minus_brv_dist1,
  input [4-1:0] search_brv_dist1,
  input [4-1:0] backoff_brv_dist1,
  input [4-1:0] min_brv_dist1,
  input [6-1:0] F_brv_dist1,
  input [3-1:0] w_init_dist_2_0,
  input [3-1:0] w_init_dist_2_1,
  input [3-1:0] w_init_dist_2_2,
  input [3-1:0] w_init_dist_2_3,
  input [4-1:0] capture_brv_dist_2,
  input [4-1:0] minus_brv_dist2,
  input [4-1:0] search_brv_dist2,
  input [4-1:0] backoff_brv_dist2,
  input [4-1:0] min_brv_dist2,
  input [6-1:0] F_brv_dist2,
  input [3-1:0] w_init_dist_3_0,
  input [3-1:0] w_init_dist_3_1,
  input [3-1:0] w_init_dist_3_2,
  input [3-1:0] w_init_dist_3_3,
  input [4-1:0] capture_brv_dist_3,
  input [4-1:0] minus_brv_dist3,
  input [4-1:0] search_brv_dist3,
  input [4-1:0] backoff_brv_dist3,
  input [4-1:0] min_brv_dist3,
  input [6-1:0] F_brv_dist3,
  input [3-1:0] w_init_dist_4_0,
  input [3-1:0] w_init_dist_4_1,
  input [3-1:0] w_init_dist_4_2,
  input [3-1:0] w_init_dist_4_3,
  input [4-1:0] capture_brv_dist_4,
  input [4-1:0] minus_brv_dist4,
  input [4-1:0] search_brv_dist4,
  input [4-1:0] backoff_brv_dist4,
  input [4-1:0] min_brv_dist4,
  input [6-1:0] F_brv_dist4,
  input [3-1:0] w_init_dist_5_0,
  input [3-1:0] w_init_dist_5_1,
  input [3-1:0] w_init_dist_5_2,
  input [3-1:0] w_init_dist_5_3,
  input [4-1:0] capture_brv_dist_5,
  input [4-1:0] minus_brv_dist5,
  input [4-1:0] search_brv_dist5,
  input [4-1:0] backoff_brv_dist5,
  input [4-1:0] min_brv_dist5,
  input [6-1:0] F_brv_dist5,
  input [3-1:0] w_init_prox_0_0,
  input [3-1:0] w_init_prox_0_1,
  input [3-1:0] w_init_prox_0_2,
  input [3-1:0] capture_brv_prox_0,
  input [3-1:0] minus_brv_prox0,
  input [3-1:0] search_brv_prox0,
  input [3-1:0] backoff_brv_prox0,
  input [3-1:0] min_brv_prox0,
  input [6-1:0] F_brv_prox0,
  input [3-1:0] w_init_prox_1_0,
  input [3-1:0] w_init_prox_1_1,
  input [3-1:0] w_init_prox_1_2,
  input [3-1:0] capture_brv_prox_1,
  input [3-1:0] minus_brv_prox1,
  input [3-1:0] search_brv_prox1,
  input [3-1:0] backoff_brv_prox1,
  input [3-1:0] min_brv_prox1,
  input [6-1:0] F_brv_prox1,
  input [3-1:0] w_init_prox_2_0,
  input [3-1:0] w_init_prox_2_1,
  input [3-1:0] w_init_prox_2_2,
  input [3-1:0] capture_brv_prox_2,
  input [3-1:0] minus_brv_prox2,
  input [3-1:0] search_brv_prox2,
  input [3-1:0] backoff_brv_prox2,
  input [3-1:0] min_brv_prox2,
  input [6-1:0] F_brv_prox2,
  input [3-1:0] w_init_prox_3_0,
  input [3-1:0] w_init_prox_3_1,
  input [3-1:0] w_init_prox_3_2,
  input [3-1:0] capture_brv_prox_3,
  input [3-1:0] minus_brv_prox3,
  input [3-1:0] search_brv_prox3,
  input [3-1:0] backoff_brv_prox3,
  input [3-1:0] min_brv_prox3,
  input [6-1:0] F_brv_prox3,
  input [3-1:0] w_init_prox_4_0,
  input [3-1:0] w_init_prox_4_1,
  input [3-1:0] w_init_prox_4_2,
  input [3-1:0] capture_brv_prox_4,
  input [3-1:0] minus_brv_prox4,
  input [3-1:0] search_brv_prox4,
  input [3-1:0] backoff_brv_prox4,
  input [3-1:0] min_brv_prox4,
  input [6-1:0] F_brv_prox4,
  input [3-1:0] w_init_prox_5_0,
  input [3-1:0] w_init_prox_5_1,
  input [3-1:0] w_init_prox_5_2,
  input [3-1:0] capture_brv_prox_5,
  input [3-1:0] minus_brv_prox5,
  input [3-1:0] search_brv_prox5,
  input [3-1:0] backoff_brv_prox5,
  input [3-1:0] min_brv_prox5,
  input [6-1:0] F_brv_prox5,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] output_spike
);

  localparam WRES_DIST = 3;
  localparam WRES_PROX = 3;
  wire [4-1:0] ein_dist;
  wire [3-1:0] ein_prox;
  wire [6-1:0] eout;
  wire [6-1:0] ec_spikes;
  wire [6-1:0] li_spikes;
  wire [4-1:0] inc_dist_0;
  wire [4-1:0] dec_dist_0;
  wire [3-1:0] weights_dist_0_0;
  wire [3-1:0] weights_dist_0_1;
  wire [3-1:0] weights_dist_0_2;
  wire [3-1:0] weights_dist_0_3;
  wire [4-1:0] inc_dist_1;
  wire [4-1:0] dec_dist_1;
  wire [3-1:0] weights_dist_1_0;
  wire [3-1:0] weights_dist_1_1;
  wire [3-1:0] weights_dist_1_2;
  wire [3-1:0] weights_dist_1_3;
  wire [4-1:0] inc_dist_2;
  wire [4-1:0] dec_dist_2;
  wire [3-1:0] weights_dist_2_0;
  wire [3-1:0] weights_dist_2_1;
  wire [3-1:0] weights_dist_2_2;
  wire [3-1:0] weights_dist_2_3;
  wire [4-1:0] inc_dist_3;
  wire [4-1:0] dec_dist_3;
  wire [3-1:0] weights_dist_3_0;
  wire [3-1:0] weights_dist_3_1;
  wire [3-1:0] weights_dist_3_2;
  wire [3-1:0] weights_dist_3_3;
  wire [4-1:0] inc_dist_4;
  wire [4-1:0] dec_dist_4;
  wire [3-1:0] weights_dist_4_0;
  wire [3-1:0] weights_dist_4_1;
  wire [3-1:0] weights_dist_4_2;
  wire [3-1:0] weights_dist_4_3;
  wire [4-1:0] inc_dist_5;
  wire [4-1:0] dec_dist_5;
  wire [3-1:0] weights_dist_5_0;
  wire [3-1:0] weights_dist_5_1;
  wire [3-1:0] weights_dist_5_2;
  wire [3-1:0] weights_dist_5_3;
  wire [3-1:0] inc_prox_0;
  wire [3-1:0] dec_prox_0;
  wire [3-1:0] weights_prox_0_0;
  wire [3-1:0] weights_prox_0_1;
  wire [3-1:0] weights_prox_0_2;
  wire [3-1:0] inc_prox_1;
  wire [3-1:0] dec_prox_1;
  wire [3-1:0] weights_prox_1_0;
  wire [3-1:0] weights_prox_1_1;
  wire [3-1:0] weights_prox_1_2;
  wire [3-1:0] inc_prox_2;
  wire [3-1:0] dec_prox_2;
  wire [3-1:0] weights_prox_2_0;
  wire [3-1:0] weights_prox_2_1;
  wire [3-1:0] weights_prox_2_2;
  wire [3-1:0] inc_prox_3;
  wire [3-1:0] dec_prox_3;
  wire [3-1:0] weights_prox_3_0;
  wire [3-1:0] weights_prox_3_1;
  wire [3-1:0] weights_prox_3_2;
  wire [3-1:0] inc_prox_4;
  wire [3-1:0] dec_prox_4;
  wire [3-1:0] weights_prox_4_0;
  wire [3-1:0] weights_prox_4_1;
  wire [3-1:0] weights_prox_4_2;
  wire [3-1:0] inc_prox_5;
  wire [3-1:0] dec_prox_5;
  wire [3-1:0] weights_prox_5_0;
  wire [3-1:0] weights_prox_5_1;
  wire [3-1:0] weights_prox_5_2;

  pulse2edge
  pe_in_dist_0
  (
    .aclk(clk),
    .pulse_in(input_spikes_dist[0]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_dist[0])
  );


  pulse2edge
  pe_in_dist_1
  (
    .aclk(clk),
    .pulse_in(input_spikes_dist[1]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_dist[1])
  );


  pulse2edge
  pe_in_dist_2
  (
    .aclk(clk),
    .pulse_in(input_spikes_dist[2]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_dist[2])
  );


  pulse2edge
  pe_in_dist_3
  (
    .aclk(clk),
    .pulse_in(input_spikes_dist[3]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_dist[3])
  );


  pulse2edge_
  pe_in_prox_0
  (
    .aclk(clk),
    .pulse_in(input_spikes_prox[0]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_prox[0])
  );


  pulse2edge_
  pe_in_prox_1
  (
    .aclk(clk),
    .pulse_in(input_spikes_prox[1]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_prox[1])
  );


  pulse2edge_
  pe_in_prox_2
  (
    .aclk(clk),
    .pulse_in(input_spikes_prox[2]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_prox[2])
  );


  segment
  #(
    .INP_DIST(4),
    .INP_PROX(3),
    .WRES_DIST(3),
    .WRES_PROX(3),
    .THRESHOLD(13)
  )
  ec_0
  (
    .input_spikes_dist(input_spikes_dist),
    .input_spikes_prox(input_spikes_prox),
    .inc_dist(inc_dist_0),
    .inc_prox(inc_prox_0),
    .dec_dist(dec_dist_0),
    .dec_prox(dec_prox_0),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[0]),
    .w_init_dist_0(w_init_dist_0_0),
    .w_init_dist_1(w_init_prox_0_0),
    .w_init_dist_2(weights_dist_0_0),
    .w_init_dist_3(weights_prox_0_0)
  );


  segment
  #(
    .INP_DIST(4),
    .INP_PROX(3),
    .WRES_DIST(3),
    .WRES_PROX(3),
    .THRESHOLD(13)
  )
  ec_1
  (
    .input_spikes_dist(input_spikes_dist),
    .input_spikes_prox(input_spikes_prox),
    .inc_dist(inc_dist_1),
    .inc_prox(inc_prox_1),
    .dec_dist(dec_dist_1),
    .dec_prox(dec_prox_1),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[1]),
    .w_init_dist_0(w_init_dist_0_1),
    .w_init_dist_1(w_init_prox_0_1),
    .w_init_dist_2(weights_dist_0_1),
    .w_init_dist_3(weights_prox_0_1)
  );


  segment
  #(
    .INP_DIST(4),
    .INP_PROX(3),
    .WRES_DIST(3),
    .WRES_PROX(3),
    .THRESHOLD(13)
  )
  ec_2
  (
    .input_spikes_dist(input_spikes_dist),
    .input_spikes_prox(input_spikes_prox),
    .inc_dist(inc_dist_2),
    .inc_prox(inc_prox_2),
    .dec_dist(dec_dist_2),
    .dec_prox(dec_prox_2),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[2]),
    .w_init_dist_0(w_init_dist_0_2),
    .w_init_dist_1(w_init_prox_0_2),
    .w_init_dist_2(weights_dist_0_2),
    .w_init_dist_3(weights_prox_0_2)
  );


  segment
  #(
    .INP_DIST(4),
    .INP_PROX(3),
    .WRES_DIST(3),
    .WRES_PROX(3),
    .THRESHOLD(13)
  )
  ec_3
  (
    .input_spikes_dist(input_spikes_dist),
    .input_spikes_prox(input_spikes_prox),
    .inc_dist(inc_dist_3),
    .inc_prox(inc_prox_3),
    .dec_dist(dec_dist_3),
    .dec_prox(dec_prox_3),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[3]),
    .w_init_dist_0(w_init_dist_0_3),
    .w_init_dist_1(w_init_prox_1_0),
    .w_init_dist_2(weights_dist_0_3),
    .w_init_dist_3(weights_prox_1_0)
  );


  segment
  #(
    .INP_DIST(4),
    .INP_PROX(3),
    .WRES_DIST(3),
    .WRES_PROX(3),
    .THRESHOLD(13)
  )
  ec_4
  (
    .input_spikes_dist(input_spikes_dist),
    .input_spikes_prox(input_spikes_prox),
    .inc_dist(inc_dist_4),
    .inc_prox(inc_prox_4),
    .dec_dist(dec_dist_4),
    .dec_prox(dec_prox_4),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[4]),
    .w_init_dist_0(w_init_dist_1_0),
    .w_init_dist_1(w_init_prox_1_1),
    .w_init_dist_2(weights_dist_1_0),
    .w_init_dist_3(weights_prox_1_1)
  );


  segment
  #(
    .INP_DIST(4),
    .INP_PROX(3),
    .WRES_DIST(3),
    .WRES_PROX(3),
    .THRESHOLD(13)
  )
  ec_5
  (
    .input_spikes_dist(input_spikes_dist),
    .input_spikes_prox(input_spikes_prox),
    .inc_dist(inc_dist_5),
    .inc_prox(inc_prox_5),
    .dec_dist(dec_dist_5),
    .dec_prox(dec_prox_5),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[5]),
    .w_init_dist_0(w_init_dist_1_1),
    .w_init_dist_1(w_init_prox_1_2),
    .w_init_dist_2(weights_dist_1_1),
    .w_init_dist_3(weights_prox_1_2)
  );


  wta
  #(
    .Q(6)
  )
  li
  (
    .ec_spikes(ec_spikes),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .li_out(output_spike)
  );


  pulse2edge_
  pe_out_0
  (
    .aclk(clk),
    .pulse_in(output_spike[0]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[0])
  );


  pulse2edge_
  pe_out_1
  (
    .aclk(clk),
    .pulse_in(output_spike[1]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[1])
  );


  pulse2edge_
  pe_out_2
  (
    .aclk(clk),
    .pulse_in(output_spike[2]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[2])
  );


  pulse2edge_
  pe_out_3
  (
    .aclk(clk),
    .pulse_in(output_spike[3]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[3])
  );


  pulse2edge_
  pe_out_4
  (
    .aclk(clk),
    .pulse_in(output_spike[4]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[4])
  );


  pulse2edge_
  pe_out_5
  (
    .aclk(clk),
    .pulse_in(output_spike[5]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[5])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_0_0
  (
    .input_weight(weights_dist_0_0),
    .ein(ein_dist[0]),
    .eout(eout[0]),
    .capture(capture_brv_dist_0[0]),
    .minus(minus_brv_dist0[0]),
    .search(search_brv_dist0[0]),
    .backoff(backoff_brv_dist0[0]),
    .min(min_brv_dist0[0]),
    .F(F_brv_dist0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_0[0]),
    .dec(dec_dist_0[0])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_0_1
  (
    .input_weight(weights_dist_0_1),
    .ein(ein_dist[1]),
    .eout(eout[0]),
    .capture(capture_brv_dist_0[1]),
    .minus(minus_brv_dist0[1]),
    .search(search_brv_dist0[1]),
    .backoff(backoff_brv_dist0[1]),
    .min(min_brv_dist0[1]),
    .F(F_brv_dist0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_0[1]),
    .dec(dec_dist_0[1])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_0_2
  (
    .input_weight(weights_dist_0_2),
    .ein(ein_dist[2]),
    .eout(eout[0]),
    .capture(capture_brv_dist_0[2]),
    .minus(minus_brv_dist0[2]),
    .search(search_brv_dist0[2]),
    .backoff(backoff_brv_dist0[2]),
    .min(min_brv_dist0[2]),
    .F(F_brv_dist0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_0[2]),
    .dec(dec_dist_0[2])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_0_3
  (
    .input_weight(weights_dist_0_3),
    .ein(ein_dist[3]),
    .eout(eout[0]),
    .capture(capture_brv_dist_0[3]),
    .minus(minus_brv_dist0[3]),
    .search(search_brv_dist0[3]),
    .backoff(backoff_brv_dist0[3]),
    .min(min_brv_dist0[3]),
    .F(F_brv_dist0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_0[3]),
    .dec(dec_dist_0[3])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_1_0
  (
    .input_weight(weights_dist_1_0),
    .ein(ein_dist[0]),
    .eout(eout[1]),
    .capture(capture_brv_dist_1[0]),
    .minus(minus_brv_dist1[0]),
    .search(search_brv_dist1[0]),
    .backoff(backoff_brv_dist1[0]),
    .min(min_brv_dist1[0]),
    .F(F_brv_dist1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_1[0]),
    .dec(dec_dist_1[0])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_1_1
  (
    .input_weight(weights_dist_1_1),
    .ein(ein_dist[1]),
    .eout(eout[1]),
    .capture(capture_brv_dist_1[1]),
    .minus(minus_brv_dist1[1]),
    .search(search_brv_dist1[1]),
    .backoff(backoff_brv_dist1[1]),
    .min(min_brv_dist1[1]),
    .F(F_brv_dist1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_1[1]),
    .dec(dec_dist_1[1])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_1_2
  (
    .input_weight(weights_dist_1_2),
    .ein(ein_dist[2]),
    .eout(eout[1]),
    .capture(capture_brv_dist_1[2]),
    .minus(minus_brv_dist1[2]),
    .search(search_brv_dist1[2]),
    .backoff(backoff_brv_dist1[2]),
    .min(min_brv_dist1[2]),
    .F(F_brv_dist1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_1[2]),
    .dec(dec_dist_1[2])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_1_3
  (
    .input_weight(weights_dist_1_3),
    .ein(ein_dist[3]),
    .eout(eout[1]),
    .capture(capture_brv_dist_1[3]),
    .minus(minus_brv_dist1[3]),
    .search(search_brv_dist1[3]),
    .backoff(backoff_brv_dist1[3]),
    .min(min_brv_dist1[3]),
    .F(F_brv_dist1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_1[3]),
    .dec(dec_dist_1[3])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_2_0
  (
    .input_weight(weights_dist_2_0),
    .ein(ein_dist[0]),
    .eout(eout[2]),
    .capture(capture_brv_dist_2[0]),
    .minus(minus_brv_dist2[0]),
    .search(search_brv_dist2[0]),
    .backoff(backoff_brv_dist2[0]),
    .min(min_brv_dist2[0]),
    .F(F_brv_dist2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_2[0]),
    .dec(dec_dist_2[0])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_2_1
  (
    .input_weight(weights_dist_2_1),
    .ein(ein_dist[1]),
    .eout(eout[2]),
    .capture(capture_brv_dist_2[1]),
    .minus(minus_brv_dist2[1]),
    .search(search_brv_dist2[1]),
    .backoff(backoff_brv_dist2[1]),
    .min(min_brv_dist2[1]),
    .F(F_brv_dist2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_2[1]),
    .dec(dec_dist_2[1])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_2_2
  (
    .input_weight(weights_dist_2_2),
    .ein(ein_dist[2]),
    .eout(eout[2]),
    .capture(capture_brv_dist_2[2]),
    .minus(minus_brv_dist2[2]),
    .search(search_brv_dist2[2]),
    .backoff(backoff_brv_dist2[2]),
    .min(min_brv_dist2[2]),
    .F(F_brv_dist2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_2[2]),
    .dec(dec_dist_2[2])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_2_3
  (
    .input_weight(weights_dist_2_3),
    .ein(ein_dist[3]),
    .eout(eout[2]),
    .capture(capture_brv_dist_2[3]),
    .minus(minus_brv_dist2[3]),
    .search(search_brv_dist2[3]),
    .backoff(backoff_brv_dist2[3]),
    .min(min_brv_dist2[3]),
    .F(F_brv_dist2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_2[3]),
    .dec(dec_dist_2[3])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_3_0
  (
    .input_weight(weights_dist_3_0),
    .ein(ein_dist[0]),
    .eout(eout[3]),
    .capture(capture_brv_dist_3[0]),
    .minus(minus_brv_dist3[0]),
    .search(search_brv_dist3[0]),
    .backoff(backoff_brv_dist3[0]),
    .min(min_brv_dist3[0]),
    .F(F_brv_dist3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_3[0]),
    .dec(dec_dist_3[0])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_3_1
  (
    .input_weight(weights_dist_3_1),
    .ein(ein_dist[1]),
    .eout(eout[3]),
    .capture(capture_brv_dist_3[1]),
    .minus(minus_brv_dist3[1]),
    .search(search_brv_dist3[1]),
    .backoff(backoff_brv_dist3[1]),
    .min(min_brv_dist3[1]),
    .F(F_brv_dist3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_3[1]),
    .dec(dec_dist_3[1])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_3_2
  (
    .input_weight(weights_dist_3_2),
    .ein(ein_dist[2]),
    .eout(eout[3]),
    .capture(capture_brv_dist_3[2]),
    .minus(minus_brv_dist3[2]),
    .search(search_brv_dist3[2]),
    .backoff(backoff_brv_dist3[2]),
    .min(min_brv_dist3[2]),
    .F(F_brv_dist3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_3[2]),
    .dec(dec_dist_3[2])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_3_3
  (
    .input_weight(weights_dist_3_3),
    .ein(ein_dist[3]),
    .eout(eout[3]),
    .capture(capture_brv_dist_3[3]),
    .minus(minus_brv_dist3[3]),
    .search(search_brv_dist3[3]),
    .backoff(backoff_brv_dist3[3]),
    .min(min_brv_dist3[3]),
    .F(F_brv_dist3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_3[3]),
    .dec(dec_dist_3[3])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_4_0
  (
    .input_weight(weights_dist_4_0),
    .ein(ein_dist[0]),
    .eout(eout[4]),
    .capture(capture_brv_dist_4[0]),
    .minus(minus_brv_dist4[0]),
    .search(search_brv_dist4[0]),
    .backoff(backoff_brv_dist4[0]),
    .min(min_brv_dist4[0]),
    .F(F_brv_dist4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_4[0]),
    .dec(dec_dist_4[0])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_4_1
  (
    .input_weight(weights_dist_4_1),
    .ein(ein_dist[1]),
    .eout(eout[4]),
    .capture(capture_brv_dist_4[1]),
    .minus(minus_brv_dist4[1]),
    .search(search_brv_dist4[1]),
    .backoff(backoff_brv_dist4[1]),
    .min(min_brv_dist4[1]),
    .F(F_brv_dist4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_4[1]),
    .dec(dec_dist_4[1])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_4_2
  (
    .input_weight(weights_dist_4_2),
    .ein(ein_dist[2]),
    .eout(eout[4]),
    .capture(capture_brv_dist_4[2]),
    .minus(minus_brv_dist4[2]),
    .search(search_brv_dist4[2]),
    .backoff(backoff_brv_dist4[2]),
    .min(min_brv_dist4[2]),
    .F(F_brv_dist4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_4[2]),
    .dec(dec_dist_4[2])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_4_3
  (
    .input_weight(weights_dist_4_3),
    .ein(ein_dist[3]),
    .eout(eout[4]),
    .capture(capture_brv_dist_4[3]),
    .minus(minus_brv_dist4[3]),
    .search(search_brv_dist4[3]),
    .backoff(backoff_brv_dist4[3]),
    .min(min_brv_dist4[3]),
    .F(F_brv_dist4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_4[3]),
    .dec(dec_dist_4[3])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_5_0
  (
    .input_weight(weights_dist_5_0),
    .ein(ein_dist[0]),
    .eout(eout[5]),
    .capture(capture_brv_dist_5[0]),
    .minus(minus_brv_dist5[0]),
    .search(search_brv_dist5[0]),
    .backoff(backoff_brv_dist5[0]),
    .min(min_brv_dist5[0]),
    .F(F_brv_dist5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_5[0]),
    .dec(dec_dist_5[0])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_5_1
  (
    .input_weight(weights_dist_5_1),
    .ein(ein_dist[1]),
    .eout(eout[5]),
    .capture(capture_brv_dist_5[1]),
    .minus(minus_brv_dist5[1]),
    .search(search_brv_dist5[1]),
    .backoff(backoff_brv_dist5[1]),
    .min(min_brv_dist5[1]),
    .F(F_brv_dist5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_5[1]),
    .dec(dec_dist_5[1])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_5_2
  (
    .input_weight(weights_dist_5_2),
    .ein(ein_dist[2]),
    .eout(eout[5]),
    .capture(capture_brv_dist_5[2]),
    .minus(minus_brv_dist5[2]),
    .search(search_brv_dist5[2]),
    .backoff(backoff_brv_dist5[2]),
    .min(min_brv_dist5[2]),
    .F(F_brv_dist5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_5[2]),
    .dec(dec_dist_5[2])
  );


  stdp
  #(
    .WRES(3)
  )
  stdp_dist_5_3
  (
    .input_weight(weights_dist_5_3),
    .ein(ein_dist[3]),
    .eout(eout[5]),
    .capture(capture_brv_dist_5[3]),
    .minus(minus_brv_dist5[3]),
    .search(search_brv_dist5[3]),
    .backoff(backoff_brv_dist5[3]),
    .min(min_brv_dist5[3]),
    .F(F_brv_dist5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_dist_5[3]),
    .dec(dec_dist_5[3])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_0_0
  (
    .input_weight(weights_prox_0_0),
    .ein(ein_prox[0]),
    .eout(eout[0]),
    .capture(capture_brv_prox_0[0]),
    .minus(minus_brv_prox0[0]),
    .search(search_brv_prox0[0]),
    .backoff(backoff_brv_prox0[0]),
    .min(min_brv_prox0[0]),
    .F(F_brv_prox0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_0[0]),
    .dec(dec_prox_0[0])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_0_1
  (
    .input_weight(weights_prox_0_1),
    .ein(ein_prox[1]),
    .eout(eout[0]),
    .capture(capture_brv_prox_0[1]),
    .minus(minus_brv_prox0[1]),
    .search(search_brv_prox0[1]),
    .backoff(backoff_brv_prox0[1]),
    .min(min_brv_prox0[1]),
    .F(F_brv_prox0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_0[1]),
    .dec(dec_prox_0[1])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_0_2
  (
    .input_weight(weights_prox_0_2),
    .ein(ein_prox[2]),
    .eout(eout[0]),
    .capture(capture_brv_prox_0[2]),
    .minus(minus_brv_prox0[2]),
    .search(search_brv_prox0[2]),
    .backoff(backoff_brv_prox0[2]),
    .min(min_brv_prox0[2]),
    .F(F_brv_prox0),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_0[2]),
    .dec(dec_prox_0[2])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_1_0
  (
    .input_weight(weights_prox_1_0),
    .ein(ein_prox[0]),
    .eout(eout[1]),
    .capture(capture_brv_prox_1[0]),
    .minus(minus_brv_prox1[0]),
    .search(search_brv_prox1[0]),
    .backoff(backoff_brv_prox1[0]),
    .min(min_brv_prox1[0]),
    .F(F_brv_prox1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_1[0]),
    .dec(dec_prox_1[0])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_1_1
  (
    .input_weight(weights_prox_1_1),
    .ein(ein_prox[1]),
    .eout(eout[1]),
    .capture(capture_brv_prox_1[1]),
    .minus(minus_brv_prox1[1]),
    .search(search_brv_prox1[1]),
    .backoff(backoff_brv_prox1[1]),
    .min(min_brv_prox1[1]),
    .F(F_brv_prox1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_1[1]),
    .dec(dec_prox_1[1])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_1_2
  (
    .input_weight(weights_prox_1_2),
    .ein(ein_prox[2]),
    .eout(eout[1]),
    .capture(capture_brv_prox_1[2]),
    .minus(minus_brv_prox1[2]),
    .search(search_brv_prox1[2]),
    .backoff(backoff_brv_prox1[2]),
    .min(min_brv_prox1[2]),
    .F(F_brv_prox1),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_1[2]),
    .dec(dec_prox_1[2])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_2_0
  (
    .input_weight(weights_prox_2_0),
    .ein(ein_prox[0]),
    .eout(eout[2]),
    .capture(capture_brv_prox_2[0]),
    .minus(minus_brv_prox2[0]),
    .search(search_brv_prox2[0]),
    .backoff(backoff_brv_prox2[0]),
    .min(min_brv_prox2[0]),
    .F(F_brv_prox2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_2[0]),
    .dec(dec_prox_2[0])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_2_1
  (
    .input_weight(weights_prox_2_1),
    .ein(ein_prox[1]),
    .eout(eout[2]),
    .capture(capture_brv_prox_2[1]),
    .minus(minus_brv_prox2[1]),
    .search(search_brv_prox2[1]),
    .backoff(backoff_brv_prox2[1]),
    .min(min_brv_prox2[1]),
    .F(F_brv_prox2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_2[1]),
    .dec(dec_prox_2[1])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_2_2
  (
    .input_weight(weights_prox_2_2),
    .ein(ein_prox[2]),
    .eout(eout[2]),
    .capture(capture_brv_prox_2[2]),
    .minus(minus_brv_prox2[2]),
    .search(search_brv_prox2[2]),
    .backoff(backoff_brv_prox2[2]),
    .min(min_brv_prox2[2]),
    .F(F_brv_prox2),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_2[2]),
    .dec(dec_prox_2[2])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_3_0
  (
    .input_weight(weights_prox_3_0),
    .ein(ein_prox[0]),
    .eout(eout[3]),
    .capture(capture_brv_prox_3[0]),
    .minus(minus_brv_prox3[0]),
    .search(search_brv_prox3[0]),
    .backoff(backoff_brv_prox3[0]),
    .min(min_brv_prox3[0]),
    .F(F_brv_prox3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_3[0]),
    .dec(dec_prox_3[0])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_3_1
  (
    .input_weight(weights_prox_3_1),
    .ein(ein_prox[1]),
    .eout(eout[3]),
    .capture(capture_brv_prox_3[1]),
    .minus(minus_brv_prox3[1]),
    .search(search_brv_prox3[1]),
    .backoff(backoff_brv_prox3[1]),
    .min(min_brv_prox3[1]),
    .F(F_brv_prox3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_3[1]),
    .dec(dec_prox_3[1])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_3_2
  (
    .input_weight(weights_prox_3_2),
    .ein(ein_prox[2]),
    .eout(eout[3]),
    .capture(capture_brv_prox_3[2]),
    .minus(minus_brv_prox3[2]),
    .search(search_brv_prox3[2]),
    .backoff(backoff_brv_prox3[2]),
    .min(min_brv_prox3[2]),
    .F(F_brv_prox3),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_3[2]),
    .dec(dec_prox_3[2])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_4_0
  (
    .input_weight(weights_prox_4_0),
    .ein(ein_prox[0]),
    .eout(eout[4]),
    .capture(capture_brv_prox_4[0]),
    .minus(minus_brv_prox4[0]),
    .search(search_brv_prox4[0]),
    .backoff(backoff_brv_prox4[0]),
    .min(min_brv_prox4[0]),
    .F(F_brv_prox4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_4[0]),
    .dec(dec_prox_4[0])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_4_1
  (
    .input_weight(weights_prox_4_1),
    .ein(ein_prox[1]),
    .eout(eout[4]),
    .capture(capture_brv_prox_4[1]),
    .minus(minus_brv_prox4[1]),
    .search(search_brv_prox4[1]),
    .backoff(backoff_brv_prox4[1]),
    .min(min_brv_prox4[1]),
    .F(F_brv_prox4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_4[1]),
    .dec(dec_prox_4[1])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_4_2
  (
    .input_weight(weights_prox_4_2),
    .ein(ein_prox[2]),
    .eout(eout[4]),
    .capture(capture_brv_prox_4[2]),
    .minus(minus_brv_prox4[2]),
    .search(search_brv_prox4[2]),
    .backoff(backoff_brv_prox4[2]),
    .min(min_brv_prox4[2]),
    .F(F_brv_prox4),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_4[2]),
    .dec(dec_prox_4[2])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_5_0
  (
    .input_weight(weights_prox_5_0),
    .ein(ein_prox[0]),
    .eout(eout[5]),
    .capture(capture_brv_prox_5[0]),
    .minus(minus_brv_prox5[0]),
    .search(search_brv_prox5[0]),
    .backoff(backoff_brv_prox5[0]),
    .min(min_brv_prox5[0]),
    .F(F_brv_prox5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_5[0]),
    .dec(dec_prox_5[0])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_5_1
  (
    .input_weight(weights_prox_5_1),
    .ein(ein_prox[1]),
    .eout(eout[5]),
    .capture(capture_brv_prox_5[1]),
    .minus(minus_brv_prox5[1]),
    .search(search_brv_prox5[1]),
    .backoff(backoff_brv_prox5[1]),
    .min(min_brv_prox5[1]),
    .F(F_brv_prox5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_5[1]),
    .dec(dec_prox_5[1])
  );


  stdp_
  #(
    .WRES(3)
  )
  stdp_prox_5_2
  (
    .input_weight(weights_prox_5_2),
    .ein(ein_prox[2]),
    .eout(eout[5]),
    .capture(capture_brv_prox_5[2]),
    .minus(minus_brv_prox5[2]),
    .search(search_brv_prox5[2]),
    .backoff(backoff_brv_prox5[2]),
    .min(min_brv_prox5[2]),
    .F(F_brv_prox5),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .inc(inc_prox_5[2]),
    .dec(dec_prox_5[2])
  );


endmodule



module pulse2edge
(
  input [1-1:0] aclk,
  input [1-1:0] pulse_in,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] edge_out
);

  reg [1-1:0] temp;
  pulse2edge_area pluse2edge_inst(.EDGE_OUT(edge_out),.ACLK(aclk),.GRST(grst),.PULSE_IN(pulse_in));

endmodule



module pulse2edge_
(
  input [1-1:0] aclk,
  input [1-1:0] pulse_in,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] edge_out
);

  reg [1-1:0] temp;
  pulse2edge_area pluse2edge_inst(.EDGE_OUT(edge_out),.ACLK(aclk),.GRST(grst),.PULSE_IN(pulse_in));

endmodule



module segment #
(
  parameter INP_DIST = 4,
  parameter INP_PROX = 3,
  parameter WRES_DIST = 3,
  parameter WRES_PROX = 3,
  parameter THRESHOLD = 13
)
(
  input [4-1:0] input_spikes_dist,
  input [3-1:0] input_spikes_prox,
  input [4-1:0] inc_dist,
  input [3-1:0] inc_prox,
  input [4-1:0] dec_dist,
  input [3-1:0] dec_prox,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] output_spike,
  input [3-1:0] w_init_dist_0,
  input [3-1:0] w_init_dist_1,
  input [3-1:0] w_init_dist_2,
  input [3-1:0] w_init_dist_3,
  input [3-1:0] w_init_prox_0,
  input [3-1:0] w_init_prox_1,
  input [3-1:0] w_init_prox_2,
  input [3-1:0] weights_dist_0,
  input [3-1:0] weights_dist_1,
  input [3-1:0] weights_dist_2,
  input [3-1:0] weights_dist_3,
  input [3-1:0] weights_prox_0,
  input [3-1:0] weights_prox_1,
  input [3-1:0] weights_prox_2
);

  wire [4-1:0] resp_func_dist;
  wire [3-1:0] resp_func_prox;

  fsm_synapse
  syn_dist_0
  (
    .input_spike(input_spikes_dist[0]),
    .inc(0),
    .dec(inc_dist[0]),
    .aclk(dec_dist[0]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_dist_0),
    .out(resp_func_dist[0])
  );


  fsm_synapse
  syn_dist_1
  (
    .input_spike(input_spikes_dist[1]),
    .inc(0),
    .dec(inc_dist[1]),
    .aclk(dec_dist[1]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_dist_1),
    .out(resp_func_dist[1])
  );


  fsm_synapse
  syn_dist_2
  (
    .input_spike(input_spikes_dist[2]),
    .inc(0),
    .dec(inc_dist[2]),
    .aclk(dec_dist[2]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_dist_2),
    .out(resp_func_dist[2])
  );


  fsm_synapse
  syn_dist_3
  (
    .input_spike(input_spikes_dist[3]),
    .inc(0),
    .dec(inc_dist[3]),
    .aclk(dec_dist[3]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_dist_3),
    .out(resp_func_dist[3])
  );


  fsm_synapse_
  syn_prox_0
  (
    .input_spike(input_spikes_prox[0]),
    .inc(0),
    .dec(inc_prox[0]),
    .aclk(dec_prox[0]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_prox_0),
    .out(resp_func_prox[0])
  );


  fsm_synapse_
  syn_prox_1
  (
    .input_spike(input_spikes_prox[1]),
    .inc(0),
    .dec(inc_prox[1]),
    .aclk(dec_prox[1]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_prox_1),
    .out(resp_func_prox[1])
  );


  fsm_synapse_
  syn_prox_2
  (
    .input_spike(input_spikes_prox[2]),
    .inc(0),
    .dec(inc_prox[2]),
    .aclk(dec_prox[2]),
    .gclk(clk),
    .rst(grst),
    .grst(rstb),
    .w_out(weights_prox_2),
    .out(resp_func_prox[2])
  );


  neuron_body
  #(
    .INPUT_SIZE(7),
    .THRESHOLD(13),
    .WRES(3)
  )
  soma
  (
    .acc_in(resp_func_prox + resp_func_dist),
    .aclk(clk),
    .pac_rst(grst),
    .rst(rstb),
    .out_spike(output_spike)
  );


endmodule



module fsm_synapse #
(
  parameter WRES = 3
)
(
  input [1-1:0] input_spike,
  input [1-1:0] inc,
  input [1-1:0] dec,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] rst,
  input [1-1:0] grst,
  output [WRES-1:0] w_out,
  output [1-1:0] out
);

  reg [1-1:0] next_gclk;
  reg [WRES-1:0] next_weight;
  reg [WRES-1:0] store_weight;

  fsm_weight_update
  fsm_weight_inst
  (
    .input_spike(next_weight),
    .inc(store_weight),
    .dec(input_spike),
    .next_gclk(inc),
    .gclk(dec),
    .store_weight(next_gclk),
    .nxt_weight(gclk)
  );


  fsm_output
  fsm_out_inst
  (
    .input_spike(out),
    .aclk(input_spike),
    .gclk(store_weight),
    .grst(aclk),
    .store_weight(gclk),
    .next_weight(next_weight),
    .out(grst)
  );

  register #(.WL(1)) gclk_next(.clk(aclk), .rst_b(~rst), .d(gclk), .q(nxt_gclk), .wen(1));
  register #(.WL(3)) inst_reg_weight (.clk(aclk), .rst_b(~rst), .d(nxt_weight), .q(store_weight), .wen(1'd1));
  assign w_out = store_weight;

endmodule



module fsm_weight_update #
(
  parameter WRES = 3
)
(
  input [1-1:0] input_spike,
  input [1-1:0] inc,
  input [1-1:0] dec,
  input [1-1:0] next_gclk,
  input [1-1:0] gclk,
  input [WRES-1:0] store_weight,
  output [WRES-1:0] nxt_weight
);

  wire [1-1:0] tinc;
  wire [1-1:0] tdec;
  assign tinc = inc & ~input_spike & ~next_gclk & gclk & ~(store_weight[0] & store_weight[1] & store_weight[2]);
  assign tdec = dec & ~input_spike & ~next_gclk & gclk & (store_weight[0] | store_weight[1] | store_weight[2]);
  fsm_weight_update_macro fsm_weight_update_inst (.NXT_WEIGHT_0(nxt_weight[0]),.NXT_WEIGHT_1(nxt_weight[1]),.NXT_WEIGHT_2(nxt_weight[2]),.INPUT_SPIKE(input_spike),.TDEC(tdec),.TINC(tinc),.STORE_WEIGHT_0(store_weight[0]),.STORE_WEIGHT_1(store_weight[1]),.STORE_WEIGHT_2(store_weight[2]));
                

endmodule



module fsm_output #
(
  parameter WRES = 3
)
(
  input [1-1:0] input_spike,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] grst,
  input [WRES-1:0] store_weight,
  input [WRES-1:0] next_weight,
  output [1-1:0] out
);

  fsm_output_macro fsm_output_inst(.OUT(out),.INPUT_SPIKE(input_spike),.STORE_WEIGHT_0(store_weight[0]),.STORE_WEIGHT_1(store_weight[1]),.STORE_WEIGHT_2(store_weight[2]),.ACLK(aclk));

endmodule



module fsm_synapse_ #
(
  parameter WRES = 3
)
(
  input [1-1:0] input_spike,
  input [1-1:0] inc,
  input [1-1:0] dec,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] rst,
  input [1-1:0] grst,
  output [WRES-1:0] w_out,
  output [1-1:0] out
);

  reg [1-1:0] next_gclk;
  reg [WRES-1:0] next_weight;
  reg [WRES-1:0] store_weight;

  fsm_weight_update
  fsm_weight_inst
  (
    .input_spike(next_weight),
    .inc(store_weight),
    .dec(input_spike),
    .next_gclk(inc),
    .gclk(dec),
    .store_weight(next_gclk),
    .nxt_weight(gclk)
  );


  fsm_output
  fsm_out_inst
  (
    .input_spike(out),
    .aclk(input_spike),
    .gclk(store_weight),
    .grst(aclk),
    .store_weight(gclk),
    .next_weight(next_weight),
    .out(grst)
  );

  register #(.WL(1)) gclk_next(.clk(aclk), .rst_b(~rst), .d(gclk), .q(nxt_gclk), .wen(1));
  register #(.WL(3)) inst_reg_weight (.clk(aclk), .rst_b(~rst), .d(nxt_weight), .q(store_weight), .wen(1'd1));
  assign w_out = store_weight;

endmodule



module neuron_body #
(
  parameter INPUT_SIZE = 7,
  parameter THRESHOLD = 13,
  parameter WRES = 3
)
(
  input [7-1:0] acc_in,
  input [1-1:0] aclk,
  input [1-1:0] pac_rst,
  input [1-1:0] rst,
  output [1-1:0] out_spike
);

  localparam p_res = 3;
  localparam IN_SIZE = 8;
  wire [1-1:0] temp_spike;

  pac
  #(
    .INPUT_SIZE(7),
    .THRESHOLD(13)
  )
  p1
  (
    .in({ 1'b0, acc_in }),
    .aclk(aclk),
    .grst(pac_rst),
    .rst(rst),
    .out(temp_spike)
  );


  fsm_convert
  #(
    .WRES(3)
  )
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
  parameter INPUT_SIZE = 7,
  parameter THRESHOLD = 13
)
(
  input [8-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] out
);

  localparam P_RES = 3;
  localparam IN_SIZE = 8;
  localparam STAGES = 2;
  localparam NUM = 11;
  localparam MAXRES = 5;
  wire [8-1:0] padded_in;
  wire [NUM-1:0] temp;
  wire [P_RES-1:0] parallel_out;
  wire [6-1:0] body_pot;
  reg [MAXRES-1:0] regout;
  reg [1-1:0] poutlatch;
  assign padded_in = in;
  assign temp[0] = padded_in[0];
  assign temp[1] = padded_in[1];
  assign temp[2] = padded_in[2];
  assign temp[3] = padded_in[3];

  adder
  #(
    .RES(1)
  )
  a1_00
  (
    .a(temp[(8>>0)*((1<<1)-0-2)+0+0:(8>>0)*((1<<1)-0-2)+0]),
    .b(temp[(8>>0)*((1<<1)-0-2)+1+0:(8>>0)*((1<<1)-0-2)+1]),
    .cin(in[4 + ((8 >> 1) * ((1 << 0) - 1) + 0)]),
    .out(temp[(8>>1)*((1<<2)-0-3)+0+1:(8>>1)*((1<<2)-0-3)+0])
  );


  adder
  #(
    .RES(1)
  )
  a1_01
  (
    .a(temp[(8>>0)*((1<<1)-0-2)+2+0:(8>>0)*((1<<1)-0-2)+2]),
    .b(temp[(8>>0)*((1<<1)-0-2)+3+0:(8>>0)*((1<<1)-0-2)+3]),
    .cin(in[4 + ((8 >> 1) * ((1 << 0) - 1) + 1)]),
    .out(temp[(8>>1)*((1<<2)-0-3)+2+1:(8>>1)*((1<<2)-0-3)+2])
  );


  adder
  #(
    .RES(2)
  )
  a1_10
  (
    .a(temp[(8>>1)*((1<<2)-1-2)+0+1:(8>>1)*((1<<2)-1-2)+0]),
    .b(temp[(8>>1)*((1<<2)-1-2)+2+1:(8>>1)*((1<<2)-1-2)+2]),
    .cin(in[4 + ((8 >> 2) * ((1 << 1) - 1) + 0)]),
    .out(temp[(8>>2)*((1<<3)-1-3)+0+2:(8>>2)*((1<<3)-1-3)+0])
  );

  assign parallel_out = temp[10:8];

  adder
  #(
    .RES(5)
  )
  adder2_in_pac
  (
    .a(parallel_out),
    .b(regout),
    .cin(padded_in[7:7]),
    .out(body_pot)
  );


  always @(posedge aclk) begin
    if(grst | rst) begin
      regout <= -13;
      poutlatch <= 0;
    end else begin
      if(out) begin
        regout <= -13;
      end else begin
        regout <= body_pot[4:0];
      end
      poutlatch <= out;
    end
  end

  assign out = body_pot[5:5] | poutlatch;

endmodule



module adder #
(
  parameter RES = 4
)
(
  input [RES-1:0] a,
  input [RES-1:0] b,
  input cin,
  output [RES+1-1:0] out
);

  assign out = a + b + cin;

endmodule



module fsm_convert #
(
  parameter WRES = 3
)
(
  input [1-1:0] aclk,
  input [1-1:0] rst,
  input [1-1:0] in,
  output [1-1:0] out
);

  reg [WRES-1:0] state;
  reg [WRES-1:0] next_state;
  fsm_simple_macro fsm_simple_inst(.IN(in),.OUT(out),.STATE_0(state[0]),.STATE_1(state[1]),.STATE_2(state[2]),.NEXT_STATE_0(next_state[0]),.NEXT_STATE_1(next_state[1]),.NEXT_STATE_2(next_state[2]));

  register
  #(
    .WL(WRES)
  )
  reg_inst
  (
    .clk(aclk),
    .rst_b(~rst),
    .d(next_state),
    .q(state),
    .wen(1)
  );


endmodule



module register #
(
  parameter WL = 1
)
(
  input [1-1:0] clk,
  input [1-1:0] rst_b,
  input [WL-1:0] d,
  output [WL-1:0] q,
  input [1-1:0] wen
);

  reg [WL-1:0] temp;

  always @(posedge clk) begin
    if(~rst_b) begin
      temp <= 1'b0;
    end else begin
      if(wen) begin
        temp <= d;
      end 
    end
  end

  assign q = temp;

endmodule



module wta #
(
  parameter Q = 6
)
(
  input [Q-1:0] ec_spikes,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [Q-1:0] li_out
);

  wire [1-1:0] first_spike;
  wire [1-1:0] first_spike_edge;
  wire [Q-1:0] inhibit_spikes;
  assign first_spike = ec_spikes > 0;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(first_spike),
    .grst(grst),
    .rst(rst),
    .edge_out(first_spike_edge)
  );


  less_equal
  l1_0
  (
    .data_in(ec_spikes[0]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .out(inhibit_spikes[0])
  );


  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .out(inhibit_spikes[1])
  );


  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .out(inhibit_spikes[2])
  );


  less_equal
  l1_3
  (
    .data_in(ec_spikes[3]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .out(inhibit_spikes[3])
  );


  less_equal
  l1_4
  (
    .data_in(ec_spikes[4]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .out(inhibit_spikes[4])
  );


  less_equal
  l1_5
  (
    .data_in(ec_spikes[5]),
    .inhibit_in(first_spike_edge),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .out(inhibit_spikes[5])
  );

  assign li_out[5] = inhibit_spikes[5];
  assign li_out[4] = inhibit_spikes[4] & ~(|inhibit_spikes[5:5]);
  assign li_out[3] = inhibit_spikes[3] & ~(|inhibit_spikes[5:4]);
  assign li_out[2] = inhibit_spikes[2] & ~(|inhibit_spikes[5:3]);
  assign li_out[1] = inhibit_spikes[1] & ~(|inhibit_spikes[5:2]);
  assign li_out[0] = inhibit_spikes[0] & ~(|inhibit_spikes[5:1]);

endmodule



module less_equal
(
  input [1-1:0] data_in,
  input [1-1:0] inhibit_in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] out
);

  wire [1-1:0] inhibit_only;
  wire [1-1:0] temp2;
  inhibit_pass DUT_wq(.INHIBIT(inhibit_in),.DATA_IN(data_in),.OUT(temp2));
  assign out = data_in & ~temp2;

endmodule



module stdp #
(
  parameter WRES = 3
)
(
  input [WRES-1:0] input_weight,
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] capture,
  input [1-1:0] minus,
  input [1-1:0] search,
  input [1-1:0] backoff,
  input [1-1:0] min,
  input [6-1:0] F,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] inc,
  output [1-1:0] dec
);

  wire [4-1:0] stdp_cases;
  wire [1-1:0] fout;

  stdp_case_gen
  s1
  (
    .ein(ein),
    .eout(eout),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .stdp_cases(stdp_cases)
  );


  flogic
  #(
    .WRES(3)
  )
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



module stdp_case_gen
(
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [4-1:0] stdp_cases
);

  reg [1-1:0] temp;
  reg [1-1:0] greater;
  stdp_case_gen_macro stdp (.EIN(ein),.EOUT(eout),.STDP_CASES_0(stdp_cases[0]),.STDP_CASES_1(stdp_cases[1]),.STDP_CASES_2(stdp_cases[2]),.STDP_CASES_3(stdp_cases[3]),.GREATER(greater));
  inhibit_pass DUT_wq(.INHIBIT(eout),.DATA_IN(ein),.OUT(temp));

endmodule



module flogic #
(
  parameter WRES = 3
)
(
  input [6-1:0] F,
  input [WRES-1:0] input_weight,
  output [1-1:0] out
);

  flogic_8x1 DUT (.OUT(out), .F_0(0), .F_1(F[0]), .F_2(F[1]), .F_3(F[2]), .F_4(F[3]), .F_5(F[4]), .F_6(F[5]), .F_7(1), .SEL_0(input_weight[0]), .SEL_1(input_weight[1]), .SEL_2(input_weight[2])); 

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

  incdec_macro macro_init (.MIN(min), .F(F), .BACKOFF(backoff), .STDP_CASES_3(stdp_cases[3]), .STDP_CASES_1(stdp_cases[1]), .MINUS(minus), .CAPTURE(capture), .STDP_CASES_0(stdp_cases[0]), .STDP_CASES_2(stdp_cases[2]), .SEARCH(search), .DEC(dec), .INC(inc)); 

endmodule



module stdp_ #
(
  parameter WRES = 3
)
(
  input [WRES-1:0] input_weight,
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] capture,
  input [1-1:0] minus,
  input [1-1:0] search,
  input [1-1:0] backoff,
  input [1-1:0] min,
  input [6-1:0] F,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] inc,
  output [1-1:0] dec
);

  wire [4-1:0] stdp_cases;
  wire [1-1:0] fout;

  stdp_case_gen
  s1
  (
    .ein(ein),
    .eout(eout),
    .aclk(aclk),
    .grst(grst),
    .rst(rst),
    .stdp_cases(stdp_cases)
  );


  flogic
  #(
    .WRES(3)
  )
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

