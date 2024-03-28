

module dendrite_3_2_13 #
(
  parameter P_DIST = 3,
  parameter P_PROX = 1,
  parameter Q = 2,
  parameter THRESHOLD = 13
)
(
  input [3-1:0] input_spikes_dist,
  input [1-1:0] input_spikes_prox,
  input [3-1:0] w_init_dist_0_0,
  input [3-1:0] w_init_dist_0_1,
  input [3-1:0] w_init_dist_0_2,
  input [3-1:0] capture_brv_dist_0,
  input [3-1:0] minus_brv_dist0,
  input [3-1:0] search_brv_dist0,
  input [3-1:0] backoff_brv_dist0,
  input [3-1:0] min_brv_dist0,
  input [6-1:0] F_brv_dist0,
  input [3-1:0] w_init_dist_1_0,
  input [3-1:0] w_init_dist_1_1,
  input [3-1:0] w_init_dist_1_2,
  input [3-1:0] capture_brv_dist_1,
  input [3-1:0] minus_brv_dist1,
  input [3-1:0] search_brv_dist1,
  input [3-1:0] backoff_brv_dist1,
  input [3-1:0] min_brv_dist1,
  input [6-1:0] F_brv_dist1,
  input [3-1:0] w_init_prox_0_0,
  input [1-1:0] capture_brv_prox_0,
  input [1-1:0] minus_brv_prox0,
  input [1-1:0] search_brv_prox0,
  input [1-1:0] backoff_brv_prox0,
  input [1-1:0] min_brv_prox0,
  input [6-1:0] F_brv_prox0,
  input [3-1:0] w_init_prox_1_0,
  input [1-1:0] capture_brv_prox_1,
  input [1-1:0] minus_brv_prox1,
  input [1-1:0] search_brv_prox1,
  input [1-1:0] backoff_brv_prox1,
  input [1-1:0] min_brv_prox1,
  input [6-1:0] F_brv_prox1,
  input clk,
  input grst,
  input rstb,
  output output_spike
);

  localparam WRES_DIST = 3;
  localparam WRES_PROX = 3;
  wire [3-1:0] ein_dist;
  wire [1-1:0] ein_prox;
  wire [2-1:0] eout;
  wire [2-1:0] ec_spikes;
  wire [2-1:0] li_spikes;
  wire [3-1:0] inc_dist_0;
  wire [3-1:0] dec_dist_0;
  wire [3-1:0] weights_dist_0_0;
  wire [3-1:0] weights_dist_0_1;
  wire [3-1:0] weights_dist_0_2;
  wire [3-1:0] inc_dist_1;
  wire [3-1:0] dec_dist_1;
  wire [3-1:0] weights_dist_1_0;
  wire [3-1:0] weights_dist_1_1;
  wire [3-1:0] weights_dist_1_2;
  wire [1-1:0] inc_prox_0;
  wire [1-1:0] dec_prox_0;
  wire [3-1:0] weights_prox_0_0;
  wire [1-1:0] inc_prox_1;
  wire [1-1:0] dec_prox_1;
  wire [3-1:0] weights_prox_1_0;

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


  pulse2edge_
  pe_in_prox_0
  (
    .aclk(clk),
    .pulse_in(input_spikes_prox[0]),
    .grst(grst),
    .rst(rstb),
    .edge_out(ein_prox[0])
  );


  segment
  #(
    .INP_DIST(3),
    .INP_PROX(1),
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
    .w_init_prox_0(weights_prox_0_0)
  );


  segment
  #(
    .INP_DIST(3),
    .INP_PROX(1),
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
    .w_init_dist_1(w_init_prox_1_0),
    .w_init_dist_2(weights_dist_0_1),
    .w_init_prox_0(weights_prox_1_0)
  );


  wta
  #(
    .Q(2)
  )
  li
  (
    .ec_spikes(ec_spikes),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .li_out(li_spikes)
  );


  pulse2edge_
  pe_out_0
  (
    .aclk(clk),
    .pulse_in(li_spikes[0]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[0])
  );


  pulse2edge_
  pe_out_1
  (
    .aclk(clk),
    .pulse_in(li_spikes[1]),
    .grst(grst),
    .rst(rstb),
    .edge_out(eout[1])
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

  assign output_spike = |li_spikes;

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
  parameter INP_DIST = 3,
  parameter INP_PROX = 1,
  parameter WRES_DIST = 3,
  parameter WRES_PROX = 3,
  parameter THRESHOLD = 13
)
(
  input [3-1:0] input_spikes_dist,
  input [1-1:0] input_spikes_prox,
  input [3-1:0] inc_dist,
  input [1-1:0] inc_prox,
  input [3-1:0] dec_dist,
  input [1-1:0] dec_prox,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] output_spike,
  input [3-1:0] w_init_dist_0,
  input [3-1:0] w_init_dist_1,
  input [3-1:0] w_init_dist_2,
  input [3-1:0] w_init_prox_0,
  output [3-1:0] weights_dist_0,
  output [3-1:0] weights_dist_1,
  output [3-1:0] weights_dist_2,
  output [3-1:0] weights_prox_0
);

  wire [3-1:0] resp_func_dist;
  wire [1-1:0] resp_func_prox;

  fsm_synapse
  syn_dist_0
  (
    .input_spike(input_spikes_dist[0]),
    .w_init(w_init_dist_0),
    .inc(inc_dist[0]),
    .dec(dec_dist[0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_dist_0),
    .syn_out(resp_func_dist[0])
  );


  fsm_synapse
  syn_dist_1
  (
    .input_spike(input_spikes_dist[1]),
    .w_init(w_init_dist_1),
    .inc(inc_dist[1]),
    .dec(dec_dist[1]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_dist_1),
    .syn_out(resp_func_dist[1])
  );


  fsm_synapse
  syn_dist_2
  (
    .input_spike(input_spikes_dist[2]),
    .w_init(w_init_dist_2),
    .inc(inc_dist[2]),
    .dec(dec_dist[2]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_dist_2),
    .syn_out(resp_func_dist[2])
  );


  fsm_synapse_
  syn_prox_0
  (
    .input_spike(input_spikes_prox[0]),
    .w_init(w_init_prox_0),
    .inc(inc_prox[0]),
    .dec(dec_prox[0]),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .w_out(weights_prox_0),
    .syn_out(resp_func_prox[0])
  );


  neuron_body
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(13),
    .WRES(3)
  )
  soma
  (
    .acc_in({ resp_func_prox, resp_func_dist }),
    .clk(clk),
    .grst(grst),
    .rstb(rstb),
    .output_spike(output_spike)
  );


