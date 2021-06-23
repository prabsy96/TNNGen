from veriloggen import *
import numpy as np
from tnn_func_mdls import *
import os

# Author = Prabhu Vellaisamy
# TNN Column VerilogGen code for Verilog RTL creation
# Original Verilog files created by Harideep Nair 

def mkColumn(numports=13):

    m = Module('column')
    p = m.Parameter('P', 32)
    q = m.Parameter('Q', 12)
    thres = m.Parameter('THRESHOLD', 13)

    in_spike = m.Input('input_spike', p.value)
    capture = m.Input('capture', q.value, dims = p.value)
    minus = m.Input('minus', q.value, dims = p.value)
    search = m.Input('search', q.value, dims = p.value)
    backoff = m.Input('backoff', q.value, dims = p.value)
    min_v = m.Input('min', q.value, dims = p.value)
    f = m.Input('F', q.value, dims = 6)
    weight_en = m.Input('weight_update_en', 1)
    aclk = m.Input('aclk', 1)
    gclk = m.Input('gclk', 1)
    rst = m.Input('rst', 1)
    out_spike = m.Output('output_spikes', q.value)
    eout = m.Output('eout', q.value)

    ein = m.Wire('ein', p.value)
    ec_spikes = m.Wire('ec_spikes', q.value)

    weights = m.Wire('weights', q.value,  dims = (p.value, 3) )

    inc = m.Wire('inc', q.value, dims = (p.value, 2))
    dec = m.Wire('dec', q.value, dims = p.value)
    #weights = Wire(2)
    gclk_pulse = m.Wire('gclk_pulse', 1)

    edge = mkEdge2pulse()
    pulse = mkPulse2edge()
    n_rnl = mkNeuronRNL()
    wta = mkWta()
    stdp = mkStdp()

    m.Instance(edge, 'ep', ports = [gclk, aclk, gclk_pulse])

    for i in range(p.value):
    	m.Instance(pulse, 'in_pe_'+str(i), ports = [aclk, in_spike[i], gclk_pulse, ein[i]] )

    rnl_param = [p.value, thres.value]

    for j in range(q.value):
    	m.Instance(n_rnl, 'ec_'+str(j), params = rnl_param, ports = [aclk, in_spike[j], gclk_pulse, ein[j]])
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
                weights[j][z], 
                f[j][z], 
                inc[j][z], 
                dec[j][z]])


    wta_param = [q.value]

    m.Instance(wta, 'li', params = wta_param, ports = [ec_spikes, aclk, gclk_pulse, out_spike])

    return m

if __name__=='__main__':
    col = mkColumn()
    if not os.path.exists('out_rtl'):
        os.mkdir('out_rtl')
    col_v = col.to_verilog('out_rtl/column.v')
    print(col_v)
