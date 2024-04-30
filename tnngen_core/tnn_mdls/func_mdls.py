#!/usr/bin/env python
# coding: utf-8

# Author = Prabhu Vellaisamy

# TNN Column Submodule VerilogGen library for Verilog RTL creation
# Original Verilog files created by Harideep Nair

from veriloggen import *
import numpy as np
import os

class TNN_Functions():
    def __init__(self, layer_id=None):
        self.layer_id = layer_id

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

        m = Module('L'+self.layer_id+'_wta_'+str(Q))
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

    # t-Winner Take All Operator
    def t_wta(self, Q=10):

        m = Module('L'+self.layer_id+'_t_wta_'+str(Q))
        q = m.Parameter('Q', Q)

        # Input/output ports
        ec_spikes = m.Input('ec_spikes', q)
        clk = m.Input('clk', 1)
        grst = m.Input('grst', 1)
        rstb = m.Input('rstb', 1)
        li_out = m.Output('li_out', q)

        first_spike = m.Wire('first_spike', 1)
        first_spike_edge = m.Wire('first_spike_edge', 1)

        m.EmbeddedCode("""assign first_spike = |ec_spikes;""")

        # Submodules
        pulse, _ = self.Pulse2edge()
        pulse_inst = m.Instance(pulse, 'pe_wta', params=None, ports=[
                                first_spike, clk, grst, rstb, first_spike_edge])
        
        less_than_or_equal, _ = self.Less_equal()
    
        for i in range(q.value):
            lq_inst = m.Instance(less_than_or_equal, 'l1_'+str(i), params=None,
            ports=[ec_spikes[i], first_spike_edge, clk, grst, rstb, li_out[i]])
    
        return m, ('clk')

    # block to select appropriate BRVs
    def Stabilize_func(self,  wres=3):

        m = Module('L'+self.layer_id+'_stabilize_func')
        wres_v = m.Parameter('WRES', wres)

        # Input/output ports
        weight = m.Input('weight', wres_v)
        F_brv = m.Input('F_brv', (1<<wres_v.value)-3 + 1)
        out = m.Output('out', 1)

        code = m.EmbeddedCode("""flogic_8x1 DUT (.OUT(out), .F_0(1'b0), .F_1(F_brv[0]), .F_2(F_brv[1]), .F_3(F_brv[2]), .F_4(F_brv[3]), .F_5(F_brv[4]), .F_6(F_brv[5]), .F_7(1'b1), .SEL_0(weight[0]), .SEL_1(weight[1]), .SEL_2(weight[2])); """)
        # code = m.EmbeddedCode("""
        #     reg [1-1:0] out_reg;
        #     always_comb
        #     begin
        #         out_reg = 0;
        #         if ((weight == 0) | (weight == ((1<<WRES)-1))) out_reg = 0;
        #         for (int i = 1; i < ((1<<WRES)-1); i++)
        #         begin
        #             if (weight == i) out_reg = F[i-1];
        #         end
        #     end
        #     assign out = out_reg;""")
        # code = m.EmbeddedCode("""
        #     reg out_reg;
        #     always @*
        #     begin
        #         out_reg = 0;
        #         if ((weight == 0) | (weight == ((1<<WRES)-1))) out_reg = 0;
        #         for (int i = 1; i < ((1<<WRES)-1); i++)
        #         begin
        #             if (weight == i) out_reg = F_brv[i-1];
        #         end
        #     end
        #     assign out = out_reg;""")

        return m, None

    # case generator for STDP
    def Stdp_case_gen(self):
        
        m = Module('L'+self.layer_id+'_stdp_case_gen')
    
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

        m = Module('L'+self.layer_id+'_fsm_convert')
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
                        state(state + Int(1, width=wres_v.value, base=2))
                    )
                )
                .Else(
                    state(state + Int(1, width=wres_v.value, base=2))
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

        m = Module('L'+self.layer_id+'_fsm_synapse')

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
    
        m = Module('L'+self.layer_id+'_stdp_wres_'+str(wres))

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
        m = Module('L'+self.layer_id+'_pac')

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

        padded_in.assign(Cat(Int(value=0, width=(in_size.value-INP.value), base=2), in_v))

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
    
        m = Module('L'+self.layer_id+'_neuron_body')
    
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

        m = Module('L'+self.layer_id+'_segment')
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
    
    # Compound Column
    def Comp_column(self, num_neurons=10, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):
        print(self)
        m = Module('L'+self.layer_id+'_comp_column_')
        num_neurons = m.Parameter('NUM_NEURONS', int(num_neurons))
        num_dend = m.Parameter('NUM_DEND', int(num_dend))
        p_dist = m.Parameter('P_DIST', int(p_dist))
        p_prox = m.Parameter('P_PROX', int(p_prox))
        num_seg = m.Parameter('NUM_SEG', int(num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(wres_prox))
        threshold = m.Parameter('THRESHOLD', int(thres))

        ##################
        # Inputs/Outputs #
        ##################

        # Control Signals
        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        # Output spikes
        output_spikes = m.Output('output_spikes', num_neurons.value)

        input_spikes_dist, input_spikes_prox = [], []
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # input_spikes_dist
        for i in range(num_neurons.value):
            input_spikes_dist.append(m.Input('input_spikes_dist_'+str(i), p_dist.value))

        # input_spikes_prox
        for i in range(num_dend.value):
            input_spikes_prox.append(m.Input('input_spikes_prox_'+str(i), p_prox.value))

        # w_init_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value):
                    for k in range(p_dist.value):
                        w_init_dist.append(m.Input('w_init_dist_'+str(n)+'_'+str(i)+str(j)+str(k), wres_dist.value))

        # w_init_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value):
                    for k in range(p_prox.value):
                        w_init_prox.append(m.Input('w_init_prox_'+str(n)+'_'+str(i)+str(j)+str(k), wres_prox.value))

        # capture_brv_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value):
                    capture_brv_dist.append(m.Input('capture_brv_dist_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        # capture_brv_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value):
                    capture_brv_prox.append(m.Input('capture_brv_prox_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        # minus_brv_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value):
                    minus_brv_dist.append(m.Input('minus_brv_dist_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        # minus_brv_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value):       
                    minus_brv_prox.append(m.Input('minus_brv_prox_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        # search_brv_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    search_brv_dist.append(m.Input('search_brv_dist_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        # search_brv_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    search_brv_prox.append(m.Input('search_brv_prox_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        # backoff_brv_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        # backoff_brv_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        # min_brv_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    min_brv_dist.append(m.Input('min_brv_dist_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        # min_brv_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    min_brv_prox.append(m.Input('min_brv_prox_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        # F_brv_dist
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    F_brv_dist.append(m.Input('F_brv_dist_'+str(n)+'_'+str(i)+str(j), (1<<wres_dist.value)-3 + 1))
        # F_brv_prox
        for n in range(num_neurons.value):
            for i in range(num_dend.value):
                for j in range(num_seg.value): 
                    F_brv_prox.append(m.Input('F_brv_prox_'+str(n)+'_'+str(i)+str(j), (1<<wres_prox.value)-3 + 1))


        ##############
        # Wires/Regs #
        ##############
        prewta_spikes = m.Wire('prewta_spikes', num_neurons.value)

        ##################
        # Instantiations #
        ##################
        comp_neuron, _ = self.Comp_neuron(num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for n in range(num_neurons.value):
            neuron_ports = [clk, grst, rstb, prewta_spikes[n], input_spikes_dist[n]]
            for i in range(num_dend.value):
                neuron_ports.append(input_spikes_prox[i])
            # w_init_dist
            neuron_ports = self.append_port3(neuron_ports, w_init_dist, n, num_dend.value, num_seg.value, p_dist.value)
            # w_init_prox
            neuron_ports = self.append_port3(neuron_ports, w_init_prox, n, num_dend.value, num_seg.value, p_prox.value)
            # capture_brv_dist
            neuron_ports = self.append_port2(neuron_ports, capture_brv_dist, n, num_dend.value, num_seg.value)
            # capture_brv_prox
            neuron_ports = self.append_port2(neuron_ports, capture_brv_prox, n, num_dend.value, num_seg.value)
            # minus_brv_dist
            neuron_ports = self.append_port2(neuron_ports, minus_brv_dist, n, num_dend.value, num_seg.value)
            # minus_brv_prox
            neuron_ports = self.append_port2(neuron_ports, minus_brv_prox, n, num_dend.value, num_seg.value)
            # search_brv_dist
            neuron_ports = self.append_port2(neuron_ports, search_brv_dist, n, num_dend.value, num_seg.value)
            # search_brv_prox
            neuron_ports = self.append_port2(neuron_ports, search_brv_prox, n, num_dend.value, num_seg.value)
            # backoff_brv_dist
            neuron_ports = self.append_port2(neuron_ports, backoff_brv_dist, n, num_dend.value, num_seg.value)
            # backoff_brv_prox
            neuron_ports = self.append_port2(neuron_ports, backoff_brv_prox, n, num_dend.value, num_seg.value)
            # min_brv_dist
            neuron_ports = self.append_port2(neuron_ports, min_brv_dist, n, num_dend.value, num_seg.value)
            # min_brv_prox
            neuron_ports = self.append_port2(neuron_ports, min_brv_prox, n, num_dend.value, num_seg.value)
            # F_brv_dist
            neuron_ports = self.append_port2(neuron_ports, F_brv_dist, n, num_dend.value, num_seg.value)
            # F_brv_prox
            neuron_ports = self.append_port2(neuron_ports, F_brv_prox, n, num_dend.value, num_seg.value)
            
            m.Instance(comp_neuron, str('L')+self.layer_id+'_comp_neuron_inst_'+str(n), params=[num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = neuron_ports)
            
        t_wta, _ = self.t_wta(num_neurons.value)
        m.Instance(t_wta, 'l1', params=[num_neurons.value], ports=[prewta_spikes, clk, grst, rstb, output_spikes])

        return m, clk.name
    
    def CV_group(self, num_units=10, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):
        m = Module('L'+self.layer_id+'_CV_group')
        num_units = m.Parameter('NUM_NEURONS', int(num_units))
        p_dist = m.Parameter('P_DIST', int(p_dist))
        p_prox = m.Parameter('P_PROX', int(p_prox))
        num_seg = m.Parameter('NUM_SEG', int(num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(wres_prox))
        threshold = m.Parameter('THRESHOLD', int(thres))

        ##################
        # Inputs/Outputs #
        ##################

        # Control Signals
        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        # Output spikes
        output_spikes = m.Output('output_spikes', num_units.value)

        input_spikes_prox = []
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # input_spikes_dist (shared across all CV units)
        input_spikes_dist = m.Input('input_spikes_dist', p_dist.value)
        # input_spikes_prox (different for every CV units)
        for i in range(num_units.value):
            input_spikes_prox.append(m.Input('input_spikes_prox_'+str(i), p_prox.value))

        # w_init_dist
        for n in range(num_units.value):
            for i in range(num_seg.value):
                for j in range(p_dist.value):
                    w_init_dist.append(m.Input('w_init_dist_'+str(n)+'_'+str(i)+str(j), wres_dist.value))
         # w_init_prox
        for n in range(num_units.value):
            for i in range(num_seg.value):
                for j in range(p_prox.value):
                    w_init_prox.append(m.Input('w_init_prox_'+str(n)+'_'+str(i)+str(j), wres_prox.value))
        # capture_brv_dist
        for n in range(num_units.value):
            for i in range(num_seg.value):
                capture_brv_dist.append(m.Input('capture_brv_dist_'+str(n)+'_'+str(i), p_dist.value))
        # capture_brv_prox
        for n in range(num_units.value):
            for i in range(num_seg.value):
                capture_brv_prox.append(m.Input('capture_brv_prox_'+str(n)+'_'+str(i), p_prox.value))
        # minus_brv_dist
        for n in range(num_units.value):
            for i in range(num_seg.value):
                minus_brv_dist.append(m.Input('minus_brv_dist_'+str(n)+'_'+str(i), p_dist.value))
        # minus_brv_prox
        for n in range(num_units.value):
            for i in range(num_seg.value):       
                minus_brv_prox.append(m.Input('minus_brv_prox_'+str(n)+'_'+str(i), p_prox.value))
        # search_brv_dist
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                search_brv_dist.append(m.Input('search_brv_dist_'+str(n)+'_'+str(i), p_dist.value))
        # search_brv_prox
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                search_brv_prox.append(m.Input('search_brv_prox_'+str(n)+'_'+str(i), p_prox.value))
        # backoff_brv_dist
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(n)+'_'+str(i), p_dist.value))
        # backoff_brv_prox
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(n)+'_'+str(i), p_prox.value))
        # min_brv_dist
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                min_brv_dist.append(m.Input('min_brv_dist_'+str(n)+'_'+str(i), p_dist.value))
        # min_brv_prox
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                min_brv_prox.append(m.Input('min_brv_prox_'+str(n)+'_'+str(i), p_prox.value))
        # F_brv_dist
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                F_brv_dist.append(m.Input('F_brv_dist_'+str(n)+'_'+str(i), (1<<wres_dist.value)-3 + 1))
        # F_brv_prox
        for n in range(num_units.value):
            for i in range(num_seg.value): 
                F_brv_prox.append(m.Input('F_brv_prox_'+str(n)+'_'+str(i), (1<<wres_prox.value)-3 + 1))

        ##################
        # Instantiations #
        ##################
        CV_unit, _ = self.CV_unit(p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for n in range(num_units.value):
            neuron_ports = [clk, grst, rstb, output_spikes[n], input_spikes_dist, input_spikes_prox[n]]
            # w_init_dist
            neuron_ports = self.append_port2(neuron_ports, w_init_dist, n, num_seg.value, p_dist.value)
            # w_init_prox
            neuron_ports = self.append_port2(neuron_ports, w_init_prox, n, num_seg.value, p_prox.value)
            # capture_brv_dist
            neuron_ports = self.append_port1(neuron_ports, capture_brv_dist, n, num_seg.value)
            # capture_brv_prox
            neuron_ports = self.append_port1(neuron_ports, capture_brv_prox, n, num_seg.value)
            # minus_brv_dist
            neuron_ports = self.append_port1(neuron_ports, minus_brv_dist, n, num_seg.value)
            # minus_brv_prox
            neuron_ports = self.append_port1(neuron_ports, minus_brv_prox, n, num_seg.value)
            # search_brv_dist
            neuron_ports = self.append_port1(neuron_ports, search_brv_dist, n, num_seg.value)
            # search_brv_prox
            neuron_ports = self.append_port1(neuron_ports, search_brv_prox, n, num_seg.value)
            # backoff_brv_dist
            neuron_ports = self.append_port1(neuron_ports, backoff_brv_dist, n, num_seg.value)
            # backoff_brv_prox
            neuron_ports = self.append_port1(neuron_ports, backoff_brv_prox, n, num_seg.value)
            # min_brv_dist
            neuron_ports = self.append_port1(neuron_ports, min_brv_dist, n, num_seg.value)
            # min_brv_prox
            neuron_ports = self.append_port1(neuron_ports, min_brv_prox, n, num_seg.value)
            # F_brv_dist
            neuron_ports = self.append_port1(neuron_ports, F_brv_dist, n, num_seg.value)
            # F_brv_prox
            neuron_ports = self.append_port1(neuron_ports, F_brv_prox, n, num_seg.value)
            
            m.Instance(CV_unit, str('L')+self.layer_id+'_CV_unit_inst_'+str(n), params=[p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = neuron_ports)
            
        return m, clk.name

    def Comp_neuron(self, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):

        m = Module('L'+self.layer_id+'_comp_neuron')
        num_dend = m.Parameter('NUM_DEND', int(num_dend))
        p_dist = m.Parameter('P_DIST', int(p_dist))
        p_prox = m.Parameter('P_PROX', int(p_prox))
        num_seg = m.Parameter('NUM_SEG', int(num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(wres_prox))
        threshold = m.Parameter('THRESHOLD', int(thres))

        ##################
        # Inputs/Outputs #
        ##################

        # Control Signals
        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')
        out_spike = m.Output('output_spike')

        # Input spikes shared across all dendrites
        input_spike_dist = m.Input('input_spikes_dist', p_dist.value)

        input_spikes_prox = []
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []
        # input_spikes_prox
        for i in range(num_dend.value):
            input_spikes_prox.append(m.Input('input_spikes_prox_'+str(i), p_prox.value))

        # w_init_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value):
                for k in range(p_dist.value):
                    w_init_dist.append(m.Input('w_init_dist_'+str(i)+str(j)+str(k), wres_dist.value))

        # w_init_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value):
                for k in range(p_prox.value):
                    w_init_prox.append(m.Input('w_init_prox_'+str(i)+str(j)+str(k), wres_prox.value))

        # capture_brv_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value):
                capture_brv_dist.append(m.Input('capture_brv_dist_'+str(i)+str(j), p_dist.value))
        # capture_brv_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value):
                capture_brv_prox.append(m.Input('capture_brv_prox_'+str(i)+str(j), p_prox.value))
        # minus_brv_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value):
                minus_brv_dist.append(m.Input('minus_brv_dist_'+str(i)+str(j), p_dist.value))
        # minus_brv_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value):       
                minus_brv_prox.append(m.Input('minus_brv_prox_'+str(i)+str(j), p_prox.value))
        # search_brv_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                search_brv_dist.append(m.Input('search_brv_dist_'+str(i)+str(j), p_dist.value))
        # search_brv_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                search_brv_prox.append(m.Input('search_brv_prox_'+str(i)+str(j), p_prox.value))
        # backoff_brv_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(i)+str(j), p_dist.value))
        # backoff_brv_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(i)+str(j), p_prox.value))
        # min_brv_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                min_brv_dist.append(m.Input('min_brv_dist_'+str(i)+str(j), p_dist.value))
        # min_brv_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                min_brv_prox.append(m.Input('min_brv_prox_'+str(i)+str(j), p_prox.value))
        # F_brv_dist
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                F_brv_dist.append(m.Input('F_brv_dist_'+str(i)+str(j), (1<<wres_dist.value)-3 + 1))
        # F_brv_prox
        for i in range(num_dend.value):
            for j in range(num_seg.value): 
                F_brv_prox.append(m.Input('F_brv_prox_'+str(i)+str(j), (1<<wres_prox.value)-3 + 1))

        ##############
        # Wires/Regs #
        ##############
        dend_out = m.Wire('dend_out', num_dend.value)

        ##################
        # Instantiations #
        ##################
        dendrite, _ = self.Dendrite(p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for i in range(num_dend.value):
            dendrite_ports = [input_spike_dist, input_spikes_prox[i], clk, grst, rstb, dend_out[i]]
            # Distal ports
            for j in range(num_seg.value):
                for k in range(p_dist.value):
                    dendrite_ports.append(w_init_dist[(i*num_seg.value*p_dist.value+j*p_dist.value) + k])
            for j in range(num_seg.value):
                dendrite_ports.append(capture_brv_dist[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(minus_brv_dist[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(search_brv_dist[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(backoff_brv_dist[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(min_brv_dist[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(F_brv_dist[i*num_seg.value+j])

            # Proximal ports
            for j in range(num_seg.value):
                for k in range(p_prox.value):
                    dendrite_ports.append(w_init_prox[(i*num_seg.value*p_prox.value+j*p_prox.value) + k])
            for j in range(num_seg.value):
                dendrite_ports.append(capture_brv_prox[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(minus_brv_prox[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(search_brv_prox[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(backoff_brv_prox[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(min_brv_prox[i*num_seg.value+j])
            for j in range(num_seg.value):
                dendrite_ports.append(F_brv_prox[i*num_seg.value+j])

            m.Instance(dendrite, str('L')+self.layer_id+'_dend_inst_'+str(i), params=[p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = dendrite_ports)
            
        
        m.EmbeddedCode('assign output_spike = |dend_out;')

        return m, clk.name
    
    def CV_unit(self, p_dist=3, p_prox=1, num_seg=8, wres_dist=3, wres_prox=3, thres=13):

        m = Module('L'+self.layer_id+'_CV_unit')
        p_dist = m.Parameter('P_DIST', int(p_dist))
        p_prox = m.Parameter('P_PROX', int(p_prox))
        num_seg = m.Parameter('NUM_SEG', int(num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(wres_prox))
        threshold = m.Parameter('THRESHOLD', int(thres))

        ##################
        # Inputs/Outputs #
        ##################

        # Control Signals
        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')
        out_spike = m.Output('output_spike')

        # Input spikes
        input_spike_dist = m.Input('input_spikes_dist', p_dist.value)
        input_spikes_prox = m.Input('input_spikes_prox', p_prox.value)

        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # w_init_dist
        for i in range(num_seg.value):
            for j in range(p_dist.value):
                w_init_dist.append(m.Input('w_init_dist_x_'+str(i)+str(j), wres_dist.value))

        # w_init_prox
        for i in range(num_seg.value):
            for j in range(p_prox.value):
                w_init_prox.append(m.Input('w_init_prox_x_'+str(i)+str(j), wres_prox.value))

        # capture_brv_dist
        for i in range(num_seg.value):
            capture_brv_dist.append(m.Input('capture_brv_dist_x_'+str(i), p_dist.value))
        # capture_brv_prox
        for i in range(num_seg.value):
                capture_brv_prox.append(m.Input('capture_brv_prox_x_'+str(i), p_prox.value))
        # minus_brv_dist
        for i in range(num_seg.value):
                minus_brv_dist.append(m.Input('minus_brv_dist_x_'+str(i), p_dist.value))
        # minus_brv_prox
        for i in range(num_seg.value):       
                minus_brv_prox.append(m.Input('minus_brv_prox_x_'+str(i), p_prox.value))
        # search_brv_dist
        for i in range(num_seg.value): 
                search_brv_dist.append(m.Input('search_brv_dist_x_'+str(i), p_dist.value))
        # search_brv_prox
        for i in range(num_seg.value): 
                search_brv_prox.append(m.Input('search_brv_prox_x_'+str(i), p_prox.value))
        # backoff_brv_dist
        for i in range(num_seg.value): 
                backoff_brv_dist.append(m.Input('backoff_brv_dist_x_'+str(i), p_dist.value))
        # backoff_brv_prox
        for i in range(num_seg.value): 
                backoff_brv_prox.append(m.Input('backoff_brv_prox_x_'+str(i), p_prox.value))
        # min_brv_dist
        for i in range(num_seg.value): 
                min_brv_dist.append(m.Input('min_brv_dist_x_'+str(i), p_dist.value))
        # min_brv_prox
        for i in range(num_seg.value): 
                min_brv_prox.append(m.Input('min_brv_prox_x_'+str(i), p_prox.value))
        # F_brv_dist
        for i in range(num_seg.value): 
                F_brv_dist.append(m.Input('F_brv_dist_x_'+str(i), (1<<wres_dist.value)-3 + 1))
        # F_brv_prox
        for i in range(num_seg.value): 
                F_brv_prox.append(m.Input('F_brv_prox_x_'+str(i), (1<<wres_prox.value)-3 + 1))

        ##############
        # Wires/Regs #
        ##############
        dend_out = m.Wire('dend_out')

        ##################
        # Instantiations #
        ##################
        dendrite, _ = self.Dendrite(p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        dendrite_ports = [input_spike_dist, input_spikes_prox, clk, grst, rstb, dend_out]
        # Distal ports
        for i in range(num_seg.value):
            for j in range(p_dist.value):
                dendrite_ports.append(w_init_dist[(i*p_dist.value) + j])
        for i in range(num_seg.value):
            dendrite_ports.append(capture_brv_dist[i])
        for i in range(num_seg.value):
            dendrite_ports.append(minus_brv_dist[i])
        for i in range(num_seg.value):
            dendrite_ports.append(search_brv_dist[i])
        for i in range(num_seg.value):
            dendrite_ports.append(backoff_brv_dist[i])
        for i in range(num_seg.value):
            dendrite_ports.append(min_brv_dist[i])
        for i in range(num_seg.value):
            dendrite_ports.append(F_brv_dist[i])

        # Proximal ports
        for i in range(num_seg.value):
            for j in range(p_prox.value):
                dendrite_ports.append(w_init_prox[(i*p_prox.value) + j])
        for i in range(num_seg.value):
            dendrite_ports.append(capture_brv_prox[i])
        for i in range(num_seg.value):
            dendrite_ports.append(minus_brv_prox[i])
        for i in range(num_seg.value):
            dendrite_ports.append(search_brv_prox[i])
        for i in range(num_seg.value):
            dendrite_ports.append(backoff_brv_prox[i])
        for i in range(num_seg.value):
            dendrite_ports.append(min_brv_prox[i])
        for i in range(num_seg.value):
            dendrite_ports.append(F_brv_prox[i])

        m.Instance(dendrite, str('L')+self.layer_id+'_dend_inst', params=[p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                    ports = dendrite_ports)
            
        
        m.EmbeddedCode('assign output_spike = |dend_out;')

        return m, clk.name

    def Dendrite(self, p_dist=3, p_prox=1, q=2, wres_dist=3, wres_prox=3, thres=13):

        m = Module('L'+self.layer_id+'_dendrite')
        p_dist = m.Parameter('P_DIST', int(p_dist))
        p_prox = m.Parameter('P_PROX', int(p_prox))
        q = m.Parameter('Q', int(q))
        wres_dist = m.Localparam('WRES_DIST', int(wres_dist))
        wres_prox = m.Localparam('WRES_PROX', int(wres_prox))
        thres = m.Parameter('THRESHOLD', int(thres))

        ##################
        # Inputs/Outputs #
        ##################

        # Input Spikes
        input_spikes_dist = m.Input('input_spikes_dist', p_dist.value)
        input_spikes_prox = m.Input('input_spikes_prox', p_prox.value)
        # Control signals
        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')
        # Output_spike
        out_spike = m.Output('output_spike')

        # STDP
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # STDP_dist
        for i in range(int(q.value)):
            for j in range(p_dist.value):
                w_init_dist.append(m.Input('w_init_dist_'+str(i)+'_'+str(j), wres_dist.value))
        for i in range(int(q.value)):
            capture_brv_dist.append(m.Input('capture_brv_dist_'+str(i), p_dist.value))
        for i in range(int(q.value)):
            minus_brv_dist.append(m.Input('minus_brv_dist_'+str(i), p_dist.value))
        for i in range(int(q.value)):
            search_brv_dist.append(m.Input('search_brv_dist_'+str(i), p_dist.value))
        for i in range(int(q.value)):
            backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(i), p_dist.value))
        for i in range(int(q.value)):
            min_brv_dist.append(m.Input('min_brv_dist_'+str(i), p_dist.value))
        for i in range(int(q.value)):
            F_brv_dist.append(m.Input('F_brv_dist_'+str(i), (1<<wres_dist.value)-3 + 1))
            

        # STDP_prox
        for i in range(int(q.value)):
            for j in range(p_prox.value):
                w_init_prox.append(m.Input('w_init_prox_'+str(i)+'_'+str(j), wres_prox.value))
        for i in range(int(q.value)):
            capture_brv_prox.append(m.Input('capture_brv_prox_'+str(i), p_prox.value))
        for i in range(int(q.value)):
            minus_brv_prox.append(m.Input('minus_brv_prox_'+str(i), p_prox.value))
        for i in range(int(q.value)):
            search_brv_prox.append(m.Input('search_brv_prox_'+str(i), p_prox.value))
        for i in range(int(q.value)):
            backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(i), p_prox.value))
        for i in range(int(q.value)):
            min_brv_prox.append(m.Input('min_brv_prox_'+str(i), p_prox.value))
        for i in range(int(q.value)):
            F_brv_prox.append(m.Input('F_brv_prox_'+str(i), (1<<wres_prox.value)-3 + 1))

        ##############
        # Wires/Regs #
        ##############

        ein_dist = m.Wire('ein_dist', p_dist.value)
        ein_prox = m.Wire('ein_prox', p_prox.value)
        eout = m.Wire('eout', q.value)
        ec_spikes = m.Wire('ec_spikes', q.value)
        li_spikes = m.Wire('li_spikes', q.value)
        # dist wires
        inc_dist, dec_dist, weights_dist = [], [], []
        for i in range(q.value):
            inc_dist.append(m.Wire('inc_dist_'+str(i), p_dist.value))
            dec_dist.append(m.Wire('dec_dist_'+str(i), p_dist.value))
            for j in range(p_dist.value):
                weights_dist.append(m.Wire('weights_dist_'+str(i)+'_'+str(j), wres_dist.value))

        # prox wires
        inc_prox, dec_prox, weights_prox = [], [], []
        for i in range(q.value):
            inc_prox.append(m.Wire('inc_prox_'+str(i), p_prox.value))
            dec_prox.append(m.Wire('dec_prox_'+str(i), p_prox.value))
            for j in range(p_prox.value):
                weights_prox.append(m.Wire('weights_prox_'+str(i)+'_'+str(j), wres_prox.value))

        ##################
        # Instantiations #
        ##################

        # edge_input_gen_dist
        pulse_dist, pulse_clk_dist = self.Pulse2edge()
        for i in range(p_dist.value):
            m.Instance(pulse_dist, 'pe_in_dist_'+str(i), ports = [input_spikes_dist[i], clk, grst, rstb, ein_dist[i]])

        # edge_input_gen_prox
        pulse_prox, pulse_clk_prox = self.Pulse2edge()
        for i in range(p_prox.value):
            m.Instance(pulse_prox, 'pe_in_prox_'+str(i), ports = [input_spikes_prox[i], clk, grst, rstb, ein_prox[i]])

        # segment
        # [YoungSeok] better way to do w_init_dist*?
        n_seg, _ = self.segment(p_dist.value, p_prox.value, wres_dist.value, wres_prox.value, thres.value)
        for i in range(q.value):
            segment_ports = [input_spikes_dist, input_spikes_prox, inc_dist[i], inc_prox[i], dec_dist[i], dec_prox[i], clk, grst, rstb, ec_spikes[i]]
            for j in range(p_dist.value):
                segment_ports.append(w_init_dist[i*p_dist.value+j])
            for j in range(p_prox.value):
                segment_ports.append(w_init_prox[i*p_prox.value+j])
            for j in range(p_dist.value):
                segment_ports.append(weights_dist[i*p_dist.value+j])
            for j in range(p_prox.value):
                segment_ports.append(weights_prox[i*p_prox.value+j])   
            m.Instance(n_seg, str('L')+self.layer_id+'_ec_'+str(i), params = [p_dist.value, p_prox.value, wres_dist.value, wres_prox.value, thres.value],
                       ports = segment_ports)

        # WTA
        wta, _ = self.Wta(q.value)
        m.Instance(wta, str('L')+self.layer_id+'_li', params = [q.value], ports = [ec_spikes, clk, grst, rstb, li_spikes])

        # edge_output_gen
        pulse, pulse_clk = self.Pulse2edge()
        for i in range(q.value):
            m.Instance(pulse, 'pe_out_'+str(i), ports = [li_spikes[i], clk, grst, rstb, eout[i]])

        # stdp_dist
        stdp_dist, _ = self.Stdp(wres_dist.value)
        for i in range(q.value):
            for j in range(p_dist.value):
                m.Instance(stdp_dist, str('L')+self.layer_id+'_stdp_dist_'+str(i)+'_'+str(j), params = [wres_dist.value],
                    ports = [
                    weights_dist[i*p_dist.value+j],
                    ein_dist[j],
                    eout[i],
                    capture_brv_dist[i][j],
                    minus_brv_dist[i][j],
                    search_brv_dist[i][j],
                    backoff_brv_dist[i][j],
                    min_brv_dist[i][j],
                    F_brv_dist[i],
                    clk,
                    grst,
                    rstb,
                    inc_dist[i][j],
                    dec_dist[i][j]
                    ])

        # stdp_prox
        stdp_prox, _ = self.Stdp(wres_prox.value)
        for i in range(q.value):
            for j in range(p_prox.value):
                m.Instance(stdp_prox, str('L')+self.layer_id+'_stdp_prox_'+str(i)+'_'+str(j), params = [wres_prox.value],
                    ports = [
                    weights_prox[i*p_prox.value+j],
                    ein_prox[j],
                    eout[i],
                    capture_brv_prox[i][j],
                    minus_brv_prox[i][j],
                    search_brv_prox[i][j],
                    backoff_brv_prox[i][j],
                    min_brv_prox[i][j],
                    F_brv_prox[i],
                    clk,
                    grst,
                    rstb,
                    inc_prox[i][j],
                    dec_prox[i][j]
                    ])

        m.EmbeddedCode('assign output_spike = |li_spikes;')

        return m, clk.name

    def append_port1(self, ports, source, n, I):
        for i in range(I):
            ports.append(source[(n*I)+i])
        return ports
    
    def append_port2(self, ports, source, n, I, J):
        for i in range(I):
            for j in range(J):
                ports.append(source[(n*I*J)+(i*J)+j])
        return ports
    
    def append_port3(self, ports, source, n, I, J, K):
        for i in range(I):
            for j in range(J):
                for k in range(K):
                    ports.append(source[(n*I*J*K)+(i*J*K)+(j*K)+k])
        return ports
    
    def append_port4(self, ports, source, n, I, J, K, L):
        for i in range(I):
            for j in range(J):
                for k in range(K):
                    for l in range(L):
                        ports.append(source[(n*I*J*K*L)+(i*J*K*L)+(j*K*L)+(k*L)+l])
        return ports