endmodule



module fsm_synapse #
(
  parameter WRES = 3
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
        if((inc == 1'b1) & (weight < 3'b111)) begin
          weight <= weight + 3'b1;
          w_nonzero <= 1'b1;
        end else if((dec == 1'b1) & (weight > 0)) begin
          weight <= weight - 3'b1;
          w_nonzero <= weight[2:1] != 0;
        end else begin
          w_nonzero <= weight > 0;
        end
      end else begin
        if(input_spike) begin
          weight <= weight - 3'b1;
          if(w_nonzero == 1'b0) begin
            w_nonzero <= 1'b0;
          end else if(weight[2:1] != 0) begin
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



module fsm_synapse_ #
(
  parameter WRES = 3
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
        if((inc == 1'b1) & (weight < 3'b111)) begin
          weight <= weight + 3'b1;
          w_nonzero <= 1'b1;
        end else if((dec == 1'b1) & (weight > 0)) begin
          weight <= weight - 3'b1;
          w_nonzero <= weight[2:1] != 0;
        end else begin
          w_nonzero <= weight > 0;
        end
      end else begin
        if(input_spike) begin
          weight <= weight - 3'b1;
          if(w_nonzero == 1'b0) begin
            w_nonzero <= 1'b0;
          end else if(weight[2:1] != 0) begin
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



module neuron_body #
(
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 13,
  parameter WRES = 3
)
(
  input [4-1:0] acc_in,
  input [1-1:0] clk,
  input [1-1:0] grst,
  input [1-1:0] rstb,
  output [1-1:0] output_spike
);

  wire [1-1:0] edge_spike;
  wire [1-1:0] pulse_spike;

  pac
  #(
    .INPUT_SIZE(4),
    .THRESHOLD(13)
  )
  acc
  (
    .in(acc_in),
    .aclk(clk),
    .grst(grst),
    .rst(rstb),
    .out(edge_spike)
  );


  edge2pulse
  epn
  (
    .edge_in(edge_spike),
    .clk_in(clk),
    .rst(rstb),
    .pulse_out(pulse_spike)
  );


  fsm_convert
  #(
    .WRES(3)
  )
  conv
  (
    .aclk(clk),
    .rst(rstb),
    .in(pulse_spike),
    .out(output_spike)
  );


endmodule



module pac #
(
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 13
)
(
  input [4-1:0] in,
  input [1-1:0] aclk,
  input [1-1:0] grst,
  input [1-1:0] rst,
  output [1-1:0] out
);

  localparam P_RES = 2;
  localparam IN_SIZE = 4;
  localparam STAGES = 1;
  localparam NUM = 4;
  localparam MAXRES = 5;
  wire [4-1:0] padded_in;
  wire [NUM-1:0] temp;
  wire [P_RES-1:0] parallel_out;
  wire [6-1:0] body_pot;
  reg [MAXRES-1:0] regout;
  reg [1-1:0] poutlatch;
  assign padded_in = in;
  assign temp[0] = padded_in[0];
  assign temp[1] = padded_in[1];

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

  assign parallel_out = temp[3:2];

  adder
  #(
    .RES(5)
  )
  adder2_in_pac
  (
    .a(parallel_out),
    .b(regout),
    .cin(padded_in[3:3]),
    .out(body_pot)
  );


  always @(posedge aclk) begin
    if(grst | rst) begin
      regout <= -5'sb1101;
      poutlatch <= 1'b0;
    end else begin
      if(out) begin
        regout <= -5'sb1101;
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
  input [4-1:0] a,
  input [4-1:0] b,
  input cin,
  output [5-1:0] out
);

  assign out = a + b + cin;

endmodule



module edge2pulse
(
  input [1-1:0] edge_in,
  input [1-1:0] clk_in,
  input [1-1:0] rst,
  output [1-1:0] pulse_out
);

  reg [1-1:0] temp1;
  reg [1-1:0] temp2;

  register
  reg_inst
  (
    .clk(clk_in),
    .rst_b(~rst),
    .d(edge_in),
    .q(temp2),
    .wen(1'b1)
  );

  assign pulse_out = edge_in & ~temp2;

endmodule



module register #
(
  parameter WL = 1
)
(
  input [1-1:0] clk,
  input [1-1:0] rst_b,
  input [1-1:0] d,
  output [1-1:0] q,
  input [1-1:0] wen
);

  reg [1-1:0] temp;

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



module wta #
(
  parameter Q = 2
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

  assign li_out[1] = inhibit_spikes[1];
  assign li_out[0] = inhibit_spikes[0] & ~(|inhibit_spikes[1:1]);

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

  flogic_8x1 DUT (.OUT(out), .F_0(1'b0), .F_1(F[0]), .F_2(F[1]), .F_3(F[2]), .F_4(F[3]), .F_5(F[4]), .F_6(F[5]), .F_7(1'b1), .SEL_0(input_weight[0]), .SEL_1(input_weight[1]), .SEL_2(input_weight[2])); 

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

