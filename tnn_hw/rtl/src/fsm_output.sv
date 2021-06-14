module fsm_output (out, input_spike, store_weight, aclk,gclk,nxt_weight,grst);


    input input_spike,aclk,gclk,grst;
    input logic [0:2] store_weight,nxt_weight;
    output logic out;

    fsm_output_macro fsm_output_inst(.OUT(out),.INPUT_SPIKE(input_spike),.STORE_WEIGHT_0(store_weight[0]),.STORE_WEIGHT_1(store_weight[1]),.STORE_WEIGHT_2(store_weight[2]),.ACLK(aclk));

endmodule
