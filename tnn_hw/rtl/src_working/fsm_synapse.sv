module fsm_synapse (out, weight, input_spike, inc, dec, aclk, gclk, rst,grst);

    input aclk, gclk, rst,grst;
    input input_spike, inc, dec;
    output logic out;
    output logic [0:2] weight;

    // localparam inital = 1'b0;
    // localparam dout = 1'b1;
    // // localparam ready_to_update = 2'b10;
    logic nxt_gclk,weight_0,w_0;

    logic [0:2] store_weight;
    logic [0:2] nxt_weight;
    // logic [0:1] state;
    // logic [0:1] nxt_state;

    // assign tinc = inc & ~input_spike & ~nxt_gclk;
    // assign tdec = dec & ~input_spike & ~nxt_gclk;

    // assign w_0 = ~(store_weight[0] | store_weight[1] | store_weight[2]);


    // always_comb begin : proc_weight_update
    //     nxt_weight = store_weight; 
    //     if(input_spike)
    //         nxt_weight = store_weight - 1;
    //     if(tinc)
    //         nxt_weight = store_weight + 1;
    //     if(tdec)
    //         nxt_weight = store_weight - 1;   
    // end

    // always_comb begin : proc_output_logic
    //     out = 0;
    //     if(input_spike & ~(w_0 | weight_0))
    //         out = 1;
    // end
    // register #(.WL(1)) weight_0_reg(.clk(aclk),.rst_b(input_spike),.d(1),.q(weight_0),.wen(w_0));
    // 
    
    fsm_weight_update fsm_weight_update_inst(nxt_weight, store_weight, input_spike, inc, dec, nxt_gclk,gclk);
    fsm_output fsm_output_inst(out, input_spike, store_weight, aclk,gclk,nxt_weight,grst);

    register #(.WL(1)) gclk_next(.clk(aclk), .rst_b(~rst), .d(gclk), .q(nxt_gclk), .wen(1));
    register #(.WL(3)) inst_reg_weight (.clk(aclk), .rst_b(~rst), .d(nxt_weight), .q(store_weight), .wen(1'd1));
    assign weight = store_weight;

endmodule
