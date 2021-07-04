

module test_fsm_synapse
(

);

  reg [1-1:0] dut_weight_update_en;
  reg [1-1:0] dut_aclk;
  reg [1-1:0] dut_gclk;
  reg [1-1:0] dut_rst;
  reg [1-1:0] dut_input_spike;
  reg [1-1:0] dut_inc;
  reg [1-1:0] dut_dec;
  wire [1-1:0] dut_out;
  wire [3-1:0] dut_weight;

  fsm_synapse
  dut
  (
    .weight_update_en(dut_weight_update_en),
    .aclk(dut_aclk),
    .gclk(dut_gclk),
    .rst(dut_rst),
    .input_spike(dut_input_spike),
    .inc(dut_inc),
    .dec(dut_dec),
    .out(dut_out),
    .weight(dut_weight)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_weight_update_en, dut_aclk, dut_gclk, dut_input_spike, dut_inc, dut_dec, dut_out, dut_weight);
    dut_input_spike = 0;
    dut_inc = 0;
    dut_dec = 0;
    dut_gclk = 0;
    dut_rst = 1;
    #25;
    dut_rst = 0;
    #5;
    dut_input_spike = 1;
    #8;
    dut_input_spike = 0;
    #2;
    dut_inc = 1;
    #14;
    dut_input_spike = 1;
    #8;
    dut_input_spike = 0;
    #17;
    dut_input_spike = 1;
    #8;
    dut_input_spike = 0;
    #5;
    dut_inc = 0;
    dut_dec = 1;
    #20;
    dut_input_spike = 1;
    #8;
    dut_input_spike = 0;
    #5;
    dut_inc = 0;
    dut_dec = 1;
    #25;
    dut_rst = 1;
    #5;
    dut_rst = 0;
    dut_inc = 0;
    dut_dec = 0;
    #5;
    #200;
    $finish;
  end


  initial begin
    dut_aclk = 0;
    forever begin
      #0.5 dut_aclk = !dut_aclk;
    end
  end


  always @(dut_aclk) begin
    i <= i % 23;
    if(i == 0) begin
      dut_gclk <= 1;
    end else begin
      dut_gclk <= 0;
    end
    i <= i + 1;
  end


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

