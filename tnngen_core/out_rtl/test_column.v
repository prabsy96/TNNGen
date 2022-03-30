

module test_column #
(
  parameter P = 4,
  parameter Q = 12,
  parameter THRESHOLD = 12
)
(

);

  reg [4-1:0] input_spikes;
  reg [4-1:0] capture_0;
  reg [4-1:0] minus_0;
  reg [4-1:0] search_0;
  reg [4-1:0] backoff_0;
  reg [4-1:0] min_0;
  reg [6-1:0] F_0;
  reg [4-1:0] capture_1;
  reg [4-1:0] minus_1;
  reg [4-1:0] search_1;
  reg [4-1:0] backoff_1;
  reg [4-1:0] min_1;
  reg [6-1:0] F_1;
  reg [4-1:0] capture_2;
  reg [4-1:0] minus_2;
  reg [4-1:0] search_2;
  reg [4-1:0] backoff_2;
  reg [4-1:0] min_2;
  reg [6-1:0] F_2;
  reg [4-1:0] capture_3;
  reg [4-1:0] minus_3;
  reg [4-1:0] search_3;
  reg [4-1:0] backoff_3;
  reg [4-1:0] min_3;
  reg [6-1:0] F_3;
  reg [4-1:0] capture_4;
  reg [4-1:0] minus_4;
  reg [4-1:0] search_4;
  reg [4-1:0] backoff_4;
  reg [4-1:0] min_4;
  reg [6-1:0] F_4;
  reg [4-1:0] capture_5;
  reg [4-1:0] minus_5;
  reg [4-1:0] search_5;
  reg [4-1:0] backoff_5;
  reg [4-1:0] min_5;
  reg [6-1:0] F_5;
  reg [4-1:0] capture_6;
  reg [4-1:0] minus_6;
  reg [4-1:0] search_6;
  reg [4-1:0] backoff_6;
  reg [4-1:0] min_6;
  reg [6-1:0] F_6;
  reg [4-1:0] capture_7;
  reg [4-1:0] minus_7;
  reg [4-1:0] search_7;
  reg [4-1:0] backoff_7;
  reg [4-1:0] min_7;
  reg [6-1:0] F_7;
  reg [4-1:0] capture_8;
  reg [4-1:0] minus_8;
  reg [4-1:0] search_8;
  reg [4-1:0] backoff_8;
  reg [4-1:0] min_8;
  reg [6-1:0] F_8;
  reg [4-1:0] capture_9;
  reg [4-1:0] minus_9;
  reg [4-1:0] search_9;
  reg [4-1:0] backoff_9;
  reg [4-1:0] min_9;
  reg [6-1:0] F_9;
  reg [4-1:0] capture_10;
  reg [4-1:0] minus_10;
  reg [4-1:0] search_10;
  reg [4-1:0] backoff_10;
  reg [4-1:0] min_10;
  reg [6-1:0] F_10;
  reg [4-1:0] capture_11;
  reg [4-1:0] minus_11;
  reg [4-1:0] search_11;
  reg [4-1:0] backoff_11;
  reg [4-1:0] min_11;
  reg [6-1:0] F_11;
  reg [1-1:0] weight_update_en;
  reg [1-1:0] aclk;
  reg [1-1:0] gclk;
  reg [1-1:0] rst;
  wire [12-1:0] output_spikes;
  integer i;
  integer k;

  column
  #(
    .P(P),
    .Q(Q),
    .THRESHOLD(THRESHOLD)
  )
  dut
  (
    .input_spikes(input_spikes),
    .capture_0(capture_0),
    .minus_0(minus_0),
    .search_0(search_0),
    .backoff_0(backoff_0),
    .min_0(min_0),
    .F_0(F_0),
    .capture_1(capture_1),
    .minus_1(minus_1),
    .search_1(search_1),
    .backoff_1(backoff_1),
    .min_1(min_1),
    .F_1(F_1),
    .capture_2(capture_2),
    .minus_2(minus_2),
    .search_2(search_2),
    .backoff_2(backoff_2),
    .min_2(min_2),
    .F_2(F_2),
    .capture_3(capture_3),
    .minus_3(minus_3),
    .search_3(search_3),
    .backoff_3(backoff_3),
    .min_3(min_3),
    .F_3(F_3),
    .capture_4(capture_4),
    .minus_4(minus_4),
    .search_4(search_4),
    .backoff_4(backoff_4),
    .min_4(min_4),
    .F_4(F_4),
    .capture_5(capture_5),
    .minus_5(minus_5),
    .search_5(search_5),
    .backoff_5(backoff_5),
    .min_5(min_5),
    .F_5(F_5),
    .capture_6(capture_6),
    .minus_6(minus_6),
    .search_6(search_6),
    .backoff_6(backoff_6),
    .min_6(min_6),
    .F_6(F_6),
    .capture_7(capture_7),
    .minus_7(minus_7),
    .search_7(search_7),
    .backoff_7(backoff_7),
    .min_7(min_7),
    .F_7(F_7),
    .capture_8(capture_8),
    .minus_8(minus_8),
    .search_8(search_8),
    .backoff_8(backoff_8),
    .min_8(min_8),
    .F_8(F_8),
    .capture_9(capture_9),
    .minus_9(minus_9),
    .search_9(search_9),
    .backoff_9(backoff_9),
    .min_9(min_9),
    .F_9(F_9),
    .capture_10(capture_10),
    .minus_10(minus_10),
    .search_10(search_10),
    .backoff_10(backoff_10),
    .min_10(min_10),
    .F_10(F_10),
    .capture_11(capture_11),
    .minus_11(minus_11),
    .search_11(search_11),
    .backoff_11(backoff_11),
    .min_11(min_11),
    .F_11(F_11),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .rst(rst),
    .output_spikes(output_spikes)
  );


  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut);
    input_spikes = 0;
    capture_0 = 1;
    capture_1 = 1;
    capture_2 = 1;
    capture_3 = 1;
    capture_4 = 1;
    capture_5 = 1;
    capture_6 = 1;
    capture_7 = 1;
    capture_8 = 1;
    capture_9 = 1;
    capture_10 = 1;
    capture_11 = 1;
    minus_0 = 1;
    minus_1 = 1;
    minus_2 = 1;
    minus_3 = 1;
    minus_4 = 1;
    minus_5 = 1;
    minus_6 = 1;
    minus_7 = 1;
    minus_8 = 1;
    minus_9 = 1;
    minus_10 = 1;
    minus_11 = 1;
    search_0 = 1;
    search_1 = 1;
    search_2 = 1;
    search_3 = 1;
    search_4 = 1;
    search_5 = 1;
    search_6 = 1;
    search_7 = 1;
    search_8 = 1;
    search_9 = 1;
    search_10 = 1;
    search_11 = 1;
    backoff_0 = 1;
    backoff_1 = 1;
    backoff_2 = 1;
    backoff_3 = 1;
    backoff_4 = 1;
    backoff_5 = 1;
    backoff_6 = 1;
    backoff_7 = 1;
    backoff_8 = 1;
    backoff_9 = 1;
    backoff_10 = 1;
    backoff_11 = 1;
    min_0 = 1;
    min_1 = 1;
    min_2 = 1;
    min_3 = 1;
    min_4 = 1;
    min_5 = 1;
    min_6 = 1;
    min_7 = 1;
    min_8 = 1;
    min_9 = 1;
    min_10 = 1;
    min_11 = 1;
    F_0 = 1;
    F_1 = 1;
    F_2 = 1;
    F_3 = 1;
    F_4 = 1;
    F_5 = 1;
    F_6 = 1;
    F_7 = 1;
    F_8 = 1;
    F_9 = 1;
    F_10 = 1;
    F_11 = 1;
    rst = 1;
    gclk = 0;
    #18;
    rst = 0;
    #29;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #6;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 0;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 0;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[3] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[1] = 1;
    #1;
    input_spikes[3] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[1] = 0;
    #2;
    input_spikes[2] = 0;
    #5;
    #1;
    input_spikes[2] = 1;
    #3;
    input_spikes[1] = 1;
    #4;
    input_spikes[3] = 1;
    #1;
    input_spikes[2] = 0;
    #1;
    input_spikes[0] = 1;
    #2;
    input_spikes[1] = 0;
    #4;
    input_spikes[3] = 0;
    #2;
    input_spikes[0] = 0;
    #5;
    #1;
    input_spikes[1] = 1;
    #3;
    input_spikes[0] = 1;
    #4;
    input_spikes[3] = 1;
    #1;
    input_spikes[1] = 0;
    #1;
    input_spikes[2] = 1;
    #2;
    input_spikes[0] = 0;
    #4;
    input_spikes[3] = 0;
    #2;
    input_spikes[2] = 0;
    #10;
    input_spikes = 0;
    #10;
    $finish;
  end


  initial begin
    aclk = 0;
    forever begin
      #0.5 aclk = !aclk;
    end
  end


  always @(aclk) begin
    i = i%23;
    if(i == 0) begin
      gclk = 0;
    end else begin
      gclk = 1;
    end
    i = i+1;
  end


