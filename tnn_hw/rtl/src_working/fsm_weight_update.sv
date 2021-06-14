module fsm_weight_update (nxt_weight, store_weight, input_spike, inc, dec, nxt_gclk,gclk);

    input input_spike,inc,dec,nxt_gclk,gclk;
    input logic [0:2] store_weight;
    output logic [0:2] nxt_weight;

    logic tinc,tdec;

    assign tinc = inc & ~input_spike & ~nxt_gclk & gclk;
    assign tdec = dec & ~input_spike & ~nxt_gclk & gclk;



    always_comb begin : proc_weight_update
        nxt_weight = store_weight; 
        if(input_spike)
            nxt_weight = store_weight - 1;
        if(tinc && store_weight != 3'b111)
            nxt_weight = store_weight + 1;
        if(tdec && store_weight != 3'b000)
            nxt_weight = store_weight - 1;   
    end


endmodule
