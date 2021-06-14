/*module register
    #(parameter WL = 1)
    (input  logic               clk,
    input   logic               rst_b,
    input   logic   [WL-1:0]    d,
    output  logic   [WL-1:0]    q,
    input   logic               wen);

	logic [WL-1:0] d_bar;
	logic [WL-1:0] d_bar_bar;
	logic wen_bar,wen_bar_bar;

	assign d_bar = ~d;
	assign d_bar_bar = ~d_bar;
	assign wen_bar = ~wen;
	assign wen_bar_bar = ~wen_bar;

    always_ff @(posedge clk, negedge rst_b) begin
        if (~rst_b)
            q <= 'b0;
        else begin
            if (wen_bar_bar)
                q <= d_bar_bar;
        end
    end
endmodule: register*/
module register 
    #(parameter WL = 1)
    (input  logic               clk,
    input   logic               rst_b,
    input   logic   [WL-1:0]    d,
    output  logic   [WL-1:0]    q,
    input   logic               wen);

    always_ff @(posedge clk) begin
        if (~rst_b)
            q <= 'b0;
        else begin
            if (wen)
                q <= d;
        end
    end
endmodule: register
