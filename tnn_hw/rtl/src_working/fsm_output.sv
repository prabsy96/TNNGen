module fsm_output (out, input_spike, store_weight, aclk,gclk,nxt_weight,grst);


    input input_spike,aclk,gclk,grst;
    input logic [0:2] store_weight,nxt_weight;
    output logic out;
    logic w_0,weight_0,reg_out,input_spike_bar,input_spike_bar_bar;

    assign w_0 = ~(store_weight[0] | store_weight[1] | store_weight[2]);
    register #(.WL(1)) weight_0_reg(.clk(aclk),.rst_b(input_spike),.d(1),.q(weight_0),.wen(w_0));
    //register #(.WL(1)) weight_1_reg(.clk(aclk),.rst_b(1),.d(reg_out),.q(out),.wen(1));

    always_comb begin : proc_output_logic
        out = 0;
        if(input_spike)
	begin
	if(~(w_0 | weight_0))
            out = 1;
	end
    end

endmodule
