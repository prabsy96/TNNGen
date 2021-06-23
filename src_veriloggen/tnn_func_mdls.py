from veriloggen import *
import numpy as np
import os

# Author = Prabhu Vellaisamy
# TNN Column Submodule VerilogGen library for Verilog RTL creation
# Original Verilog files created by Harideep Nair 


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

def mkStdp_case_gen(numports=5):

    m = Module('stdp_case_gen')
    ein = m.Input('ein', 1)
    eout = m.Input('eout', 1)
    aclk = m.Input('aclk', 1)
    grst = m.Input('grst', 1)

    stdp_cases = m.Output('stdp_cases', 4)

    temp = m.Wire('temp', 1)
    tboth = m.Wire('tboth', 1)
    tone = m.Wire('tone', 1)
    greater = m.Wire('greater', 1)

    temp.assign(~ ein & eout)

    pulse = mkPulse2edge()

    pulse_inst = m.Instance(pulse, 'pe', params = None,  ports = [aclk, temp, grst, greater]) #m.connect_ports(pulse))    

    tboth.assign(ein & eout)
    tone.assign(ein ^ eout)

    stdp_cases[0].assign(~ greater & tboth)
    stdp_cases[1].assign(greater & tboth)
    stdp_cases[2].assign(~ greater & tone)
    stdp_cases[3].assign(greater & tone)

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

def mkStdp(numports=13):
    m = Module('stdp.v')
    ein = m.Input('ein', 1)
    eout = m.Input('eout', 1)
    capture = m.Input('capture', 1)
    minus = m.Input('minus', 1)
    search = m.Input('search', 1)
    backoff = m.Input('backoff', 1)
    min_v = m.Input('min', 1)
    aclk = m.Input('aclk', 1)
    grst = m.Input('grst', 1)
    input_weight = m.Input('input_weight', 3)
    F = m.Input('F', 6)

    inc = m.Output('inc', 1)
    dec = m.Output('dec', 1)

    cases = m.Wire('stdp_cases', 4)
    fout = m.Wire('fout', 1)

    # target submodule
    pulse = mkPulse2edge()
    stdp_case = mkStdp_case_gen()
    flogic = mkFlogic()
    incdec = mkIncdec()

    

    stdp_case_gen_inst = m.Instance(pulse, 's1', params = None, ports = [ein, eout, aclk, grst, cases])
    flogic_inst = m.Instance(flogic, 's2', params = None, ports = [F, input_weight, fout])
    incdec_inst = m.Instance(incdec, 's3', params = None, ports = [cases, capture, minus, search, backoff, min_v, F, inc, dec]) 


    return m

def mkPac():
    m = Module('pac')
    ip_size = m.Parameter('INPUT_SIZE', 32)
    thres = m.Parameter('THRESHOLD', 13)

    #clog2_ip_size = ip_size.value.bit_length() - 1
    clog2_ip_size = np.log2(ip_size.value) 
    #x = raw_value('$clog2(INPUT_SIZE)')
    out_res = m.Localparam('OUT_RES', int(clog2_ip_size)) 
    in_size = m.Localparam('IN_SIZE', out_res.value*2) 
    stages = m.Localparam('STAGES', in_size.value-1)
    num = m.Localparam('NUM', 2*in_size.value-out_res.value-2)
    maxres = m.Localparam('MAXRES', max(out_res.value+1, thres.value+1))    

    in_v = m.Input('in', in_size.value)
    aclk = m.Input('aclk', 1)
    grst = m.Input('grst', 1)
    out_v = m.Output('out', 1)

    tin = m.Wire('tin', in_size.value)
    temp = m.Wire('temp', num.value)
    tout = m.Wire('tout', out_res.value)
    t2out = m.Wire('t2out', maxres.value)
    fout = m.Reg('fout', maxres.value)
    maxout = m.Wire('maxout', maxres.value)

    insert_code_1 = m.EmbeddedCode("assign tin = IN_SIZE\'(in);")

    in_size_val = int((in_size.value)/2)

    #f = For(pre = '0', condition = 'in_size.name/2', post = '1' ) 
    #f_st= f.set_statement(temp(0))
    #f = While(condition='in_size.name/2' )
    #print(f(temp(0)))

    for i_v in range(in_size_val):
        temp[i_v].assign(tin[i_v])

    adder = mkAdder()

    count = []
    count.append(0)
    
    for i in range(stages.value):
         
        j = Div(in_size.value,Sll(1, (i+2)))
        for j in range(i):
            m.Instance(adder, 'a1_'+str(i)+str(j), params = count, ports = [Slice(temp, Srl(in_size.value, i)*(Sll(1, i+1)-i-3 + 2*j*(i+1)), (Srl(in_size.value, i))*((Sll(1, i+1))-i-2) + 2*j*(i+1)+i), 
            Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1), Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1)*(i+1)+i),
            tin[Add(in_size_val,(Srl(in_size.value, i+1))*((Sll(1,i)-1))+j)],
            Slice(temp, Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3 + j*(i+2)), Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3 + j*(i+2)) +(i+1))
            ])

        count[0] = i+1

    tout.assign(Slice(temp, num.value - out_res.value, num.value-1))

    m.Always(Posedge(aclk)) (fout(maxout))

    out_v.assign(~ t2out[1])

    insert_code_2 = m.EmbeddedCode("assign muxout = (out | grst) ? -1*THRESHOLD : t2out[1:MAXRES];")
  
    return m

