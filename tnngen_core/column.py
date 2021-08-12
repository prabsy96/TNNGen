from veriloggen import *
from tnn_mdls.func_mdls import TNN_Functions, Test_TNN_Functions
from backend import backend
import os

# Author = Prabhu Vellaisamy
# TNN Column VerilogGen code for Verilog RTL creation
# Original Verilog files created by Harideep Nair 

class TNN_Col():

    def __init__(self, p = 4, q = 3, thres = 13):

        self.p = p
        self.q = q
        self.thres = thres
    
    def col_v(self):

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
            backoff.append(m.Input('backoff_'+str(i), p.value))
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

        edge, edge_clk = tnn_func.Edge2pulse()
        pulse, pulse_clk = tnn_func.Pulse2edge()
        n_rnl, n_rnl_clk = tnn_func.NeuronRNL(p.value, thres.value)
        wta, wta_clk = tnn_func.Wta(q.value)
        stdp, stdp_clk = tnn_func.Stdp()

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

        return m, (aclk.name, gclk.name)

    def col_tb(self):

        m = Module('test_column')
        p = m.Parameter('P', self.p)
        q = m.Parameter('Q', self.q)
        thres = m.Parameter('THRESHOLD', self.thres)

        col, col_clk = self.col_v()

        ports = m.copy_sim_ports(col)
        i = m.Integer('i', 32, value = 0)
        k = m.Integer('k', 32, value = 0)

        minus, capture, search, backoff, min_v, f = [], [], [], [], [], []
        minus_temp, capture_temp, search_temp, backoff_temp, min_v_temp, f_temp = [], [], [], [], [], []

        aclk = ports['aclk']
        input_spikes = ports['input_spikes']

        for j in range(q.value):
            capture.append(ports['capture_'+str(j)])
            minus.append(ports['minus_'+str(j)])
            search.append(ports['search_'+str(j)])
            backoff.append(ports['backoff_'+str(j)])
            min_v.append(ports['min_'+str(j)])
            f.append(ports['F_'+str(j)])

        weight_en = ports['weight_update_en']
        gclk = ports['gclk']
        rst = ports['rst']
        out_spike = ports['output_spikes']

        dut = m.Instance(col, 'dut', params = [p, q, thres], ports = m.connect_ports(col))

        dump = simulation.setup_waveform(m, dut, ports = m.connect_ports(col))
        clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        for j in range(q.value):
            capture_temp.append(capture[j](1))
            minus_temp.append(minus[j](1))
            search_temp.append(search[j](1))
            backoff_temp.append(backoff[j](1))
            min_v_temp.append(min_v[j](1))
            f_temp.append(f[j](1))

        dump.add( 

            input_spikes(0),

            capture_temp,
            minus_temp,
            search_temp,
            backoff_temp,
            min_v_temp,
            f_temp,

            rst(1),
            gclk(0),
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

            Delay(1),
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

            Delay(1),
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

            Delay(1),
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

            Delay(1),
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

            Delay(1),
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

            Delay(1),
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

            Delay(1),
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

            Delay(1),
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

        m.Always(aclk) (EmbeddedCode('i = i%23;'), 
            If(i==0) (
                EmbeddedCode('gclk = 0;')) 
            .Else(
                EmbeddedCode('gclk = 1;'))
            , EmbeddedCode('i = i+1;'))

        return m 
