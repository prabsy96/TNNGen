#!/usr/bin/env python
# coding: utf-8

# Author: Prabhu Vellaisamy
# TNN Column VerilogGen code for Verilog RTL creation

from veriloggen import *
from tnn_mdls.func_mdls import TNN_Functions
from tnn_mdls.tb_func_mdls import Test_TNN_Functions
from backend import backend
import os

class TNN_Col():
    def __init__(self, p = 4, q = 3, thres = 13, wres = 3):

        self.p = p
        self.q = q
        self.thres = thres
        self.wres = wres

    """
    Column Implementation
    """
    def col_v(self):

        m = Module('column_'+str(self.p)+'_'+str(self.q)+'_'+str(self.thres))
        p = m.Parameter('P', int(self.p))
        q = m.Parameter('Q', int(self.q))
        wres = m.Localparam('wres', int(self.wres))
        thres = m.Parameter('THRESHOLD', int(self.thres))

        # Inputs/Outputs
        input_spikes = m.Input('input_spikes', p.value)
        w_init, capture_brv, minus_brv, search_brv, backoff_brv, min_brv, F_brv = [], [], [], [], [], [], []
        for i in range(int(q.value)):
            for j in range(p.value):
                w_init.append(m.Input('w_init_'+str(i)+'_'+str(j), wres.value))
            capture_brv.append(m.Input('capture_brv_'+str(i), p.value))
            minus_brv.append(m.Input('minus_brv'+str(i), p.value))
            search_brv.append(m.Input('search_brv'+str(i), p.value))
            backoff_brv.append(m.Input('backoff_brv'+str(i), p.value))
            min_brv.append(m.Input('min_brv'+str(i), p.value))
            F_brv.append(m.Input('F_brv'+str(i), (1<<wres.value)-3 + 1))
        weight_en = m.Input('weight_update_en', 1)
        aclk = m.Input('aclk', 1)
        gclk = m.Input('gclk', 1)
        rst = m.Input('rst', 1)
        out_spike = m.Output('output_spikes', q.value)

        # Wires/Regs
        ein = m.Wire('ein', p.value)
        eout = m.Wire('eout', q.value)
        ec_spikes = m.Wire('ec_spikes', q.value)
        inc, dec, weights = [], [], []
        for i in range(q.value):
            inc.append(m.Wire('inc_'+str(i), p.value))
            dec.append(m.Wire('dec_'+str(i), p.value))
            for j in range(p.value):
                weights.append(m.Wire('weights_'+str(i)+'_'+str(j), wres.value))

        gclk_pulse = m.Wire('gclk_pulse', 1)
    
        tnn_func = TNN_Functions("0")

        pulse, pulse_clk = tnn_func.Pulse2edge()
        edge, edge_clk = tnn_func.Edge2pulse()
        n_rnl, n_rnl_clk = tnn_func.NeuronRNL(p.value, thres.value, wres.value)
        wta, wta_clk = tnn_func.Wta(q.value)
        stdp, stdp_clk = tnn_func.Stdp(wres.value)

        m.Instance(edge, 'ep', ports = [gclk, aclk, gclk_pulse])

        for i in range(p.value):
            m.Instance(pulse, 'in_pe_'+str(i), ports = [aclk, input_spikes[i], gclk_pulse, rst, ein[i]])
        
        rnl_param = [p.value, thres.value, wres.value]

        for i in range(q.value):
            rnl_ports = [input_spikes, inc[i], dec[i], weight_en, aclk, gclk, gclk_pulse, rst, ec_spikes[i]]
            for j in range(p.value):
                rnl_ports.append(weights[i*p.value+j])
            m.Instance(n_rnl, 'nueron_rnl_'+str(i), params = rnl_param, 
                       ports = rnl_ports)
            
        m.Instance(wta, 'li', params = [q.value], ports = [ec_spikes, aclk, gclk_pulse, rst, out_spike])

        for i in range(q.value):
            m.Instance(pulse, 'out_pe_'+str(i), ports = [aclk, out_spike[i], gclk_pulse, rst, eout[i]])

        for i in range(q.value):
            for j in range(p.value):
                m.Instance(stdp, 'stdp_'+str(i)+'_'+str(j), params = [wres.value],
                    ports = [
                    weights[i*p.value+j],
                    ein[j],
                    eout[i],
                    capture_brv[i][j],
                    minus_brv[i][j],
                    search_brv[i][j],
                    backoff_brv[i][j],
                    min_brv[i][j],
                    F_brv[i],
                    aclk,
                    gclk_pulse,
                    rst,
                    inc[i][j],
                    dec[i][j]
                    ])

        return m, (aclk.name, gclk.name)

    """
    Testbench for column
    """
    def col_tb(self):
    
            m = Module('test_column')
            p = m.Parameter('P', self.p)
            q = m.Parameter('Q', self.q)
            wres = m.Localparam('wres', int(self.wres))
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
                capture.append(ports['capture_brv_'+str(j)])
                minus.append(ports['minus_brv'+str(j)])
                search.append(ports['search_brv'+str(j)])
                backoff.append(ports['backoff_brv'+str(j)])
                min_v.append(ports['min_brv'+str(j)])
                f.append(ports['F_brv'+str(j)])
    
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
