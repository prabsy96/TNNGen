

module test_column #
(
  parameter P = 4,
  parameter Q = 3,
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
  reg [1-1:0] weight_update_en;
  reg [1-1:0] aclk;
  reg [1-1:0] gclk;
  reg [1-1:0] rst;
  wire [3-1:0] output_spikes;
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
    minus_0 = 1;
    minus_1 = 1;
    minus_2 = 1;
    search_0 = 1;
    search_1 = 1;
    search_2 = 1;
    backoff_0 = 1;
    backoff_1 = 1;
    backoff_2 = 1;
    min_0 = 1;
    min_1 = 1;
    min_2 = 1;
    F_0 = 1;
    F_1 = 1;
    F_2 = 1;
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
  parameter Q = 3,
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
  input [1-1:0] weight_update_en,
  input [1-1:0] aclk,
  input [1-1:0] gclk,
  input [1-1:0] rst,
  output [3-1:0] output_spikes
);

  wire [4-1:0] inc0;
  wire [4-1:0] dec0;
  wire [4-1:0] inc1;
  wire [4-1:0] dec1;
  wire [4-1:0] inc2;
  wire [4-1:0] dec2;
  wire [3-1:0] eout;
  wire [4-1:0] ein;
  wire [3-1:0] ec_spikes;
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


  wta
  #(
    .Q(3)
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
  parameter Q = 3
)
(
  input [3-1:0] ec_spikes,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  output [3-1:0] li_out
);

  wire first_spike;
  wire [3-1:0] temp;
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

  assign li_out[2] = temp[2];

  less_equal
  l1_1
  (
    .data_in(ec_spikes[1]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[1])
  );

  assign li_out[2] = temp[2];

  less_equal
  l1_2
  (
    .data_in(ec_spikes[2]),
    .inhibit_in(first_spike),
    .aclk(aclk),
    .rst(grst),
    .out(temp[2])
  );

  assign li_out[2] = temp[2];
  assign li_out[1] = temp[1] & ~(|temp[2:2]);
  assign li_out[0] = temp[0] & ~(|temp[2:1]);

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

