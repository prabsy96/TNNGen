

module test_simple
(

);

  reg dut_clk;
  reg dut_grst;
  reg dut_rstb;
  reg [18-1:0] dut_layer_in;
  reg [504-1:0] dut_w_init;
  reg [72-1:0] dut_capture_brv;
  reg [72-1:0] dut_minus_brv;
  reg [72-1:0] dut_search_brv;
  reg [72-1:0] dut_backoff_brv;
  reg [72-1:0] dut_min_brv;
  reg [504-1:0] dut_F_brv;
  wire [4-1:0] dut_layer_out;

  TNN_Layer_0
  dut
  (
    .clk(dut_clk),
    .grst(dut_grst),
    .rstb(dut_rstb),
    .layer_in(dut_layer_in),
    .w_init(dut_w_init),
    .capture_brv(dut_capture_brv),
    .minus_brv(dut_minus_brv),
    .search_brv(dut_search_brv),
    .backoff_brv(dut_backoff_brv),
    .min_brv(dut_min_brv),
    .F_brv(dut_F_brv),
    .layer_out(dut_layer_out)
  );


  initial begin
    dut_clk = 0;
    forever begin
      #0.5 dut_clk = !dut_clk;
    end
  end


  initial begin
    $dumpfile("/afs/ece.cmu.edu/usr/weichehu/Private/yn_github/TNNGen/tnngen_core/waveform_9oa7rs94.vcd");
    $dumpvars(0, dut, dut_clk, dut_grst, dut_rstb, dut_layer_in, dut_w_init, dut_capture_brv, dut_minus_brv, dut_search_brv, dut_backoff_brv, dut_min_brv, dut_F_brv, dut_layer_out);
    #0.5;
    dut_layer_in = 0;
    dut_w_init = 0;
    dut_capture_brv = -1;
    dut_minus_brv = -1;
    dut_search_brv = -1;
    dut_backoff_brv = -1;
    dut_min_brv = -1;
    dut_F_brv = -1;
    #0;
    dut_rstb = 0;
    #8;
    dut_rstb = 1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 209510;
    #1;
    dut_layer_in = 209510;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 511;
    #1;
    dut_layer_in = 511;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 4088;
    #1;
    dut_layer_in = 4088;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 38836;
    #1;
    dut_layer_in = 38836;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 8176;
    #1;
    dut_layer_in = 8176;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 4088;
    #1;
    dut_layer_in = 4088;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 112420;
    #1;
    dut_layer_in = 112420;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 32704;
    #1;
    dut_layer_in = 32704;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 112420;
    #1;
    dut_layer_in = 112420;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 149723;
    #1;
    dut_layer_in = 149723;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 261632;
    #1;
    dut_layer_in = 261632;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 223307;
    #1;
    dut_layer_in = 223307;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 261632;
    #1;
    dut_layer_in = 261632;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 1022;
    #1;
    dut_layer_in = 1022;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 112420;
    #1;
    dut_layer_in = 112420;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 511;
    #1;
    dut_layer_in = 511;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 511;
    #1;
    dut_layer_in = 511;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 228928;
    #1;
    dut_layer_in = 228928;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 1022;
    #1;
    dut_layer_in = 1022;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 163520;
    #1;
    dut_layer_in = 163520;
    #127;
    dut_layer_in = 0;
    #1;
    dut_layer_in = 0;
    #100;
    $finish;
  end

  integer i;

  initial i = 0;
  always @ (posedge dut_clk)
      begin
          if (dut_rstb) 
              begin
              i = i % 130;
              if (i==0) dut_grst = 1;
              if (i==1) dut_grst = 0;
              i = i + 1;
          end
      end

endmodule



module TNN_Layer_0 #
(
  parameter NUM_COL = 1,
  parameter NUM_NEURONS = 4,
  parameter NUM_SYNAPSE = 18,
  parameter WRES = 7,
  parameter THRESHOLD = 64,
  parameter IN_WIDTH = 72,
  parameter OUT_WIDTH = 4,
  parameter is_clk = 1
)
(
  input clk,
  input grst,
  input rstb,
  input [18-1:0] layer_in,
  input [504-1:0] w_init,
  input [72-1:0] capture_brv,
  input [72-1:0] minus_brv,
  input [72-1:0] search_brv,
  input [72-1:0] backoff_brv,
  input [72-1:0] min_brv,
  input [504-1:0] F_brv,
  output [4-1:0] layer_out
);


  L0_simple_column
  #(
    .num_neuron(4),
    .num_synapse(18),
    .WRES(7),
    .THRESHOLD(64)
  )
  L0_column_inst_0
  (
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(layer_out[3:0]),
    .input_spikes(layer_in[17:0]),
    .w_init(w_init[503:0]),
    .capture_brv(capture_brv[71:0]),
    .minus_brv(minus_brv[71:0]),
    .search_brv(search_brv[71:0]),
    .backoff_brv(backoff_brv[71:0]),
    .min_brv(min_brv[71:0]),
    .F_brv(F_brv[503:0])
  );


endmodule