def mkNeuronbody(numports = 5):
    m = Module('neuron_body')
    in_size_v = m.Parameter('INPUT_SIZE', 16)
    thres_v = m.Parameter('THRESHOLD', 13)
    acc_in = m.Input('acc_in', in_size_v)
    aclk = m.Input('aclk', 1)
    pac_rst = m.Input('pac_rst', 1)
    rst = m.Input('rst', 1)
    out_v = m.Output('out_spike', 1)

    temp = m.Wire('temp_spike', 1)

    pac = mkPac()
    fsm_s = mkFsm_simple()

    par_pac = [in_size_v.value, thres_v.value]

    pac_inst = m.Instance(pac, 'p1', params = par_pac, ports = [acc_in, aclk, pac_rst, temp] )

    fsm_simple_inst =m.Instance(fsm_s, 'fs', params = None, ports = [aclk, rst, temp, out_v])

    return m

def mkNeuronRNL(numports = 10):
    m = Module('neuron_rnl_ptt')
    in_size = m.Parameter('INPUT_SIZE', 64)
    thres = m.Parameter('THRESHOLD', 13)

    in_v = m.Input('input_spikes', in_size.value)
    inc = m.Input('inc', in_size.value)
    dec = m.Input('dec', in_size.value)
    weight_en = m.Input('weight_update_en', 1)
    aclk = m.Input('aclk', 1)
    gclk = m.Input('gclk', 1)
    grst = m.Input('grst', 1)
    rst = m.Input('rst', 1)

    out_v = m.Output('out_spike', 1)
    weight = m.Output('weights', in_size.value, dims = 3 )

    up_in = m.Wire('up_in', in_size.value)

    fsm_s = mkFsm_synapse()
    nbody = mkNeuronbody()

    for i in range(in_size.value):
        m.Instance(fsm_s, 'f1_'+str(i), params = None, ports = [weight_en, aclk, gclk, rst, in_v[i], inc[i], dec[i], up_in[i], weight[i]])

    par_nbody = [in_size.value, thres.value]

    m.Instance(nbody, 'p1', params = par_nbody, ports = [up_in, aclk, grst, rst, out_v])    

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
    stdp_case = mkStdp_case_gen()
    stdp = mkStdp()
    pac = mkPac()
    n_body = mkNeuronbody()
    n_rnl = mkNeuronRNL()

    if not os.path.exists('out_rtl'):
        os.mkdir('out_rtl')    

    pulse_v = pulse.to_verilog('out_rtl/pulse2edge.v')
    adder_v = adder.to_verilog('out_rtl/adder.v')
    edge_v = edge.to_verilog('out_rtl/edge2pulse.v')
    less_v = less.to_verilog('out_rtl/less_equal.v') 
    incdec_v = incdec.to_verilog('out_rtl/incdec.v')
    wta_v = wta.to_verilog('out_rtl/wta.v')
    flogic_v = flogic.to_verilog('out_rtl/flogic.v')
    simple_v = simple.to_verilog('out_rtl/fsm_simple.v')
    synapse_v = synapse.to_verilog('out_rtl/fsm_synapse.v')
    stdp_case_gen_v = stdp_case.to_verilog('out_rtl/stdp_case_gen.v')
    stdp_v = stdp.to_verilog('out_rtl/stdp.v')
    pac_v = pac.to_verilog('out_rtl/pac.v')
    n_body_v = n_body.to_verilog('out_rtl/neuron_body.v')
    n_rnl_v = n_rnl.to_verilog('out_rtl/neuron_rnl_ptt.v')


    #print(pulse_v)
    #print(adder_v)
    #print(edge_v)
    #print(less_v)
    #print(incdec_v)
    #print(wta_v)
    #print(flogic_v)
    #print(simple_v)
    #print(synapse_v)
    #print(stdp_case_gen_v)
    #print(stdp_v)
    #print(pac_v)
    #print(n_body_v)
    #print(n_rnl_v)
    #print(col_v)
