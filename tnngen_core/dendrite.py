# Authors: Wei-Che Huang, YoungSeok Na
# Reference RTL provided by: Harideep Nair
#
# Veriloggen-translation of Active Dendrite in RTL

from veriloggen import *
from tnn_mdls.func_mdls import TNN_Functions
from tnn_mdls.tb_func_mdls import Test_TNN_Functions
from backend import backend
import os

class ActiveDendrite():
    def __init__(self, num_col=2, num_neurons=10, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):
        self.num_col = num_col
        self.num_neurons = num_neurons
        self.num_dend = num_dend
        self.p_dist = p_dist
        self.p_prox = p_prox
        self.num_seg = num_seg
        self.wres_dist = wres_dist
        self.wres_prox = wres_prox
        self.thres = thres

    def TNN_Layer(self):
        
        m = Module('TNN_Layer')
        num_col = m.Parameter('NUM_COL', int(self.num_col))
        num_neurons = m.Parameter('NUM_NEURONS', int(self.num_neurons))
        num_dend = m.Parameter('NUM_DEND', int(self.num_dend))
        p_dist = m.Parameter('P_DIST', int(self.p_dist))
        p_prox = m.Parameter('P_PROX', int(self.p_prox))
        num_seg = m.Parameter('NUM_SEG', int(self.num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(self.wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(self.wres_prox))
        threshold = m.Parameter('THRESHOLD', int(self.thres))

        ##################
        # Inputs/Outputs #
        ##################

        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        input_spikes_dist, input_spikes_prox = [], []
        output_spikes = []
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # input_spikes_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                input_spikes_dist.append(m.Input('input_spikes_dist_'+str(c)+'_'+str(n), p_dist.value))

        # input_spikes_prox
        for i in range(num_dend.value):
            input_spikes_prox.append(m.Input('input_spikes_prox_'+str(i), p_prox.value))

        # w_init_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value):
                        for k in range(p_dist.value):
                            w_init_dist.append(m.Input('w_init_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j)+str(k), wres_dist.value))

        # w_init_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value):
                        for k in range(p_prox.value):
                            w_init_prox.append(m.Input('w_init_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j)+str(k), wres_prox.value))

        # capture_brv_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value):
                        capture_brv_dist.append(m.Input('capture_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))

        # capture_brv_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value):
                        capture_brv_prox.append(m.Input('capture_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        # minus_brv_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value):
                        minus_brv_dist.append(m.Input('minus_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
        # minus_brv_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value):       
                        minus_brv_prox.append(m.Input('minus_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
        # search_brv_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        search_brv_dist.append(m.Input('search_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
        # search_brv_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        search_brv_prox.append(m.Input('search_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
        # backoff_brv_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
        # backoff_brv_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
        # min_brv_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        min_brv_dist.append(m.Input('min_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
        # min_brv_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        min_brv_prox.append(m.Input('min_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
        # F_brv_dist
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        F_brv_dist.append(m.Input('F_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), (1<<wres_dist.value)-3 + 1))
        
        # F_brv_prox
        for c in range(num_col.value):
            for n in range(num_neurons.value):
                for i in range(num_dend.value):
                    for j in range(num_seg.value): 
                        F_brv_prox.append(m.Input('F_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), (1<<wres_prox.value)-3 + 1))

        # Output_spikes
        for c in range(num_col.value):
            output_spikes.append(m.Output('output_spikes'+'_'+str(c), num_neurons.value))

        ##################
        # Instantiations #
        ##################
        comp_col, _ = self.Comp_column(num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for c in range(num_col.value):
            col_ports = [clk, grst, rstb, output_spikes[c]]
            # input_spikes_dist
            for n in range(num_neurons.value):
                col_ports.append(input_spikes_dist[c*num_neurons.value+n])
            # input_spikes_prox
            for d in range(num_dend.value):
                col_ports.append(input_spikes_prox[d])
            # w_init_dist
            col_ports = self.append_port4(col_ports, w_init_dist, c, num_neurons.value, num_dend.value, num_seg.value, p_dist.value)
            # w_init_prox
            col_ports = self.append_port4(col_ports, w_init_prox, c, num_neurons.value, num_dend.value, num_seg.value, p_prox.value)
            # capture_brv_dist
            col_ports = self.append_port3(col_ports, capture_brv_dist, c, num_neurons.value, num_dend.value, num_seg.value)
            # capture_brv_prox
            col_ports = self.append_port3(col_ports, capture_brv_prox, c, num_neurons.value, num_dend.value, num_seg.value)
            # minus_brv_dist
            col_ports = self.append_port3(col_ports, minus_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # minus_brv_prox
            col_ports = self.append_port3(col_ports, minus_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # search_brv_dist
            col_ports = self.append_port3(col_ports, search_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # search_brv_prox
            col_ports = self.append_port3(col_ports, search_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # backoff_brv_dist
            col_ports = self.append_port3(col_ports, backoff_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # backoff_brv_prox
            col_ports = self.append_port3(col_ports, backoff_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # min_brv_dist
            col_ports = self.append_port3(col_ports, min_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # min_brv_prox
            col_ports = self.append_port3(col_ports, min_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # F_brv_dist
            col_ports = self.append_port3(col_ports, F_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # F_brv_prox
            col_ports = self.append_port3(col_ports, F_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)

            m.Instance(comp_col, 'comp_col_inst_'+str(c), params=[num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = col_ports)
        
        return m, clk.name
    
    def CV_Layer(self):
            
        m = Module('CV_Layer')
        num_groups = m.Parameter('NUM_CV_GROUPS', int(self.num_col))
        num_units = m.Parameter('NUM_CV_UNITS', int(self.num_neurons))
        p_dist = m.Parameter('P_DIST', int(self.p_dist))
        p_prox = m.Parameter('P_PROX', int(self.p_prox))
        num_seg = m.Parameter('NUM_SEG', int(self.num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(self.wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(self.wres_prox))
        threshold = m.Parameter('THRESHOLD', int(self.thres))

        ##################
        # Inputs/Outputs #
        ##################

        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        input_spikes_dist, input_spikes_prox = [], []
        output_spikes = []
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # input_spikes_dist (each groups have a different set, but all unit within a group shares)
        for c in range(num_groups.value):
            input_spikes_dist.append(m.Input('input_spikes_dist_'+str(c), p_dist.value))

        # input_spikes_prox (each groups share the same set, but all units differ)
        for i in range(num_units.value):
            input_spikes_prox.append(m.Input('input_spikes_prox_'+str(i), p_prox.value))

        # w_init_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value):
                    for j in range(p_dist.value):
                        w_init_dist.append(m.Input('w_init_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), wres_dist.value))

        # w_init_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value):
                    for j in range(p_prox.value):
                        w_init_prox.append(m.Input('w_init_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), wres_prox.value))

        # capture_brv_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value):
                    capture_brv_dist.append(m.Input('capture_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i), p_dist.value))

        # capture_brv_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value):
                    capture_brv_prox.append(m.Input('capture_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i), p_prox.value))
        # minus_brv_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value):
                    minus_brv_dist.append(m.Input('minus_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i), p_dist.value))
        
        # minus_brv_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value):       
                    minus_brv_prox.append(m.Input('minus_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i), p_prox.value))
        
        # search_brv_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    search_brv_dist.append(m.Input('search_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i), p_dist.value))
        
        # search_brv_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    search_brv_prox.append(m.Input('search_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i), p_prox.value))
        
        # backoff_brv_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i), p_dist.value))
        
        # backoff_brv_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i), p_prox.value))
        
        # min_brv_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    min_brv_dist.append(m.Input('min_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i), p_dist.value))
        
        # min_brv_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    min_brv_prox.append(m.Input('min_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i), p_prox.value))
        
        # F_brv_dist
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    F_brv_dist.append(m.Input('F_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i), (1<<wres_dist.value)-3 + 1))
        
        # F_brv_prox
        for c in range(num_groups.value):
            for n in range(num_units.value):
                for i in range(num_seg.value): 
                    F_brv_prox.append(m.Input('F_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i), (1<<wres_prox.value)-3 + 1))

        # Output_spikes
        for c in range(num_groups.value):
            output_spikes.append(m.Output('output_spikes'+'_'+str(c), num_units.value))

        ##################
        # Instantiations #
        ##################
        CV_group, _ = self.CV_group(num_units.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for c in range(num_groups.value):
            col_ports = [clk, grst, rstb, output_spikes[c], input_spikes_dist[c]]
            # input_spikes_prox
            for i in range(num_units.value):
                col_ports.append(input_spikes_prox[i])
            # w_init_dist
            col_ports = self.append_port3(col_ports, w_init_dist, c, num_units.value, num_seg.value, p_dist.value)
            # w_init_prox
            col_ports = self.append_port3(col_ports, w_init_prox, c, num_units.value, num_seg.value, p_prox.value)
            # capture_brv_dist
            col_ports = self.append_port2(col_ports, capture_brv_dist, c, num_units.value, num_seg.value)
            # capture_brv_prox
            col_ports = self.append_port2(col_ports, capture_brv_prox, c, num_units.value, num_seg.value)
            # minus_brv_dist
            col_ports = self.append_port2(col_ports, minus_brv_dist, c, num_units.value, num_seg.value)
            # minus_brv_prox
            col_ports = self.append_port2(col_ports, minus_brv_prox, c, num_units.value, num_seg.value)
            # search_brv_dist
            col_ports = self.append_port2(col_ports, search_brv_dist, c, num_units.value, num_seg.value)
            # search_brv_prox
            col_ports = self.append_port2(col_ports, search_brv_prox, c, num_units.value, num_seg.value)
            # backoff_brv_dist
            col_ports = self.append_port2(col_ports, backoff_brv_dist, c, num_units.value, num_seg.value)
            # backoff_brv_prox
            col_ports = self.append_port2(col_ports, backoff_brv_prox, c, num_units.value, num_seg.value)
            # min_brv_dist
            col_ports = self.append_port2(col_ports, min_brv_dist, c, num_units.value, num_seg.value)
            # min_brv_prox
            col_ports = self.append_port2(col_ports, min_brv_prox, c, num_units.value, num_seg.value)
            # F_brv_dist
            col_ports = self.append_port2(col_ports, F_brv_dist, c, num_units.value, num_seg.value)
            # F_brv_prox
            col_ports = self.append_port2(col_ports, F_brv_prox, c, num_units.value, num_seg.value)

            m.Instance(CV_group, 'CV_group_'+str(c), params=[num_units.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = col_ports)
        
        return m, clk.name   


    def Comp_column(self, num_neurons=10, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):

        m = Module('comp_column')
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
            
            m.Instance(comp_neuron, 'comp_neuron_inst_'+str(n), params=[num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = neuron_ports)
            
        tnn_func = TNN_Functions()
        t_wta, _ = tnn_func.t_wta(num_neurons.value)
        m.Instance(t_wta, 'l1', params=[num_neurons.value], ports=[prewta_spikes, clk, grst, rstb, output_spikes])

        return m, clk.name
    
    def CV_group(self, num_units=10, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):
        m = Module('CV_group')
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
            
            m.Instance(CV_unit, 'CV_unit_'+str(n), params=[p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = neuron_ports)
            
        return m, clk.name

    def Comp_neuron(self, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):

        m = Module('comp_neuron')
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

            m.Instance(dendrite, 'dend_inst_'+str(i), params=[p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = dendrite_ports)
            
        
        m.EmbeddedCode('assign output_spike = |dend_out;')

        return m, clk.name
    
    def CV_unit(self, p_dist=3, p_prox=1, num_seg=8, wres_dist=3, wres_prox=3, thres=13):

        m = Module('CV_unit')
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

        m.Instance(dendrite, 'dend_inst', params=[p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                    ports = dendrite_ports)
            
        
        m.EmbeddedCode('assign output_spike = |dend_out;')

        return m, clk.name

    def Dendrite(self, p_dist=3, p_prox=1, q=2, wres_dist=3, wres_prox=3, thres=13):

        m = Module('dendrite_'+str(p_dist)+'_'+str(q)+'_'+str(thres))
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
        n_seg, _ = tnn_func.segment(p_dist.value, p_prox.value, wres_dist.value, wres_prox.value, thres.value)
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
            m.Instance(n_seg, 'ec_'+str(i), params = [p_dist.value, p_prox.value, wres_dist.value, wres_prox.value, thres.value],
                       ports = segment_ports)

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