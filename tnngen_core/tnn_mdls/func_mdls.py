#!/usr/bin/env python
# coding: utf-8

# In[14]:


# Author = Prabhu Vellaisamy

# TNN Column Submodule VerilogGen library for Verilog RTL creation
# Original Verilog files created by Harideep Nair

from veriloggen import *
import numpy as np
import os


# In[15]:


class TNN_Functions:

    # inhibit operator
    def Less_equal(self):

        m = Module('less_equal')

        # input-output ports
        data_in = m.Input('data_in', 1)
        inhibit_in = m.Input('inhibit_in', 1)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)
        out = m.Output('out', 1)

        inhibit_only = m.Wire('inhibit_only', 1)
        inhibit_only_edge = m.Wire('temp2', 1)

        # Instantiation of macro
        # inhibit= self.inhibit_pass()

        # inhibit_inst = m.Instance(inhibit, 'inhibit_inst', params=None, ports=[inhibit_in,data_in,inhibit_only_edge])
        code = m.EmbeddedCode("inhibit_pass DUT_wq(.INHIBIT(inhibit_in),.DATA_IN(data_in),.OUT(temp2));")
        #inhibit_only.assign(~data_in & inhibit_in)
        out.assign(data_in & ~inhibit_only_edge)

        return m, ('aclk')
        """
        elif default == str(0):

            m = Module('less_equal')

            # input-output ports
            data_in = m.Input('data_in', 1)
            inhibit_in = m.Input('inhibit_in', 1)
            aclk = m.Input('aclk', 1)
            grst = m.Input('grst', 1)
            rst = m.Input('rst', 1)
            out = m.Output('out', 1)

            inhibit_only = m.Wire('inhibit_only', 1)
            inhibit_only_edge = m.Wire('temp2', 1)

            # submodule
            pulse, pulse_clk_name = self.Pulse2edge(default)

            pulse_inst = m.Instance(pulse, 'pulse_inst', params=None, ports=[
                                    aclk, inhibit_only,grst, rst, inhibit_only_edge])

            inhibit_only.assign(~data_in & inhibit_in)
            out.assign(data_in & ~inhibit_only_edge)

            return m, ('aclk')
        """

    # pulse -> edge converter
    def Pulse2edge(self):

        #if default == str(1):
        m = Module('pulse2edge')
        aclk = m.Input('aclk', 1)
        pulse_in = m.Input('pulse_in', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)
        edge_out = m.Output('edge_out', 1)

        temp = m.Reg('temp', 1)

        # Instantiation of macro
        # pulse, pulse_clk_name = self.pulse2edge_area()

        # pulse_inst = m.Instance(pulse, 'pulse_inst', params=None, ports=[edge_out,
        # aclk, grst, pulse_in])

        code = m.EmbeddedCode("pulse2edge_area pluse2edge_inst(.EDGE_OUT(edge_out),.ACLK(aclk),.GRST(grst),.PULSE_IN(pulse_in));")

        return m, ('aclk')
        
        """
        elif default == str(0):

            m = Module('pulse2edge')

            # input-output ports
            aclk = m.Input('aclk', 1)
            pulse_in = m.Input('pulse_in', 1)
            grst = m.Input('grst', 1)
            rst = m.Input('rst', 1)
            edge_out = m.Output('edge_out', 1)

            temp = m.Reg('temp', 1)
            edge_out.assign(pulse_in | temp)

            # always block
            m.Always(Posedge(aclk))(
                If(grst | rst)(temp(Int(0, width=1, base=2)))
                .Else(temp(edge_out)))

            return m, ('aclk')
        """

    # adder module
    
    # def pulse2edge_area(self):
    #     m = Module('pulse2edge_area')
    #     return

    def Adder(self, res=4):

        m = Module('adder')
        res = m.Parameter('RES', res)
    
        # input-output ports
        a = m.Input('a', res)
        b = m.Input('b', res)
        cin = m.Input('cin')
        out = m.Output('out', res + 1)
    
        out.assign(a+b+cin)
    
        # no clocks, combinational design
        return m, None
        
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


