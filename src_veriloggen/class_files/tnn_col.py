from veriloggen import *
import numpy as np
from func_mdls import TNN_Functions
from tnn_backend import *
import os

# Author = Prabhu Vellaisamy
# TNN Column VerilogGen code for Verilog RTL creation
# Original Verilog files created by Harideep Nair 

class TNN_Col:

    def __init__(self, p = 4, q = 3, thres = 13):

        self.p = p
        self.q = q
        self. thres = thres

    def constr_verilog(self):

        m = Module('column')
        p = m.Parameter('P', self.p)
        q = m.Parameter('Q', self.q)
        thres = m.Parameter('THRESHOLD', self.thres)

        in_spike = m.Input('input_spikes', p.value)

        minus, capture, search, backoff, min_v, f, weight, inc, dec = [], [], [], [], [], [], [], [], []

        for i in range(q.value):
            capture.append(m.Input('capture_'+str(i), p.value))
            minus.append(m.Input('minus_'+str(i), p.value))
            search.append(m.Input('search_'+str(i), p.value))
            backoff.append(m.Input('backoff_'+str(i), q.value))
            min_v.append(m.Input('min_'+str(i), p.value))
            inc.append(m.Wire('inc'+str(i), p.value))
            dec.append(m.Wire('dec'+str(i), p.value))
            f.append(m.Input('F_'+str(i), 6))
        
        weight_en = m.Input('weight_update_en', 1)
        aclk = m.Input('aclk', 1)
        gclk = m.Input('gclk', 1)
        rst = m.Input('rst', 1)
        out_spike = m.Output('output_spikes', q.value)
        eout = m.Wire('eout', q.value)
        ein = m.Wire('ein', p.value)
        ec_spikes = m.Wire('ec_spikes', q.value)

        for k in range(q.value):
            for l in range(p.value):
                weight.append(m.Wire('weights_'+str(k)+'_'+str(l), 3))

        gclk_pulse = m.Wire('gclk_pulse', 1)

        tnn_func = TNN_Functions()

        edge = tnn_func.mkEdge2pulse()
        pulse = tnn_func.mkPulse2edge()
        n_rnl = tnn_func.mkNeuronRNL(p.value, thres.value)
        wta = tnn_func.mkWta(q.value)
        stdp = tnn_func.mkStdp()

        m.Instance(edge, 'ep', ports = [gclk, aclk, gclk_pulse])

        for i in range(p.value):
        	m.Instance(pulse, 'in_pe_'+str(i), ports = [aclk, in_spike[i], gclk_pulse, ein[i]] )

        rnl_param = [p.value, thres.value]

        for j in range(q.value):
        	m.Instance(n_rnl, 'ec_'+str(j), params = rnl_param, ports = [in_spike, inc[j], dec[j], weight_en, aclk, gclk, gclk_pulse, rst])
        	m.Instance(pulse, 'out_pe_'+str(j), ports = [aclk, out_spike[j], gclk_pulse, eout[j]] )

        	for z in range(p.value):
        		m.Instance(stdp, 's0_'+str(z)+str(j)+str(z), ports = [ein[z], 
        			eout[j], 
        			capture[j][z], 
        			minus[j][z], 
        			search[j][z], 
        			backoff[j][z], 
        			min_v[j][z], 
        			aclk, 
        			gclk_pulse, 
                    weight[j], 
                    f[j], 
                    inc[j][z], 
                    dec[j][z]])

        m.Instance(wta, 'li', params = [q.value], ports = [ec_spikes, aclk, gclk_pulse, out_spike])

        return m

if __name__=='__main__':
    
    tnn = TNN_Col()
    tnn = tnn.constr_verilog()
    gen_verilog(module = tnn, path = 'out_rtl', print_v = True)
