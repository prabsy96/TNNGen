# Authors: Wei-Che Huang, YoungSeok Na
# Reference RTL provided by: Harideep Nair
#
# Veriloggen-translation of Active Dendrite in RTL

from veriloggen import *
from tnn_mdls.func_mdls import TNN_Functions, Test_TNN_Functions
from backend import backend
import os

class ActiveDendrite():
    def __init__(self, p_dist=3, p_prox=1, q=2, wres_dist=3, wres_prox=3, thres=13):
        self.p_dist = p_dist
        self.p_prox = p_prox
        self.q = q
        self.wres_dist = wres_dist
        self.wres_prox = wres_prox
        self.thres = thres

    def col_v(self):

        m = Module('dendrite_'+str(self.p_dist)+'_'+str(self.q)+'_'+str(self.thres))
        p_dist = m.Parameter('P_DIST', int(self.p_dist))
        p_prox = m.Parameter('P_PROX', int(self.p_prox))
        q = m.Parameter('Q', int(self.q))
        wres_dist = m.Localparam('WRES_DIST', int(self.wres_dist))
        wres_prox = m.Localparam('WRES_PROX', int(self.wres_prox))
        thres = m.Parameter('THRESHOLD', int(self.thres))

        ##################
        # Inputs/Outputs #
        ##################

        # Input Spikes
        input_spikes_dist = m.Input('input_spikes_dist', p_dist.value)
        input_spikes_prox = m.Input('input_spikes_prox', p_prox.value)

        # STDP
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # STDP_dist
        for i in range(int(q.value)):
            for j in range(p_dist.value):
                w_init_dist.append(m.Input('w_init_dist_'+str(i)+'_'+str(j), wres_dist.value))
            capture_brv_dist.append(m.Input('capture_brv_dist_'+str(i), p_dist.value))
            minus_brv_dist.append(m.Input('minus_brv_dist'+str(i), p_dist.value))
            search_brv_dist.append(m.Input('search_brv_dist'+str(i), p_dist.value))
            backoff_brv_dist.append(m.Input('backoff_brv_dist'+str(i), p_dist.value))
            min_brv_dist.append(m.Input('min_brv_dist'+str(i), p_dist.value))
            F_brv_dist.append(m.Input('F_brv_dist'+str(i), (1<<wres_dist.value)-3 + 1))

        # STDP_prox
        for i in range(int(q.value)):
            for j in range(p_prox.value):
                w_init_prox.append(m.Input('w_init_prox_'+str(i)+'_'+str(j), wres_prox.value))
            capture_brv_prox.append(m.Input('capture_brv_prox_'+str(i), p_prox.value))
            minus_brv_prox.append(m.Input('minus_brv_prox'+str(i), p_prox.value))
            search_brv_prox.append(m.Input('search_brv_prox'+str(i), p_prox.value))
            backoff_brv_prox.append(m.Input('backoff_brv_prox'+str(i), p_prox.value))
            min_brv_prox.append(m.Input('min_brv_prox'+str(i), p_prox.value))
            F_brv_prox.append(m.Input('F_brv_prox'+str(i), (1<<wres_prox.value)-3 + 1))

        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')
        out_spike = m.Output('output_spike')

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
    
        tnn_func = TNN_Functions()

        ##################
        # Instantiations #
        ##################

        # edge_input_gen_dist
        pulse_dist, pulse_clk_dist = tnn_func.Pulse2edge()
        for i in range(p_dist.value):
            m.Instance(pulse_dist, 'pe_in_dist_'+str(i), ports = [input_spikes_dist[i], clk, grst, rstb, ein_dist[i]])

        # edge_input_gen_prox
        pulse_prox, pulse_clk_prox = tnn_func.Pulse2edge()
        for i in range(p_prox.value):
            m.Instance(pulse_prox, 'pe_in_prox_'+str(i), ports = [input_spikes_prox[i], clk, grst, rstb, ein_prox[i]])

        # segment
        # [YoungSeok] better way to do w_init_dist*?
        n_seg, _ = tnn_func.segment(p_dist.value, p_prox.value, wres_dist.value, wres_prox.value, thres)
        for i in range(q.value):
            m.Instance(n_seg, 'ec_'+str(i), params = [p_dist.value, p_prox.value, wres_dist.value, wres_prox.value, thres.value],
                       ports = [
                           input_spikes_dist,
                           input_spikes_prox,
                           inc_dist[i],
                           inc_prox[i],
                           dec_dist[i],
                           dec_prox[i],
                           clk,
                           grst,
                           rstb,
                           ec_spikes[i],
                           w_init_dist[i],
                           w_init_prox[i],
                           weights_dist[i],
                           weights_prox[i]
                       ])

        # WTA
        wta, _ = tnn_func.Wta(q.value)
        m.Instance(wta, 'li', params = [q.value], ports = [ec_spikes, clk, grst, rstb, li_spikes])

        # edge_output_gen
        pulse, pulse_clk = tnn_func.Pulse2edge()
        for i in range(q.value):
            m.Instance(pulse, 'pe_out_'+str(i), ports = [li_spikes[i], clk, grst, rstb, eout[i]])

        # stdp_dist
        stdp_dist, _ = tnn_func.Stdp(wres_dist.value)
        for i in range(q.value):
            for j in range(p_dist.value):
                m.Instance(stdp_dist, 'stdp_dist_'+str(i)+'_'+str(j), params = [wres_dist.value],
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
        stdp_prox, _ = tnn_func.Stdp(wres_prox.value)
        for i in range(q.value):
            for j in range(p_prox.value):
                m.Instance(stdp_prox, 'stdp_prox_'+str(i)+'_'+str(j), params = [wres_prox.value],
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
