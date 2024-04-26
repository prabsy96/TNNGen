# Authors: Wei-Che Huang, YoungSeok Na
# Reference RTL provided by: Harideep Nair
#
# Veriloggen-translation of Active Dendrite in RTL

from veriloggen import *
from tnn_mdls.func_mdls import TNN_Functions
from tnn_mdls.tb_func_mdls import Test_TNN_Functions
from backend import backend
import os

class Layers():
    #def __init__(self):
        # self.num_col = num_col
        # self.num_neurons = num_neurons
        # self.num_dend = num_dend
        # self.p_dist = p_dist
        # self.p_prox = p_prox
        # self.num_seg = num_seg
        # self.wres_dist = wres_dist
        # self.wres_prox = wres_prox
        # self.thres = thres

    def TNN_Layer(num_col=2, num_neurons=10, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):
        
        m = Module('TNN_Layer')
        num_col = m.Parameter('NUM_COL', int(num_col))
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

        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        input_spikes_dist, input_spikes_prox = [], []
        output_spikes = []
        w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
        w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

        # input_spikes_dist
        #for c in range(num_col.value):
        #    for n in range(num_neurons.value):
        #        input_spikes_dist.append(m.Input('input_spikes_dist_'+str(c)+'_'+str(n), p_dist.value))
        input_spikes_dist = m.Input('input_spikes_dist', num_col.value*num_neurons.value*p_dist.value)

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
        #for i in range(num_col.value*num_neurons.value):
        #    output_spikes.append(m.Output('layer_out_spikes'))
        #for c in range(num_col.value):
        #    output_spikes.append(m.Output('output_spikes'+'_'+str(c), num_neurons.value))
        output_spikes = m.Output('layer_out_spikes', num_col.value*num_neurons.value)

        ##################
        # Instantiations #
        ##################
        tnn_func = TNN_Functions()

        comp_col, _ = tnn_func.Comp_column(num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for c in range(num_col.value):
            col_ports = [clk, grst, rstb, 
                         output_spikes.slice((c+1)*num_neurons.value-1, c*num_neurons.value)]
            # input_spikes_dist
            for n in range(num_neurons.value):
                col_ports.append(input_spikes_dist.slice(((n+1)*p_dist.value)+(c*num_neurons.value*p_dist.value)-1, (n*p_dist.value)+(c*num_neurons.value*p_dist.value)))
            
            # input_spikes_prox
            for d in range(num_dend.value):
                col_ports.append(input_spikes_prox[d])
            # w_init_dist
            col_ports = tnn_func.append_port4(col_ports, w_init_dist, c, num_neurons.value, num_dend.value, num_seg.value, p_dist.value)
            # w_init_prox
            col_ports = tnn_func.append_port4(col_ports, w_init_prox, c, num_neurons.value, num_dend.value, num_seg.value, p_prox.value)
            # capture_brv_dist
            col_ports = tnn_func.append_port3(col_ports, capture_brv_dist, c, num_neurons.value, num_dend.value, num_seg.value)
            # capture_brv_prox
            col_ports = tnn_func.append_port3(col_ports, capture_brv_prox, c, num_neurons.value, num_dend.value, num_seg.value)
            # minus_brv_dist
            col_ports = tnn_func.append_port3(col_ports, minus_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # minus_brv_prox
            col_ports = tnn_func.append_port3(col_ports, minus_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # search_brv_dist
            col_ports = tnn_func.append_port3(col_ports, search_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # search_brv_prox
            col_ports = tnn_func.append_port3(col_ports, search_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # backoff_brv_dist
            col_ports = tnn_func.append_port3(col_ports, backoff_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # backoff_brv_prox
            col_ports = tnn_func.append_port3(col_ports, backoff_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # min_brv_dist
            col_ports = tnn_func.append_port3(col_ports, min_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # min_brv_prox
            col_ports = tnn_func.append_port3(col_ports, min_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
            # F_brv_dist
            col_ports = tnn_func.append_port3(col_ports, F_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
            # F_brv_prox
            col_ports = tnn_func.append_port3(col_ports, F_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)

            m.Instance(comp_col, 'comp_col_inst_'+str(c), params=[num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = col_ports)
        
        return m
    
    def CV_Layer(self, num_col=2, num_neurons=10, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13):
            
        m = Module('CV_Layer')
        num_groups = m.Parameter('NUM_CV_GROUPS', int(num_col))
        num_units = m.Parameter('NUM_CV_UNITS', int(num_neurons))
        p_dist = m.Parameter('P_DIST', int(p_dist))
        p_prox = m.Parameter('P_PROX', int(p_prox))
        num_seg = m.Parameter('NUM_SEG', int(num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(wres_prox))
        threshold = m.Parameter('THRESHOLD', int(thres))

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
        tnn_func = TNN_Functions()
        CV_group, _ = tnn_func.CV_group(num_units.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for c in range(num_groups.value):
            col_ports = [clk, grst, rstb, output_spikes[c], input_spikes_dist[c]]
            # input_spikes_prox
            for i in range(num_units.value):
                col_ports.append(input_spikes_prox[i])
            # w_init_dist
            col_ports = tnn_func.append_port3(col_ports, w_init_dist, c, num_units.value, num_seg.value, p_dist.value)
            # w_init_prox
            col_ports = tnn_func.append_port3(col_ports, w_init_prox, c, num_units.value, num_seg.value, p_prox.value)
            # capture_brv_dist
            col_ports = tnn_func.append_port2(col_ports, capture_brv_dist, c, num_units.value, num_seg.value)
            # capture_brv_prox
            col_ports = tnn_func.append_port2(col_ports, capture_brv_prox, c, num_units.value, num_seg.value)
            # minus_brv_dist
            col_ports = tnn_func.append_port2(col_ports, minus_brv_dist, c, num_units.value, num_seg.value)
            # minus_brv_prox
            col_ports = tnn_func.append_port2(col_ports, minus_brv_prox, c, num_units.value, num_seg.value)
            # search_brv_dist
            col_ports = tnn_func.append_port2(col_ports, search_brv_dist, c, num_units.value, num_seg.value)
            # search_brv_prox
            col_ports = tnn_func.append_port2(col_ports, search_brv_prox, c, num_units.value, num_seg.value)
            # backoff_brv_dist
            col_ports = tnn_func.append_port2(col_ports, backoff_brv_dist, c, num_units.value, num_seg.value)
            # backoff_brv_prox
            col_ports = tnn_func.append_port2(col_ports, backoff_brv_prox, c, num_units.value, num_seg.value)
            # min_brv_dist
            col_ports = tnn_func.append_port2(col_ports, min_brv_dist, c, num_units.value, num_seg.value)
            # min_brv_prox
            col_ports = tnn_func.append_port2(col_ports, min_brv_prox, c, num_units.value, num_seg.value)
            # F_brv_dist
            col_ports = tnn_func.append_port2(col_ports, F_brv_dist, c, num_units.value, num_seg.value)
            # F_brv_prox
            col_ports = tnn_func.append_port2(col_ports, F_brv_prox, c, num_units.value, num_seg.value)

            m.Instance(CV_group, 'CV_group_'+str(c), params=[num_units.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = col_ports)
        
        return m