# In[18]:


    # edge -> pulse converter
    
    def Edge2pulse(self):
        
        #if default == str(1):
        m = Module('edge2pulse')
        # input-output ports
        edge_in = m.Input('edge_in', 1)
        clk_in = m.Input('clk_in', 1)
        rst = m.Input('rst', 1)
        
        pulse_out = m.Output('pulse_out', 1)
        
        temp1 = m.Reg('temp1', 1)
        temp2 = m.Reg('temp2', 1)

        # Instantiation of macro
        # edge = self.register()

        # edge_inst = m.Instance(edge, 'edge_inst', params=None, ports=[clk_in, ~rst,
        # edge_in, temp2, 1])

        #code = m.EmbeddedCode("register edge_pulse_reg(.clk(clk_in),.rst_b(~rst),.d(edge_in),.q(temp2),.wen(1));")
        reg = self.Register()
        reg_inst = m.Instance(reg, 'reg_inst', params = None, ports = [clk_in, ~rst, edge_in, temp2, 1]) 
        

        pulse_out.assign(edge_in & ~temp2)
        # INSERT TNN7 Edge2Pulse
            
        return m, ('clk_in')
        """
        elif default == str(0):

            m = Module('edge2pulse')
        
            # input-output ports
            edge_in = m.Input('edge_in', 1)
            clk_in = m.Input('clk_in', 1)
            pulse_out = m.Output('pulse_out', 1)
        
            temp1 = m.Reg('temp1', 1)
            temp2 = m.Reg('temp2', 1)
        
            # always block
            m.Always(Posedge(clk_in))(
                temp1(edge_in),
                temp2(temp1)
            )
        
            pulse_out.assign(edge_in & ~temp2)
            return m, ('clk_in')

        # increment/decrement logic for synaptic weight updates
        """
    
    def Incdec(self):

        #if default == str(1):
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

        # Instantiation of macro
        # indec_mac = self.incdec_macro()

        # incdec_inst = m.Instance(incdec_mac, 'incdec_inst', params=None, ports=[min, F, backoff, stdp_cases[3], 
        # stdp_cases[1], minus, capture, stdp_cases[0], stdp_cases[2], search, dec, inc])

        code = m.EmbeddedCode("""incdec_macro macro_init (.MIN(min), .F(F), .BACKOFF(backoff), .STDP_CASES_3(stdp_cases[3]), .STDP_CASES_1(stdp_cases[1]), .MINUS(minus), .CAPTURE(capture), .STDP_CASES_0(stdp_cases[0]), .STDP_CASES_2(stdp_cases[2]), .SEARCH(search), .DEC(dec), .INC(inc)); """)
            
        
        # INSERT TNN7 IncDec
        
        return m, None
        """
        elif default == str(0):
    
            m = Module('incdec')
        
            # input-output ports
            cases = m.Input('stdp_cases', 4)
            capture = m.Input('capture', 1)
            minus = m.Input('minus', 1)
            search = m.Input('search', 1)
            backoff = m.Input('backoff', 1)
            min_case = m.Input('min', 1)
            F = m.Input('F', 1)
            inc = m.Output('inc', 1)
            dec = m.Output('dec', 1)
        
            stabilize_brv = m.Wire('stabilize_brv', 1)
        
            stabilize_brv.assign(F | min_case)

            temp0 = m.Wire('temp0', 1)
            temp1 = m.Wire('temp1', 1)
            temp2 = m.Wire('temp2', 1)
            temp3 = m.Wire('temp3', 1)

            temp0.assign(cases[0] & capture & stabilize_brv)
            temp1.assign(cases[1] & minus & stabilize_brv)
            temp2.assign(cases[2] & search)
            temp3.assign(cases[3] & backoff & stabilize_brv)
        
            inc.assign(temp0 | temp2)
            dec.assign(temp1 | temp3)
        
            # no clocks returned
            return m, None
        """

    # Winner Take All Operator
    def Wta(self, Q=10):

        m = Module('wta')
        q = m.Parameter('Q', Q)

        # Inputs and Outputs
        ec_spikes = m.Input('ec_spikes', q)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)
        li_out = m.Output('li_out', q)

        first_spike = m.Wire('first_spike', 1)
        first_spike_edge = m.Wire('first_spike_edge', 1)
        inhibit_spikes = m.Wire('inhibit_spikes', q)

        first_spike.assign(ec_spikes > 0)

        # submodule
        pulse, pulse_clk_name = self.Pulse2edge()

        pulse_inst = m.Instance(pulse, 'pulse_inst', params=None, ports=[
                                aclk, first_spike, grst, rst, first_spike_edge])
        
        less_equal, less_equal_clk_name = self.Less_equal()
    
        for j in range(q.value):
            lq_inst = m.Instance(less_equal, 'l1_'+str(j), params=None,
                                ports=[ec_spikes[j], first_spike_edge, aclk, grst, rst, inhibit_spikes[j]])
        li_out[q.value-1].assign(inhibit_spikes[q.value-1])
    
        for k in range(q.value-2, -1, -1):
            li_out[k].assign(inhibit_spikes[k] & ~ Uor(Slice(inhibit_spikes, q.value-1, k+1)))
    
        return m, ('aclk')



    # block to select appropriate BRVs
    def Flogic(self,  wres=3):

        #if default == str(1):
        m = Module('flogic')
        wres_v = m.Parameter('WRES', wres)
        # inputs and outputs
        F = m.Input('F', (1<<wres_v.value)-3 + 1)
        input_weight = m.Input('input_weight', wres_v)
        out = m.Output('out', 1)
        # INSERT TNN7 Flogic
        # Instantiation of macro
        # flogic_mac = self.flogic_8x1()
        # flogic_inst = m.Instance(flogic_mac, 'flogic_inst', params=None, ports=[out, 0, F[0], F[1], F[2], F[3]
        # , F[4], F[5],1, input_weight[0], input_weight[1], input_weight[2]])

        code = m.EmbeddedCode("""flogic_8x1 DUT (.OUT(out), .F_0(0), .F_1(F[0]), .F_2(F[1]), .F_3(F[2]), .F_4(F[3]), .F_5(F[4]), .F_6(F[5]), .F_7(1), .SEL_0(input_weight[0]), .SEL_1(input_weight[1]), .SEL_2(input_weight[2])); """)
        
        return m, None
        """
        elif default == str(0):

            m = Module('flogic')

            wres_v = m.Parameter('WRES', wres)
        
            # inputs and outputs
            F = m.Input('F', (1<<wres_v.value)-3 + 1)
            input_weight = m.Input('input_weight', wres_v)
            out = m.Output('out', 1)

            out.assign(Cond((input_weight == 0) | (input_weight == ((1<<wres_v.value)-1)), true_value=Int(0, width=1, base=2),  false_value=F[input_weight-1]))
        
            return m, None
        """

    # case generator for STDP
    def Stdp_case_gen(self):
        
        #if default == str(1):
        m = Module('stdp_case_gen')
    
        # inputs and outputs
        ein = m.Input('ein', 1)
        eout = m.Input('eout', 1)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)
        stdp_cases = m.Output('stdp_cases', 4)
        temp = m.Reg('temp', 1)
        greater = m.Reg('greater',1)

        # Instantiation of macro
        # stdp_case_mac = self.stdp_case_gen_macro()
        # stdp_case_inst = m.Instance(stdp_case_mac, 'stdp_case_inst', params=None, ports=[ein, eout, stdp_cases[0], stdp_cases[1], stdp_cases[2],stdp_cases[3], greater])
        # inhibit = self.inhibit_pass()
        # inhibit_inst =  m.Instance(inhibit, 'inhibit_inst', params=None, ports=[eout, ein, temp])

        code1 = m.EmbeddedCode("stdp_case_gen_macro stdp (.EIN(ein),.EOUT(eout),.STDP_CASES_0(stdp_cases[0]),.STDP_CASES_1(stdp_cases[1]),.STDP_CASES_2(stdp_cases[2]),.STDP_CASES_3(stdp_cases[3]),.GREATER(greater));")

        code2 = m.EmbeddedCode("inhibit_pass DUT_wq(.INHIBIT(eout),.DATA_IN(ein),.OUT(temp));")

        greater.assign = (eout & ~temp)
    
    
        return m, ('aclk')
        """
        elif default == str(0):

            m = Module('stdp_case_gen')
        
            # inputs and outputs
            ein = m.Input('ein', 1)
            eout = m.Input('eout', 1)
            aclk = m.Input('aclk', 1)
            grst = m.Input('grst', 1)
            rst = m.Input('rst', 1)
            stdp_cases = m.Output('stdp_cases', 4)
        
            eout_only = m.Wire('eout_only', 1)
            tboth = m.Wire('tboth', 1)
            tone = m.Wire('tone', 1)
            greater = m.Wire('greater', 1)
        
            eout_only.assign(~ ein & eout)
        
            # submodule
            pulse, pulse_clk_name = self.Pulse2edge(default)
            pulse_inst = m.Instance(pulse, 'pe', params=None,  ports=[
                                    aclk, eout_only, grst,rst, greater])
        
            tboth.assign(ein & eout)
            tone.assign(ein ^ eout)
        
            stdp_cases[0].assign(~ greater & tboth)
            stdp_cases[1].assign(greater & tboth)
            stdp_cases[2].assign(~ greater & tone)
            stdp_cases[3].assign(greater & tone)
        
            return m, ('aclk')
        """

    def Fsm_weight_update(self, wres=3):
        m = Module('fsm_weight_update')
        wres_v = m.Parameter('WRES', wres)
        input_spike = m.Input('input_spike', 1)
        inc = m.Input('inc', 1)
        dec = m.Input('dec', 1)
        
        next_gclk = m.Input('next_gclk', 1)
        gclk = m.Input('gclk', 1)
        store_weight = m.Input('store_weight',wres_v)
        nxt_weight = m.Output('nxt_weight', wres_v)

        tinc = m.Wire('tinc', 1)
        tdec = m.Wire('tdec', 1)

        tinc.assign(inc & ~input_spike & ~next_gclk & gclk & ~(store_weight[0] & store_weight[1] & store_weight[2]))
        tdec.assign(dec & ~input_spike & ~next_gclk & gclk & ((store_weight[0] | store_weight[1] | store_weight[2])))

        # fsm_wup_mac = self.fsm_weight_update_macro()
        # fsm_wup_inst =  m.Instance(fsm_wup_mac, 'fsm_qup_inst', params=None, ports=[next_weight[0], next_weight[1], next_weight[2], input_spike, tdec, tinc, store_weight[0], store_weight[1], store_weight[2]])

        code = m.EmbeddedCode("""fsm_weight_update_macro fsm_weight_update_inst (.NXT_WEIGHT_0(nxt_weight[0]),.NXT_WEIGHT_1(nxt_weight[1]),.NXT_WEIGHT_2(nxt_weight[2]),.INPUT_SPIKE(input_spike),.TDEC(tdec),.TINC(tinc),.STORE_WEIGHT_0(store_weight[0]),.STORE_WEIGHT_1(store_weight[1]),.STORE_WEIGHT_2(store_weight[2]));
                """)

        return m, ('gclk')

    def Fsm_output(self, wres=3):
        m = Module('fsm_output')
        wres_v = m.Parameter('WRES', wres)
        # inputs and outputs
        input_spike = m.Input('input_spike', 1)
        aclk = m.Input('aclk', 1)
        gclk = m.Input('gclk', 1)
        grst = m.Input('grst', 1)
        store_weight = m.Input('store_weight',wres_v)
        next_weight = m.Input('next_weight', wres_v)
        out = m.Output('out', 1)

        # fsm_out_mac = self.fsm_output_macro()
        # fsm_out_inst =  m.Instance(fsm_out_mac, 'fsm_out_inst', params=None, ports=[out, input_spike, store_weight[0], store_weight[1], store_weight[2], aclk])

        code = m.EmbeddedCode("""fsm_output_macro fsm_output_inst(.OUT(out),.INPUT_SPIKE(input_spike),.STORE_WEIGHT_0(store_weight[0]),.STORE_WEIGHT_1(store_weight[1]),.STORE_WEIGHT_2(store_weight[2]),.ACLK(aclk));""")

        return m, ('aclk')

    # Converts pac single cycle pulse to generate [wmax+1]-cycles wide output spike pulse
    def Fsm_convert(self, wres=3):

        #if default == str(1):
        m = Module('fsm_convert')
        wres_v = m.Parameter('WRES', wres)
        # inputs and outputs
        aclk = m.Input('aclk', 1)
        rst = m.Input('rst', 1)
        in_v = m.Input('in', 1)
        out_v = m.Output('out', 1)
        state = m.Reg('state', wres_v)
        next_state = m.Reg('next_state', wres_v)
        # Instantiation of macro
        # fsm_convert_mac = self.fsm_simple_macro()
        # fsm_inst =  m.Instance(fsm_convert_mac, 'fsm_inst', params=None, ports=[in_v, out_v, state[0], state[1], state[2]])
        # regs = self.register()
        # regs_inst = m.Instance(regs, 'regs_inst', params=3, ports=[aclk, ~rst, next_state,state,1])

        code1 = m.EmbeddedCode("""fsm_simple_macro fsm_simple_inst(.IN(in),.OUT(out),.STATE_0(state[0]),.STATE_1(state[1]),.STATE_2(state[2]),.NEXT_STATE_0(next_state[0]),.NEXT_STATE_1(next_state[1]),.NEXT_STATE_2(next_state[2]));""")

        #code2 = m.EmbeddedCode("register #(3) inst_state_reg(.clk(aclk),.rst_b(~rst),.d(next_state),.q(state),.wen(1));")
        
        reg = self.Register()
        reg_inst = m.Instance(reg, 'reg_inst', params = [wres_v], ports = [aclk, ~rst, next_state, state, 1]) 
        

        # INSERT TNN7 fsm_simple module

        return m, ('aclk')
        """        
        elif default == str(0):

            m = Module('fsm_convert')

            wres_v = m.Parameter('WRES', wres)

            # inputs and outputs
            aclk = m.Input('aclk', 1)
            rst = m.Input('rst', 1)
            in_v = m.Input('in', 1)
            out_v = m.Output('out', 1)

            state = m.Reg('state', wres_v)
            temp = m.Reg('temp', 1)

            m.Always(Posedge(aclk)) (
                If(rst)(
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

            # temp.assign(state == 0)
            out_v.assign((~temp) | (temp & in_v))

            return m, ('aclk')
        """

    # synapse implementation
    def Fsm_synapse(self, wres=3):

        #if default == str(1):
        m = Module('fsm_synapse')

        wres_v = m.Parameter('WRES', wres)

        # inputs and outputs
        input_spike = m.Input('input_spike', 1)
        #w_init = m.Input('w_init', wres_v)
        inc = m.Input('inc', 1)
        dec = m.Input('dec', 1)
        aclk = m.Input('aclk', 1)
        gclk = m.Input('gclk', 1)
        rst = m.Input('rst', 1)
        grst = m.Input('grst', 1)
        w_out = m.Output('w_out', wres_v)
        out_v = m.Output('out', 1)
        next_gclk = m.Reg('next_gclk', 1)
        next_weight = m.Reg('next_weight', wres_v)
        store_weight = m.Reg('store_weight', wres_v)

        fsm_weight, fsm_weight_clk = self.Fsm_weight_update()
        fsm_weight_inst =  m.Instance(fsm_weight, 'fsm_weight_inst', params=None, ports=[next_weight, store_weight, input_spike, inc,dec, next_gclk, gclk])

        fsm_out, fsm_out_clk = self.Fsm_output()
        fsm_out_inst =  m.Instance(fsm_out, 'fsm_out_inst', params=None, ports=[out_v, input_spike, store_weight, aclk, gclk, next_weight, grst])

        # regs_gclk = self.register()
        # regs_gclk_inst = m.Instance(regs_gclk, 'regs_clk_inst', params=None, ports=[aclk, ~rst, gclk,next_gclk,1])

        # regs_weight = self.register()
        # regs_weight_inst = m.Instance(regs_weight, 'regs_weight_inst', params=3, ports=[aclk, ~rst, next_weight,store_weight,1])

        #code1 = m.EmbeddedCode("fsm_weight_update fsm_weight_update_inst(nxt_weight, store_weight, input_spike, inc, dec, nxt_gclk,gclk);")

        #code2 = m.EmbeddedCode("fsm_output fsm_output_inst(out, input_spike, store_weight, aclk,gclk,nxt_weight,grst);")

        code3 = m.EmbeddedCode("register #(.WL(1)) gclk_next(.clk(aclk), .rst_b(~rst), .d(gclk), .q(nxt_gclk), .wen(1));")

        code4 = m.EmbeddedCode("register #(.WL(3)) inst_reg_weight (.clk(aclk), .rst_b(~rst), .d(nxt_weight), .q(store_weight), .wen(1'd1));")

            
        #out_v.assign(input_spike & w_nonzero)
        w_out.assign(store_weight)

        return m, ('aclk', 'gclk')
        """
        elif default == str(0):
            m = Module('fsm_synapse')

            wres_v = m.Parameter('WRES', wres)

            # inputs and outputs
            input_spike = m.Input('input_spike', 1)
            w_init = m.Input('w_init', wres_v)
            inc = m.Input('inc', 1)
            dec = m.Input('dec', 1)
            aclk = m.Input('aclk', 1)
            gclk = m.Input('gclk', 1)
            rst = m.Input('rst', 1)
            w_out = m.Output('w_out', wres_v)
            out_v = m.Output('out', 1)

            weight = m.Reg('weight', wres_v)
            w_nonzero = m.Reg('w_nonzero', wres_v)

            m.Always(Posedge(aclk)) (
                If(rst)(
                    weight(w_init),
                    w_nonzero(w_init > 0)
                )
                .Elif(gclk)(
                    If((inc == Int(1, width=1, base=2)) & (weight < Int(2**wres_v.value - 1, width=wres_v.value, base=2))) (
                        weight(weight + 1),
                        w_nonzero(Int(1, width=1, base=2))
                    )
                    .Elif((dec == Int(1, width=1, base=2)) & (weight > 0)) (
                        weight(weight - 1),
                        w_nonzero(Slice(weight, wres_v.value-1, 1) != 0)
                    )
                    .Else(
                        w_nonzero(weight > 0)
                    )
                )
                .Elif(input_spike) (
                    weight(weight - 1),
                    If(w_nonzero == Int(0, width=1, base=2)) (
                        w_nonzero(Int(0, width=1, base=2))
                    )
                    .Else(
                        If(Slice(weight, wres_v.value-1, 1) != 0) (
                            w_nonzero(Int(0, width=1, base=2))
                        )
                        .Else(
                            w_nonzero(Int(1, width=1, base=2))
                        )
                    )
                )
            )

            out_v.assign(input_spike & w_nonzero)
            w_out.assign(weight)

            return m, ('aclk', 'gclk')
        """
    
    # STDP top module
    def Stdp(self, wres=3):
    
        m = Module('stdp')

        wres_v = m.Parameter('WRES', wres)

        # input and outputs
        input_weight = m.Input('input_weight', wres_v)
        ein = m.Input('ein', 1)
        eout = m.Input('eout', 1)
        capture = m.Input('capture', 1)
        minus = m.Input('minus', 1)
        search = m.Input('search', 1)
        backoff = m.Input('backoff', 1)
        min_v = m.Input('min', 1)
        F = m.Input('F', (1<<wres)-3 + 1)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)
        inc = m.Output('inc', 1)
        dec = m.Output('dec', 1)

        stdp_cases = m.Wire('stdp_cases', 4)
        fout = m.Wire('fout', 1)
    
        # target submodule
        stdp_case, stdp_case_gen_clk = self.Stdp_case_gen()
        flogic, flogic_clk = self.Flogic(wres_v.value)
        incdec, incdec_clk = self.Incdec()
    
        stdp_case_gen_inst = m.Instance(stdp_case, 's1', params=None, ports=[
                                        ein, eout, aclk, grst, rst, stdp_cases])
        flogic_inst = m.Instance(flogic, 's2', params=[wres],
                                 ports=[F, input_weight, fout])
        incdec_inst = m.Instance(incdec, 's3', params=None, ports=[
                                 stdp_cases, capture, minus, search, backoff, min_v, fout, inc, dec])
    
        return m, ('aclk')


