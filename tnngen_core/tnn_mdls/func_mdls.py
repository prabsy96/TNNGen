#!/usr/bin/env python
# coding: utf-8

# In[14]:


# Author = Prabhu Vellaisamy

# TNN Column Submodule VerilogGen library for Verilog RTL creation
# Original Verilog files created by Harideep Nair

from veriloggen import *
import numpy as np
import os

class TNN_Functions:

    # inhibit operator
    def Less_equal(self):

        m = Module('less_equal')

        # Input/output ports
        data_in = m.Input('data_in', 1)
        inhibit_in = m.Input('inhibit_in', 1)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        out = m.Output('out', 1)

        # Wires
        inhibit_only = m.Wire('inhibit_only', 1)
        inhibit_only_edge = m.Wire('inhibit_only_edge', 1)

        inhibit_only.assign(~data_in & inhibit_in)

        # Submodules
        pulse, _ = self.Pulse2edge()
        pe_le = m.Instance(pulse, 'pe_le', params=None, 
                           ports=[inhibit_only, clk, grst, rstb, inhibit_only_edge])

        out.assign(data_in & ~inhibit_only_edge)

        return m, ('clk')

    # Pulse to edge converter
    def Pulse2edge(self):

        m = Module('pulse2edge')

        # Input/output ports
        pulse_in = m.Input('pulse_in', 1)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        edge_out = m.Output('edge_out', 1)

        # Regs
        temp = m.Reg('temp', 1)

        m.Always(Posedge(clk))(
            If (grst | ~rstb)(temp(Int(0, width=1, base=2)))
            .Else(temp(edge_out))
        )

        edge_out.assign(pulse_in | temp)

        return m, ('clk')

    # Adder module
    def Adder(self, res=4):

        m = Module('adder')
        res = m.Parameter('RES', res)
    
        # Input/output ports
        a = m.Input('a', res)
        b = m.Input('b', res)
        cin = m.Input('cin')
        out = m.Output('out', res + 1)
    
        out.assign(a+b+cin)
    
        # no clocks, combinational design
        return m, None
        
    # Register module
    def Register(self, wl=1):
        
        m = Module('register')
        wl = m.Parameter('WL', wl)
        
        clk = m.Input('clk', 1)
        rst_b = m.Input('rst_b', 1)
        d = m.Input('d', wl)
        q = m.Output('q', wl)
        wen = m.Input('wen', 1)
        
        temp = m.Reg('temp', wl)
        
        m.Always(Posedge(clk)) (
          If(~rst_b)(temp(Int(0, width=wl.value, base=2)))
          .Else( If(wen)(temp(d))
                )
        )
        
        q.assign(temp)
        
        return m

    # Edge to pulse converter
    def Edge2pulse(self):
        
        m = Module('edge2pulse')

        # Input/output ports
        edge_in = m.Input('edge_in', 1)
        clk = m.Input('clk', 1)
        pulse_out = m.Output('pulse_out', 1)
        
        temp = m.Reg('temp', 1)

        # always block
        m.Always(Posedge(clk))(
            temp(edge_in)
        )
    
        pulse_out.assign(edge_in & ~temp)
            
        return m, ('clk')

    # Increment/decrement logic for synaptic weight updates
    def Incdec(self):

        m = Module('incdec')

        # Input/output ports
        stdp_cases = m.Input('stdp_cases', 4)
        capture_brv = m.Input('capture_brv', 1)
        minus_brv = m.Input('minus_brv', 1)
        search_brv = m.Input('search_brv', 1)
        backoff_brv = m.Input('backoff_brv', 1)
        min_brv = m.Input('min_brv', 1)
        fout_brv = m.Input('fout_brv', 1)
        inc = m.Output('inc', 1)
        dec = m.Output('dec', 1)
        
        stabilize_brv = m.Wire('stabilize_brv', 1)
    
        stabilize_brv.assign(fout_brv | min_brv)
    
        inc.assign((stdp_cases[0] & capture_brv & stabilize_brv) | (stdp_cases[2] & search_brv))
        dec.assign((stdp_cases[1] & minus_brv & stabilize_brv) | (stdp_cases[3] & backoff_brv & stabilize_brv))
    
        # no clocks returned
        return m, None

    # Winner Take All Operator
    def Wta(self, Q=10):

        m = Module('wta')
        q = m.Parameter('Q', Q)

        # Input/output ports
        ec_spikes = m.Input('ec_spikes', q)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        li_out = m.Output('li_out', q)

        first_spike = m.Wire('first_spike', 1)
        first_spike_edge = m.Wire('first_spike_edge', 1)
        inhibit_spikes = m.Wire('inhibit_spikes', q)

        m.EmbeddedCode("""assign first_spike = |ec_spikes;""")

        # Submodules
        pulse, _ = self.Pulse2edge()
        pulse_inst = m.Instance(pulse, 'pe_wta', params=None, ports=[
                                first_spike, clk, grst, rstb, first_spike_edge])
        
        less_equal, _ = self.Less_equal()
    
        for i in range(q.value):
            lq_inst = m.Instance(less_equal, 'l1_'+str(i), params=None,
            ports=[ec_spikes[i], first_spike_edge, clk, grst, rstb, inhibit_spikes[i]])
            
        li_out[0].assign(inhibit_spikes[0])
    
        for j in range(1, q.value):
            li_out[j].assign(inhibit_spikes[j] & ~ Uor(Slice(inhibit_spikes, j-1, 0)))
    
        return m, ('clk')



    # block to select appropriate BRVs
    def Stabilize_func(self,  wres=3):

        m = Module('stabilize_func')
        wres_v = m.Parameter('WRES', wres)

        # Input/output ports
        weight = m.Input('weight', wres_v)
        F_brv = m.Input('F', (1<<wres_v.value)-3 + 1)
        out = m.Output('out', 1)

        code = m.EmbeddedCode("""flogic_8x1 DUT (.OUT(out), .F_0(1'b0), .F_1(F[0]), .F_2(F[1]), .F_3(F[2]), .F_4(F[3]), .F_5(F[4]), .F_6(F[5]), .F_7(1'b1), .SEL_0(weight[0]), .SEL_1(weight[1]), .SEL_2(weight[2])); """)

        return m, None

    # case generator for STDP
    def Stdp_case_gen(self):
        
        m = Module('stdp_case_gen')
    
        # Input/output ports
        ein = m.Input('ein', 1)
        eout = m.Input('eout', 1)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        stdp_cases = m.Output('stdp_cases', 4)
        
        eout_only = m.Wire('eout_only', 1)
        e_both = m.Wire('e_both', 1)
        e_one = m.Wire('e_one', 1)
        greater = m.Wire('greater', 1)
    
        eout_only.assign(~ ein & eout)
    
        # submodule
        pulse, _ = self.Pulse2edge()
        pulse_inst = m.Instance(pulse, 'pe', params=None,  ports=[
                                eout_only, clk, grst, rstb, greater])
    
        e_both.assign(ein & eout)
        e_one.assign(ein ^ eout)
    
        stdp_cases[0].assign(~ greater & e_both)
        stdp_cases[1].assign(greater & e_both)
        stdp_cases[2].assign(~ greater & e_one)
        stdp_cases[3].assign(greater & e_one)
        
        return m, ('clk')

    # Converts pac single cycle pulse to generate [wmax+1]-cycles wide output spike pulse
    def Fsm_convert(self, wres=3):

        m = Module('fsm_convert')
        wres_v = m.Parameter('WRES', wres)

        # Input/output ports
        in_v = m.Input('in', 1)
        clk = m.Input('clk', 1)
        rstb = m.Input('rstb', 1)
        out_v = m.Output('out', 1)

        state = m.Reg('state', wres_v)
        temp = m.Reg('temp', 1)

        m.Always(Posedge(clk)) (
            If(~rstb)(
                state(Int(0, width=wres_v.value, base=2))
            )
            .Else(
                If(state == Int(0, width=wres_v.value, base=2)) (
                    If(in_v)(
                        state(state + 1)
                    )
                )
                .Else(
                    state(state + 1)
                )
            )
        )

        m.Always()(
            If(state == 0)(
                temp(Int(1, width=1, base=2))
            )
            .Else(
                temp(Int(0, width=1, base=2))
            )
        )

        out_v.assign((~temp) | (temp & in_v))

        return m, ('clk')

    # synapse implementation
    def Fsm_synapse(self, wres=3):

        m = Module('fsm_synapse')

        wres_v = m.Parameter('WRES', wres)

        # Input/output ports
        input_spike = m.Input('input_spike', 1)
        w_init = m.Input('w_init', wres_v)
        inc = m.Input('inc', 1)
        dec = m.Input('dec', 1)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        w_out = m.Output('w_out', wres_v)
        syn_out_v = m.Output('syn_out', 1)

        weight = m.Reg('weight', wres_v)
        w_nonzero = m.Reg('w_nonzero', 1)

        m.Always(Posedge(clk)) (
            # Global reset to initialize weight to zero
            If(~rstb)(
                weight(w_init),
                w_nonzero(w_init > 0)
            )
            # STDP update
            .Elif(grst)(
                If((inc == Int(1, width=1, base=2)) & (weight < Int(2**wres_v.value - 1, width=wres_v.value, base=2))) (
                    weight(weight + Int(1, width=wres_v.value, base=2)),
                    w_nonzero(Int(1, width=1, base=2))
                )
                .Elif((dec == Int(1, width=1, base=2)) & (weight > 0)) (
                    weight(weight - Int(1, width=wres_v.value, base=2)),
                    w_nonzero(Slice(weight, wres_v.value-1, 1) != 0)
                )
                .Else(
                    w_nonzero(weight > 0)
                )
            )
            # RNL readout
            .Elif(input_spike) (
                weight(weight - Int(1, width=wres_v.value, base=2)),
                If(w_nonzero == Int(0, width=1, base=2)) (
                    w_nonzero(Int(0, width=1, base=2))
                )
                .Else(
                    If(Uor(Slice(weight, wres_v.value-1, 1)) == 0) (
                        w_nonzero(Int(0, width=1, base=2))
                    )
                    .Else(
                        w_nonzero(Int(1, width=1, base=2))
                    )
                )
            )
        )

        syn_out_v.assign(input_spike & w_nonzero)
        w_out.assign(weight)

        return m, ('clk')

    
    # STDP top module
    def Stdp(self, wres=3):
    
        m = Module('stdp')

        wres_v = m.Parameter('WRES', wres)

        # Input/output ports
        weight_in = m.Input('weight_in', wres_v)
        ein = m.Input('ein', 1)
        eout = m.Input('eout', 1)
        capture_brv = m.Input('capture_brv', 1)
        minus_brv = m.Input('minus_brv', 1)
        search_brv = m.Input('search_brv', 1)
        backoff_brv = m.Input('backoff_brv', 1)
        min_brv = m.Input('min_brv', 1)
        F_brv = m.Input('F_brv', (1<<wres)-3 + 1)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        inc = m.Output('inc', 1)
        dec = m.Output('dec', 1)

        stdp_cases = m.Wire('stdp_cases', 4)
        fout_brv = m.Wire('fout_brv', 1)
    
        # target submodule
        stdp_case, _ = self.Stdp_case_gen()
        flogic, _ = self.Stabilize_func(wres_v.value)
        incdec, _ = self.Incdec()
    
        stdp_case_gen_inst = m.Instance(stdp_case, 'casegen', params=None, ports=[
                                        ein, eout, clk, grst, rstb, stdp_cases])
        flogic_inst = m.Instance(flogic, 'flogic', params=[wres],
                                 ports=[weight_in, F_brv, fout_brv])
        incdec_inst = m.Instance(incdec, 'control', params=None, ports=[
                                 stdp_cases, capture_brv, minus_brv, search_brv, backoff_brv, min_brv, fout_brv, inc, dec])
    
        return m, ('clk')

    # Parallel Accumulator
    def Pac(self, ip_size = 16, thres = 13):
        m = Module('pac')

        INP = m.Parameter('INP', int(ip_size))
        THRESHOLD = m.Parameter('THRESHOLD', int(thres)) 

        clog2_input_size = np.ceil(np.log2(int(INP.value)))
        clog2_thres = np.ceil(np.log2(int(THRESHOLD.value)))

        p_res = m.Localparam('P_RES', int(clog2_input_size))
        in_size = m.Localparam('IN_SIZE', int(1 << p_res.value))
        stages = m.Localparam('STAGES', p_res.value - 1)
        num = m.Localparam('NUM', 2*in_size.value-p_res.value-2)
        maxres = m.Localparam('MAXRES', max(p_res.value+1, int(clog2_thres)+1))

        # Inputs and Outputs
        in_v = m.Input('in', INP.value)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        pac_out = m.Output('pac_out', 1)

        padded_in = m.Wire('padded_in', in_size.value)
        temp = m.Wire('temp', num)
        parallel_out = m.Wire('parallel_out', p_res)
        body_pot = m.Wire('body_pot', maxres.value + 1)
        regout = m.Reg('regout', maxres)
        poutlatch = m.Reg('poutlatch', 1)

        padded_in.assign(Cat(Int(value=0, width=in_size.value-INP.value, base=2), in_v))

        in_size_val = int((in_size.value)/2)
    
        for i_v in range(in_size_val):
            temp[i_v].assign(padded_in[i_v])

        # submodule
        adder, _ = self.Adder()

        for i in range(stages.value):
            for j in range(int(in_size.value/(1<<(i+2)))):
                m.Instance(adder, 
                            'a1_'+str(i)+str(j), 
                            params=[i+1], 
                            ports=[
                                Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + 2*j *(i+1)+i, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + 2*j*(i+1)),
                                Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1) * (i+1)+i, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1)*(i+1)),
                                padded_in[Add(in_size_val, (Srl(in_size.value, i+1))*((Sll(1, i)-1))+j)],
                                Slice(temp, Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3) + j*(i+2) + (i+1), Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3) + j*(i+2))
                            ])
        
        parallel_out.assign(Slice(temp, num.value - 1, num.value - p_res.value))

        m.Instance(adder, 
                   'adder2_in_pac', 
                   params=[maxres.value], 
                   ports=[
                          Cat(Int(value=0, width=maxres.value-p_res.value, base=2), parallel_out),
                          regout,
                          Slice(padded_in, in_size.value-1 , in_size.value-1),
                          body_pot
                         ])

        m.Always(Posedge(clk))(
            If(grst | ~rstb)(
                regout(Int(-1*THRESHOLD.value, width=maxres.value, base=2)),
                poutlatch(Int(0, width=1, base=2))
            )
            .Else(
                If(pac_out)(
                    regout(Int(-1*THRESHOLD.value, width=maxres.value, base=2))
                )
                .Else(
                    regout(Slice(body_pot, maxres.value-1 , 0))
                ),
                poutlatch(pac_out)
            )
        )

        pac_out.assign(Slice(body_pot, maxres.value, maxres.value) | poutlatch)

        return m, ('clk')

    # Neuron body module
    def Neuronbody(self, ip_size=16, thres=13, wres=3):
    
        m = Module('neuron_body')
    
        in_size_v = m.Parameter('INPUT_SIZE', ip_size)
        thres_v = m.Parameter('THRESHOLD', thres)
        wres_v = m.Parameter('WRES', wres)
    
        # inputs and outputs
        acc_in = m.Input('acc_in', in_size_v.value)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        out_v = m.Output('output_spike', 1)
    
        edge_v = m.Wire('edge_spike', 1)
        pulse_v = m.Wire('pulse_spike', 1)

        # submodule
        pac, pac_clk = self.Pac(ip_size=in_size_v.value, thres=thres_v.value)
        fsm_c, fsm_c_clk = self.Fsm_convert(wres_v.value)
        edge, _ = self.Edge2pulse()
    
        par_pac = [in_size_v.value, thres_v.value]
    
        pac_inst = m.Instance(pac, 'acc', params=par_pac, ports=[
                              acc_in, clk, grst, rstb, edge_v])
        
        edge_inst = m.Instance(edge, 'epn', ports=[edge_v, clk, pulse_v])
    
        fsm_convert_inst = m.Instance(fsm_c, 'conv', params=[wres_v.value], ports=[
                                      pulse_v, clk, rstb, out_v])
    
        return m, ('clk')
    
    # Neuron RNL
    def NeuronRNL(self, ip_size=16, thres=13, wres = 3):
    
        m = Module('neuron_rnl_ptt')
        in_size = m.Parameter('INPUT_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        wres = m.Parameter('wres', wres)
    
        # inputs and outputs
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
            weight.append(m.Output('weights_'+str(i), wres.value))
    
        up_in = m.Wire('up_in', in_size.value)
    
        # submodule
        fsm_s, fsm_clk = self.Fsm_synapse(wres.value)
        nbody, nbody_clk = self.Neuronbody(ip_size=in_size.value, thres=thres.value, wres=wres.value)
    
        for i in range(in_size.value):
            m.Instance(fsm_s, 'f1_'+str(i), params=None,
                       ports=[in_v[i], 0, inc[i], dec[i], aclk, gclk, rst, weight[i], up_in[i]])
    
        par_nbody = [in_size.value, thres.value, wres.value]
    
        m.Instance(nbody, 'p1', params=par_nbody, ports=[
                   up_in, aclk, grst, rst, out_v])
    
        return m, ('aclk', 'gclk')
    
    # Segment
    def segment(self, ip_size_dist=16, ip_size_prox=1, wres_dist=3, wres_prox=3, thres=13):

        m = Module('segment')
        # parameters
        in_size_dist = m.Parameter('INP_DIST', ip_size_dist)
        in_size_prox = m.Parameter('INP_PROX', ip_size_prox)
        wres_dist = m.Parameter('WRES_DIST', wres_dist)
        wres_prox = m.Parameter('WRES_PROX', wres_prox)
        thres = m.Parameter('THRESHOLD', thres)

        # inputs and outputs
        input_spikes_dist = m.Input('input_spikes_dist', in_size_dist.value)
        input_spikes_prox = m.Input('input_spikes_prox', in_size_prox.value)
        inc_dist = m.Input('inc_dist', in_size_dist.value)
        inc_prox = m.Input('inc_prox', in_size_prox.value)
        dec_dist = m.Input('dec_dist', in_size_dist.value)
        dec_prox = m.Input('dec_prox', in_size_prox.value)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        output_spike = m.Output('output_spike', 1)

        w_init_dist = []
        for i in range(in_size_dist.value):
            w_init_dist.append(m.Input('w_init_dist_'+str(i), wres_dist.value))

        w_init_prox = []
        for i in range(in_size_prox.value):
            w_init_prox.append(m.Input('w_init_prox_'+str(i), wres_prox.value))

        weights_dist = []
        for i in range(in_size_dist.value):
            weights_dist.append(m.Output('weights_dist_'+str(i), wres_dist.value))

        weights_prox = []
        for i in range(in_size_prox.value):
            weights_prox.append(m.Output('weights_prox_'+str(i), wres_prox.value))

        # wires/regs
        resp_func_dist = m.Wire('resp_func_dist', in_size_dist.value)
        resp_func_prox = m.Wire('resp_func_prox', in_size_prox.value)
            
        # submodules
        # Distal: Synaptic weight + readout logic FSM
        fsm_s_dist, fsm_clk_dist = self.Fsm_synapse(wres_dist.value)
        for i in range(in_size_dist.value):
            ### TODO: investigate fsm_synapse module ###
            m.Instance(fsm_s_dist, 'syn_dist_'+str(i), params=None,
                       ports=[input_spikes_dist[i], w_init_dist[i], inc_dist[i], dec_dist[i], clk, grst, rstb, weights_dist[i], resp_func_dist[i]])

        # Proximal: Synaptic weight + readout logic FSM
        fsm_s_prox, fsm_clk_prox = self.Fsm_synapse(wres_prox.value)
        for i in range(in_size_prox.value):
            ### TODO: investigate fsm_synapse module ###
            m.Instance(fsm_s_prox, 'syn_prox_'+str(i), params=None,
                       ports=[input_spikes_prox[i], w_init_prox[i], inc_prox[i], dec_prox[i], clk, grst, rstb, weights_prox[i], resp_func_prox[i]])

        # Neuron body
        soma, soma_clk = self.Neuronbody(ip_size=in_size_dist.value+in_size_prox.value, thres=thres.value, wres=wres_dist.value)
        m.Instance(soma, 'soma', params=[in_size_dist.value+in_size_prox.value, thres.value, wres_dist.value],
                  ports=[Cat(resp_func_prox,resp_func_dist), clk, grst, rstb, output_spike])

        return m, ('clk')


# Testbench class

class Test_TNN_Functions(TNN_Functions):

    tnn = TNN_Functions()

    def Tb_Less_equal(self):

        m = Module('test_less_equal')
        lq, lq_clk = self.tnn.Less_equal()

        dut = Submodule(m, lq, name='dut')

        data_in = dut['data_in']
        inhibit_in = dut['inhibit_in']
        clk = dut['clk']
        rst = dut['rst']
        out = dut['out']

        i = m.Integer('i', 32, 0)

        dump = simulation.setup_waveform(
            m, dut, [data_in, inhibit_in, clk, rst, out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

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

        m.Always(clk)(EmbeddedCode('i = i%23;'),
                       If(i == 0)(
            rst(1))
            .Else(
                rst(0)), EmbeddedCode('i = i+1;'))

        return m


# In[30]:


    def Tb_Pulse2edge(self):
        m = Module('test_pulse2edge')
    
        pulse, pulse_clk = self.tnn.Pulse2edge()
    
        dut = Submodule(m, pulse, 'dut')
    
        edge_out = dut['edge_out']
        pulse_in = dut['pulse_in']
        aclk = dut['aclk']
        grst = dut['grst']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [pulse_in, aclk, grst, edge_out])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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
    
        m.Always(Posedge(aclk))(EmbeddedCode('i = i%23;'),
                                If(i == 0)(
            grst(1))
            .Else(
                grst(0)), EmbeddedCode('i=i+1;'))
    
        return m


# In[31]:


    def Tb_Adder(self, RES=4):
        m = Module('test_adder')
    
        res = m.Parameter('RES', RES)
    
        adder, add_clk = self.tnn.Adder(res.value)
    
        dut = Submodule(m, adder, 'dut')
    
        out = dut['out']
        a = dut['a']
        b = dut['b']
        cin = dut['cin']
    
        i = m.Integer('i', 32, value=0)
    
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


# In[32]:


    def Tb_Edge2pulse(self):
        m = Module('test_edge2pulse')
    
        edge, edge_clk = self.tnn.Edge2pulse()
    
        dut = Submodule(m, edge, 'dut')
    
        edge_in = dut['edge_in']
        clk_in = dut['clk_in']
        pulse_out = dut['pulse_out']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [edge_in, clk_in, pulse_out])
        clock = simulation.setup_clock(m, clk_in, hperiod=0.5)
    
        dump.add(
            edge_in(0),
            Delay(5),
    
            edge_in(1),
            Delay(100),
    
            simulation.finish()
        )
    
        m.Always(clk_in)(EmbeddedCode('i = i%23;'),
                         If(i == 0)(
            EmbeddedCode('dut_edge_in = ~dut_edge_in;')), EmbeddedCode('i = i+1;'))
    
        return m


# In[33]:


    def Tb_Incdec(self):
        m = Module('test_incdec')
    
        incdec, inc_clk = self.tnn.Incdec()
    
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
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(
            m, dut, [cases, capture, minus, search, backoff, min_v, F, inc, dec])
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


# In[34]:


    def Tb_Wta(self, Q=4):
    
        m = Module('test_wta')
    
        q = m.Parameter('Q', Q)
        wta, wta_clk = self.tnn.Wta(q.value)
    
        dut = Submodule(m, wta, 'dut')
    
        ec_spikes = dut['ec_spikes']
        aclk = dut['aclk']
        grst = dut['grst']
        li_out = dut['li_out']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [ec_spikes, aclk, grst, li_out])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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
    
        m.Always(Posedge(aclk))(EmbeddedCode('i = i%23;'),
                                If(i == 0)(
            grst(1))
            .Else(
                grst(0)), EmbeddedCode('i=i+1;'))
    
        return m


