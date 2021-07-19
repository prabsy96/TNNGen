# Author = Prabhu Vellaisamy

# TNN Column Submodule VerilogGen library for Verilog RTL creation
# Original Verilog files created by Harideep Nair 

from veriloggen import *
import numpy as np
import os


class TNN_Functions():

    def Less_equal(self):
        m = Module('less_equal')
        data_in = m.Input('data_in', 1)
        inhibit_in = m.Input('inhibit_in', 1)
        aclk = m.Input('aclk', 1)
        rst = m.Input('rst', 1)
        out = m.Output('out', 1)

        temp1 = m.Wire('temp1', 1)
        temp2 = m.Wire('temp2', 1)

        # target submodule
        pulse = self.Pulse2edge()

        # copy paras and ports
        #params = m.copy_params(led)
        ports = m.copy_ports(pulse)

        pulse_inst = Submodule(m, pulse, name = 'pulse_inst', arg_ports = [aclk, temp1, rst, temp2])

        temp1.assign(~data_in & inhibit_in)
       
        out.assign(data_in & ~temp2)

        return m

    def Pulse2edge(self):
    	m = Module('pulse2edge')
    	aclk = m.Input('aclk', 1)
    	pulse_in = m.Input('pulse_in', 1)
    	grst = m.Input('grst', 1)
    	edge_out = m.Output('edge_out', 1)

    	temp = m.Reg('temp',1)

    	m.Always(Posedge(aclk), Posedge(grst)) (If(grst) (temp(0)).Else (temp(edge_out)))
    	edge_out.assign(pulse_in | temp)
    	return m

    def Adder(self, res = 4):
        m = Module('adder')
        res = m.Parameter('RES',res )
        a = m.Input('a', res)
        b = m.Input('b', res)
        cin = m.Input('cin')
        out = m.Output('out', res)

        out.assign(a + b + cin)

        return m

    def Edge2pulse(self):
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

    def Incdec(self):

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

    def Wta(self, Q = 10):
        
        m = Module('wta')
        q = m.Parameter('Q', Q)

        ec_spikes = m.Input('ec_spikes', q.value)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        li_out = m.Output('li_out', q.value)

        first_spike = m.Wire('first_spike')
        first_spike_edge = m.Wire('first_spike_edge')
        temp = m.Wire('temp', q.value)

        i = m.Genvar('i', 32)

        # target submodule
        pulse = self.Pulse2edge()
        less_equal = self.Less_equal()   

        pulse_inst = Submodule(m, pulse, name = 'pulse_inst', arg_ports = [aclk, first_spike, grst, first_spike_edge])

        for j in range(q.value): 
            Submodule(m, less_equal, name = 'l1_'+str(j), arg_ports = [ec_spikes[j], first_spike_edge, aclk, grst, temp[j]])

        li_out[0].assign(temp[0])

        for k in range(1, q.value):
            li_out[k].assign(temp[k] & ~ Uor(Slice(temp, k-1, 0)) )

        return m

    def Flogic(self):
        m = Module('flogic')
        F = m.Input('F', 6)
        input_weight = m.Input('input_weight', 3)
        out = m.OutputReg('out', 1)

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

    def Stdp_case_gen(self):

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

        pulse = self.Pulse2edge()

        pulse_inst = m.Instance(pulse, 'pe', params = None,  ports = [aclk, temp, grst, greater]) #m.connect_ports(pulse))    

        tboth.assign(ein & eout)
        tone.assign(ein ^ eout)

        stdp_cases[0].assign(~ greater & tboth)
        stdp_cases[1].assign(greater & tboth)
        stdp_cases[2].assign(~ greater & tone)
        stdp_cases[3].assign(greater & tone)

        return m

    def Fsm_simple(self):
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

    def Fsm_synapse(self):
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

    def Stdp(self):
        m = Module('stdp')
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
        stdp_case = self.Stdp_case_gen()
        flogic =self. Flogic()
        incdec = self.Incdec()

        stdp_case_gen_inst = m.Instance(stdp_case, 's1', params = None, ports = [ein, eout, aclk, grst, cases])
        flogic_inst = m.Instance(flogic, 's2', params = None, ports = [F, input_weight, fout])
        incdec_inst = m.Instance(incdec, 's3', params = None, ports = [cases, capture, minus, search, backoff, min_v, fout, inc, dec]) 

        return m

    def Pac(self, ip_size = 32, thres = 13):
        m = Module('pac')
        in_size = m.Parameter('INPUT_SIZE', int(ip_size))
        thres = m.Parameter('THRESHOLD', int(thres))
        clog2_in_size = np.log2(int(in_size.value))
        clog2_thres = np.log2(int(thres.value))

        stages = m.Localparam('STAGES', int(clog2_in_size)-1)
        out_res = m.Localparam('OUT_RES', int(clog2_in_size))
        num = m.Localparam('NUM', 2*in_size.value-out_res.value-2)
        maxres = m.Localparam('MAXRES', max(out_res.value+1, int(clog2_thres)+1))   

        in_v = m.Input('in', in_size.value)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        out_v = m.Output('out', 1)

        #tin = m.Wire('tin', in_size.value)
        temp = m.Wire('temp', width = num.value)
        tout = m.Wire('tout', width = out_res.value)
        t2out = m.Wire('t2out', width = maxres.value+1)
        fout = m.Reg('fout', width = maxres.value)
        muxout = m.Wire('muxout', width = maxres.value)

        in_size_val = int((in_size.value)/2)

        for i_v in range(in_size_val):
            temp[i_v].assign(in_v[i_v])

        adder = self.Adder()

        count = []
        count.append(0)
        
        for i in range(stages.value):
             
            j = Div(in_size.value,Sll(1, (i+2)))
            for j in range(i):
                m.Instance(adder, 'a1_'+str(i)+str(j), 
                    params = count, 
                    ports = [
                    Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + 2*j*(i+1)+i, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + 2*j*(i+1)), 
                    Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1)*(i+1)+i, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1)*(i+1)),
                    in_v[Add(in_size_val,(Srl(in_size.value, i+1))*((Sll(1,i)-1))+j)],
                    Slice(temp, Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3 + j*(i+2)) +(i+1), Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3 + j*(i+2)))
                    ])

            count[0] = i+1

        tout.assign(Slice(temp, num.value-1, num.value - out_res.value))

        muxout.assign(Cond((out_v | grst) == 1, true_value = -1*thres.value,  false_value = Slice(t2out, maxres.value,  1)))

        m.Always(Posedge(aclk)) (fout(muxout))

        out_v.assign(~ t2out[1])

        return m

    def Neuronbody(self, ip_size = 16, thres = 13):
        m = Module('neuron_body')
        in_size_v = m.Parameter('INPUT_SIZE', ip_size)
        thres_v = m.Parameter('THRESHOLD', thres)
        acc_in = m.Input('acc_in', in_size_v.value)
        aclk = m.Input('aclk', 1)
        pac_rst = m.Input('pac_rst', 1)
        rst = m.Input('rst', 1)
        out_v = m.Output('out_spike', 1)

        temp = m.Wire('temp_spike', 1)

        pac = self.Pac(ip_size = in_size_v.value, thres = thres_v.value)
        fsm_s = self.Fsm_simple()

        par_pac = [in_size_v.value, thres_v.value]

        pac_inst = m.Instance(pac, 'p1', params = par_pac, ports = [acc_in, aclk, pac_rst, temp] )

        fsm_simple_inst =m.Instance(fsm_s, 'fs', params = None, ports = [aclk, rst, temp, out_v])

        return m

    def NeuronRNL(self, ip_size = 16, thres = 13):
        m = Module('neuron_rnl_ptt')
        in_size = m.Parameter('INPUT_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)

        in_v = m.Input('input_spikes', in_size.value)
        inc = m.Input('inc', in_size.value)
        dec = m.Input('dec', in_size.value)
        weight_en = m.Input('weight_update_en', 1)
        aclk = m.Input('aclk', 1)
        gclk = m.Input('gclk', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)

        out_v = m.Output('out_spike', 1)
        weight = []
        for i in range(in_size.value):
            weight.append(m.Output('weights_'+str(i), 3))
        #weight = m.Output('weights', 3 , dims = in_size.value )

        up_in = m.Wire('up_in', in_size.value)

        fsm_s = self.Fsm_synapse()
        nbody = self.Neuronbody(ip_size = in_size.value, thres = thres.value )

        for i in range(in_size.value):
            m.Instance(fsm_s, 'f1_'+str(i), params = None, ports = [weight_en, aclk, gclk, rst, in_v[i], inc[i], dec[i], up_in[i], weight[i]])

        par_nbody = [in_size.value, thres.value]

        m.Instance(nbody, 'p1', params = par_nbody, ports = [up_in, aclk, grst, rst, out_v])    

        return m

class Test_TNN_Functions():

    tnn = TNN_Functions()

    def Tb_Less_equal(self):
        
        m = Module('test_less_equal')
        lq = self.tnn.Less_equal()

        dut = Submodule(m, lq, name = 'dut')

        data_in = dut['data_in']
        inhibit_in = dut['inhibit_in']
        aclk = dut['aclk']
        rst = dut['rst']
        out = dut['out']

        i = m.Integer('i', 32, 0)

        dump = simulation.setup_waveform(m, dut, [data_in, inhibit_in, aclk, rst, out])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
        
        dump.add(
            data_in(0), 
            inhibit_in(1),
            Delay(5),

            data_in(1),
            Delay(1),

            data_in(0),
            Delay(5),

            inhibit_in(1),
            Delay(11),

            inhibit_in(0),
            Delay(5),

            data_in(1),
            Delay(3),

            inhibit_in(1),
            Delay(5),

            data_in(0),
            Delay(9),

            inhibit_in(0),
            Delay(5),

            inhibit_in(1),
            Delay(3),

            data_in(1),
            Delay(5),

            data_in(0),
            Delay(9),

            inhibit_in(0),
            Delay(5),

            data_in(1),
            inhibit_in(1),
            Delay(8),

            data_in(0),
            Delay(9),

            inhibit_in(0),
            Delay(10),

            data_in(0),
            Delay(100),

            simulation.finish()
            )

        m.Always(aclk) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                rst(1))
            .Else(
                rst(0))
            , EmbeddedCode('i = i+1;'))
        
        return m

    def Tb_Pulse2edge(self):
        m = Module('test_pulse2edge')

        pulse = self.tnn.Pulse2edge()

        dut = Submodule(m, pulse, 'dut')

        edge_out = dut['edge_out']
        pulse_in = dut['pulse_in']
        aclk = dut['aclk']
        grst = dut['grst']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [pulse_in, aclk, grst, edge_out])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
        
        dump.add(
            pulse_in(0), 
            Delay(5),

            pulse_in(1),
            Delay(1),

            pulse_in(0),
            Delay(5),

            pulse_in(1),
            Delay(1),

            pulse_in(0),
            Delay(22),

            pulse_in(1),
            Delay(8),

            pulse_in(1),
            Delay(10),

            pulse_in(0),
            Delay(100),

            simulation.finish()
            )

        m.Always(Posedge(aclk)) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                grst(1)) 
            .Else(
                grst(0))
            , EmbeddedCode('i=i+1;'))

        return m


    def Tb_Adder(self, RES = 4):
        m = Module('test_adder')

        res = m.Parameter('RES', RES)

        adder = self.tnn.Adder(res.value)

        dut = Submodule(m, adder, 'dut')

        out = dut['out']
        a = dut['a']
        b = dut['b']
        cin = dut['cin']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [a, b, cin, out])
        
        dump.add(
            a(0),
            b(0),
            cin(0),
            Delay(5),

            a(3),
            Delay(5),

            b(int('1100', 2)),
            Delay(10),

            cin(1),
            Delay(10),

            cin(0),
            Delay(22),
            Delay(200),

            simulation.finish()
            )

        return m

    def Tb_Edge2pulse(self):
        m = Module('test_edge2pulse')

        edge = self.tnn.Edge2pulse()

        dut = Submodule(m, edge, 'dut')

        edge_in = dut['edge_in']
        clk_in = dut['clk_in']
        pulse_out = dut['pulse_out']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [edge_in, clk_in, pulse_out])
        clock = simulation.setup_clock(m, clk_in, hperiod = 0.5)
        
        dump.add(
            edge_in(0),
            Delay(5),

            edge_in(1),
            Delay(100),

            simulation.finish()
            )

        m.Always(clk_in) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                EmbeddedCode('edge_in = ~edge_in;')) 
            , EmbeddedCode('i = i+1;'))

        return m

    def Tb_Incdec(self):
        m = Module('test_incdec')

        incdec = self.tnn.Incdec()

        dut = Submodule(m, incdec, 'dut')

        inc = dut['inc']
        dec = dut['dec']
        cases = dut['stdp_cases']
        capture = dut['capture']
        minus = dut['minus']
        backoff = dut['backoff']
        search = dut['search']
        min_v = dut['min']
        F = dut['F']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [cases, capture, minus, search, backoff, min_v, F, inc, dec])
        #clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
        
        dump.add(
            cases(0),
            capture(0),
            minus(0),
            search(0),
            backoff(0),
            min_v(0),
            F(0),
            Delay(5),

            cases(int('1000', 2)),
            Delay(5),

            capture(1),
            Delay(5),

            F(1),
            Delay(5),

            cases(int('0100', 2)),
            Delay(5),

            minus(1),
            F(0),
            Delay(5),

            F(1),
            Delay(5),

            cases(int('0010', 2)),
            Delay(5),

            search(1),
            F(0),
            Delay(5),

            F(1),
            Delay(5),

            cases(1),
            Delay(5),

            backoff(1),
            F(0),
            Delay(5),

            F(1),
            Delay(10),

            cases(0),
            Delay(200),

            simulation.finish()
            )

        return m

    def Tb_Wta(self, Q = 4):

        m = Module('test_wta')

        q = m.Parameter('Q', Q)
        wta = self.tnn.Wta(q.value)

        dut = Submodule(m, wta, 'dut')

        ec_spikes = dut['ec_spikes']
        aclk = dut['aclk']
        grst = dut['grst']
        li_out = dut['li_out']  

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [ec_spikes, aclk, grst, li_out])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
        
        dump.add(
            ec_spikes(0),
            Delay(5),

            ec_spikes[2](1),
            ec_spikes[1](1),
            Delay(1),

            ec_spikes[3](1),
            Delay(5),

            ec_spikes[0](1),
            Delay(2),

            ec_spikes[2](0),
            ec_spikes[1](0),
            Delay(1),

            ec_spikes[3](0),
            Delay(5),

            ec_spikes[0](0),
            Delay(9),

            ec_spikes[2](1),
            ec_spikes[1](1),
            ec_spikes[0](1),
            ec_spikes[3](1),

            Delay(8),
            ec_spikes[3](0),
            ec_spikes[2](0),
            ec_spikes[0](0),
            ec_spikes[1](0),
            
            Delay(15),
            ec_spikes[2](1),
            ec_spikes[3](1),

            Delay(1),
            ec_spikes[1](1),
            
            Delay(5),
            ec_spikes[0](1),

            Delay(6),
            ec_spikes[2](0),
            ec_spikes[3](0),

            Delay(1),
            ec_spikes[1](0),

            Delay(5),
            ec_spikes[0](0),
            
            Delay(10),
            ec_spikes(0),

            Delay(100),

            simulation.finish()
            )

        m.Always(Posedge(aclk)) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                grst(1)) 
            .Else(
                grst(0))
            , EmbeddedCode('i=i+1;'))

        return m

    def Tb_Flogic(self): 

        m = Module('test_flogic')
        flogic = self.tnn.Flogic()

        dut = Submodule(m, flogic, 'dut')

        F = dut['F']
        input_weight = dut['input_weight']
        out = dut['out']

        dump = simulation.setup_waveform(m, dut, [F, input_weight, out])

        dump.add(
            F(0),
            input_weight (0),
            Delay(5),

            F(int('111111', 2)),
            Delay(5),

            input_weight(1),
            Delay(5),

            F(int('011111', 2)),
            Delay(5),

            input_weight(2),
            F(int('111111', 2)),
            Delay(5),

            F(int('101111', 2)),
            Delay(5),

            input_weight(3),
            F(int('111111', 2)),
            Delay(5),

            F(int('110111', 2)),
            Delay(5),

            input_weight(4),
            Delay(5),

            F(int('111011', 2)),
            Delay(5),

            input_weight(5),
            Delay(5),

            F(int('111101', 2)),
            Delay(5),

            input_weight(6),
            Delay(5),

            F(int('111110', 2)),
            Delay(5),

            input_weight(7),
            Delay(5),

            F(0),
            Delay(5),

            Delay(100),

            simulation.finish()
            )

        return m

    def Tb_Stdp_case_gen(self):

        m = Module('test_stdp_case_gen')
        stdp_case = self.tnn.Stdp_case_gen()

        dut = Submodule(m, stdp_case, 'dut')

        stdp_cases = dut['stdp_cases']
        ein = dut['ein']
        eout = dut['eout']
        aclk = dut['aclk']
        grst = dut['grst']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [ein, eout, aclk, grst])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(
            ein(0),
            eout(0),
            Delay(5),

            ein(1),
            Delay(2),

            eout(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            eout(1),
            Delay(2),

            ein(1),
            Delay(16),

            ein(0),
            eout(0),
            
            Delay(5),
            ein(1),
            
            Delay(18),
            ein(0),

            Delay(16),
            eout(1),

            Delay(7),
            eout(0),

            Delay(5),
            ein(0),

            Delay(2),
            eout(0),

            Delay(6),
            ein(0),
            
            Delay(9),
            eout(0),

            Delay(10),
            ein(0),
            eout(0),

            Delay(10),

            Delay(100),

            simulation.finish()
            )

        m.Always(Posedge(aclk)) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                grst(1)) 
            .Else(
                grst(0))
            , EmbeddedCode('i=i+1;'))

        return m

    def Tb_Fsm_simple(self):

        m = Module('test_fsm_simple')
        fsm_simple = self.tnn.Fsm_simple()
        dut = Submodule(m, fsm_simple, 'dut')

        aclk = dut['aclk']
        rst = dut['rst']
        in_v = dut['in']
        out_v = dut['out']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [aclk, rst, in_v, out_v])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(

            in_v(0),
            rst(1),
            Delay(25),

            rst(0),
            Delay(5.001),

            in_v(1),
            Delay(1),

            in_v(0),
            Delay(12),

            in_v(1),
            Delay(5),

            in_v(0),
            Delay(3),

            rst(0),
            Delay(200),

            simulation.finish()
            )

        return m

    def Tb_Fsm_synapse(self):

        m = Module('test_fsm_synapse')
        synapse = self.tnn.Fsm_synapse()
        dut = Submodule(m, synapse, 'dut')

        weight_update_en = dut['weight_update_en']
        aclk = dut['aclk']
        gclk = dut['gclk']
        rst = dut['rst']
        input_spike = dut['input_spike']
        inc = dut['inc'] 
        dec = dut['dec']
        out_v = dut['out']
        weight = dut['weight']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [weight_update_en, aclk, gclk,
            input_spike, inc, dec, out_v, weight])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(

            input_spike(0),
            inc(0),
            dec(0),
            gclk(0),
            rst(1),
            Delay(25),

            rst(0),
            Delay(5),

            input_spike(1),
            Delay(8),

            input_spike(0),
            Delay(2),

            inc(1),
            Delay(14),

            input_spike(1),
            Delay(8),

            input_spike(0),
            Delay(17),

            input_spike(1),
            Delay(8),

            input_spike(0),
            Delay(5),

            inc(0),
            dec(1),
            Delay(20),

            input_spike(1),
            Delay(8),

            input_spike(0),
            Delay(5),

            inc(0),
            dec(1),
            Delay(25),

            rst(1),
            Delay(5),

            rst(0),
            inc(0),
            dec(0),
            Delay(5),

            Delay(200),

            simulation.finish()
            )

        m.Always(aclk) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                EmbeddedCode('gclk = ~gclk;')) 
            , EmbeddedCode('i=i+1;'))

        return m

    def Tb_Stdp(self):
        m = Module('test_stdp')
        stdp = self.tnn.Stdp()
        dut = Submodule(m, stdp, 'dut')

        ein = dut['ein']
        eout = dut['eout']
        capture = dut['capture']
        minus = dut['minus']
        search = dut['search']
        backoff = dut['backoff']
        min_v = dut['min']
        aclk = dut['aclk']
        grst = dut['grst']
        input_weight = dut['input_weight']
        F = dut['F']
        inc = dut['inc']
        dec = dut['dec']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [ein, eout, capture, minus, search,
            backoff, min_v, aclk, grst, input_weight, F, inc, dec])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(

            ein(0),
            input_weight(int('101',2)),
            eout(0),
            aclk(1),
            capture(1),
            minus(1),
            search(1),
            backoff(1),
            min_v(1),
            F (int('111111', 2)),
            Delay(5),

            ein(1),
            Delay(2),

            eout(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            eout(1),
            Delay(2),

            ein(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            ein(1),
            Delay(18),

            ein(0),
            Delay(16),

            eout(1),
            Delay(7),

            eout(0),
            Delay(5),

            ein(0),
            Delay(2),

            eout(0),
            Delay(6),

            ein(0),
            Delay(10),

            eout(0),
            Delay(5),

            search(0),
            capture(0),
            ein(0),
            Delay(2),

            eout(1),
            Delay(16),

            min_v(0),
            ein(0),
            eout(0),
            Delay(5),

            F(int('111101',2)),
            eout(1),
            Delay(2),

            ein(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            F(int('111111', 2)),
            ein(1),
            Delay(18),

            ein(0),
            Delay(16),

            eout(1),
            Delay(7),

            eout(0),
            Delay(5),

            ein(0),
            Delay(2),

            eout(0),
            Delay(6),

            ein(0),
            Delay(9),

            eout(0),
            Delay(10),

            ein(0),
            eout(0),
            Delay(10),

            simulation.finish()
            )

        m.Always(Posdge(aclk)) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                gclk(1)) 
            .Else(
                gclk(0))
            , EmbeddedCode('i=i+1;'))

        return m

    def Tb_Pac(self, ip_size = 4, thres = 13):
        m = Module('test_pac')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)

        pac = self.tnn.Pac(ip_size = ip_size.value, thres = thres.value)
        dut = Submodule(m, pac, 'dut')

        in_v = dut['in']
        aclk = dut['aclk']
        grst = dut['grst']
        out_v = dut['out']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [in_v, aclk, grst, out_v])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(
            i(0),
            in_v(0),
            Delay(5),

            in_v(int('0001', 2)),
            Delay(3),

            in_v(int('1001', 2)),
            Delay(2),

            in_v(int('1000', 2)),
            Delay(2),

            in_v(int('1100', 2)),
            Delay(2),

            in_v(int('1000', 2)),
            Delay(2),

            in_v(int('0000', 2)),
            Delay(3),

            in_v(int('0000', 2)),
            Delay(20),

            in_v(int('0000', 2)),
            Delay(200),

            simulation.finish()
            )

        m.Always(Posedge(aclk)) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                grst(1)) 
            .Else(
                grst(0))
            , EmbeddedCode('i=i+1;'))

        return m

    def Tb_Neuronbody(self, ip_size = 4, thres = 13):

        m = Module('test_neuron_body')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)

        nb = self.tnn.Neuronbody(ip_size = ip_size.value, thres = thres.value)
        dut = Submodule(m, nb, 'dut')

        acc_in = dut['acc_in']
        aclk = dut['aclk']
        pac_rst = dut['pac_rst']
        rst = dut['rst']
        out_v = dut['out_spike']

        i = m.Integer('i', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, [acc_in, aclk, pac_rst, rst, out_v])
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(
            i(0),
            acc_in(0),
            rst(1),
            Delay(5),

            rst(0),
            Delay(46),

            rst(0),
            Delay(1),

            acc_in(int('0001', 2)),
            Delay(1),

            acc_in(int('1001', 2)),
            Delay(4),       

            acc_in(int('1000', 2)),
            Delay(2),

            acc_in(int('1100', 2)),
            Delay(1),

            acc_in(int('0100', 2)),
            Delay(1),

            acc_in(int('0000', 2)),
            Delay(20),

            rst(1),
            Delay(20),

            acc_in(0),
            Delay(20),

            acc_in(0),
            Delay(200),

            simulation.finish()
            )

        m.Always(Posedge(aclk)) (EmbeddedCode('i= i%23;'), 
            If(i==0) (
                pac_rst(1)) 
            .Else(
                pac_rst(0))
            , EmbeddedCode('i = i+1;'))

        return m


    def Tb_NeuronRNL(self, ip_size = 4, thres = 13):
        m = Module('test_neuron_rnl')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        rnl = self.tnn.NeuronRNL(ip_size = ip_size.value, thres = thres.value)

        here = m.copy_sim_ports(rnl)

        input_spikes = here['input_spikes']
        inc = here['inc']
        dec = here['dec']
        weight_en = here['weight_update_en']
        aclk = here['aclk']
        gclk = here['gclk']
        grst = here['grst']
        rst = here['rst']
        out_v = here['out_spike']

        dut = m.Instance(rnl, 'dut', ports = m.connect_ports(rnl))

        i = m.Integer('i', 32, value = 0)
        j = m.Integer('j', 32, value = 0)

        dump = simulation.setup_waveform(m, dut, ports = m.connect_ports(rnl))
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(
            input_spikes (0),
            inc(0),
            dec(0),
            rst(1),
            Delay(18),
            
            rst(0),
            #/* Computational Wave 1 */
        
            Delay(29),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),
            
            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 2 */

            Delay(6),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),

            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](0),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 3 */

            Delay(5),
            inc[0](1),
            inc[1](1),
            inc[3](1),

            Delay(1),
            inc(0),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),

            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 4 */

            Delay(5),
            inc(1),

            Delay(1),
            inc(0),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),

            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 5 */

            Delay(5),
            inc(1),

            Delay(1),
            inc(0),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),

            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),
            input_spikes[0](0),
            
            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 6 */

            Delay(5),
            inc(1),

            Delay(1),
            inc(0),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),
            
            Delay(1),
            input_spikes[3](0),
            
            Delay(1),
            input_spikes[2](0),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 7 */

            Delay(5),
            inc[0](1),
            inc[1](1),
            inc[3](1),

            Delay(1),
            inc(0),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),

            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 8 */

            Delay(5),
            inc[0](1),
            inc[1](1),
            dec[2](1),
            inc[3](1),

            Delay(1),
            inc(0),
            dec(0),
            input_spikes[3](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[1](1),

            Delay(1),
            input_spikes[3](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),   
            input_spikes[0](0),

            Delay(4),
            input_spikes[1](0),

            Delay(2),
            input_spikes[2](0),

            #/* Computational Wave 9 */

            Delay(5),
            inc(1),

            Delay(1),
            inc(0),
            input_spikes[2](1),

            Delay(3),
            input_spikes[1](1),

            Delay(4),
            input_spikes[3](1),

            Delay(1),
            input_spikes[2](0),

            Delay(1),
            input_spikes[0](1),

            Delay(2),
            input_spikes[1](0),
            
            Delay(4),
            input_spikes[3](0),

            Delay(2),
            input_spikes[0](0),

            #/* Computational Wave 10 */

            Delay(5),
            inc(1),

            Delay(1),
            inc (0),
            input_spikes[1](1),

            Delay(3),
            input_spikes[0](1),

            Delay(4),
            input_spikes[3](1),

            Delay(1),
            input_spikes[1](0),

            Delay(1),
            input_spikes[2](1),

            Delay(2),
            input_spikes[0](0),

            Delay(4),
            input_spikes[3](0),

            Delay(2),
            input_spikes[2](0),

            Delay(10),
            input_spikes(0),

            Delay(10),
            simulation.finish()
            )
        m.Initial(i(0))
        m.Always(aclk) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                EmbeddedCode('gclk = ~gclk;'))
            , EmbeddedCode('i = i+1;'))

        m.Initial(j(0))
        m.Always(Posedge(aclk)) (EmbeddedCode('j = j%23;'), 
            If(j==0) (
                grst(1)) 
            .Else(  
                grst(0))
            , EmbeddedCode('j = j+1;'))

        return m