# In[26]:

    # Parallel Accumulator
    def Pac(self, ip_size = 16, thres = 13):
        m = Module('pac')

        input_size = m.Parameter('INPUT_SIZE', int(ip_size))
        thres = m.Parameter('THRESHOLD', int(thres)) 
        clog2_input_size = np.ceil(np.log2(int(input_size.value)))
        clog2_thres = np.ceil(np.log2(int(thres.value)))

        p_res = m.Localparam('P_RES', int(clog2_input_size))
        in_size = m.Localparam('IN_SIZE', int(1 << p_res.value))
        stages = m.Localparam('STAGES', p_res.value - 1)
        num = m.Localparam('NUM', 2*in_size.value-p_res.value-2)
        maxres = m.Localparam('MAXRES', max(p_res.value+1, int(clog2_thres)+1))

        # Inputs and Outputs
        in_v = m.Input('in', in_size.value)
        aclk = m.Input('aclk', 1)
        grst = m.Input('grst', 1)
        rst = m.Input('rst', 1)
        out_v = m.Output('out', 1)

        padded_in = m.Wire('padded_in', in_size.value)
        temp = m.Wire('temp', num)
        parallel_out = m.Wire('parallel_out', p_res)
        body_pot = m.Wire('body_pot', maxres.value + 1)
        regout = m.Reg('regout', maxres)
        poutlatch = m.Reg('poutlatch', 1)

        padded_in.assign(in_v)

        in_size_val = int((in_size.value)/2)
    
        for i_v in range(in_size_val):
            temp[i_v].assign(padded_in[i_v])

        # submodule
        adder, add_clk = self.Adder()

        for i in range(stages.value):
            for j in range(int(in_size.value/(1<<(i+2)))):
                m.Instance(adder, 
                            'a1_'+str(i)+str(j), 
                            params=[i+1], 
                            ports=[
                                Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + 2*j *(i+1)+i, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + 2*j*(i+1)),
                                Slice(temp, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1) * (i+1)+i, Srl(in_size.value, i)*((Sll(1, i+1))-i-2) + (2*j+1)*(i+1)),
                                in_v[Add(in_size_val, (Srl(in_size.value, i+1))*((Sll(1, i)-1))+j)],
                                Slice(temp, Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3) + j*(i+2) + (i+1), Srl(in_size.value, i+1)*(Sll(1, i+2)-i-3) + j*(i+2))
                            ])
        
        parallel_out.assign(Slice(temp, num.value - 1, num.value - p_res.value))

        m.Instance(adder, 
                   'adder2_in_pac', 
                   params=[maxres.value], 
                   ports=[
                          parallel_out,
                          regout,
                          Slice(padded_in, in_size.value-1 , in_size.value-1),
                          body_pot
                         ])

        m.Always(Posedge(aclk))(
            If(grst | rst)(
                regout(-1*thres.value),
                poutlatch(0)
            )
            .Else(
                If(out_v)(
                    regout(-1*thres.value)
                )
                .Else(
                    regout(Slice(body_pot, maxres.value-1 , 0))
                ),
                poutlatch(out_v)
            )
        )

        out_v.assign(Slice(body_pot, maxres.value, maxres.value) | poutlatch)

        return m, ('aclk')


