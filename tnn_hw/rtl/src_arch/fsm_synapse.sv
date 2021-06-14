module fsm_synapse (out, weight, input_spike, inc, dec, aclk, gclk, rst,grst);

    input aclk, gclk, rst,grst;
    input input_spike, inc, dec;
    output logic out;
    output logic [0:2] weight;

    logic nxt_gclk,weight_0,w_0;

    logic [0:2] store_weight;
    logic [0:2] nxt_weight;

    
    fsm_weight_update fsm_weight_update_inst(nxt_weight, store_weight, input_spike, inc, dec, nxt_gclk,gclk);
    fsm_output fsm_output_inst(out, input_spike, store_weight, aclk,gclk,nxt_weight,grst);

    register #(.WL(1)) gclk_next(.clk(aclk), .rst_b(~rst), .d(gclk), .q(nxt_gclk), .wen(1));
    register #(.WL(3)) inst_reg_weight (.clk(aclk), .rst_b(~rst), .d(nxt_weight), .q(store_weight), .wen(1'd1));
    assign weight = store_weight;

endmodule
