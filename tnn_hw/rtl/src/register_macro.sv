module register_macro
    #(parameter WL = 1)
    (input  logic               clk,
    input   logic               rst_b,
    input   logic   [WL-1:0]    d,
    output  logic   [WL-1:0]    q,
    input   logic               wen);

	logic [WL-1:0] d_bar;
	logic [WL-1:0] d_bar_bar;
	logic wen_bar,wen_bar_bar;


    generate
	  for(i=0;i<WL;i=i+1)
      begin: generate_register
        sync_reset_b register_gen (.CLK(clk),.RST_B(rst_b),.D(d[i]), .Q(q[i]), .wen(wen));
      end
	endgenerate

endmodule: register_macro