# In[27]:


    # Neuron body module
    def Neuronbody(self, ip_size=16, thres=13, wres=3):
    
        m = Module('neuron_body')
    
        in_size_v = m.Parameter('INPUT_SIZE', ip_size)
        thres_v = m.Parameter('THRESHOLD', thres)
        wres_v = m.Parameter('WRES', wres)

        clog2_input_size = np.ceil(np.log2(int(in_size_v.value)))
        p_res = m.Localparam('p_res', int(clog2_input_size))
        in_size = m.Localparam('IN_SIZE', int(1 << p_res.value))
    
        # inputs and outputs
        acc_in = m.Input('acc_in', in_size_v.value)
        aclk = m.Input('aclk', 1)
        pac_rst = m.Input('pac_rst', 1)
        rst = m.Input('rst', 1)
        out_v = m.Output('out_spike', 1)
    
        temp = m.Wire('temp_spike', 1)

        get_cat = Cat(Int(value=0, width=in_size.value - in_size_v.value, base=2), acc_in)
    
        # submodule
        pac, pac_clk = self.Pac(ip_size=in_size_v.value, thres=thres_v.value)
        fsm_c, fsm_c_clk = self.Fsm_convert( wres_v.value)
    
        par_pac = [in_size_v.value, thres_v.value]
    
        pac_inst = m.Instance(pac, 'p1', params=par_pac, ports=[
                              get_cat, aclk, pac_rst, rst, temp])
    
        fsm_convert_inst = m.Instance(fsm_c, 'fs', params=[wres_v.value], ports=[
                                      aclk, rst, temp, out_v])
    
        return m, ('aclk')


