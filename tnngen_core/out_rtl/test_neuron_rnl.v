

module test_neuron_rnl #
(
  parameter IP_SIZE = 4,
  parameter THRESHOLD = 3
)
(

);

  reg [4-1:0] input_spikes;
  reg [4-1:0] inc;
  reg [4-1:0] dec;
  reg [1-1:0] weight_update_en;
  reg [1-1:0] aclk;
  reg [1-1:0] gclk;
  reg [1-1:0] grst;
  reg [1-1:0] rst;
  wire [1-1:0] out_spike;
  wire [3-1:0] weights_0;
  wire [3-1:0] weights_1;
  wire [3-1:0] weights_2;
  wire [3-1:0] weights_3;

  neuron_rnl_ptt
  dut
  (
    .input_spikes(input_spikes),
    .inc(inc),
    .dec(dec),
    .weight_update_en(weight_update_en),
    .aclk(aclk),
    .gclk(gclk),
    .grst(grst),
    .rst(rst),
    .out_spike(out_spike),
    .weights_0(weights_0),
    .weights_1(weights_1),
    .weights_2(weights_2),
    .weights_3(weights_3)
  );

  integer i;
  integer j;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut);
    input_spikes = 0;
    inc = 0;
    dec = 0;
    rst = 1;
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
    inc[0] = 1;
    inc[1] = 1;
    inc[3] = 1;
    #1;
    inc = 0;
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
    inc = 1;
    #1;
    inc = 0;
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
    inc = 1;
    #1;
    inc = 0;
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
    inc = 1;
    #1;
    inc = 0;
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
    inc[0] = 1;
    inc[1] = 1;
    inc[3] = 1;
    #1;
    inc = 0;
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
    inc[0] = 1;
    inc[1] = 1;
    dec[2] = 1;
    inc[3] = 1;
    #1;
    inc = 0;
    dec = 0;
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
    inc = 1;
    #1;
    inc = 0;
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
    inc = 1;
    #1;
    inc = 0;
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


  initial begin
    i = 0;
  end


  always @(aclk) begin
    i = i%23;
    if(i == 0) begin
      gclk = ~gclk;
    end 
    i = i+1;
  end


  initial begin
    j = 0;
  end


  always @(posedge aclk) begin
    j = j%23;
    if(j == 0) begin
      grst <= 1;
    end else begin
      grst <= 0;
    end
    j = j+1;
  end


endmodule



module neuron_rnl_ptt #
(
  parameter INPUT_SIZE = 4,
  parameter THRESHOLD = 3
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
    .THRESHOLD(3)
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
  parameter THRESHOLD = 3
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
    .THRESHOLD(3)
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
  parameter THRESHOLD = 3
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
  localparam MAXRES = 3;
  wire [4-1:0] temp;
  wire [2-1:0] tout;
  wire [4-1:0] t2out;
  reg [3-1:0] fout;
  wire [3-1:0] muxout;
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
    .RES(3)
  )
  adder2_in_pac
  (
    .a({ 1'b0, tout }),
    .b(fout),
    .cin(in[3]),
    .out(t2out)
  );

  assign muxout = ((out | grst) == 1)? -3'sb11 : t2out[3:1];

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