module L0_simple_column #
(
  parameter num_neuron = 4,
  parameter num_synapse = 18,
  parameter WRES = 7,
  parameter THRESHOLD = 64
)
(
  input clk,
  input grst,
  input rstb,
  output [4-1:0] output_spike,
  input [18-1:0] input_spikes,
  input [504-1:0] w_init,
  input [72-1:0] capture_brv,
  input [72-1:0] minus_brv,
  input [72-1:0] search_brv,
  input [72-1:0] backoff_brv,
  input [72-1:0] min_brv,
  input [504-1:0] F_brv
);

  wire [18-1:0] ein;
  wire [4-1:0] eout;
  wire [4-1:0] ec_spikes;
  wire [4-1:0] li_spikes;
  wire [18-1:0] inc_0;
  wire [18-1:0] dec_0;
  wire [7-1:0] weights_0_0;
  wire [7-1:0] weights_0_1;
  wire [7-1:0] weights_0_2;
  wire [7-1:0] weights_0_3;
  wire [7-1:0] weights_0_4;
  wire [7-1:0] weights_0_5;
  wire [7-1:0] weights_0_6;
  wire [7-1:0] weights_0_7;
  wire [7-1:0] weights_0_8;
  wire [7-1:0] weights_0_9;
  wire [7-1:0] weights_0_10;
  wire [7-1:0] weights_0_11;
  wire [7-1:0] weights_0_12;
  wire [7-1:0] weights_0_13;
  wire [7-1:0] weights_0_14;
  wire [7-1:0] weights_0_15;
  wire [7-1:0] weights_0_16;
  wire [7-1:0] weights_0_17;
  wire [18-1:0] inc_1;
  wire [18-1:0] dec_1;
  wire [7-1:0] weights_1_0;
  wire [7-1:0] weights_1_1;
  wire [7-1:0] weights_1_2;
  wire [7-1:0] weights_1_3;
  wire [7-1:0] weights_1_4;
  wire [7-1:0] weights_1_5;
  wire [7-1:0] weights_1_6;
  wire [7-1:0] weights_1_7;
  wire [7-1:0] weights_1_8;
  wire [7-1:0] weights_1_9;
  wire [7-1:0] weights_1_10;
  wire [7-1:0] weights_1_11;
  wire [7-1:0] weights_1_12;
  wire [7-1:0] weights_1_13;
  wire [7-1:0] weights_1_14;
  wire [7-1:0] weights_1_15;
  wire [7-1:0] weights_1_16;
  wire [7-1:0] weights_1_17;
  wire [18-1:0] inc_2;
  wire [18-1:0] dec_2;
  wire [7-1:0] weights_2_0;
  wire [7-1:0] weights_2_1;
  wire [7-1:0] weights_2_2;
  wire [7-1:0] weights_2_3;
  wire [7-1:0] weights_2_4;
  wire [7-1:0] weights_2_5;
  wire [7-1:0] weights_2_6;
  wire [7-1:0] weights_2_7;
  wire [7-1:0] weights_2_8;
  wire [7-1:0] weights_2_9;
  wire [7-1:0] weights_2_10;
  wire [7-1:0] weights_2_11;
  wire [7-1:0] weights_2_12;
  wire [7-1:0] weights_2_13;
  wire [7-1:0] weights_2_14;
  wire [7-1:0] weights_2_15;
  wire [7-1:0] weights_2_16;
  wire [7-1:0] weights_2_17;
  wire [18-1:0] inc_3;
  wire [18-1:0] dec_3;
  wire [7-1:0] weights_3_0;
  wire [7-1:0] weights_3_1;
  wire [7-1:0] weights_3_2;
  wire [7-1:0] weights_3_3;
  wire [7-1:0] weights_3_4;
  wire [7-1:0] weights_3_5;
  wire [7-1:0] weights_3_6;
  wire [7-1:0] weights_3_7;
  wire [7-1:0] weights_3_8;
  wire [7-1:0] weights_3_9;
  wire [7-1:0] weights_3_10;
  wire [7-1:0] weights_3_11;
  wire [7-1:0] weights_3_12;
  wire [7-1:0] weights_3_13;
  wire [7-1:0] weights_3_14;
  wire [7-1:0] weights_3_15;
  wire [7-1:0] weights_3_16;
  wire [7-1:0] weights_3_17;

  pulse2edge
  pe_in_0
  (
    .pulse_in(input_spikes[0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[0])
  );


  pulse2edge
  pe_in_1
  (
    .pulse_in(input_spikes[1]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[1])
  );


  pulse2edge
  pe_in_2
  (
    .pulse_in(input_spikes[2]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[2])
  );


  pulse2edge
  pe_in_3
  (
    .pulse_in(input_spikes[3]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[3])
  );


  pulse2edge
  pe_in_4
  (
    .pulse_in(input_spikes[4]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[4])
  );


  pulse2edge
  pe_in_5
  (
    .pulse_in(input_spikes[5]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[5])
  );


  pulse2edge
  pe_in_6
  (
    .pulse_in(input_spikes[6]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[6])
  );


  pulse2edge
  pe_in_7
  (
    .pulse_in(input_spikes[7]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[7])
  );


  pulse2edge
  pe_in_8
  (
    .pulse_in(input_spikes[8]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[8])
  );


  pulse2edge
  pe_in_9
  (
    .pulse_in(input_spikes[9]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[9])
  );


  pulse2edge
  pe_in_10
  (
    .pulse_in(input_spikes[10]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[10])
  );


  pulse2edge
  pe_in_11
  (
    .pulse_in(input_spikes[11]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[11])
  );


  pulse2edge
  pe_in_12
  (
    .pulse_in(input_spikes[12]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[12])
  );


  pulse2edge
  pe_in_13
  (
    .pulse_in(input_spikes[13]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[13])
  );


  pulse2edge
  pe_in_14
  (
    .pulse_in(input_spikes[14]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[14])
  );


  pulse2edge
  pe_in_15
  (
    .pulse_in(input_spikes[15]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[15])
  );


  pulse2edge
  pe_in_16
  (
    .pulse_in(input_spikes[16]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[16])
  );


  pulse2edge
  pe_in_17
  (
    .pulse_in(input_spikes[17]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(ein[17])
  );


  L0_simple_neuron
  #(
    .INP(18),
    .WRES(7),
    .THRESHOLD(64)
  )
  L0_ec_0
  (
    .input_spikes(input_spikes),
    .inc(inc_0),
    .dec(dec_0),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[0]),
    .w_init(w_init[125:0]),
    .weights_0(weights_0_0),
    .weights_1(weights_0_1),
    .weights_2(weights_0_2),
    .weights_3(weights_0_3),
    .weights_4(weights_0_4),
    .weights_5(weights_0_5),
    .weights_6(weights_0_6),
    .weights_7(weights_0_7),
    .weights_8(weights_0_8),
    .weights_9(weights_0_9),
    .weights_10(weights_0_10),
    .weights_11(weights_0_11),
    .weights_12(weights_0_12),
    .weights_13(weights_0_13),
    .weights_14(weights_0_14),
    .weights_15(weights_0_15),
    .weights_16(weights_0_16),
    .weights_17(weights_0_17)
  );


  L0_simple_neuron
  #(
    .INP(18),
    .WRES(7),
    .THRESHOLD(64)
  )
  L0_ec_1
  (
    .input_spikes(input_spikes),
    .inc(inc_1),
    .dec(dec_1),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[1]),
    .w_init(w_init[251:126]),
    .weights_0(weights_1_0),
    .weights_1(weights_1_1),
    .weights_2(weights_1_2),
    .weights_3(weights_1_3),
    .weights_4(weights_1_4),
    .weights_5(weights_1_5),
    .weights_6(weights_1_6),
    .weights_7(weights_1_7),
    .weights_8(weights_1_8),
    .weights_9(weights_1_9),
    .weights_10(weights_1_10),
    .weights_11(weights_1_11),
    .weights_12(weights_1_12),
    .weights_13(weights_1_13),
    .weights_14(weights_1_14),
    .weights_15(weights_1_15),
    .weights_16(weights_1_16),
    .weights_17(weights_1_17)
  );


  L0_simple_neuron
  #(
    .INP(18),
    .WRES(7),
    .THRESHOLD(64)
  )
  L0_ec_2
  (
    .input_spikes(input_spikes),
    .inc(inc_2),
    .dec(dec_2),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[2]),
    .w_init(w_init[377:252]),
    .weights_0(weights_2_0),
    .weights_1(weights_2_1),
    .weights_2(weights_2_2),
    .weights_3(weights_2_3),
    .weights_4(weights_2_4),
    .weights_5(weights_2_5),
    .weights_6(weights_2_6),
    .weights_7(weights_2_7),
    .weights_8(weights_2_8),
    .weights_9(weights_2_9),
    .weights_10(weights_2_10),
    .weights_11(weights_2_11),
    .weights_12(weights_2_12),
    .weights_13(weights_2_13),
    .weights_14(weights_2_14),
    .weights_15(weights_2_15),
    .weights_16(weights_2_16),
    .weights_17(weights_2_17)
  );


  L0_simple_neuron
  #(
    .INP(18),
    .WRES(7),
    .THRESHOLD(64)
  )
  L0_ec_3
  (
    .input_spikes(input_spikes),
    .inc(inc_3),
    .dec(dec_3),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(ec_spikes[3]),
    .w_init(w_init[503:378]),
    .weights_0(weights_3_0),
    .weights_1(weights_3_1),
    .weights_2(weights_3_2),
    .weights_3(weights_3_3),
    .weights_4(weights_3_4),
    .weights_5(weights_3_5),
    .weights_6(weights_3_6),
    .weights_7(weights_3_7),
    .weights_8(weights_3_8),
    .weights_9(weights_3_9),
    .weights_10(weights_3_10),
    .weights_11(weights_3_11),
    .weights_12(weights_3_12),
    .weights_13(weights_3_13),
    .weights_14(weights_3_14),
    .weights_15(weights_3_15),
    .weights_16(weights_3_16),
    .weights_17(weights_3_17)
  );


  L0_wta_4
  #(
    .Q(4)
  )
  L0_li
  (
    .ec_spikes(ec_spikes),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .li_out(li_spikes)
  );


  pulse2edge_
  pe_out_0
  (
    .pulse_in(li_spikes[0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(eout[0])
  );


  pulse2edge_
  pe_out_1
  (
    .pulse_in(li_spikes[1]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(eout[1])
  );


  pulse2edge_
  pe_out_2
  (
    .pulse_in(li_spikes[2]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(eout[2])
  );


  pulse2edge_
  pe_out_3
  (
    .pulse_in(li_spikes[3]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(eout[3])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_0
  (
    .weight_in(weights_0_0),
    .ein(ein[0]),
    .eout(eout[0]),
    .capture_brv(capture_brv[0]),
    .minus_brv(minus_brv[0]),
    .search_brv(search_brv[0]),
    .backoff_brv(backoff_brv[0]),
    .min_brv(min_brv[0]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[0]),
    .dec(dec_0[0])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_1
  (
    .weight_in(weights_0_1),
    .ein(ein[1]),
    .eout(eout[0]),
    .capture_brv(capture_brv[1]),
    .minus_brv(minus_brv[1]),
    .search_brv(search_brv[1]),
    .backoff_brv(backoff_brv[1]),
    .min_brv(min_brv[1]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[1]),
    .dec(dec_0[1])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_2
  (
    .weight_in(weights_0_2),
    .ein(ein[2]),
    .eout(eout[0]),
    .capture_brv(capture_brv[2]),
    .minus_brv(minus_brv[2]),
    .search_brv(search_brv[2]),
    .backoff_brv(backoff_brv[2]),
    .min_brv(min_brv[2]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[2]),
    .dec(dec_0[2])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_3
  (
    .weight_in(weights_0_3),
    .ein(ein[3]),
    .eout(eout[0]),
    .capture_brv(capture_brv[3]),
    .minus_brv(minus_brv[3]),
    .search_brv(search_brv[3]),
    .backoff_brv(backoff_brv[3]),
    .min_brv(min_brv[3]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[3]),
    .dec(dec_0[3])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_4
  (
    .weight_in(weights_0_4),
    .ein(ein[4]),
    .eout(eout[0]),
    .capture_brv(capture_brv[4]),
    .minus_brv(minus_brv[4]),
    .search_brv(search_brv[4]),
    .backoff_brv(backoff_brv[4]),
    .min_brv(min_brv[4]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[4]),
    .dec(dec_0[4])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_5
  (
    .weight_in(weights_0_5),
    .ein(ein[5]),
    .eout(eout[0]),
    .capture_brv(capture_brv[5]),
    .minus_brv(minus_brv[5]),
    .search_brv(search_brv[5]),
    .backoff_brv(backoff_brv[5]),
    .min_brv(min_brv[5]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[5]),
    .dec(dec_0[5])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_6
  (
    .weight_in(weights_0_6),
    .ein(ein[6]),
    .eout(eout[0]),
    .capture_brv(capture_brv[6]),
    .minus_brv(minus_brv[6]),
    .search_brv(search_brv[6]),
    .backoff_brv(backoff_brv[6]),
    .min_brv(min_brv[6]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[6]),
    .dec(dec_0[6])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_7
  (
    .weight_in(weights_0_7),
    .ein(ein[7]),
    .eout(eout[0]),
    .capture_brv(capture_brv[7]),
    .minus_brv(minus_brv[7]),
    .search_brv(search_brv[7]),
    .backoff_brv(backoff_brv[7]),
    .min_brv(min_brv[7]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[7]),
    .dec(dec_0[7])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_8
  (
    .weight_in(weights_0_8),
    .ein(ein[8]),
    .eout(eout[0]),
    .capture_brv(capture_brv[8]),
    .minus_brv(minus_brv[8]),
    .search_brv(search_brv[8]),
    .backoff_brv(backoff_brv[8]),
    .min_brv(min_brv[8]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[8]),
    .dec(dec_0[8])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_9
  (
    .weight_in(weights_0_9),
    .ein(ein[9]),
    .eout(eout[0]),
    .capture_brv(capture_brv[9]),
    .minus_brv(minus_brv[9]),
    .search_brv(search_brv[9]),
    .backoff_brv(backoff_brv[9]),
    .min_brv(min_brv[9]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[9]),
    .dec(dec_0[9])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_10
  (
    .weight_in(weights_0_10),
    .ein(ein[10]),
    .eout(eout[0]),
    .capture_brv(capture_brv[10]),
    .minus_brv(minus_brv[10]),
    .search_brv(search_brv[10]),
    .backoff_brv(backoff_brv[10]),
    .min_brv(min_brv[10]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[10]),
    .dec(dec_0[10])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_11
  (
    .weight_in(weights_0_11),
    .ein(ein[11]),
    .eout(eout[0]),
    .capture_brv(capture_brv[11]),
    .minus_brv(minus_brv[11]),
    .search_brv(search_brv[11]),
    .backoff_brv(backoff_brv[11]),
    .min_brv(min_brv[11]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[11]),
    .dec(dec_0[11])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_12
  (
    .weight_in(weights_0_12),
    .ein(ein[12]),
    .eout(eout[0]),
    .capture_brv(capture_brv[12]),
    .minus_brv(minus_brv[12]),
    .search_brv(search_brv[12]),
    .backoff_brv(backoff_brv[12]),
    .min_brv(min_brv[12]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[12]),
    .dec(dec_0[12])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_13
  (
    .weight_in(weights_0_13),
    .ein(ein[13]),
    .eout(eout[0]),
    .capture_brv(capture_brv[13]),
    .minus_brv(minus_brv[13]),
    .search_brv(search_brv[13]),
    .backoff_brv(backoff_brv[13]),
    .min_brv(min_brv[13]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[13]),
    .dec(dec_0[13])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_14
  (
    .weight_in(weights_0_14),
    .ein(ein[14]),
    .eout(eout[0]),
    .capture_brv(capture_brv[14]),
    .minus_brv(minus_brv[14]),
    .search_brv(search_brv[14]),
    .backoff_brv(backoff_brv[14]),
    .min_brv(min_brv[14]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[14]),
    .dec(dec_0[14])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_15
  (
    .weight_in(weights_0_15),
    .ein(ein[15]),
    .eout(eout[0]),
    .capture_brv(capture_brv[15]),
    .minus_brv(minus_brv[15]),
    .search_brv(search_brv[15]),
    .backoff_brv(backoff_brv[15]),
    .min_brv(min_brv[15]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[15]),
    .dec(dec_0[15])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_16
  (
    .weight_in(weights_0_16),
    .ein(ein[16]),
    .eout(eout[0]),
    .capture_brv(capture_brv[16]),
    .minus_brv(minus_brv[16]),
    .search_brv(search_brv[16]),
    .backoff_brv(backoff_brv[16]),
    .min_brv(min_brv[16]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[16]),
    .dec(dec_0[16])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_0_17
  (
    .weight_in(weights_0_17),
    .ein(ein[17]),
    .eout(eout[0]),
    .capture_brv(capture_brv[17]),
    .minus_brv(minus_brv[17]),
    .search_brv(search_brv[17]),
    .backoff_brv(backoff_brv[17]),
    .min_brv(min_brv[17]),
    .F_brv(F_brv[125:0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_0[17]),
    .dec(dec_0[17])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_0
  (
    .weight_in(weights_1_0),
    .ein(ein[0]),
    .eout(eout[1]),
    .capture_brv(capture_brv[18]),
    .minus_brv(minus_brv[18]),
    .search_brv(search_brv[18]),
    .backoff_brv(backoff_brv[18]),
    .min_brv(min_brv[18]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[0]),
    .dec(dec_1[0])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_1
  (
    .weight_in(weights_1_1),
    .ein(ein[1]),
    .eout(eout[1]),
    .capture_brv(capture_brv[19]),
    .minus_brv(minus_brv[19]),
    .search_brv(search_brv[19]),
    .backoff_brv(backoff_brv[19]),
    .min_brv(min_brv[19]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[1]),
    .dec(dec_1[1])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_2
  (
    .weight_in(weights_1_2),
    .ein(ein[2]),
    .eout(eout[1]),
    .capture_brv(capture_brv[20]),
    .minus_brv(minus_brv[20]),
    .search_brv(search_brv[20]),
    .backoff_brv(backoff_brv[20]),
    .min_brv(min_brv[20]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[2]),
    .dec(dec_1[2])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_3
  (
    .weight_in(weights_1_3),
    .ein(ein[3]),
    .eout(eout[1]),
    .capture_brv(capture_brv[21]),
    .minus_brv(minus_brv[21]),
    .search_brv(search_brv[21]),
    .backoff_brv(backoff_brv[21]),
    .min_brv(min_brv[21]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[3]),
    .dec(dec_1[3])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_4
  (
    .weight_in(weights_1_4),
    .ein(ein[4]),
    .eout(eout[1]),
    .capture_brv(capture_brv[22]),
    .minus_brv(minus_brv[22]),
    .search_brv(search_brv[22]),
    .backoff_brv(backoff_brv[22]),
    .min_brv(min_brv[22]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[4]),
    .dec(dec_1[4])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_5
  (
    .weight_in(weights_1_5),
    .ein(ein[5]),
    .eout(eout[1]),
    .capture_brv(capture_brv[23]),
    .minus_brv(minus_brv[23]),
    .search_brv(search_brv[23]),
    .backoff_brv(backoff_brv[23]),
    .min_brv(min_brv[23]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[5]),
    .dec(dec_1[5])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_6
  (
    .weight_in(weights_1_6),
    .ein(ein[6]),
    .eout(eout[1]),
    .capture_brv(capture_brv[24]),
    .minus_brv(minus_brv[24]),
    .search_brv(search_brv[24]),
    .backoff_brv(backoff_brv[24]),
    .min_brv(min_brv[24]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[6]),
    .dec(dec_1[6])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_7
  (
    .weight_in(weights_1_7),
    .ein(ein[7]),
    .eout(eout[1]),
    .capture_brv(capture_brv[25]),
    .minus_brv(minus_brv[25]),
    .search_brv(search_brv[25]),
    .backoff_brv(backoff_brv[25]),
    .min_brv(min_brv[25]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[7]),
    .dec(dec_1[7])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_8
  (
    .weight_in(weights_1_8),
    .ein(ein[8]),
    .eout(eout[1]),
    .capture_brv(capture_brv[26]),
    .minus_brv(minus_brv[26]),
    .search_brv(search_brv[26]),
    .backoff_brv(backoff_brv[26]),
    .min_brv(min_brv[26]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[8]),
    .dec(dec_1[8])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_9
  (
    .weight_in(weights_1_9),
    .ein(ein[9]),
    .eout(eout[1]),
    .capture_brv(capture_brv[27]),
    .minus_brv(minus_brv[27]),
    .search_brv(search_brv[27]),
    .backoff_brv(backoff_brv[27]),
    .min_brv(min_brv[27]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[9]),
    .dec(dec_1[9])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_10
  (
    .weight_in(weights_1_10),
    .ein(ein[10]),
    .eout(eout[1]),
    .capture_brv(capture_brv[28]),
    .minus_brv(minus_brv[28]),
    .search_brv(search_brv[28]),
    .backoff_brv(backoff_brv[28]),
    .min_brv(min_brv[28]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[10]),
    .dec(dec_1[10])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_11
  (
    .weight_in(weights_1_11),
    .ein(ein[11]),
    .eout(eout[1]),
    .capture_brv(capture_brv[29]),
    .minus_brv(minus_brv[29]),
    .search_brv(search_brv[29]),
    .backoff_brv(backoff_brv[29]),
    .min_brv(min_brv[29]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[11]),
    .dec(dec_1[11])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_12
  (
    .weight_in(weights_1_12),
    .ein(ein[12]),
    .eout(eout[1]),
    .capture_brv(capture_brv[30]),
    .minus_brv(minus_brv[30]),
    .search_brv(search_brv[30]),
    .backoff_brv(backoff_brv[30]),
    .min_brv(min_brv[30]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[12]),
    .dec(dec_1[12])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_13
  (
    .weight_in(weights_1_13),
    .ein(ein[13]),
    .eout(eout[1]),
    .capture_brv(capture_brv[31]),
    .minus_brv(minus_brv[31]),
    .search_brv(search_brv[31]),
    .backoff_brv(backoff_brv[31]),
    .min_brv(min_brv[31]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[13]),
    .dec(dec_1[13])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_14
  (
    .weight_in(weights_1_14),
    .ein(ein[14]),
    .eout(eout[1]),
    .capture_brv(capture_brv[32]),
    .minus_brv(minus_brv[32]),
    .search_brv(search_brv[32]),
    .backoff_brv(backoff_brv[32]),
    .min_brv(min_brv[32]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[14]),
    .dec(dec_1[14])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_15
  (
    .weight_in(weights_1_15),
    .ein(ein[15]),
    .eout(eout[1]),
    .capture_brv(capture_brv[33]),
    .minus_brv(minus_brv[33]),
    .search_brv(search_brv[33]),
    .backoff_brv(backoff_brv[33]),
    .min_brv(min_brv[33]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[15]),
    .dec(dec_1[15])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_16
  (
    .weight_in(weights_1_16),
    .ein(ein[16]),
    .eout(eout[1]),
    .capture_brv(capture_brv[34]),
    .minus_brv(minus_brv[34]),
    .search_brv(search_brv[34]),
    .backoff_brv(backoff_brv[34]),
    .min_brv(min_brv[34]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[16]),
    .dec(dec_1[16])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_1_17
  (
    .weight_in(weights_1_17),
    .ein(ein[17]),
    .eout(eout[1]),
    .capture_brv(capture_brv[35]),
    .minus_brv(minus_brv[35]),
    .search_brv(search_brv[35]),
    .backoff_brv(backoff_brv[35]),
    .min_brv(min_brv[35]),
    .F_brv(F_brv[251:126]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_1[17]),
    .dec(dec_1[17])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_0
  (
    .weight_in(weights_2_0),
    .ein(ein[0]),
    .eout(eout[2]),
    .capture_brv(capture_brv[36]),
    .minus_brv(minus_brv[36]),
    .search_brv(search_brv[36]),
    .backoff_brv(backoff_brv[36]),
    .min_brv(min_brv[36]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[0]),
    .dec(dec_2[0])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_1
  (
    .weight_in(weights_2_1),
    .ein(ein[1]),
    .eout(eout[2]),
    .capture_brv(capture_brv[37]),
    .minus_brv(minus_brv[37]),
    .search_brv(search_brv[37]),
    .backoff_brv(backoff_brv[37]),
    .min_brv(min_brv[37]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[1]),
    .dec(dec_2[1])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_2
  (
    .weight_in(weights_2_2),
    .ein(ein[2]),
    .eout(eout[2]),
    .capture_brv(capture_brv[38]),
    .minus_brv(minus_brv[38]),
    .search_brv(search_brv[38]),
    .backoff_brv(backoff_brv[38]),
    .min_brv(min_brv[38]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[2]),
    .dec(dec_2[2])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_3
  (
    .weight_in(weights_2_3),
    .ein(ein[3]),
    .eout(eout[2]),
    .capture_brv(capture_brv[39]),
    .minus_brv(minus_brv[39]),
    .search_brv(search_brv[39]),
    .backoff_brv(backoff_brv[39]),
    .min_brv(min_brv[39]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[3]),
    .dec(dec_2[3])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_4
  (
    .weight_in(weights_2_4),
    .ein(ein[4]),
    .eout(eout[2]),
    .capture_brv(capture_brv[40]),
    .minus_brv(minus_brv[40]),
    .search_brv(search_brv[40]),
    .backoff_brv(backoff_brv[40]),
    .min_brv(min_brv[40]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[4]),
    .dec(dec_2[4])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_5
  (
    .weight_in(weights_2_5),
    .ein(ein[5]),
    .eout(eout[2]),
    .capture_brv(capture_brv[41]),
    .minus_brv(minus_brv[41]),
    .search_brv(search_brv[41]),
    .backoff_brv(backoff_brv[41]),
    .min_brv(min_brv[41]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[5]),
    .dec(dec_2[5])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_6
  (
    .weight_in(weights_2_6),
    .ein(ein[6]),
    .eout(eout[2]),
    .capture_brv(capture_brv[42]),
    .minus_brv(minus_brv[42]),
    .search_brv(search_brv[42]),
    .backoff_brv(backoff_brv[42]),
    .min_brv(min_brv[42]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[6]),
    .dec(dec_2[6])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_7
  (
    .weight_in(weights_2_7),
    .ein(ein[7]),
    .eout(eout[2]),
    .capture_brv(capture_brv[43]),
    .minus_brv(minus_brv[43]),
    .search_brv(search_brv[43]),
    .backoff_brv(backoff_brv[43]),
    .min_brv(min_brv[43]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[7]),
    .dec(dec_2[7])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_8
  (
    .weight_in(weights_2_8),
    .ein(ein[8]),
    .eout(eout[2]),
    .capture_brv(capture_brv[44]),
    .minus_brv(minus_brv[44]),
    .search_brv(search_brv[44]),
    .backoff_brv(backoff_brv[44]),
    .min_brv(min_brv[44]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[8]),
    .dec(dec_2[8])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_9
  (
    .weight_in(weights_2_9),
    .ein(ein[9]),
    .eout(eout[2]),
    .capture_brv(capture_brv[45]),
    .minus_brv(minus_brv[45]),
    .search_brv(search_brv[45]),
    .backoff_brv(backoff_brv[45]),
    .min_brv(min_brv[45]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[9]),
    .dec(dec_2[9])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_10
  (
    .weight_in(weights_2_10),
    .ein(ein[10]),
    .eout(eout[2]),
    .capture_brv(capture_brv[46]),
    .minus_brv(minus_brv[46]),
    .search_brv(search_brv[46]),
    .backoff_brv(backoff_brv[46]),
    .min_brv(min_brv[46]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[10]),
    .dec(dec_2[10])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_11
  (
    .weight_in(weights_2_11),
    .ein(ein[11]),
    .eout(eout[2]),
    .capture_brv(capture_brv[47]),
    .minus_brv(minus_brv[47]),
    .search_brv(search_brv[47]),
    .backoff_brv(backoff_brv[47]),
    .min_brv(min_brv[47]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[11]),
    .dec(dec_2[11])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_12
  (
    .weight_in(weights_2_12),
    .ein(ein[12]),
    .eout(eout[2]),
    .capture_brv(capture_brv[48]),
    .minus_brv(minus_brv[48]),
    .search_brv(search_brv[48]),
    .backoff_brv(backoff_brv[48]),
    .min_brv(min_brv[48]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[12]),
    .dec(dec_2[12])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_13
  (
    .weight_in(weights_2_13),
    .ein(ein[13]),
    .eout(eout[2]),
    .capture_brv(capture_brv[49]),
    .minus_brv(minus_brv[49]),
    .search_brv(search_brv[49]),
    .backoff_brv(backoff_brv[49]),
    .min_brv(min_brv[49]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[13]),
    .dec(dec_2[13])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_14
  (
    .weight_in(weights_2_14),
    .ein(ein[14]),
    .eout(eout[2]),
    .capture_brv(capture_brv[50]),
    .minus_brv(minus_brv[50]),
    .search_brv(search_brv[50]),
    .backoff_brv(backoff_brv[50]),
    .min_brv(min_brv[50]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[14]),
    .dec(dec_2[14])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_15
  (
    .weight_in(weights_2_15),
    .ein(ein[15]),
    .eout(eout[2]),
    .capture_brv(capture_brv[51]),
    .minus_brv(minus_brv[51]),
    .search_brv(search_brv[51]),
    .backoff_brv(backoff_brv[51]),
    .min_brv(min_brv[51]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[15]),
    .dec(dec_2[15])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_16
  (
    .weight_in(weights_2_16),
    .ein(ein[16]),
    .eout(eout[2]),
    .capture_brv(capture_brv[52]),
    .minus_brv(minus_brv[52]),
    .search_brv(search_brv[52]),
    .backoff_brv(backoff_brv[52]),
    .min_brv(min_brv[52]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[16]),
    .dec(dec_2[16])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_2_17
  (
    .weight_in(weights_2_17),
    .ein(ein[17]),
    .eout(eout[2]),
    .capture_brv(capture_brv[53]),
    .minus_brv(minus_brv[53]),
    .search_brv(search_brv[53]),
    .backoff_brv(backoff_brv[53]),
    .min_brv(min_brv[53]),
    .F_brv(F_brv[377:252]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_2[17]),
    .dec(dec_2[17])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_0
  (
    .weight_in(weights_3_0),
    .ein(ein[0]),
    .eout(eout[3]),
    .capture_brv(capture_brv[54]),
    .minus_brv(minus_brv[54]),
    .search_brv(search_brv[54]),
    .backoff_brv(backoff_brv[54]),
    .min_brv(min_brv[54]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[0]),
    .dec(dec_3[0])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_1
  (
    .weight_in(weights_3_1),
    .ein(ein[1]),
    .eout(eout[3]),
    .capture_brv(capture_brv[55]),
    .minus_brv(minus_brv[55]),
    .search_brv(search_brv[55]),
    .backoff_brv(backoff_brv[55]),
    .min_brv(min_brv[55]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[1]),
    .dec(dec_3[1])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_2
  (
    .weight_in(weights_3_2),
    .ein(ein[2]),
    .eout(eout[3]),
    .capture_brv(capture_brv[56]),
    .minus_brv(minus_brv[56]),
    .search_brv(search_brv[56]),
    .backoff_brv(backoff_brv[56]),
    .min_brv(min_brv[56]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[2]),
    .dec(dec_3[2])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_3
  (
    .weight_in(weights_3_3),
    .ein(ein[3]),
    .eout(eout[3]),
    .capture_brv(capture_brv[57]),
    .minus_brv(minus_brv[57]),
    .search_brv(search_brv[57]),
    .backoff_brv(backoff_brv[57]),
    .min_brv(min_brv[57]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[3]),
    .dec(dec_3[3])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_4
  (
    .weight_in(weights_3_4),
    .ein(ein[4]),
    .eout(eout[3]),
    .capture_brv(capture_brv[58]),
    .minus_brv(minus_brv[58]),
    .search_brv(search_brv[58]),
    .backoff_brv(backoff_brv[58]),
    .min_brv(min_brv[58]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[4]),
    .dec(dec_3[4])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_5
  (
    .weight_in(weights_3_5),
    .ein(ein[5]),
    .eout(eout[3]),
    .capture_brv(capture_brv[59]),
    .minus_brv(minus_brv[59]),
    .search_brv(search_brv[59]),
    .backoff_brv(backoff_brv[59]),
    .min_brv(min_brv[59]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[5]),
    .dec(dec_3[5])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_6
  (
    .weight_in(weights_3_6),
    .ein(ein[6]),
    .eout(eout[3]),
    .capture_brv(capture_brv[60]),
    .minus_brv(minus_brv[60]),
    .search_brv(search_brv[60]),
    .backoff_brv(backoff_brv[60]),
    .min_brv(min_brv[60]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[6]),
    .dec(dec_3[6])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_7
  (
    .weight_in(weights_3_7),
    .ein(ein[7]),
    .eout(eout[3]),
    .capture_brv(capture_brv[61]),
    .minus_brv(minus_brv[61]),
    .search_brv(search_brv[61]),
    .backoff_brv(backoff_brv[61]),
    .min_brv(min_brv[61]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[7]),
    .dec(dec_3[7])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_8
  (
    .weight_in(weights_3_8),
    .ein(ein[8]),
    .eout(eout[3]),
    .capture_brv(capture_brv[62]),
    .minus_brv(minus_brv[62]),
    .search_brv(search_brv[62]),
    .backoff_brv(backoff_brv[62]),
    .min_brv(min_brv[62]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[8]),
    .dec(dec_3[8])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_9
  (
    .weight_in(weights_3_9),
    .ein(ein[9]),
    .eout(eout[3]),
    .capture_brv(capture_brv[63]),
    .minus_brv(minus_brv[63]),
    .search_brv(search_brv[63]),
    .backoff_brv(backoff_brv[63]),
    .min_brv(min_brv[63]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[9]),
    .dec(dec_3[9])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_10
  (
    .weight_in(weights_3_10),
    .ein(ein[10]),
    .eout(eout[3]),
    .capture_brv(capture_brv[64]),
    .minus_brv(minus_brv[64]),
    .search_brv(search_brv[64]),
    .backoff_brv(backoff_brv[64]),
    .min_brv(min_brv[64]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[10]),
    .dec(dec_3[10])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_11
  (
    .weight_in(weights_3_11),
    .ein(ein[11]),
    .eout(eout[3]),
    .capture_brv(capture_brv[65]),
    .minus_brv(minus_brv[65]),
    .search_brv(search_brv[65]),
    .backoff_brv(backoff_brv[65]),
    .min_brv(min_brv[65]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[11]),
    .dec(dec_3[11])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_12
  (
    .weight_in(weights_3_12),
    .ein(ein[12]),
    .eout(eout[3]),
    .capture_brv(capture_brv[66]),
    .minus_brv(minus_brv[66]),
    .search_brv(search_brv[66]),
    .backoff_brv(backoff_brv[66]),
    .min_brv(min_brv[66]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[12]),
    .dec(dec_3[12])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_13
  (
    .weight_in(weights_3_13),
    .ein(ein[13]),
    .eout(eout[3]),
    .capture_brv(capture_brv[67]),
    .minus_brv(minus_brv[67]),
    .search_brv(search_brv[67]),
    .backoff_brv(backoff_brv[67]),
    .min_brv(min_brv[67]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[13]),
    .dec(dec_3[13])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_14
  (
    .weight_in(weights_3_14),
    .ein(ein[14]),
    .eout(eout[3]),
    .capture_brv(capture_brv[68]),
    .minus_brv(minus_brv[68]),
    .search_brv(search_brv[68]),
    .backoff_brv(backoff_brv[68]),
    .min_brv(min_brv[68]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[14]),
    .dec(dec_3[14])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_15
  (
    .weight_in(weights_3_15),
    .ein(ein[15]),
    .eout(eout[3]),
    .capture_brv(capture_brv[69]),
    .minus_brv(minus_brv[69]),
    .search_brv(search_brv[69]),
    .backoff_brv(backoff_brv[69]),
    .min_brv(min_brv[69]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[15]),
    .dec(dec_3[15])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_16
  (
    .weight_in(weights_3_16),
    .ein(ein[16]),
    .eout(eout[3]),
    .capture_brv(capture_brv[70]),
    .minus_brv(minus_brv[70]),
    .search_brv(search_brv[70]),
    .backoff_brv(backoff_brv[70]),
    .min_brv(min_brv[70]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[16]),
    .dec(dec_3[16])
  );


  L0_stdp_wres_7
  #(
    .WRES(7)
  )
  L0_stdp_3_17
  (
    .weight_in(weights_3_17),
    .ein(ein[17]),
    .eout(eout[3]),
    .capture_brv(capture_brv[71]),
    .minus_brv(minus_brv[71]),
    .search_brv(search_brv[71]),
    .backoff_brv(backoff_brv[71]),
    .min_brv(min_brv[71]),
    .F_brv(F_brv[503:378]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .inc(inc_3[17]),
    .dec(dec_3[17])
  );

  assign output_spike = li_spikes;

endmodule



module pulse2edge
(
  input [1-1:0] pulse_in,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] edge_out
);

  reg [1-1:0] temp;

  always @(posedge clk) begin
    if(grst | ~rstb) begin
      temp <= 1'b0;
    end else begin
      temp <= edge_out;
    end
  end

  assign edge_out = pulse_in | temp;

endmodule



module L0_simple_neuron #
(
  parameter INP = 18,
  parameter WRES = 7,
  parameter THRESHOLD = 64
)
(
  input [18-1:0] input_spikes,
  input [18-1:0] inc,
  input [18-1:0] dec,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] output_spike,
  input [126-1:0] w_init,
  output [7-1:0] weights_0,
  output [7-1:0] weights_1,
  output [7-1:0] weights_2,
  output [7-1:0] weights_3,
  output [7-1:0] weights_4,
  output [7-1:0] weights_5,
  output [7-1:0] weights_6,
  output [7-1:0] weights_7,
  output [7-1:0] weights_8,
  output [7-1:0] weights_9,
  output [7-1:0] weights_10,
  output [7-1:0] weights_11,
  output [7-1:0] weights_12,
  output [7-1:0] weights_13,
  output [7-1:0] weights_14,
  output [7-1:0] weights_15,
  output [7-1:0] weights_16,
  output [7-1:0] weights_17
);

  wire [18-1:0] resp_func;

  L0_fsm_synapse
  syn_0
  (
    .input_spike(input_spikes[0]),
    .w_init(w_init[6:0]),
    .inc(inc[0]),
    .dec(dec[0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_0),
    .syn_out(resp_func[0])
  );


  L0_fsm_synapse
  syn_1
  (
    .input_spike(input_spikes[1]),
    .w_init(w_init[13:7]),
    .inc(inc[1]),
    .dec(dec[1]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_1),
    .syn_out(resp_func[1])
  );


  L0_fsm_synapse
  syn_2
  (
    .input_spike(input_spikes[2]),
    .w_init(w_init[20:14]),
    .inc(inc[2]),
    .dec(dec[2]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_2),
    .syn_out(resp_func[2])
  );


  L0_fsm_synapse
  syn_3
  (
    .input_spike(input_spikes[3]),
    .w_init(w_init[27:21]),
    .inc(inc[3]),
    .dec(dec[3]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_3),
    .syn_out(resp_func[3])
  );


  L0_fsm_synapse
  syn_4
  (
    .input_spike(input_spikes[4]),
    .w_init(w_init[34:28]),
    .inc(inc[4]),
    .dec(dec[4]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_4),
    .syn_out(resp_func[4])
  );


  L0_fsm_synapse
  syn_5
  (
    .input_spike(input_spikes[5]),
    .w_init(w_init[41:35]),
    .inc(inc[5]),
    .dec(dec[5]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_5),
    .syn_out(resp_func[5])
  );


  L0_fsm_synapse
  syn_6
  (
    .input_spike(input_spikes[6]),
    .w_init(w_init[48:42]),
    .inc(inc[6]),
    .dec(dec[6]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_6),
    .syn_out(resp_func[6])
  );


  L0_fsm_synapse
  syn_7
  (
    .input_spike(input_spikes[7]),
    .w_init(w_init[55:49]),
    .inc(inc[7]),
    .dec(dec[7]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_7),
    .syn_out(resp_func[7])
  );


  L0_fsm_synapse
  syn_8
  (
    .input_spike(input_spikes[8]),
    .w_init(w_init[62:56]),
    .inc(inc[8]),
    .dec(dec[8]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_8),
    .syn_out(resp_func[8])
  );


  L0_fsm_synapse
  syn_9
  (
    .input_spike(input_spikes[9]),
    .w_init(w_init[69:63]),
    .inc(inc[9]),
    .dec(dec[9]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_9),
    .syn_out(resp_func[9])
  );


  L0_fsm_synapse
  syn_10
  (
    .input_spike(input_spikes[10]),
    .w_init(w_init[76:70]),
    .inc(inc[10]),
    .dec(dec[10]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_10),
    .syn_out(resp_func[10])
  );


  L0_fsm_synapse
  syn_11
  (
    .input_spike(input_spikes[11]),
    .w_init(w_init[83:77]),
    .inc(inc[11]),
    .dec(dec[11]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_11),
    .syn_out(resp_func[11])
  );


  L0_fsm_synapse
  syn_12
  (
    .input_spike(input_spikes[12]),
    .w_init(w_init[90:84]),
    .inc(inc[12]),
    .dec(dec[12]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_12),
    .syn_out(resp_func[12])
  );


  L0_fsm_synapse
  syn_13
  (
    .input_spike(input_spikes[13]),
    .w_init(w_init[97:91]),
    .inc(inc[13]),
    .dec(dec[13]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_13),
    .syn_out(resp_func[13])
  );


  L0_fsm_synapse
  syn_14
  (
    .input_spike(input_spikes[14]),
    .w_init(w_init[104:98]),
    .inc(inc[14]),
    .dec(dec[14]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_14),
    .syn_out(resp_func[14])
  );


  L0_fsm_synapse
  syn_15
  (
    .input_spike(input_spikes[15]),
    .w_init(w_init[111:105]),
    .inc(inc[15]),
    .dec(dec[15]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_15),
    .syn_out(resp_func[15])
  );


  L0_fsm_synapse
  syn_16
  (
    .input_spike(input_spikes[16]),
    .w_init(w_init[118:112]),
    .inc(inc[16]),
    .dec(dec[16]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_16),
    .syn_out(resp_func[16])
  );


  L0_fsm_synapse
  syn_17
  (
    .input_spike(input_spikes[17]),
    .w_init(w_init[125:119]),
    .inc(inc[17]),
    .dec(dec[17]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_17),
    .syn_out(resp_func[17])
  );


  L0_neuron_body
  #(
    .INPUT_SIZE(18),
    .THRESHOLD(64),
    .WRES(7)
  )
  soma
  (
    .acc_in(resp_func),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(output_spike)
  );


endmodule



module L0_fsm_synapse #
(
  parameter WRES = 7
)
(
  input [1-1:0] input_spike,
  input [WRES-1:0] w_init,
  input [1-1:0] inc,
  input [1-1:0] dec,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [WRES-1:0] w_out,
  output [1-1:0] syn_out
);

  reg [WRES-1:0] weight;
  reg [1-1:0] w_nonzero;

  always @(posedge clk) begin
    if(~rstb) begin
      weight <= w_init;
      w_nonzero <= w_init > 0;
    end else begin
      if(grst) begin
        if((inc == 1'b1) & (weight < 7'b1111111)) begin
          weight <= weight + 7'b1;
          w_nonzero <= 1'b1;
        end else if((dec == 1'b1) & (weight > 0)) begin
          weight <= weight - 7'b1;
          w_nonzero <= weight[6:1] != 0;
        end else begin
          w_nonzero <= weight > 0;
        end
      end else begin
        if(input_spike) begin
          weight <= weight - 7'b1;
          if(w_nonzero == 1'b0) begin
            w_nonzero <= 1'b0;
          end else if(|weight[6:1] == 0) begin
            w_nonzero <= 1'b0;
          end else begin
            w_nonzero <= 1'b1;
          end
        end 
      end
    end
  end

  assign syn_out = input_spike & w_nonzero;
  assign w_out = weight;

endmodule



module L0_neuron_body #
(
  parameter INPUT_SIZE = 18,
  parameter THRESHOLD = 64,
  parameter WRES = 7
)
(
  input [18-1:0] acc_in,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] output_spike
);

  wire [1-1:0] edge_spike;
  wire [1-1:0] pulse_spike;

  L0_pac
  #(
    .INP(18),
    .THRESHOLD(64)
  )
  acc
  (
    .in(acc_in),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .pac_out(edge_spike)
  );


  edge2pulse
  epn
  (
    .edge_in(edge_spike),
    .clk(clk),
    .pulse_out(pulse_spike)
  );


  L0_fsm_convert
  #(
    .WRES(7)
  )
  conv
  (
    .in(pulse_spike),
    .clk(clk),
    .rstb(rstb),
    .out(output_spike)
  );


endmodule



module L0_pac #
(
  parameter INP = 18,
  parameter THRESHOLD = 64
)
(
  input [18-1:0] in,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] pac_out
);

  localparam P_RES = 5;
  localparam IN_SIZE = 32;
  localparam STAGES = 4;
  localparam NUM = 57;
  localparam MAXRES = 7;
  wire [32-1:0] padded_in;
  wire [NUM-1:0] temp;
  wire [P_RES-1:0] parallel_out;
  wire [8-1:0] body_pot;
  reg [MAXRES-1:0] regout;
  reg [1-1:0] poutlatch;
  assign padded_in = { 14'b0, in };
  assign temp[0] = padded_in[0];
  assign temp[1] = padded_in[1];
  assign temp[2] = padded_in[2];
  assign temp[3] = padded_in[3];
  assign temp[4] = padded_in[4];
  assign temp[5] = padded_in[5];
  assign temp[6] = padded_in[6];
  assign temp[7] = padded_in[7];
  assign temp[8] = padded_in[8];
  assign temp[9] = padded_in[9];
  assign temp[10] = padded_in[10];
  assign temp[11] = padded_in[11];
  assign temp[12] = padded_in[12];
  assign temp[13] = padded_in[13];
  assign temp[14] = padded_in[14];
  assign temp[15] = padded_in[15];

  adder
  #(
    .RES(1)
  )
  a1_00
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+0+0:(32>>0)*((1<<1)-0-2)+0]),
    .b(temp[(32>>0)*((1<<1)-0-2)+1+0:(32>>0)*((1<<1)-0-2)+1]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 0)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+0+1:(32>>1)*((1<<2)-0-3)+0])
  );


  adder
  #(
    .RES(1)
  )
  a1_01
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+2+0:(32>>0)*((1<<1)-0-2)+2]),
    .b(temp[(32>>0)*((1<<1)-0-2)+3+0:(32>>0)*((1<<1)-0-2)+3]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 1)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+2+1:(32>>1)*((1<<2)-0-3)+2])
  );


  adder
  #(
    .RES(1)
  )
  a1_02
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+4+0:(32>>0)*((1<<1)-0-2)+4]),
    .b(temp[(32>>0)*((1<<1)-0-2)+5+0:(32>>0)*((1<<1)-0-2)+5]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 2)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+4+1:(32>>1)*((1<<2)-0-3)+4])
  );


  adder
  #(
    .RES(1)
  )
  a1_03
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+6+0:(32>>0)*((1<<1)-0-2)+6]),
    .b(temp[(32>>0)*((1<<1)-0-2)+7+0:(32>>0)*((1<<1)-0-2)+7]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 3)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+6+1:(32>>1)*((1<<2)-0-3)+6])
  );


  adder
  #(
    .RES(1)
  )
  a1_04
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+8+0:(32>>0)*((1<<1)-0-2)+8]),
    .b(temp[(32>>0)*((1<<1)-0-2)+9+0:(32>>0)*((1<<1)-0-2)+9]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 4)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+8+1:(32>>1)*((1<<2)-0-3)+8])
  );


  adder
  #(
    .RES(1)
  )
  a1_05
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+10+0:(32>>0)*((1<<1)-0-2)+10]),
    .b(temp[(32>>0)*((1<<1)-0-2)+11+0:(32>>0)*((1<<1)-0-2)+11]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 5)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+10+1:(32>>1)*((1<<2)-0-3)+10])
  );


  adder
  #(
    .RES(1)
  )
  a1_06
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+12+0:(32>>0)*((1<<1)-0-2)+12]),
    .b(temp[(32>>0)*((1<<1)-0-2)+13+0:(32>>0)*((1<<1)-0-2)+13]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 6)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+12+1:(32>>1)*((1<<2)-0-3)+12])
  );


  adder
  #(
    .RES(1)
  )
  a1_07
  (
    .a(temp[(32>>0)*((1<<1)-0-2)+14+0:(32>>0)*((1<<1)-0-2)+14]),
    .b(temp[(32>>0)*((1<<1)-0-2)+15+0:(32>>0)*((1<<1)-0-2)+15]),
    .cin(padded_in[16 + ((32 >> 1) * ((1 << 0) - 1) + 7)]),
    .out(temp[(32>>1)*((1<<2)-0-3)+14+1:(32>>1)*((1<<2)-0-3)+14])
  );


  adder
  #(
    .RES(2)
  )
  a1_10
  (
    .a(temp[(32>>1)*((1<<2)-1-2)+0+1:(32>>1)*((1<<2)-1-2)+0]),
    .b(temp[(32>>1)*((1<<2)-1-2)+2+1:(32>>1)*((1<<2)-1-2)+2]),
    .cin(padded_in[16 + ((32 >> 2) * ((1 << 1) - 1) + 0)]),
    .out(temp[(32>>2)*((1<<3)-1-3)+0+2:(32>>2)*((1<<3)-1-3)+0])
  );


  adder
  #(
    .RES(2)
  )
  a1_11
  (
    .a(temp[(32>>1)*((1<<2)-1-2)+4+1:(32>>1)*((1<<2)-1-2)+4]),
    .b(temp[(32>>1)*((1<<2)-1-2)+6+1:(32>>1)*((1<<2)-1-2)+6]),
    .cin(padded_in[16 + ((32 >> 2) * ((1 << 1) - 1) + 1)]),
    .out(temp[(32>>2)*((1<<3)-1-3)+3+2:(32>>2)*((1<<3)-1-3)+3])
  );


  adder
  #(
    .RES(2)
  )
  a1_12
  (
    .a(temp[(32>>1)*((1<<2)-1-2)+8+1:(32>>1)*((1<<2)-1-2)+8]),
    .b(temp[(32>>1)*((1<<2)-1-2)+10+1:(32>>1)*((1<<2)-1-2)+10]),
    .cin(padded_in[16 + ((32 >> 2) * ((1 << 1) - 1) + 2)]),
    .out(temp[(32>>2)*((1<<3)-1-3)+6+2:(32>>2)*((1<<3)-1-3)+6])
  );


  adder
  #(
    .RES(2)
  )
  a1_13
  (
    .a(temp[(32>>1)*((1<<2)-1-2)+12+1:(32>>1)*((1<<2)-1-2)+12]),
    .b(temp[(32>>1)*((1<<2)-1-2)+14+1:(32>>1)*((1<<2)-1-2)+14]),
    .cin(padded_in[16 + ((32 >> 2) * ((1 << 1) - 1) + 3)]),
    .out(temp[(32>>2)*((1<<3)-1-3)+9+2:(32>>2)*((1<<3)-1-3)+9])
  );


  adder
  #(
    .RES(3)
  )
  a1_20
  (
    .a(temp[(32>>2)*((1<<3)-2-2)+0+2:(32>>2)*((1<<3)-2-2)+0]),
    .b(temp[(32>>2)*((1<<3)-2-2)+3+2:(32>>2)*((1<<3)-2-2)+3]),
    .cin(padded_in[16 + ((32 >> 3) * ((1 << 2) - 1) + 0)]),
    .out(temp[(32>>3)*((1<<4)-2-3)+0+3:(32>>3)*((1<<4)-2-3)+0])
  );


  adder
  #(
    .RES(3)
  )
  a1_21
  (
    .a(temp[(32>>2)*((1<<3)-2-2)+6+2:(32>>2)*((1<<3)-2-2)+6]),
    .b(temp[(32>>2)*((1<<3)-2-2)+9+2:(32>>2)*((1<<3)-2-2)+9]),
    .cin(padded_in[16 + ((32 >> 3) * ((1 << 2) - 1) + 1)]),
    .out(temp[(32>>3)*((1<<4)-2-3)+4+3:(32>>3)*((1<<4)-2-3)+4])
  );


  adder
  #(
    .RES(4)
  )
  a1_30
  (
    .a(temp[(32>>3)*((1<<4)-3-2)+0+3:(32>>3)*((1<<4)-3-2)+0]),
    .b(temp[(32>>3)*((1<<4)-3-2)+4+3:(32>>3)*((1<<4)-3-2)+4]),
    .cin(padded_in[16 + ((32 >> 4) * ((1 << 3) - 1) + 0)]),
    .out(temp[(32>>4)*((1<<5)-3-3)+0+4:(32>>4)*((1<<5)-3-3)+0])
  );

  assign parallel_out = temp[56:52];

  adder
  #(
    .RES(7)
  )
  adder2_in_pac
  (
    .a({ 2'b0, parallel_out }),
    .b(regout),
    .cin(padded_in[31:31]),
    .out(body_pot)
  );


  always @(posedge clk) begin
    if(grst | ~rstb) begin
      regout <= -7'sb1000000;
      poutlatch <= 1'b0;
    end else begin
      if(pac_out) begin
        regout <= -7'sb1000000;
      end else begin
        regout <= body_pot[6:0];
      end
      poutlatch <= pac_out;
    end
  end

  assign pac_out = body_pot[7:7] | poutlatch;

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



module edge2pulse
(
  input [1-1:0] edge_in,
  input [1-1:0] clk,
  output [1-1:0] pulse_out
);

  reg [1-1:0] temp;

  always @(posedge clk) begin
    temp <= edge_in;
  end

  assign pulse_out = edge_in & ~temp;

endmodule



module L0_fsm_convert #
(
  parameter WRES = 7
)
(
  input [1-1:0] in,
  input [1-1:0] clk,
  input [1-1:0] rstb,
  output [1-1:0] out
);

  reg [WRES-1:0] state;
  reg [1-1:0] temp;

  always @(posedge clk) begin
    if(~rstb) begin
      state <= 7'b0;
    end else begin
      if(state == 7'b0) begin
        if(in) begin
          state <= state + 7'b1;
        end 
      end else begin
        state <= state + 7'b1;
      end
    end
  end


  always @(*) begin
    if(state == 0) begin
      temp <= 1'b1;
    end else begin
      temp <= 1'b0;
    end
  end

  assign out = ~temp | temp & in;

endmodule



module L0_wta_4 #
(
  parameter Q = 4
)
(
  input [Q-1:0] ec_spikes,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [Q-1:0] li_out
);

  wire [1-1:0] first_spike;
  wire [1-1:0] first_spike_edge;
  wire [Q-1:0] inhibit_spikes;
  assign first_spike = |ec_spikes;

  pulse2edge
  pe_wta
  (
    .pulse_in(first_spike),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(first_spike_edge)
  );


  less_equal
  l1_0
  (
    .data_in(ec_spikes[0]),
    .inhibit_in(first_spike_edge),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .out(inhibit_spikes[0])
  );


  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike_edge),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .out(inhibit_spikes[1])
  );


  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike_edge),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .out(inhibit_spikes[2])
  );


  less_equal
  l1_3
  (
    .data_in(ec_spikes[3]),
    .inhibit_in(first_spike_edge),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .out(inhibit_spikes[3])
  );

  assign li_out[0] = inhibit_spikes[0];
  assign li_out[1] = inhibit_spikes[1] & ~(|inhibit_spikes[0:0]);
  assign li_out[2] = inhibit_spikes[2] & ~(|inhibit_spikes[1:0]);
  assign li_out[3] = inhibit_spikes[3] & ~(|inhibit_spikes[2:0]);

endmodule



module less_equal
(
  input [1-1:0] data_in,
  input [1-1:0] inhibit_in,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] out
);

  wire [1-1:0] inhibit_only;
  wire [1-1:0] inhibit_only_edge;
  assign inhibit_only = ~data_in & inhibit_in;

  pulse2edge
  pe_le
  (
    .pulse_in(inhibit_only),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(inhibit_only_edge)
  );

  assign out = data_in & ~inhibit_only_edge;

endmodule



module pulse2edge_
(
  input [1-1:0] pulse_in,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] edge_out
);

  reg [1-1:0] temp;

  always @(posedge clk) begin
    if(grst | ~rstb) begin
      temp <= 1'b0;
    end else begin
      temp <= edge_out;
    end
  end

  assign edge_out = pulse_in | temp;

endmodule



module L0_stdp_wres_7 #
(
  parameter WRES = 7
)
(
  input [WRES-1:0] weight_in,
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] capture_brv,
  input [1-1:0] minus_brv,
  input [1-1:0] search_brv,
  input [1-1:0] backoff_brv,
  input [1-1:0] min_brv,
  input [126-1:0] F_brv,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] inc,
  output [1-1:0] dec
);

  wire [4-1:0] stdp_cases;
  wire [1-1:0] fout_brv;

  L0_stdp_case_gen
  casegen
  (
    .ein(ein),
    .eout(eout),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .stdp_cases(stdp_cases)
  );


  L0_stabilize_func_7
  #(
    .WRES(7)
  )
  flogic
  (
    .weight(weight_in),
    .F_brv(F_brv),
    .out(fout_brv)
  );


  incdec
  control
  (
    .stdp_cases(stdp_cases),
    .capture_brv(capture_brv),
    .minus_brv(minus_brv),
    .search_brv(search_brv),
    .backoff_brv(backoff_brv),
    .min_brv(min_brv),
    .fout_brv(fout_brv),
    .inc(inc),
    .dec(dec)
  );


endmodule



module L0_stdp_case_gen
(
  input [1-1:0] ein,
  input [1-1:0] eout,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [4-1:0] stdp_cases
);

  wire [1-1:0] eout_only;
  wire [1-1:0] e_both;
  wire [1-1:0] e_one;
  wire [1-1:0] greater;
  assign eout_only = ~ein & eout;

  pulse2edge
  pe
  (
    .pulse_in(eout_only),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .edge_out(greater)
  );

  assign e_both = ein & eout;
  assign e_one = ein ^ eout;
  assign stdp_cases[0] = ~greater & e_both;
  assign stdp_cases[1] = greater & e_both;
  assign stdp_cases[2] = ~greater & e_one;
  assign stdp_cases[3] = greater & e_one;

endmodule



module L0_stabilize_func_7 #
(
  parameter WRES = 7
)
(
  input [WRES-1:0] weight,
  input [126-1:0] F_brv,
  output [1-1:0] out
);


  integer i;
  reg out_reg;
                    
  always @(*)
  begin
      out_reg = 1'b0;
                    
      if ((weight == 0) | (weight == ((1<<WRES)-1))) begin
          out_reg = 1'b0;
      end
                    
      for (i = 1; i < ((1<<WRES)-1); i = i + 1) begin
          if (weight == i) begin
              out_reg = F_brv[i-1];
          end
      end
  end
                    
  assign out = out_reg;
            

endmodule



module incdec
(
  input [4-1:0] stdp_cases,
  input [1-1:0] capture_brv,
  input [1-1:0] minus_brv,
  input [1-1:0] search_brv,
  input [1-1:0] backoff_brv,
  input [1-1:0] min_brv,
  input [1-1:0] fout_brv,
  output [1-1:0] inc,
  output [1-1:0] dec
);

  wire [1-1:0] stabilize_brv;
  assign stabilize_brv = fout_brv | min_brv;
  assign inc = stdp_cases[0] & capture_brv & stabilize_brv | stdp_cases[2] & search_brv;
  assign dec = stdp_cases[1] & minus_brv & stabilize_brv | stdp_cases[3] & backoff_brv & stabilize_brv;

endmodule