endmodule



module column #
(
  parameter P = 4,
  parameter Q = 12,
  parameter THRESHOLD = 12
)
(
  input [4-1:0] input_spikes,
  input [4-1:0] capture_0,
  input [4-1:0] minus_0,
  input [4-1:0] search_0,
  input [4-1:0] backoff_0,
  input [4-1:0] min_0,
  input [6-1:0] F_0,
  input [4-1:0] capture_1,
  input [4-1:0] minus_1,
  input [4-1:0] search_1,
  input [4-1:0] backoff_1,
  input [4-1:0] min_1,
  input [6-1:0] F_1,
  input [4-1:0] capture_2,
  input [4-1:0] minus_2,
  input [4-1:0] search_2,
  input [4-1:0] backoff_2,
  input [4-1:0] min_2,
  input [6-1:0] F_2,
  input [4-1:0] capture_3,
  input [4-1:0] minus_3,
  input [4-1:0] search_3,
  input [4-1:0] backoff_3,
  input [4-1:0] min_3,
  input [6-1:0] F_3,
  input [4-1:0] capture_4,
  input [4-1:0] minus_4,
  input [4-1:0] search_4,
  input [4-1:0] backoff_4,
  input [4-1:0] min_4,
  input [6-1:0] F_4,
  input [4-1:0] capture_5,
  input [4-1:0] minus_5,
  input [4-1:0] search_5,
  input [4-1:0] backoff_5,
  input [4-1:0] min_5,
  input [6-1:0] F_5,
  input [4-1:0] capture_6,
  input [4-1:0] minus_6,
  input [4-1:0] search_6,
  input [4-1:0] backoff_6,
  input [4-1:0] min_6,
  input [6-1:0] F_6,
  input [4-1:0] capture_7,
  input [4-1:0] minus_7,
  input [4-1:0] search_7,
  input [4-1:0] backoff_7,
  input [4-1:0] min_7,
  input [6-1:0] F_7,
  input [4-1:0] capture_8,
  input [4-1:0] minus_8,
  input [4-1:0] search_8,
  input [4-1:0] backoff_8,
  input [4-1:0] min_8,
  input [6-1:0] F_8,
  input [4-1:0] capture_9,
  input [4-1:0] minus_9,
  input [4-1:0] search_9,
  input [4-1:0] backoff_9,
  input [4-1:0] min_9,
  input [6-1:0] F_9,
  input [4-1:0] capture_10,
  input [4-1:0] minus_10,
  input [4-1:0] search_10,
  input [4-1:0] backoff_10,
  input [4-1:0] min_10,
  input [6-1:0] F_10,
  input [4-1:0] capture_11,
  input [4-1:0] minus_11,
  input [4-1:0] search_11,
  input [4-1:0] backoff_11,
  input [4-1:0] min_11,
  input [6-1:0] F_11,
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] rst,
  output [12-1:0] output_spikes
);

  wire [4-1:0] inc0;
  wire [4-1:0] dec0;
  wire [4-1:0] inc1;
  wire [4-1:0] dec1;
  wire [4-1:0] inc2;
  wire [4-1:0] dec2;
  wire [4-1:0] inc3;
  wire [4-1:0] dec3;
  wire [4-1:0] inc4;
  wire [4-1:0] dec4;
  wire [4-1:0] inc5;
  wire [4-1:0] dec5;
  wire [4-1:0] inc6;
  wire [4-1:0] dec6;
  wire [4-1:0] inc7;
  wire [4-1:0] dec7;
  wire [4-1:0] inc8;
  wire [4-1:0] dec8;
  wire [4-1:0] inc9;
  wire [4-1:0] dec9;
  wire [4-1:0] inc10;
  wire [4-1:0] dec10;
  wire [4-1:0] inc11;
  wire [4-1:0] dec11;
  wire [12-1:0] eout;
  wire [4-1:0] ein;
  wire [12-1:0] ec_spikes;
  wire [3-1:0] weights_0_0;
  wire [3-1:0] weights_0_1;
  wire [3-1:0] weights_0_2;
  wire [3-1:0] weights_0_3;
  wire [3-1:0] weights_1_0;
  wire [3-1:0] weights_1_1;
  wire [3-1:0] weights_1_2;
  wire [3-1:0] weights_1_3;
  wire [3-1:0] weights_2_0;
  wire [3-1:0] weights_2_1;
  wire [3-1:0] weights_2_2;
  wire [3-1:0] weights_2_3;
  wire [3-1:0] weights_3_0;
  wire [3-1:0] weights_3_1;
  wire [3-1:0] weights_3_2;
  wire [3-1:0] weights_3_3;
  wire [3-1:0] weights_4_0;
  wire [3-1:0] weights_4_1;
  wire [3-1:0] weights_4_2;
  wire [3-1:0] weights_4_3;
  wire [3-1:0] weights_5_0;
  wire [3-1:0] weights_5_1;
  wire [3-1:0] weights_5_2;
  wire [3-1:0] weights_5_3;
  wire [3-1:0] weights_6_0;
  wire [3-1:0] weights_6_1;
  wire [3-1:0] weights_6_2;
  wire [3-1:0] weights_6_3;
  wire [3-1:0] weights_7_0;
  wire [3-1:0] weights_7_1;
  wire [3-1:0] weights_7_2;
  wire [3-1:0] weights_7_3;
  wire [3-1:0] weights_8_0;
  wire [3-1:0] weights_8_1;
  wire [3-1:0] weights_8_2;
  wire [3-1:0] weights_8_3;
  wire [3-1:0] weights_9_0;
  wire [3-1:0] weights_9_1;
  wire [3-1:0] weights_9_2;
  wire [3-1:0] weights_9_3;
  wire [3-1:0] weights_10_0;
  wire [3-1:0] weights_10_1;
  wire [3-1:0] weights_10_2;
  wire [3-1:0] weights_10_3;
  wire [3-1:0] weights_11_0;
  wire [3-1:0] weights_11_1;
  wire [3-1:0] weights_11_2;
  wire [3-1:0] weights_11_3;
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
    .pulse_in(input_spikes[0]),
    .grst(gclk_pulse),
    .edge_out(ein[0])
  );


  pulse2edge
  in_pe_1
  (
    .aclk(aclk),
    .pulse_in(input_spikes[1]),
    .grst(gclk_pulse),
    .edge_out(ein[1])
  );


  pulse2edge
  in_pe_2
  (
    .aclk(aclk),
    .pulse_in(input_spikes[2]),
    .grst(gclk_pulse),
    .edge_out(ein[2])
  );


  pulse2edge
  in_pe_3
  (
    .aclk(aclk),
    .pulse_in(input_spikes[3]),
    .grst(gclk_pulse),
    .edge_out(ein[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_0
  (
    .input_spikes(input_spikes),
    .inc(inc0),
    .dec(dec0),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[0]),
    .weights_0(weights_0_0)
  );


  pulse2edge
  out_pe_0
  (
    .aclk(aclk),
    .pulse_in(output_spikes[0]),
    .grst(gclk_pulse),
    .edge_out(eout[0])
  );


  stdp
  s0_000
  (
    .ein(ein[0]),
    .eout(eout[0]),
    .capture(capture_0[0]),
    .minus(minus_0[0]),
    .search(search_0[0]),
    .backoff(backoff_0[0]),
    .min(min_0[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_0),
    .F(F_0),
    .inc(inc0[0]),
    .dec(dec0[0])
  );


  stdp
  s0_101
  (
    .ein(ein[1]),
    .eout(eout[0]),
    .capture(capture_0[1]),
    .minus(minus_0[1]),
    .search(search_0[1]),
    .backoff(backoff_0[1]),
    .min(min_0[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_0),
    .F(F_0),
    .inc(inc0[1]),
    .dec(dec0[1])
  );


  stdp
  s0_202
  (
    .ein(ein[2]),
    .eout(eout[0]),
    .capture(capture_0[2]),
    .minus(minus_0[2]),
    .search(search_0[2]),
    .backoff(backoff_0[2]),
    .min(min_0[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_0),
    .F(F_0),
    .inc(inc0[2]),
    .dec(dec0[2])
  );


  stdp
  s0_303
  (
    .ein(ein[3]),
    .eout(eout[0]),
    .capture(capture_0[3]),
    .minus(minus_0[3]),
    .search(search_0[3]),
    .backoff(backoff_0[3]),
    .min(min_0[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_0),
    .F(F_0),
    .inc(inc0[3]),
    .dec(dec0[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_1
  (
    .input_spikes(input_spikes),
    .inc(inc1),
    .dec(dec1),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[1]),
    .weights_0(weights_0_1)
  );


  pulse2edge
  out_pe_1
  (
    .aclk(aclk),
    .pulse_in(output_spikes[1]),
    .grst(gclk_pulse),
    .edge_out(eout[1])
  );


  stdp
  s0_010
  (
    .ein(ein[0]),
    .eout(eout[1]),
    .capture(capture_1[0]),
    .minus(minus_1[0]),
    .search(search_1[0]),
    .backoff(backoff_1[0]),
    .min(min_1[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_1),
    .F(F_1),
    .inc(inc1[0]),
    .dec(dec1[0])
  );


  stdp
  s0_111
  (
    .ein(ein[1]),
    .eout(eout[1]),
    .capture(capture_1[1]),
    .minus(minus_1[1]),
    .search(search_1[1]),
    .backoff(backoff_1[1]),
    .min(min_1[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_1),
    .F(F_1),
    .inc(inc1[1]),
    .dec(dec1[1])
  );


  stdp
  s0_212
  (
    .ein(ein[2]),
    .eout(eout[1]),
    .capture(capture_1[2]),
    .minus(minus_1[2]),
    .search(search_1[2]),
    .backoff(backoff_1[2]),
    .min(min_1[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_1),
    .F(F_1),
    .inc(inc1[2]),
    .dec(dec1[2])
  );


  stdp
  s0_313
  (
    .ein(ein[3]),
    .eout(eout[1]),
    .capture(capture_1[3]),
    .minus(minus_1[3]),
    .search(search_1[3]),
    .backoff(backoff_1[3]),
    .min(min_1[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_1),
    .F(F_1),
    .inc(inc1[3]),
    .dec(dec1[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_2
  (
    .input_spikes(input_spikes),
    .inc(inc2),
    .dec(dec2),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[2]),
    .weights_0(weights_0_2)
  );


  pulse2edge
  out_pe_2
  (
    .aclk(aclk),
    .pulse_in(output_spikes[2]),
    .grst(gclk_pulse),
    .edge_out(eout[2])
  );


  stdp
  s0_020
  (
    .ein(ein[0]),
    .eout(eout[2]),
    .capture(capture_2[0]),
    .minus(minus_2[0]),
    .search(search_2[0]),
    .backoff(backoff_2[0]),
    .min(min_2[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_2),
    .F(F_2),
    .inc(inc2[0]),
    .dec(dec2[0])
  );


  stdp
  s0_121
  (
    .ein(ein[1]),
    .eout(eout[2]),
    .capture(capture_2[1]),
    .minus(minus_2[1]),
    .search(search_2[1]),
    .backoff(backoff_2[1]),
    .min(min_2[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_2),
    .F(F_2),
    .inc(inc2[1]),
    .dec(dec2[1])
  );


  stdp
  s0_222
  (
    .ein(ein[2]),
    .eout(eout[2]),
    .capture(capture_2[2]),
    .minus(minus_2[2]),
    .search(search_2[2]),
    .backoff(backoff_2[2]),
    .min(min_2[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_2),
    .F(F_2),
    .inc(inc2[2]),
    .dec(dec2[2])
  );


  stdp
  s0_323
  (
    .ein(ein[3]),
    .eout(eout[2]),
    .capture(capture_2[3]),
    .minus(minus_2[3]),
    .search(search_2[3]),
    .backoff(backoff_2[3]),
    .min(min_2[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_2),
    .F(F_2),
    .inc(inc2[3]),
    .dec(dec2[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_3
  (
    .input_spikes(input_spikes),
    .inc(inc3),
    .dec(dec3),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[3]),
    .weights_0(weights_0_3)
  );


  pulse2edge
  out_pe_3
  (
    .aclk(aclk),
    .pulse_in(output_spikes[3]),
    .grst(gclk_pulse),
    .edge_out(eout[3])
  );


  stdp
  s0_030
  (
    .ein(ein[0]),
    .eout(eout[3]),
    .capture(capture_3[0]),
    .minus(minus_3[0]),
    .search(search_3[0]),
    .backoff(backoff_3[0]),
    .min(min_3[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_3),
    .F(F_3),
    .inc(inc3[0]),
    .dec(dec3[0])
  );


  stdp
  s0_131
  (
    .ein(ein[1]),
    .eout(eout[3]),
    .capture(capture_3[1]),
    .minus(minus_3[1]),
    .search(search_3[1]),
    .backoff(backoff_3[1]),
    .min(min_3[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_3),
    .F(F_3),
    .inc(inc3[1]),
    .dec(dec3[1])
  );


  stdp
  s0_232
  (
    .ein(ein[2]),
    .eout(eout[3]),
    .capture(capture_3[2]),
    .minus(minus_3[2]),
    .search(search_3[2]),
    .backoff(backoff_3[2]),
    .min(min_3[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_3),
    .F(F_3),
    .inc(inc3[2]),
    .dec(dec3[2])
  );


  stdp
  s0_333
  (
    .ein(ein[3]),
    .eout(eout[3]),
    .capture(capture_3[3]),
    .minus(minus_3[3]),
    .search(search_3[3]),
    .backoff(backoff_3[3]),
    .min(min_3[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_0_3),
    .F(F_3),
    .inc(inc3[3]),
    .dec(dec3[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_4
  (
    .input_spikes(input_spikes),
    .inc(inc4),
    .dec(dec4),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[4]),
    .weights_0(weights_1_0)
  );


  pulse2edge
  out_pe_4
  (
    .aclk(aclk),
    .pulse_in(output_spikes[4]),
    .grst(gclk_pulse),
    .edge_out(eout[4])
  );


  stdp
  s0_040
  (
    .ein(ein[0]),
    .eout(eout[4]),
    .capture(capture_4[0]),
    .minus(minus_4[0]),
    .search(search_4[0]),
    .backoff(backoff_4[0]),
    .min(min_4[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_0),
    .F(F_4),
    .inc(inc4[0]),
    .dec(dec4[0])
  );


  stdp
  s0_141
  (
    .ein(ein[1]),
    .eout(eout[4]),
    .capture(capture_4[1]),
    .minus(minus_4[1]),
    .search(search_4[1]),
    .backoff(backoff_4[1]),
    .min(min_4[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_0),
    .F(F_4),
    .inc(inc4[1]),
    .dec(dec4[1])
  );


  stdp
  s0_242
  (
    .ein(ein[2]),
    .eout(eout[4]),
    .capture(capture_4[2]),
    .minus(minus_4[2]),
    .search(search_4[2]),
    .backoff(backoff_4[2]),
    .min(min_4[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_0),
    .F(F_4),
    .inc(inc4[2]),
    .dec(dec4[2])
  );


  stdp
  s0_343
  (
    .ein(ein[3]),
    .eout(eout[4]),
    .capture(capture_4[3]),
    .minus(minus_4[3]),
    .search(search_4[3]),
    .backoff(backoff_4[3]),
    .min(min_4[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_0),
    .F(F_4),
    .inc(inc4[3]),
    .dec(dec4[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_5
  (
    .input_spikes(input_spikes),
    .inc(inc5),
    .dec(dec5),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[5]),
    .weights_0(weights_1_1)
  );


  pulse2edge
  out_pe_5
  (
    .aclk(aclk),
    .pulse_in(output_spikes[5]),
    .grst(gclk_pulse),
    .edge_out(eout[5])
  );


  stdp
  s0_050
  (
    .ein(ein[0]),
    .eout(eout[5]),
    .capture(capture_5[0]),
    .minus(minus_5[0]),
    .search(search_5[0]),
    .backoff(backoff_5[0]),
    .min(min_5[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_1),
    .F(F_5),
    .inc(inc5[0]),
    .dec(dec5[0])
  );


  stdp
  s0_151
  (
    .ein(ein[1]),
    .eout(eout[5]),
    .capture(capture_5[1]),
    .minus(minus_5[1]),
    .search(search_5[1]),
    .backoff(backoff_5[1]),
    .min(min_5[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_1),
    .F(F_5),
    .inc(inc5[1]),
    .dec(dec5[1])
  );


  stdp
  s0_252
  (
    .ein(ein[2]),
    .eout(eout[5]),
    .capture(capture_5[2]),
    .minus(minus_5[2]),
    .search(search_5[2]),
    .backoff(backoff_5[2]),
    .min(min_5[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_1),
    .F(F_5),
    .inc(inc5[2]),
    .dec(dec5[2])
  );


  stdp
  s0_353
  (
    .ein(ein[3]),
    .eout(eout[5]),
    .capture(capture_5[3]),
    .minus(minus_5[3]),
    .search(search_5[3]),
    .backoff(backoff_5[3]),
    .min(min_5[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_1),
    .F(F_5),
    .inc(inc5[3]),
    .dec(dec5[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_6
  (
    .input_spikes(input_spikes),
    .inc(inc6),
    .dec(dec6),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[6]),
    .weights_0(weights_1_2)
  );


  pulse2edge
  out_pe_6
  (
    .aclk(aclk),
    .pulse_in(output_spikes[6]),
    .grst(gclk_pulse),
    .edge_out(eout[6])
  );


  stdp
  s0_060
  (
    .ein(ein[0]),
    .eout(eout[6]),
    .capture(capture_6[0]),
    .minus(minus_6[0]),
    .search(search_6[0]),
    .backoff(backoff_6[0]),
    .min(min_6[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_2),
    .F(F_6),
    .inc(inc6[0]),
    .dec(dec6[0])
  );


  stdp
  s0_161
  (
    .ein(ein[1]),
    .eout(eout[6]),
    .capture(capture_6[1]),
    .minus(minus_6[1]),
    .search(search_6[1]),
    .backoff(backoff_6[1]),
    .min(min_6[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_2),
    .F(F_6),
    .inc(inc6[1]),
    .dec(dec6[1])
  );


  stdp
  s0_262
  (
    .ein(ein[2]),
    .eout(eout[6]),
    .capture(capture_6[2]),
    .minus(minus_6[2]),
    .search(search_6[2]),
    .backoff(backoff_6[2]),
    .min(min_6[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_2),
    .F(F_6),
    .inc(inc6[2]),
    .dec(dec6[2])
  );


  stdp
  s0_363
  (
    .ein(ein[3]),
    .eout(eout[6]),
    .capture(capture_6[3]),
    .minus(minus_6[3]),
    .search(search_6[3]),
    .backoff(backoff_6[3]),
    .min(min_6[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_2),
    .F(F_6),
    .inc(inc6[3]),
    .dec(dec6[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_7
  (
    .input_spikes(input_spikes),
    .inc(inc7),
    .dec(dec7),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[7]),
    .weights_0(weights_1_3)
  );


  pulse2edge
  out_pe_7
  (
    .aclk(aclk),
    .pulse_in(output_spikes[7]),
    .grst(gclk_pulse),
    .edge_out(eout[7])
  );


  stdp
  s0_070
  (
    .ein(ein[0]),
    .eout(eout[7]),
    .capture(capture_7[0]),
    .minus(minus_7[0]),
    .search(search_7[0]),
    .backoff(backoff_7[0]),
    .min(min_7[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_3),
    .F(F_7),
    .inc(inc7[0]),
    .dec(dec7[0])
  );


  stdp
  s0_171
  (
    .ein(ein[1]),
    .eout(eout[7]),
    .capture(capture_7[1]),
    .minus(minus_7[1]),
    .search(search_7[1]),
    .backoff(backoff_7[1]),
    .min(min_7[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_3),
    .F(F_7),
    .inc(inc7[1]),
    .dec(dec7[1])
  );


  stdp
  s0_272
  (
    .ein(ein[2]),
    .eout(eout[7]),
    .capture(capture_7[2]),
    .minus(minus_7[2]),
    .search(search_7[2]),
    .backoff(backoff_7[2]),
    .min(min_7[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_3),
    .F(F_7),
    .inc(inc7[2]),
    .dec(dec7[2])
  );


  stdp
  s0_373
  (
    .ein(ein[3]),
    .eout(eout[7]),
    .capture(capture_7[3]),
    .minus(minus_7[3]),
    .search(search_7[3]),
    .backoff(backoff_7[3]),
    .min(min_7[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_1_3),
    .F(F_7),
    .inc(inc7[3]),
    .dec(dec7[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_8
  (
    .input_spikes(input_spikes),
    .inc(inc8),
    .dec(dec8),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[8]),
    .weights_0(weights_2_0)
  );


  pulse2edge
  out_pe_8
  (
    .aclk(aclk),
    .pulse_in(output_spikes[8]),
    .grst(gclk_pulse),
    .edge_out(eout[8])
  );


  stdp
  s0_080
  (
    .ein(ein[0]),
    .eout(eout[8]),
    .capture(capture_8[0]),
    .minus(minus_8[0]),
    .search(search_8[0]),
    .backoff(backoff_8[0]),
    .min(min_8[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_0),
    .F(F_8),
    .inc(inc8[0]),
    .dec(dec8[0])
  );


  stdp
  s0_181
  (
    .ein(ein[1]),
    .eout(eout[8]),
    .capture(capture_8[1]),
    .minus(minus_8[1]),
    .search(search_8[1]),
    .backoff(backoff_8[1]),
    .min(min_8[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_0),
    .F(F_8),
    .inc(inc8[1]),
    .dec(dec8[1])
  );


  stdp
  s0_282
  (
    .ein(ein[2]),
    .eout(eout[8]),
    .capture(capture_8[2]),
    .minus(minus_8[2]),
    .search(search_8[2]),
    .backoff(backoff_8[2]),
    .min(min_8[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_0),
    .F(F_8),
    .inc(inc8[2]),
    .dec(dec8[2])
  );


  stdp
  s0_383
  (
    .ein(ein[3]),
    .eout(eout[8]),
    .capture(capture_8[3]),
    .minus(minus_8[3]),
    .search(search_8[3]),
    .backoff(backoff_8[3]),
    .min(min_8[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_0),
    .F(F_8),
    .inc(inc8[3]),
    .dec(dec8[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_9
  (
    .input_spikes(input_spikes),
    .inc(inc9),
    .dec(dec9),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[9]),
    .weights_0(weights_2_1)
  );


  pulse2edge
  out_pe_9
  (
    .aclk(aclk),
    .pulse_in(output_spikes[9]),
    .grst(gclk_pulse),
    .edge_out(eout[9])
  );


  stdp
  s0_090
  (
    .ein(ein[0]),
    .eout(eout[9]),
    .capture(capture_9[0]),
    .minus(minus_9[0]),
    .search(search_9[0]),
    .backoff(backoff_9[0]),
    .min(min_9[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_1),
    .F(F_9),
    .inc(inc9[0]),
    .dec(dec9[0])
  );


  stdp
  s0_191
  (
    .ein(ein[1]),
    .eout(eout[9]),
    .capture(capture_9[1]),
    .minus(minus_9[1]),
    .search(search_9[1]),
    .backoff(backoff_9[1]),
    .min(min_9[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_1),
    .F(F_9),
    .inc(inc9[1]),
    .dec(dec9[1])
  );


  stdp
  s0_292
  (
    .ein(ein[2]),
    .eout(eout[9]),
    .capture(capture_9[2]),
    .minus(minus_9[2]),
    .search(search_9[2]),
    .backoff(backoff_9[2]),
    .min(min_9[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_1),
    .F(F_9),
    .inc(inc9[2]),
    .dec(dec9[2])
  );


  stdp
  s0_393
  (
    .ein(ein[3]),
    .eout(eout[9]),
    .capture(capture_9[3]),
    .minus(minus_9[3]),
    .search(search_9[3]),
    .backoff(backoff_9[3]),
    .min(min_9[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_1),
    .F(F_9),
    .inc(inc9[3]),
    .dec(dec9[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_10
  (
    .input_spikes(input_spikes),
    .inc(inc10),
    .dec(dec10),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[10]),
    .weights_0(weights_2_2)
  );


  pulse2edge
  out_pe_10
  (
    .aclk(aclk),
    .pulse_in(output_spikes[10]),
    .grst(gclk_pulse),
    .edge_out(eout[10])
  );


  stdp
  s0_0100
  (
    .ein(ein[0]),
    .eout(eout[10]),
    .capture(capture_10[0]),
    .minus(minus_10[0]),
    .search(search_10[0]),
    .backoff(backoff_10[0]),
    .min(min_10[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_2),
    .F(F_10),
    .inc(inc10[0]),
    .dec(dec10[0])
  );


  stdp
  s0_1101
  (
    .ein(ein[1]),
    .eout(eout[10]),
    .capture(capture_10[1]),
    .minus(minus_10[1]),
    .search(search_10[1]),
    .backoff(backoff_10[1]),
    .min(min_10[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_2),
    .F(F_10),
    .inc(inc10[1]),
    .dec(dec10[1])
  );


  stdp
  s0_2102
  (
    .ein(ein[2]),
    .eout(eout[10]),
    .capture(capture_10[2]),
    .minus(minus_10[2]),
    .search(search_10[2]),
    .backoff(backoff_10[2]),
    .min(min_10[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_2),
    .F(F_10),
    .inc(inc10[2]),
    .dec(dec10[2])
  );


  stdp
  s0_3103
  (
    .ein(ein[3]),
    .eout(eout[10]),
    .capture(capture_10[3]),
    .minus(minus_10[3]),
    .search(search_10[3]),
    .backoff(backoff_10[3]),
    .min(min_10[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_2),
    .F(F_10),
    .inc(inc10[3]),
    .dec(dec10[3])
  );


  neuron_rnl_ptt
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
  )
  ec_11
  (
    .input_spikes(input_spikes),
    .inc(inc11),
    .dec(dec11),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(gclk_pulse),
    .rst(rst),
    .out_spike(ec_spikes[11]),
    .weights_0(weights_2_3)
  );


  pulse2edge
  out_pe_11
  (
    .aclk(aclk),
    .pulse_in(output_spikes[11]),
    .grst(gclk_pulse),
    .edge_out(eout[11])
  );


  stdp
  s0_0110
  (
    .ein(ein[0]),
    .eout(eout[11]),
    .capture(capture_11[0]),
    .minus(minus_11[0]),
    .search(search_11[0]),
    .backoff(backoff_11[0]),
    .min(min_11[0]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_3),
    .F(F_11),
    .inc(inc11[0]),
    .dec(dec11[0])
  );


  stdp
  s0_1111
  (
    .ein(ein[1]),
    .eout(eout[11]),
    .capture(capture_11[1]),
    .minus(minus_11[1]),
    .search(search_11[1]),
    .backoff(backoff_11[1]),
    .min(min_11[1]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_3),
    .F(F_11),
    .inc(inc11[1]),
    .dec(dec11[1])
  );


  stdp
  s0_2112
  (
    .ein(ein[2]),
    .eout(eout[11]),
    .capture(capture_11[2]),
    .minus(minus_11[2]),
    .search(search_11[2]),
    .backoff(backoff_11[2]),
    .min(min_11[2]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_3),
    .F(F_11),
    .inc(inc11[2]),
    .dec(dec11[2])
  );


  stdp
  s0_3113
  (
    .ein(ein[3]),
    .eout(eout[11]),
    .capture(capture_11[3]),
    .minus(minus_11[3]),
    .search(search_11[3]),
    .backoff(backoff_11[3]),
    .min(min_11[3]),
    .aclk(aclk),
    .grst(gclk_pulse),
    .input_weight(weights_2_3),
    .F(F_11),
    .inc(inc11[3]),
    .dec(dec11[3])
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
  assign edge_out = pulse_in | temp;

  always @(posedge aclk) begin
    if(grst) begin
      temp <= 1'b0;
    end else begin
      temp <= edge_out;
    end
  end


endmodule



module neuron_rnl_ptt #
(
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 12
)
(
  input [4-1:0] input_spikes,
  input [4-1:0] inc,
  input [4-1:0] dec,
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] out_spike,
  output [3-1:0] weights_0,
  output [3-1:0] weights_1,
  output [3-1:0] weights_2,
  output [3-1:0] weights_3
);

  wire [4-1:0] up_in;

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


  neuron_body
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
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
  wire [1-1:0] tinc;
  wire [1-1:0] tdec;
  reg [1-1:0] spike;
  assign tinc = inc & ~input_spike;
  assign tdec = dec & ~input_spike;

  always @(posedge aclk) begin
    if(rst) begin
      state <= S0;
      spike <= 0;
      dout <= 0;
    end else begin
      if(gclk) begin
        dout <= 0;
        if(state == S0) begin
          if((tinc & weight_update_en) == 1) begin
            state <= S1;
          end 
        end else if(state == S1) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S0;
          end else if((tinc & weight_update_en) == 1) begin
            state <= S2;
          end 
        end else if(state == S2) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S1;
          end else if((tinc & weight_update_en) == 1) begin
            state <= S3;
          end 
        end else if(state == S3) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S2;
          end else if((tinc & weight_update_en) == 1) begin
            state <= S4;
          end 
        end else if(state == S4) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S3;
          end else if((tinc & weight_update_en) == 1) begin
            state <= S5;
          end 
        end else if(state == S5) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S4;
          end else if((tinc & weight_update_en) == 1) begin
            state <= S6;
          end 
        end else if(state == S6) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S5;
          end else if((tinc & weight_update_en) == 1) begin
            state <= S7;
          end 
        end else if(state == S7) begin
          if((tdec & weight_update_en) == 1) begin
            state <= S6;
          end 
        end 
      end else if(input_spike) begin
        spike <= 1;
        if(state == S0) begin
          state <= S7;
          dout <= 1;
        end else if(state == S1) begin
          state <= S0;
        end else if(state == S2) begin
          state <= S1;
        end else if(state == S3) begin
          state <= S2;
        end else if(state == S4) begin
          state <= S3;
        end else if(state == S5) begin
          state <= S4;
        end else if(state == S6) begin
          state <= S5;
        end else if(state == S7) begin
          state <= S6;
        end 
      end else begin
        spike <= 0;
      end
    end
  end

  assign out = ~dout | spike;
  assign weight = state;

endmodule



module neuron_body #
(
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 12
)
(
  input [4-1:0] acc_in,
  input [1-1:0] aclk,
  input [1-1:0] pac_rst,
  input [1-1:0] rst,
  output [1-1:0] out_spike
);

  wire [1-1:0] temp_spike;

  pac
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(12)
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
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 12
)
(
  input [4-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [1-1:0] out
);

  localparam STAGES = 1;
  localparam OUT_RES = 2;
  localparam NUM = 4;
  localparam MAXRES = 4;
  wire [4-1:0] temp;
  wire [2-1:0] tout;
  wire [5-1:0] t2out;
  reg [4-1:0] fout;
  wire [4-1:0] muxout;
  assign temp[0] = in[0];
  assign temp[1] = in[1];

  adder
  #(
    .RES(1)
  )
  a1_00
  (
    .a(temp[(4>>0)*((1<<1)-0-2)+0+0:(4>>0)*((1<<1)-0-2)+0]),
    .b(temp[(4>>0)*((1<<1)-0-2)+1+0:(4>>0)*((1<<1)-0-2)+1]),
    .cin(in[2 + ((4 >> 1) * ((1 << 0) - 1) + 0)]),
    .out(temp[(4>>1)*((1<<2)-0-3)+0+1:(4>>1)*((1<<2)-0-3)+0])
  );

  assign tout = temp[3:2];

  adder
  #(
    .RES(4)
  )
  adder2_in_pac
  (
    .a({ 2'b0, tout }),
    .b(fout),
    .cin(in[3]),
    .out(t2out)
  );

  assign muxout = ((out | grst) == 1)? -4'sb1100 : t2out[4:1];

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
  output out
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
  localparam [3-1:0] S0 = 0;
  localparam [3-1:0] S1 = 1;
  localparam [3-1:0] S2 = 2;
  localparam [3-1:0] S3 = 3;
  localparam [3-1:0] S4 = 4;
  localparam [3-1:0] S5 = 5;
  localparam [3-1:0] S6 = 6;
  localparam [3-1:0] S7 = 7;
  reg [3-1:0] state;

  always @(posedge aclk) begin
    if(rst) begin
      state <= S0;
    end else begin
      if(state == S0) begin
        if(in) begin
          state <= S1;
        end else begin
          state <= S0;
        end
      end else if(state == S1) begin
        state <= S2;
      end else if(state == S2) begin
        state <= S3;
      end else if(state == S3) begin
        state <= S4;
      end else if(state == S4) begin
        state <= S5;
      end else if(state == S5) begin
        state <= S6;
      end else if(state == S6) begin
        state <= S7;
      end else if(state == S7) begin
        state <= S0;
      end else begin
        state <= S0;
      end
    end
  end

  assign out = ~temp | temp & in;
  assign temp = ~state[2] | state[1] | state[0];

endmodule



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

  stdp_case_gen
  s1
  (
    .ein(ein),
    .eout(eout),
    .aclk(aclk),
    .grst(grst),
    .stdp_cases(stdp_cases)
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
  assign stdp_cases[3] = ~greater & tboth;
  assign stdp_cases[2] = greater & tboth;
  assign stdp_cases[1] = ~greater & tone;
  assign stdp_cases[0] = greater & tone;

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
      out <= F[5];
    end else if(input_weight == 3'b10) begin
      out <= F[4];
    end else if(input_weight == 3'b11) begin
      out <= F[3];
    end else if(input_weight == 3'b100) begin
      out <= F[2];
    end else if(input_weight == 3'b101) begin
      out <= F[1];
    end else if(input_weight == 3'b110) begin
      out <= F[0];
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
  parameter Q = 12
)
(
  input [12-1:0] ec_spikes,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [12-1:0] li_out
);

  wire first_spike;
  wire [12-1:0] temp;
  genvar i;

  less_equal
  l1_0
  (
    .data_in(ec_spikes[0]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[0])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[1])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[2])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_3
  (
    .data_in(ec_spikes[3]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[3])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_4
  (
    .data_in(ec_spikes[4]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[4])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_5
  (
    .data_in(ec_spikes[5]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[5])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_6
  (
    .data_in(ec_spikes[6]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[6])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_7
  (
    .data_in(ec_spikes[7]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[7])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_8
  (
    .data_in(ec_spikes[8]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[8])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_9
  (
    .data_in(ec_spikes[9]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[9])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_10
  (
    .data_in(ec_spikes[10]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[10])
  );

  assign li_out[11] = temp[11];

  less_equal
  l1_11
  (
    .data_in(ec_spikes[11]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[11])
  );

  assign li_out[11] = temp[11];
  assign li_out[10] = temp[10] & ~(|temp[11:11]);
  assign li_out[9] = temp[9] & ~(|temp[11:10]);
  assign li_out[8] = temp[8] & ~(|temp[11:9]);
  assign li_out[7] = temp[7] & ~(|temp[11:8]);
  assign li_out[6] = temp[6] & ~(|temp[11:7]);
  assign li_out[5] = temp[5] & ~(|temp[11:6]);
  assign li_out[4] = temp[4] & ~(|temp[11:5]);
  assign li_out[3] = temp[3] & ~(|temp[11:4]);
  assign li_out[2] = temp[2] & ~(|temp[11:3]);
  assign li_out[1] = temp[1] & ~(|temp[11:2]);
  assign li_out[0] = temp[0] & ~(|temp[11:1]);

endmodule



module less_equal
(
  input [1-1:0] data_in,
  input [1-1:0] inhibit_in,
  input [1-1:0] aclk,
  input [1-1:0] rst,
  output [1-1:0] out
);

  wire [1-1:0] temp1;
  wire [1-1:0] temp2;

  pulse2edge
  pulse_inst
  (
    .aclk(aclk),
    .pulse_in(temp1),
    .grst(rst),
    .edge_out(temp2)
  );

  assign temp1 = ~data_in & inhibit_in;
  assign out = data_in & ~temp2;

endmodule

