module fsm_weight_update (nxt_weight, store_weight, input_spike, inc, dec, nxt_gclk,gclk);

    input input_spike,inc,dec,nxt_gclk,gclk;
    input logic [0:2] store_weight;
    output logic [0:2] nxt_weight;

    logic tinc,tdec;

    assign tinc = inc & ~input_spike & ~nxt_gclk & gclk & ~(store_weight[0] & store_weight[1] & store_weight[2]);
    assign tdec = dec & ~input_spike & ~nxt_gclk & gclk & ((store_weight[0] | store_weight[1] | store_weight[2]));
    fsm_weight_update_macro fsm_weight_update_inst (.NXT_WEIGHT_0(nxt_weight[0]),.NXT_WEIGHT_1(nxt_weight[1]),.NXT_WEIGHT_2(nxt_weight[2]),.INPUT_SPIKE(input_spike),.TDEC(tdec),.TINC(tinc),.STORE_WEIGHT_0(store_weight[0]),.STORE_WEIGHT_1(store_weight[1]),.STORE_WEIGHT_2(store_weight[2]));

endmodule