# In[28]:

    
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


# In[29]:
    
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
            weights_dist.append(m.Input('weights_dist_'+str(i), wres_dist.value))

        weights_prox = []
        for i in range(in_size_prox.value):
            weights_prox.append(m.Input('weights_prox_'+str(i), wres_prox.value))

        # wires/regs
        resp_func_dist = m.Wire('resp_func_dist', in_size_dist.value)
        resp_func_prox = m.Wire('resp_func_prox', in_size_prox.value)
            
        # submodules
        # Distal: Synaptic weight + readout logic FSM
        fsm_s_dist, fsm_clk_dist = self.Fsm_synapse(wres_dist.value)
        for i in range(in_size_dist.value):
            ### TODO: investigate fsm_synapse module ###
            m.Instance(fsm_s_dist, 'syn_dist_'+str(i), params=None,
                       ports=[input_spikes_dist[i], 0, inc_dist[i], dec_dist[i], clk, grst, rstb, weights_dist[i], resp_func_dist[i]])

        # Proximal: Synaptic weight + readout logic FSM
        fsm_s_prox, fsm_clk_prox = self.Fsm_synapse(wres_prox.value)
        for i in range(in_size_prox.value):
            ### TODO: investigate fsm_synapse module ###
            m.Instance(fsm_s_prox, 'syn_prox_'+str(i), params=None,
                       ports=[input_spikes_prox[i], 0, inc_prox[i], dec_prox[i], clk, grst, rstb, weights_prox[i], resp_func_prox[i]])

        # Neuron body
        soma, soma_clk = self.Neuronbody(ip_size=in_size_dist.value+in_size_prox.value, thres=thres.value, wres=wres_dist.value)
        m.Instance(soma, 'soma', params=[in_size_dist.value+in_size_prox.value, thres.value, wres_dist.value],
                   ports=[(resp_func_prox+resp_func_dist), clk, grst, rstb, output_spike])
        
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
        aclk = dut['aclk']
        rst = dut['rst']
        out = dut['out']

        i = m.Integer('i', 32, 0)

        dump = simulation.setup_waveform(
            m, dut, [data_in, inhibit_in, aclk, rst, out])
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)

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

        m.Always(aclk)(EmbeddedCode('i = i%23;'),
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
            EmbeddedCode('edge_in = ~edge_in;')), EmbeddedCode('i = i+1;'))
    
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