# In[35]:


    def Tb_Flogic(self, wres = 3):
    
        m = Module('test_flogic')
        flogic, flogic_clk = self.tnn.Flogic(wres)
    
        dut = Submodule(m, flogic, 'dut')
    
        F = dut['F']
        input_weight = dut['input_weight']
        out = dut['out']
    
        dump = simulation.setup_waveform(m, dut, [F, input_weight, out])
    
        dump.add(
            F(0),
            input_weight(0),
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


# In[36]:


    def Tb_Stdp_case_gen(self):
    
        m = Module('test_stdp_case_gen')
        stdp_case, case_clk = self.tnn.Stdp_case_gen()
    
        dut = Submodule(m, stdp_case, 'dut')
    
        stdp_cases = dut['stdp_cases']
        ein = dut['ein']
        eout = dut['eout']
        aclk = dut['aclk']
        grst = dut['grst']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [ein, eout, aclk, grst])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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
    
        m.Always(Posedge(aclk))(EmbeddedCode('i = i%23;'),
                                If(i == 0)(
            grst(1))
            .Else(
                grst(0)), EmbeddedCode('i=i+1;'))
    
        return m


# In[37]:


    def Tb_Fsm_convert(self, wres = 3):
    
        m = Module('test_fsm_convert')
        fsm_convert, simple_clk = self.tnn.Fsm_convert(wres)
        dut = Submodule(m, fsm_convert, 'dut')
    
        aclk = dut['aclk']
        rst = dut['rst']
        in_v = dut['in']
        out_v = dut['out']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [aclk, rst, in_v, out_v])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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


