

module test_adder
(

);

  localparam dut_RES = 4;
  reg [dut_RES-1:0] dut_a;
  reg [dut_RES-1:0] dut_b;
  reg dut_cin;
  wire [dut_RES-1:0] dut_out;

  adder
  #(
    .RES(dut_RES)
  )
  dut
  (
    .a(dut_a),
    .b(dut_b),
    .cin(dut_cin),
    .out(dut_out)
  );

  integer i;

  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, dut, dut_a, dut_b, dut_cin, dut_out);
    dut_a = 0;
    dut_b = 0;
    dut_cin = 0;
    #5;
    dut_a = 3;
    #5;
    dut_b = 12;
    #10;
    dut_cin = 1;
    #10;
    dut_cin = 0;
    #22;
    #200;
    $finish;
  end


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

