

module test_edge2pulse
(

);

  reg [1-1:0] dut_edge_in;
  reg [1-1:0] dut_clk_in;
  wire [1-1:0] dut_pulse_out;

  edge2pulse
  dut
  (
    .edge_in(dut_edge_in),
    .clk_in(dut_clk_in),
    .pulse_out(dut_pulse_out)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_edge_in, dut_clk_in, dut_pulse_out);
    dut_edge_in = 0;
    #5;
    dut_edge_in = 1;
    #100;
    $finish;
  end


  initial begin
    dut_clk_in = 0;
    forever begin
      #0.5 dut_clk_in = !dut_clk_in;
    end
  end


  always @(dut_clk_in) begin
    i <= i % 23;
    if(i == 0) begin
      dut_edge_in <= ~dut_edge_in;
    end 
    i <= i + 1;
  end


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

