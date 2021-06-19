

module test
(

);

  localparam uut_WIDTH = 8;
  reg uut_CLK;
  reg uut_RST;
  wire [uut_WIDTH-1:0] uut_LED;

  blinkled
  uut
  (
    .CLK(uut_CLK),
    .RST(uut_RST),
    .LED(uut_LED)
  );


  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, uut, uut_CLK, uut_RST, uut_LED);
  end


  initial begin
    uut_CLK = 0;
    forever begin
      #5 uut_CLK = !uut_CLK;
    end
  end


  initial begin
    uut_RST = 0;
    #100;
    uut_RST = 1;
    #100;
    uut_RST = 0;
    #100000;
    $finish;
  end


endmodule



module blinkled #
(
  parameter WIDTH = 8
)
(
  input CLK,
  input RST,
  output reg [WIDTH-1:0] LED
);

  reg [32-1:0] count;

  always @(posedge CLK) begin
    if(RST) begin
      count <= 0;
      LED <= 0;
    end else begin
      if(count == 1023) begin
        count <= 0;
      end else begin
        count <= count + 1;
      end
      if(count == 1023) begin
        LED <= LED + 1;
      end 
      $display("LED:%d count:%d", LED, count);
    end
  end


endmodule

