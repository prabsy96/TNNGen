/*
 * Author: Harideep Nair
 *
 * Testbench for parallel accumulative counter (pac.sv)
 */

`timescale 1ns / 1ps

module register_tb;

    reg [0:3] in;
    reg aclk, grst;
    wire out;

    integer i;

    parameter INPUT_SIZE = 4;
    parameter THRESHOLD = 13;
    
    register DUT (.q(out), .d(in), .clk(aclk), .rst_b(~grst),.wen(1));
    
    initial
    begin

        $dumpfile("register.vcd");
        $dumpvars(0, register_tb);

        in = 4'b0;

        #5
        in = 4'b0001;
        
        #3
        in = 4'b1001;
        
        #2
        in = 4'b1000;

        #2
        in = 4'b1100;

        #2
        in = 4'b1001;

        #1
        in = 4'b0000;

        #20
        in = 4'b0000;
        
        #20
        in = 4'b0000;
        
        #200
        $finish;

    end
    
    initial begin
        aclk = 1;
        forever begin
            #0.5;
            aclk = ~aclk;
        end
    end
    
    initial i = 0;
    always @ (posedge aclk)
    begin
        i = i % 23;
        if (i==0) grst <= 1;
        else grst <= 0;
        i = i + 1;
    end

endmodule
