from veriloggen import *


def mkLessequal(numports=5):
    m = Module('less_equal')
    data_in = m.Input('data_in', 1)
    inhibit_in = m.Input('inhibit_in', 1)
    aclk = m.Input('aclk', 1)
    rst = m.Input('rst', 1)
    out = m.Output('out', 1)

    temp1 = m.Wire('temp1', 1)
    temp2 = m.Wire('temp2', 1)

    temp1.assign(~data_in & inhibit_in)


    # target submodule
    pulse = mkPulse2edge()

    # copy paras and ports
    #params = m.copy_params(led)
    ports = m.copy_ports(pulse)
    
    # aclk = ports['aclk']
    # pulse_in = ports['pulse_in']
    # grst = ports['grst']
    # edge_out = ports['edge_out']

    pulse_inst = m.Instance(mkPulse2edge(numports), 'pulse_inst', params = None,  ports = [aclk, temp1, rst, temp2]) #m.connect_ports(pulse))    

    out.assign(data_in & ~temp2)

    return m


def mkPulse2edge(numports=4):
	m = Module('pulse2edge')
	aclk = m.Input('aclk', 1)
	pulse_in = m.Input('pulse_in', 1)
	grst = m.Input('grst', 1)
	edge_out = m.Output('edge_out', 1)

	temp = m.Reg('temp',1)

	m.Always(Posedge(aclk), Posedge(grst)) (If(grst) (temp(0)).Else (temp(edge_out)))
	edge_out.assign(pulse_in | temp)
	return m

def mkAdder(numports=4):
    m = Module('adder')
    res = m.Parameter('RES',4)
    a = m.Input('a', res)
    b = m.Input('b', res)
    cin = m.Input('cin')
    out = m.Output('out', res)

    out.assign(a + b + cin)

    return m

def mkEdge2pulse(numports=3):
    m = Module('edge2pulse')
    edge_in = m.Input('edge_in', 1)
    clk_in = m.Input('clk_in', 1)
    pulse_out = m.Output('pulse_out', 1)

    temp1 = m.Reg('temp1', 1)
    temp2 = m.Reg('temp2', 1)

    m.Always(Posedge(clk_in)) (
            temp1(edge_in),
            temp2(temp1)
            )

    pulse_out.assign(edge_in & ~temp2)
    return m



def mkIncdec(numports=9):

    m = Module('incdec')
    cases = m.Input('stdp_cases', 4)
    capture = m.Input('capture', 1)
    minus = m.Input('minus', 1)
    search = m.Input('search', 1)
    backoff = m.Input('backoff', 1)
    min_case = m.Input('min', 1)
    F = m.Input('F', 1)
    inc = m.Output('inc', 1)
    dec = m.Output('dec', 1)

    temp = m.Wire('temp', 1)

    temp.assign(F | min_case)

    inc.assign((cases[0] & capture & temp) | (cases[2] & search))
    dec.assign((cases[1] & minus & temp) | (cases[3] & backoff & temp));

    return m

def mkWta(numports=4):
    
    m = Module('wta')
    default_par = 10
    Q = m.Parameter('Q', default_par)
    ec_spikes = m.Input('ec_spikes', Q)
    aclk = m.Input('aclk', 1)
    grst = m.Input('grst', 1)
    li_out = m.Output('li_out', Q)

    first_spike = m.Wire('first_spike')
    first_spike_edge = m.Wire('first_spike_edge')
    temp = m.Wire('temp', Q)

    i = m.Genvar('i', 32)

    # target submodule
    pulse = mkPulse2edge()
    less_equal = mkLessequal()

    pulse_inst = m.Instance(pulse, 'wta_pet', params = None, ports = [aclk, first_spike, grst, first_spike_edge])   

    for j in range(default_par): m.Instance(less_equal, 'l1_'+str(j), params = None, ports = [ec_spikes[j], first_spike_edge[j], aclk, grst, temp[j]])

    return m

def mkFlogic(numports=3):
    m = Module('flogic')
    F = m.Input('F', 6)
    input_weight = m.Input('input_weight', 3)
    out = m.Output('out', 1)

    #m.Always(Posedge(aclk), Posedge(grst)) (If(grst) (temp(0)).Else (temp(edge_out)))

    m.Always() (If(input_weight==Int(0, width = 3, base = 2)) (out(0))
        .Elif(input_weight==Int(1, width = 3, base = 2)) (out(F[0]))
        .Elif(input_weight==Int(2, width = 3, base = 2)) (out(F[1]))
        .Elif(input_weight==Int(3, width = 3, base = 2)) (out(F[2]))
        .Elif(input_weight==Int(4, width = 3, base = 2)) (out(F[3]))
        .Elif(input_weight==Int(5, width = 3, base = 2)) (out(F[4]))
        .Elif(input_weight==Int(6, width = 3, base = 2)) (out(F[5]))
        .Elif(input_weight==Int(7, width = 3, base = 2)) (out(1))
        )


    return m

def mkFsm_simple(numports=4):
    m = Module('fsm_simple')
    aclk = m.Input('aclk', 1)
    rst = m.Input('rst', 1)
    in_v = m.Input('in', 1)
    out_v = m.Output('out', 1)

    temp = m.Wire('temp', 1)

    fsm = FSM(m, 'fsm', aclk, rst)
    fsm_v = fsm.state
    fsm.goto_next(out_v==1)
    fsm.goto_next()
    fsm.goto_next()
    fsm.goto_next()
    fsm.goto_next()
    fsm.goto_next()
    fsm.goto_next()
    fsm.goto_next()

    out_v.assign((~temp) | (temp & in_v))
    
    temp.assign(~ fsm_v[2] | fsm_v[1] | fsm_v[0])
    

    return m

