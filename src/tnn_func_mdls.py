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
    Q = m.Parameter('Q', 10)
    ec_spikes = m.Input('ec_spikes', Q)
    aclk = m.Input('aclk', 1)
    grst = m.Input('grst', 1)
    li_out = m.Output('li_out', Q)

    first_spike = m.Wire('first_spike')
    first_spike_edge = m.Wire('first_spike_edge')
    temp = m.Wire('temp', Q)

    # target submodule
    pulse = mkPulse2edge()

    pulse_inst = m.Instance(pulse, 'wta_pet', params = None, ports = [aclk, first_spike, grst, first_spike_edge])   

    




if __name__=='__main__':
    pulse = mkPulse2edge()
    adder = mkAdder()
    edge = mkEdge2pulse()
    less = mkLessequal()
    incdec = mkIncdec()
    pulse_v = pulse.to_verilog('pulse2edge.v')
    adder_v = adder.to_verilog('adder.v')
    edge_v = edge.to_verilog('edge2pulse.v')
    less_v = less.to_verilog('less_equal.v') 
    incdec_v = incdec.to_verilog('incdec.v')
    #print(pulse_v)
    #print(adder_v)
    #print(edge_v)
    print(less_v)
    print(incdec_v)