# In[38]:


    def Tb_Fsm_synapse(self, wres = 3):
    
        m = Module('test_fsm_synapse')
        synapse, synapse_clk= self.tnn.Fsm_synapse(wres)
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
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [weight_update_en, aclk, gclk,
                                                  input_spike, inc, dec, out_v, weight])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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
    
        m.Always(aclk)(EmbeddedCode('i = i%23;'),
                       If(i == 0)(
            EmbeddedCode('gclk = ~gclk;')), EmbeddedCode('i=i+1;'))
    
        return m


# In[39]:


    def Tb_Stdp(self, wres = 3):
        m = Module('test_stdp')
        stdp, stdp_clk = self.tnn.Stdp(wres)
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
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [ein, eout, capture, minus, search,
                                                  backoff, min_v, aclk, grst, input_weight, F, inc, dec])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
        dump.add(
    
            ein(0),
            input_weight(int('101', 2)),
            eout(0),
            aclk(1),
            capture(1),
            minus(1),
            search(1),
            backoff(1),
            min_v(1),
            F(int('111111', 2)),
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
    
            F(int('111101', 2)),
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
    
        m.Always(Posdge(aclk))(EmbeddedCode('i = i%23;'),
                               If(i == 0)(
            gclk(1))
            .Else(
                gclk(0)), EmbeddedCode('i=i+1;'))
    
        return m


# In[40]:


    def Tb_Pac(self, ip_size=4, thres=13):
        m = Module('test_pac')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
    
        pac, pac_clk = self.tnn.Pac(ip_size=ip_size.value, thres=thres.value)
        dut = Submodule(m, pac, 'dut')
    
        in_v = dut['in']
        aclk = dut['aclk']
        grst = dut['grst']
        out_v = dut['out']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [in_v, aclk, grst, out_v])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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
    
        m.Always(Posedge(aclk))(EmbeddedCode('i = i%23;'),
                                If(i == 0)(
            grst(1))
            .Else(
                grst(0)), EmbeddedCode('i=i+1;'))
    
        return m