def mkFsm_synapse(numports=9):
    m = Module('fsm_synapse')
    weight_update_en = m.Input('weight_update_en', 1)
    aclk = m.Input('aclk', 1)
    gclk = m.Input('gclk', 1)
    rst = m.Input('rst', 1)
    input_spike = m.Input('input_spike', 1)
    inc = m.Input('inc', 1) 
    dec = m.Input('dec', 1)
    out_v = m.Output('out', 1)
    weight = m.Output('weight', 3)

    state = m.Reg('state', 3)
    S0 = m.Localparam('S0', 0, 3)
    S1 = m.Localparam('S1', 1, 3)
    S2 = m.Localparam('S2', 2, 3)
    S3 = m.Localparam('S3', 3, 3)
    S4 = m.Localparam('S4', 4, 3)
    S5 = m.Localparam('S5', 5, 3)
    S6 = m.Localparam('S6', 6, 3)
    S7 = m.Localparam('S7', 7, 3)



    dout = m.Reg('dout', 1)
    din = m.Wire('din', 1)
    tclk = m.Wire('tclk', 1)
    tinc = m.Wire('tinc', 1)
    tdec = m.Wire('tdec', 1)

    tinc.assign(inc & ~ input_spike)
    tdec.assign(dec & ~ input_spike)
    tclk.assign(aclk & input_spike)

    m.Always(Posedge(aclk), Posedge(gclk)) ( 
        If(tclk) (
            If(rst) (
                state(S0))
            .Else(
                If(state==S0) (
                    If(tclk) (
                        state(S7)) 
                    .Else (
                        state(S0)) 
                    ) 
                .Elif(state==S1) (
                    If(tclk == 1) (
                        state(S0)) 
                    .Else (
                        state(S1)) ) 
                .Elif(state==S2) (
                    If(tclk) (
                        state(S1)) 
                    .Else (
                        state(S2)) )
                .Elif(state==S3) (
                    If(tclk) (
                        state(S2)) 
                    .Else (
                        state(S3)) )
                .Elif(state==S4) (
                    If(tclk) (
                        state(S3)) 
                    .Else (
                        state(S4)) )
                .Elif(state==S5) (
                    If(tclk) (
                        state(S4)) 
                    .Else (
                        state(S5)) )
                .Elif(state==S6) (
                    If(tclk) (
                        state(S5)) 
                    .Else (
                        state(S6)) )
                .Elif(state==S7) (
                    If(tclk) (
                        state(S6)) 
                    .Else (
                        state(S7)) )
                )) 
        .Else(
            If(rst) (
                state(S0)) 
            .Else (
                If(state==S0) (
                    If(tinc & weight_update_en) (
                        state(S1)) 
                    .Else (
                        state(S0)) )
                .Elif(state==S1) (
                    If(tdec & weight_update_en) (
                        state(S0)) 
                    .Elif(tinc & weight_update_en) (
                        state(S2)) 
                    .Else (
                        state(S1))
                    )
                .Elif(state==S2) (
                    If(tdec & weight_update_en) (
                        state(S1)) 
                    .Elif(tinc & weight_update_en) (
                        state(S3)) 
                    .Else (
                        state(S2))
                    )
                .Elif(state==S3) (
                    If(tdec & weight_update_en) (
                        state(S2)) 
                    .Elif(tinc & weight_update_en) (
                        state(S4)) 
                    .Else (
                        state(S3))
                    )
                .Elif(state==S4) (
                    If(tdec & weight_update_en) (
                        state(S3)) 
                    .Elif(tinc & weight_update_en) (
                        state(S5)) 
                    .Else (
                        state(S4))
                    )
                .Elif(state==S5) (
                    If(tdec & weight_update_en) (
                        state(S4)) 
                    .Elif(tinc & weight_update_en) (
                        state(S6)) 
                    .Else (
                        state(S5))
                    )     
                .Elif(state==S6) (
                    If(tdec & weight_update_en) (
                        state(S5)) 
                    .Elif(tinc & weight_update_en) (
                        state(S7)) 
                    .Else (
                        state(S6))
                    )
                .Elif(state==S7) (
                    If(tdec & weight_update_en) (
                        state(S6)) 
                    .Else (
                        state(S7))
                    )
                ) 
            )
        )

    din.assign(state[2] & state[1] & state[0])

    m.Always(Posedge(din), Posedge(gclk)) (If(din) ( If(input_spike) (dout(1)) .Else (dout(0))) .Else (dout(0)))

    out_v.assign(~ dout | input_spike)
    weight.assign(state)

    return m


if __name__=='__main__':
    pulse = mkPulse2edge()
    adder = mkAdder()
    edge = mkEdge2pulse()
    less = mkLessequal()
    incdec = mkIncdec()
    wta = mkWta()
    flogic = mkFlogic()
    simple = mkFsm_simple()
    synapse = mkFsm_synapse()

    pulse_v = pulse.to_verilog('pulse2edge.v')
    adder_v = adder.to_verilog('adder.v')
    edge_v = edge.to_verilog('edge2pulse.v')
    less_v = less.to_verilog('less_equal.v') 
    incdec_v = incdec.to_verilog('incdec.v')
    wta_v = wta.to_verilog('wta.v')
    flogic_v = flogic.to_verilog('flogic.v')
    simple_v = simple.to_verilog('fsm_simple.v')
    synapse_v = synapse.to_verilog('fsm_synapse.v')

    #print(pulse_v)
    #print(adder_v)
    #print(edge_v)
    #print(less_v)
    #print(incdec_v)
    #print(wta_v)
    #print(flogic_v)
    #print(simple_v)
    print(synapse_v)