# In[41]:


    def Tb_Neuronbody(self, ip_size=4, thres=13, wres = 3):
    
        m = Module('test_neuron_body')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        wres = m.Parameter('WRES', wres)
    
        nb, bdy_clk = self.tnn.Neuronbody(ip_size=ip_size.value, thres=thres.value, wres=wres.value)
        dut = Submodule(m, nb, 'dut')
    
        acc_in = dut['acc_in']
        aclk = dut['aclk']
        pac_rst = dut['pac_rst']
        rst = dut['rst']
        out_v = dut['out_spike']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(
            m, dut, [acc_in, aclk, pac_rst, rst, out_v])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
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
    
        m.Always(Posedge(aclk))(EmbeddedCode('i= i%23;'),
                                If(i == 0)(
            pac_rst(1))
            .Else(
                pac_rst(0)), EmbeddedCode('i = i+1;'))
    
        return m


# In[ ]:


    def Tb_NeuronRNL(self, ip_size=4, thres=13, wres = 3):
        m = Module('test_neuron_rnl')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        wres = m.Parameter('WRES', wres)

        rnl, rnl_clk = self.tnn.NeuronRNL(ip_size=ip_size.value, thres=thres.value, wres=wres)
    
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
    
        dut = m.Instance(rnl, 'dut', ports=m.connect_ports(rnl))
    
        i = m.Integer('i', 32, value=0)
        j = m.Integer('j', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, ports=m.connect_ports(rnl))
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)
    
        dump.add(
            input_spikes(0),
            inc(0),
            dec(0),
            rst(1),
            Delay(18),
    
            rst(0),
            # /* Computational Wave 1 */
    
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
    
            # /* Computational Wave 2 */
    
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
    
            # /* Computational Wave 3 */
    
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
    
            # /* Computational Wave 4 */
    
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
    
            # /* Computational Wave 5 */
    
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
    
            # /* Computational Wave 6 */
    
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
    
            # /* Computational Wave 7 */
    
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
    
            # /* Computational Wave 8 */
    
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
    
            # /* Computational Wave 9 */
    
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
    
            # /* Computational Wave 10 */
    
            Delay(5),
            inc(1),
    
            Delay(1),
            inc(0),
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
        m.Always(aclk)(EmbeddedCode('i = i%23;'),
                       If(i == 0)(
            EmbeddedCode('gclk = ~gclk;')), EmbeddedCode('i = i+1;'))
    
        m.Initial(j(0))
        m.Always(Posedge(aclk))(EmbeddedCode('j = j%23;'),
                                If(j == 0)(
            grst(1))
            .Else(
                grst(0)), EmbeddedCode('j = j+1;'))
    
        return m
