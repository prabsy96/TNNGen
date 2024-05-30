# Authors: Wei-Che Huang, YoungSeok Na
# Reference RTL provided by: Harideep Nair
#
# Veriloggen-translation of Active Dendrite in RTL

from veriloggen import *
from tnn_mdls.func_mdls import TNN_Functions
from tnn_mdls.tb_func_mdls import Test_TNN_Functions
from backend import backend
import numpy as np
import os

class Layer():
    def __init__(self, layer_type=None, num_col=2, num_neurons=10, num_dend=16, p_dist=3, p_prox=1, num_seg=2, wres_dist=3, wres_prox=3, thres=13, rfsize=None, stride=None, nprev=None, inputsize=None, tnn7_en=False):
        self.num_col = num_col
        self.num_neurons = num_neurons
        self.num_dend = num_dend
        self.p_dist = p_dist
        self.p_prox = p_prox
        self.num_seg = num_seg
        self.wres_dist = wres_dist
        self.wres_prox = wres_prox
        self.thres = thres
        self.layer_type = layer_type
        self.layer_id = None
        self.rfsize = rfsize
        self.stride = stride
        self.nprev = nprev
        self.inputsize = inputsize
        self.tnn7_en = tnn7_en

    def Kernel_Layer(self, layer_id=None):
        m = Module('Kernel_Layer_'+str(layer_id))
        self.layer_id = str(layer_id)

        ##################
        # Parameters #
        ##################
        rfsize = m.Parameter('RFSIZE', int(self.rfsize))
        stride = m.Parameter('STRIDE', int(self.stride))
        nprev = m.Parameter('NPREV', int(self.nprev))
        inputsize = m.Parameter('INPUTSIZE', int(self.inputsize))
        in_width = m.Parameter('IN_WIDTH', int(inputsize.value*inputsize.value*nprev.value))
        p = m.Parameter('p', int(rfsize.value*rfsize.value*nprev.value))
        num_k = int((((inputsize.value-rfsize.value)/stride.value)+1) * (((inputsize.value-rfsize.value)/stride.value)+1))
        out_width = m.Parameter('OUT_WIDTH', int(p.value*num_k))
        is_clk = m.Parameter('is_clk', 0)

        ##################
        # Inputs/Outputs #
        ##################
        layer_in = m.Input('layer_in', in_width.value)
        layer_out = m.Output('layer_out', out_width.value)

        #####################
        # Intermediate wire #
        #####################
        temp_out = m.Wire('temp_out', out_width.value)

        #######################
        # Combinational logic #
        #######################
        n_col = int(((inputsize.value-rfsize.value)/stride.value)+1)
        n_row = int(((inputsize.value-rfsize.value)/stride.value)+1)

        for k in range(num_k):
            ky = int(np.floor(k/n_col))
            kx = int(np.floor(k%n_row))
            
            for r in range(rfsize.value):
                out_bot = rfsize.value*rfsize.value*nprev.value*k+r*rfsize.value*nprev.value
                out_top = out_bot+(rfsize.value*nprev.value-1)
                in_bot = ((kx + ky*inputsize.value)*stride.value + inputsize.value*r)*nprev.value
                in_top = in_bot+(rfsize.value*nprev.value-1)
                temp_out.slice(out_top, out_bot).assign(layer_in.slice(in_top, in_bot))

        layer_out.assign(temp_out)

        return m

    def TNN_Layer(self, layer_id=None):
        m = Module('TNN_Layer_'+str(layer_id))
        self.layer_id = str(layer_id)
        num_col = m.Parameter('NUM_COL', int(self.num_col))
        num_neurons = m.Parameter('NUM_NEURONS', int(self.num_neurons))
        num_dend = m.Parameter('NUM_DEND', int(self.num_dend))
        p_dist = m.Parameter('P_DIST', int(self.p_dist))
        p_prox = m.Parameter('P_PROX', int(self.p_prox))
        num_seg = m.Parameter('NUM_SEG', int(self.num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(self.wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(self.wres_prox))
        threshold = m.Parameter('THRESHOLD', int(self.thres))
        in_width = m.Parameter('IN_WIDTH', int(num_col.value*num_neurons.value*p_dist.value))
        out_width = m.Parameter('OUT_WIDTH', int(num_col.value*num_neurons.value))
        is_clk = m.Parameter('is_clk', 1)

        ##################
        # Inputs/Outputs #
        ##################

        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        # input_spikes_dist (Different for each minicolumn, different for each neuron)
        input_spikes_dist_width = num_neurons.value*p_dist.value
        input_spikes_dist = m.Input('layer_in', num_col.value*input_spikes_dist_width)

        # input_spikes_prox (Different for each minicolumn, shared across all neurons, different for each dendrite)
        input_spikes_prox_width = num_dend.value*p_prox.value
        input_spikes_prox = m.Input('input_spikes_prox', num_col.value*input_spikes_prox_width)

        # w_init_dist
        w_init_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value*wres_dist.value
        w_init_dist = m.Input('w_init_dist', num_col.value*w_init_dist_width)

        # w_init_prox
        w_init_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value*wres_prox.value
        w_init_prox = m.Input('w_init_prox', num_col.value*w_init_prox_width)

        # capture_brv_dist
        capture_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        capture_brv_dist = m.Input('capture_brv_dist', num_col.value*capture_brv_dist_width)

        # capture_brv_prox
        capture_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        capture_brv_prox = m.Input('capture_brv_prox', num_col.value*capture_brv_prox_width)

        # minus_brv_dist
        minus_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        minus_brv_dist = m.Input('minus_brv_dist', num_col.value*minus_brv_dist_width)
        
        # minus_brv_prox
        minus_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        minus_brv_prox = m.Input('minus_brv_prox', num_col.value*minus_brv_prox_width)
        
        # search_brv_dist
        search_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        search_brv_dist = m.Input('search_brv_dist', num_col.value*search_brv_dist_width)
        
        # search_brv_prox
        search_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        search_brv_prox = m.Input('search_brv_prox', num_col.value*search_brv_prox_width)
        
        # backoff_brv_dist
        backoff_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        backoff_brv_dist = m.Input('backoff_brv_dist', num_col.value*backoff_brv_dist_width)
        
        # backoff_brv_prox
        backoff_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        backoff_brv_prox = m.Input('backoff_brv_prox', num_col.value*backoff_brv_prox_width)
        
        # min_brv_dist
        min_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        min_brv_dist = m.Input('min_brv_dist', num_col.value*min_brv_dist_width)
        
        # min_brv_prox
        min_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        min_brv_prox = m.Input('min_brv_prox', num_col.value*min_brv_prox_width)
        
        # F_brv_dist
        F_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*((1<<wres_dist.value)-3 + 1)
        F_brv_dist = m.Input('F_brv_dist', num_col.value*F_brv_dist_width)
        
        # F_brv_prox
        F_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*((1<<wres_prox.value)-3 + 1)
        F_brv_prox = m.Input('F_brv_prox', num_col.value*F_brv_prox_width)

        # Output_spikes
        output_spikes = m.Output('layer_out', num_col.value*num_neurons.value)

        ##################
        # Instantiations #
        ##################
        tnn_func = TNN_Functions(self.layer_id, tnn7_en=self.tnn7_en)

        minicolumn, _ = tnn_func.Minicolumn(num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for c in range(num_col.value):
            col_ports = [clk, grst, rstb, 
                         output_spikes.slice((c+1)*num_neurons.value-1, c*num_neurons.value)]
            
            # input_spikes_dist
            col_ports.append(input_spikes_dist.slice((c+1)*input_spikes_dist_width-1, c*input_spikes_dist_width))
            # input_spikes_prox
            col_ports.append(input_spikes_prox.slice((c+1)*input_spikes_prox_width-1, c*input_spikes_prox_width))
            # w_init_dist
            col_ports.append(w_init_dist.slice((c+1)*w_init_dist_width-1, c*w_init_dist_width))
            # w_init_prox
            col_ports.append(w_init_prox.slice((c+1)*w_init_prox_width-1, c*w_init_prox_width))
            # capture_brv_dist
            col_ports.append(capture_brv_dist.slice((c+1)*capture_brv_dist_width-1, c*capture_brv_dist_width))
            # capture_brv_prox
            col_ports.append(capture_brv_prox.slice((c+1)*capture_brv_prox_width-1, c*capture_brv_prox_width))
            # minus_brv_dist
            col_ports.append(minus_brv_dist.slice((c+1)*minus_brv_dist_width-1, c*minus_brv_dist_width))
            # minus_brv_prox
            col_ports.append(minus_brv_prox.slice((c+1)*minus_brv_prox_width-1, c*minus_brv_prox_width))
            # search_brv_dist
            col_ports.append(search_brv_dist.slice((c+1)*search_brv_dist_width-1, c*search_brv_dist_width))
            # search_brv_prox
            col_ports.append(search_brv_prox.slice((c+1)*search_brv_prox_width-1, c*search_brv_prox_width))
            # backoff_brv_dist
            col_ports.append(backoff_brv_dist.slice((c+1)*backoff_brv_dist_width-1, c*backoff_brv_dist_width))
            # backoff_brv_prox
            col_ports.append(backoff_brv_prox.slice((c+1)*backoff_brv_prox_width-1, c*backoff_brv_prox_width))
            # min_brv_dist
            col_ports.append(min_brv_dist.slice((c+1)*min_brv_dist_width-1, c*min_brv_dist_width))
            # min_brv_prox
            col_ports.append(min_brv_prox.slice((c+1)*min_brv_prox_width-1, c*min_brv_prox_width))
            # F_brv_dist
            col_ports.append(F_brv_dist.slice((c+1)*F_brv_dist_width-1, c*F_brv_dist_width))
            # F_brv_prox
            col_ports.append(F_brv_prox.slice((c+1)*F_brv_prox_width-1, c*F_brv_prox_width))

            m.Instance(minicolumn, 'L'+str(self.layer_id)+'_minicolumn_inst_'+str(c), params=[num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = col_ports)
        
        return m
    
    def CV_Layer(self, layer_id=None):
        m = Module('CV_Layer_'+str(layer_id))
        self.layer_id = str(layer_id)
        num_col = m.Parameter('NUM_COL', int(self.num_col))
        num_neurons = m.Parameter('NUM_NEURONS', int(self.num_neurons))
        num_dend = m.Parameter('NUM_DEND', int(self.num_dend))
        p_dist = m.Parameter('P_DIST', int(self.p_dist))
        p_prox = m.Parameter('P_PROX', int(self.p_prox))
        num_seg = m.Parameter('NUM_SEG', int(self.num_seg))
        wres_dist = m.Parameter('WRES_DIST', int(self.wres_dist))
        wres_prox = m.Parameter('WRES_PROX', int(self.wres_prox))
        threshold = m.Parameter('THRESHOLD', int(self.thres))
        in_width = m.Parameter('IN_WIDTH', int(num_col.value*p_dist.value))
        out_width = m.Parameter('OUT_WIDTH', int(num_col.value*num_neurons.value))
        is_clk = m.Parameter('is_clk', 1)

        ##################
        # Inputs/Outputs #
        ##################

        clk = m.Input('clk')
        grst = m.Input('grst')
        rstb = m.Input('rstb')

        # input_spikes_dist
        input_spikes_dist = m.Input('layer_in', num_col.value*p_dist.value)

        # input_spikes_prox
        input_spikes_prox_width = num_neurons.value*p_prox.value
        input_spikes_prox = m.Input('input_spikes_prox', input_spikes_prox_width)

        # w_init_dist
        w_init_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value*wres_dist.value
        w_init_dist = m.Input('w_init_dist', num_col.value*w_init_dist_width)

        # w_init_prox
        w_init_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value*wres_prox.value
        w_init_prox = m.Input('w_init_prox', num_col.value*w_init_prox_width)

        # capture_brv_dist
        capture_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        capture_brv_dist = m.Input('capture_brv_dist', num_col.value*capture_brv_dist_width)

        # capture_brv_prox
        capture_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        capture_brv_prox = m.Input('capture_brv_prox', num_col.value*capture_brv_prox_width)

        # minus_brv_dist
        minus_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        minus_brv_dist = m.Input('minus_brv_dist', num_col.value*minus_brv_dist_width)
        
        # minus_brv_prox
        minus_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        minus_brv_prox = m.Input('minus_brv_prox', num_col.value*minus_brv_prox_width)
        
        # search_brv_dist
        search_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        search_brv_dist = m.Input('search_brv_dist', num_col.value*search_brv_dist_width)
        
        # search_brv_prox
        search_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        search_brv_prox = m.Input('search_brv_prox', num_col.value*search_brv_prox_width)
        
        # backoff_brv_dist
        backoff_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        backoff_brv_dist = m.Input('backoff_brv_dist', num_col.value*backoff_brv_dist_width)
        
        # backoff_brv_prox
        backoff_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        backoff_brv_prox = m.Input('backoff_brv_prox', num_col.value*backoff_brv_prox_width)
        
        # min_brv_dist
        min_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*p_dist.value
        min_brv_dist = m.Input('min_brv_dist', num_col.value*min_brv_dist_width)
        
        # min_brv_prox
        min_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*p_prox.value
        min_brv_prox = m.Input('min_brv_prox', num_col.value*min_brv_prox_width)
        
        # F_brv_dist
        F_brv_dist_width = num_neurons.value*num_dend.value*num_seg.value*((1<<wres_dist.value)-3 + 1)
        F_brv_dist = m.Input('F_brv_dist', num_col.value*F_brv_dist_width)
        
        # F_brv_prox
        F_brv_prox_width = num_neurons.value*num_dend.value*num_seg.value*((1<<wres_prox.value)-3 + 1)
        F_brv_prox = m.Input('F_brv_prox', num_col.value*F_brv_prox_width)

        # Output_spikes
        output_spikes = m.Output('layer_out', num_col.value*num_neurons.value)

        ##################
        # Instantiations #
        ##################
        tnn_func = TNN_Functions(self.layer_id, tnn7_en=self.tnn7_en)

        comp_col, _ = tnn_func.CV_Group(num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
        for c in range(num_col.value):
            col_ports = [clk, grst, rstb, 
                         output_spikes.slice((c+1)*num_neurons.value-1, c*num_neurons.value),
                         input_spikes_dist.slice((c+1)*p_dist.value-1, c*p_dist.value),
                         input_spikes_prox]

            # w_init_dist
            col_ports.append(w_init_dist.slice((c+1)*w_init_dist_width-1, c*w_init_dist_width))
            # w_init_prox
            col_ports.append(w_init_prox.slice((c+1)*w_init_prox_width-1, c*w_init_prox_width))
            # capture_brv_dist
            col_ports.append(capture_brv_dist.slice((c+1)*capture_brv_dist_width-1, c*capture_brv_dist_width))
            # capture_brv_prox
            col_ports.append(capture_brv_prox.slice((c+1)*capture_brv_prox_width-1, c*capture_brv_prox_width))
            # minus_brv_dist
            col_ports.append(minus_brv_dist.slice((c+1)*minus_brv_dist_width-1, c*minus_brv_dist_width))
            # minus_brv_prox
            col_ports.append(minus_brv_prox.slice((c+1)*minus_brv_prox_width-1, c*minus_brv_prox_width))
            # search_brv_dist
            col_ports.append(search_brv_dist.slice((c+1)*search_brv_dist_width-1, c*search_brv_dist_width))
            # search_brv_prox
            col_ports.append(search_brv_prox.slice((c+1)*search_brv_prox_width-1, c*search_brv_prox_width))
            # backoff_brv_dist
            col_ports.append(backoff_brv_dist.slice((c+1)*backoff_brv_dist_width-1, c*backoff_brv_dist_width))
            # backoff_brv_prox
            col_ports.append(backoff_brv_prox.slice((c+1)*backoff_brv_prox_width-1, c*backoff_brv_prox_width))
            # min_brv_dist
            col_ports.append(min_brv_dist.slice((c+1)*min_brv_dist_width-1, c*min_brv_dist_width))
            # min_brv_prox
            col_ports.append(min_brv_prox.slice((c+1)*min_brv_prox_width-1, c*min_brv_prox_width))
            # F_brv_dist
            col_ports.append(F_brv_dist.slice((c+1)*F_brv_dist_width-1, c*F_brv_dist_width))
            # F_brv_prox
            col_ports.append(F_brv_prox.slice((c+1)*F_brv_prox_width-1, c*F_brv_prox_width))

            m.Instance(comp_col, 'L'+str(self.layer_id)+'_CV_group_'+str(c), params=[num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
                       ports = col_ports)
        
        return m
    
    # def CV_Layer(self, layer_id=None):
            
    #     m = Module('CV_Layer_'+str(layer_id))
    #     self.layer_id = str(layer_id)
    #     num_col = m.Parameter('NUM_COL', int(self.num_col))
    #     num_neurons = m.Parameter('NUM_NEURONS', int(self.num_neurons))
    #     p_dist = m.Parameter('P_DIST', int(self.p_dist))
    #     p_prox = m.Parameter('P_PROX', int(self.p_prox))
    #     num_seg = m.Parameter('NUM_SEG', int(self.num_seg))
    #     wres_dist = m.Parameter('WRES_DIST', int(self.wres_dist))
    #     wres_prox = m.Parameter('WRES_PROX', int(self.wres_prox))
    #     threshold = m.Parameter('THRESHOLD', int(self.thres))
    #     in_width = m.Parameter('IN_WIDTH', int(num_col.value*p_dist.value))
    #     out_width = m.Parameter('OUT_WIDTH', int(num_col.value*num_neurons.value))
    #     is_clk = m.Parameter('is_clk', 1)

    #     ##################
    #     # Inputs/Outputs #
    #     ##################

    #     clk = m.Input('clk')
    #     grst = m.Input('grst')
    #     rstb = m.Input('rstb')

    #     # input_spikes_dist (each groups have a different set, but all unit within a group shares)
    #     input_spikes_dist = m.Input('layer_in', num_col.value*p_dist.value)

    #     # input_spikes_prox (each groups share the same set, but all units differ)
    #     input_spikes_prox_width = num_neurons.value*p_prox.value
    #     input_spikes_prox = m.Input('input_spikes_prox', input_spikes_prox_width)

    #     # w_init_dist
    #     w_init_dist_width = num_neurons.value*num_seg.value*p_dist.value*wres_dist.value
    #     w_init_dist = m.Input('w_init_dist', num_col.value*w_init_dist_width)

    #     # w_init_prox
    #     w_init_prox_width = num_neurons.value*num_seg.value*p_prox.value*wres_prox.value
    #     w_init_prox = m.Input('w_init_prox', num_col.value*w_init_prox_width)

    #     # capture_brv_dist
    #     capture_brv_dist_width = num_neurons.value*num_seg.value*p_dist.value
    #     capture_brv_dist = m.Input('capture_brv_dist', num_col.value*capture_brv_dist_width)

    #     # capture_brv_prox
    #     capture_brv_prox_width = num_neurons.value*num_seg.value*p_prox.value
    #     capture_brv_prox = m.Input('capture_brv_prox', num_col.value*capture_brv_prox_width)

    #     # minus_brv_dist
    #     minus_brv_dist_width = num_neurons.value*num_seg.value*p_dist.value
    #     minus_brv_dist = m.Input('minus_brv_dist', num_col.value*minus_brv_dist_width)
        
    #     # minus_brv_prox
    #     minus_brv_prox_width = num_neurons.value*num_seg.value*p_prox.value
    #     minus_brv_prox = m.Input('minus_brv_prox', num_col.value*minus_brv_prox_width)
        
    #     # search_brv_dist
    #     search_brv_dist_width = num_neurons.value*num_seg.value*p_dist.value
    #     search_brv_dist = m.Input('search_brv_dist', num_col.value*search_brv_dist_width)
        
    #     # search_brv_prox
    #     search_brv_prox_width = num_neurons.value*num_seg.value*p_prox.value
    #     search_brv_prox = m.Input('search_brv_prox', num_col.value*search_brv_prox_width)
        
    #     # backoff_brv_dist
    #     backoff_brv_dist_width = num_neurons.value*num_seg.value*p_dist.value
    #     backoff_brv_dist = m.Input('backoff_brv_dist', num_col.value*backoff_brv_dist_width)
        
    #     # backoff_brv_prox
    #     backoff_brv_prox_width = num_neurons.value*num_seg.value*p_prox.value
    #     backoff_brv_prox = m.Input('backoff_brv_prox', num_col.value*backoff_brv_prox_width)
        
    #     # min_brv_dist
    #     min_brv_dist_width = num_neurons.value*num_seg.value*p_dist.value
    #     min_brv_dist = m.Input('min_brv_dist', num_col.value*min_brv_dist_width)
        
    #     # min_brv_prox
    #     min_brv_prox_width = num_neurons.value*num_seg.value*p_prox.value
    #     min_brv_prox = m.Input('min_brv_prox', num_col.value*min_brv_prox_width)
        
    #     # F_brv_dist
    #     F_brv_dist_width = num_neurons.value*num_seg.value*((1<<wres_dist.value)-3 + 1)
    #     F_brv_dist = m.Input('F_brv_dist', num_col.value*F_brv_dist_width)
        
    #     # F_brv_prox
    #     F_brv_prox_width = num_neurons.value*num_seg.value*((1<<wres_prox.value)-3 + 1)
    #     F_brv_prox = m.Input('F_brv_prox', num_col.value*F_brv_prox_width)

    #     # Output_spikes
    #     output_spikes = m.Output('layer_out'+'_'+str(c), num_col.value*num_neurons.value)

    #     ##################
    #     # Instantiations #
    #     ##################
    #     tnn_func = TNN_Functions(self.layer_id, tnn7_en=self.tnn7_en)
    #     CV_group, _ = tnn_func.CV_group(num_neurons.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
    #     for c in range(num_col.value):
    #         col_ports = [clk, grst, rstb, 
    #                      output_spikes.slice((c+1)*num_neurons.value-1, c*num_neurons.value),
    #                      input_spikes_dist.slice((c+1)*p_dist.value-1, c*p_dist.value),
    #                      input_spikes_prox]
            
    #         # w_init_dist
    #         col_ports.append(w_init_dist.slice((c+1)*w_init_dist_width-1, c*w_init_dist_width))
    #         # w_init_prox
    #         col_ports.append(w_init_prox.slice((c+1)*w_init_prox_width-1, c*w_init_prox_width))
    #         # capture_brv_dist
    #         col_ports.append(capture_brv_dist.slice((c+1)*capture_brv_dist_width-1, c*capture_brv_dist_width))
    #         # capture_brv_prox
    #         col_ports.append(capture_brv_prox.slice((c+1)*capture_brv_prox_width-1, c*capture_brv_prox_width))
    #         # minus_brv_dist
    #         col_ports.append(minus_brv_dist.slice((c+1)*minus_brv_dist_width-1, c*minus_brv_dist_width))
    #         # minus_brv_prox
    #         col_ports.append(minus_brv_prox.slice((c+1)*minus_brv_prox_width-1, c*minus_brv_prox_width))
    #         # search_brv_dist
    #         col_ports.append(search_brv_dist.slice((c+1)*search_brv_dist_width-1, c*search_brv_dist_width))
    #         # search_brv_prox
    #         col_ports.append(search_brv_prox.slice((c+1)*search_brv_prox_width-1, c*search_brv_prox_width))
    #         # backoff_brv_dist
    #         col_ports.append(backoff_brv_dist.slice((c+1)*backoff_brv_dist_width-1, c*backoff_brv_dist_width))
    #         # backoff_brv_prox
    #         col_ports.append(backoff_brv_prox.slice((c+1)*backoff_brv_prox_width-1, c*backoff_brv_prox_width))
    #         # min_brv_dist
    #         col_ports.append(min_brv_dist.slice((c+1)*min_brv_dist_width-1, c*min_brv_dist_width))
    #         # min_brv_prox
    #         col_ports.append(min_brv_prox.slice((c+1)*min_brv_prox_width-1, c*min_brv_prox_width))
    #         # F_brv_dist
    #         col_ports.append(F_brv_dist.slice((c+1)*F_brv_dist_width-1, c*F_brv_dist_width))
    #         # F_brv_prox
    #         col_ports.append(F_brv_prox.slice((c+1)*F_brv_prox_width-1, c*F_brv_prox_width))

    #         m.Instance(CV_group, 'L'+self.layer_id+'_CV_group_'+str(c), params=[num_neurons.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
    #                    ports = col_ports)
        
    #     return m

    # def TNN_Layer(self, layer_id=None):
    #     m = Module('TNN_Layer_'+str(layer_id))
    #     self.layer_id = str(layer_id)
    #     num_col = m.Parameter('NUM_COL', int(self.num_col))
    #     num_neurons = m.Parameter('NUM_NEURONS', int(self.num_neurons))
    #     num_dend = m.Parameter('NUM_DEND', int(self.num_dend))
    #     p_dist = m.Parameter('P_DIST', int(self.p_dist))
    #     p_prox = m.Parameter('P_PROX', int(self.p_prox))
    #     num_seg = m.Parameter('NUM_SEG', int(self.num_seg))
    #     wres_dist = m.Parameter('WRES_DIST', int(self.wres_dist))
    #     wres_prox = m.Parameter('WRES_PROX', int(self.wres_prox))
    #     threshold = m.Parameter('THRESHOLD', int(self.thres))
    #     in_width = m.Parameter('IN_WIDTH', int(num_col.value*num_neurons.value*p_dist.value))
    #     out_width = m.Parameter('OUT_WIDTH', int(num_col.value*num_neurons.value))
    #     is_clk = m.Parameter('is_clk', 1)

    #     ##################
    #     # Inputs/Outputs #
    #     ##################

    #     clk = m.Input('clk')
    #     grst = m.Input('grst')
    #     rstb = m.Input('rstb')

    #     input_spikes_dist, input_spikes_prox = [], []
    #     output_spikes = []
    #     w_init_dist, capture_brv_dist, minus_brv_dist, search_brv_dist, backoff_brv_dist, min_brv_dist, F_brv_dist = [], [], [], [], [], [], []
    #     w_init_prox, capture_brv_prox, minus_brv_prox, search_brv_prox, backoff_brv_prox, min_brv_prox, F_brv_prox = [], [], [], [], [], [], []

    #     # input_spikes_dist
    #     #for c in range(num_col.value):
    #     #    for n in range(num_neurons.value):
    #     #        input_spikes_dist.append(m.Input('input_spikes_dist_'+str(c)+'_'+str(n), p_dist.value))
    #     input_spikes_dist = m.Input('layer_in', num_col.value*num_neurons.value*p_dist.value)

    #     # input_spikes_prox
    #     for i in range(num_dend.value):
    #         input_spikes_prox.append(m.Input('input_spikes_prox_'+str(i), p_prox.value))

    #     # w_init_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value):
    #                     for k in range(p_dist.value):
    #                         w_init_dist.append(m.Input('w_init_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j)+str(k), wres_dist.value))

    #     # w_init_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value):
    #                     for k in range(p_prox.value):
    #                         w_init_prox.append(m.Input('w_init_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j)+str(k), wres_prox.value))

    #     # capture_brv_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value):
    #                     capture_brv_dist.append(m.Input('capture_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))

    #     # capture_brv_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value):
    #                     capture_brv_prox.append(m.Input('capture_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
    #     # minus_brv_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value):
    #                     minus_brv_dist.append(m.Input('minus_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
    #     # minus_brv_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value):       
    #                     minus_brv_prox.append(m.Input('minus_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
    #     # search_brv_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     search_brv_dist.append(m.Input('search_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
    #     # search_brv_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     search_brv_prox.append(m.Input('search_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
    #     # backoff_brv_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     backoff_brv_dist.append(m.Input('backoff_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
    #     # backoff_brv_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     backoff_brv_prox.append(m.Input('backoff_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
    #     # min_brv_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     min_brv_dist.append(m.Input('min_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_dist.value))
        
    #     # min_brv_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     min_brv_prox.append(m.Input('min_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), p_prox.value))
        
    #     # F_brv_dist
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     F_brv_dist.append(m.Input('F_brv_dist_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), (1<<wres_dist.value)-3 + 1))
        
    #     # F_brv_prox
    #     for c in range(num_col.value):
    #         for n in range(num_neurons.value):
    #             for i in range(num_dend.value):
    #                 for j in range(num_seg.value): 
    #                     F_brv_prox.append(m.Input('F_brv_prox_'+str(c)+'_'+str(n)+'_'+str(i)+str(j), (1<<wres_prox.value)-3 + 1))

    #     # Output_spikes
    #     #for i in range(num_col.value*num_neurons.value):
    #     #    output_spikes.append(m.Output('layer_out_spikes'))
    #     #for c in range(num_col.value):
    #     #    output_spikes.append(m.Output('output_spikes'+'_'+str(c), num_neurons.value))
    #     output_spikes = m.Output('layer_out', num_col.value*num_neurons.value)

    #     ##################
    #     # Instantiations #
    #     ##################
    #     tnn_func = TNN_Functions(self.layer_id, tnn7_en=self.tnn7_en)

    #     comp_col, _ = tnn_func.Comp_column(num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value)
    #     for c in range(num_col.value):
    #         col_ports = [clk, grst, rstb, 
    #                      output_spikes.slice((c+1)*num_neurons.value-1, c*num_neurons.value)]
    #         # input_spikes_dist
    #         for n in range(num_neurons.value):
    #             col_ports.append(input_spikes_dist.slice(((n+1)*p_dist.value)+(c*num_neurons.value*p_dist.value)-1, (n*p_dist.value)+(c*num_neurons.value*p_dist.value)))
            
    #         # input_spikes_prox
    #         for d in range(num_dend.value):
    #             col_ports.append(input_spikes_prox[d])
    #         # w_init_dist
    #         col_ports = tnn_func.append_port4(col_ports, w_init_dist, c, num_neurons.value, num_dend.value, num_seg.value, p_dist.value)
    #         # w_init_prox
    #         col_ports = tnn_func.append_port4(col_ports, w_init_prox, c, num_neurons.value, num_dend.value, num_seg.value, p_prox.value)
    #         # capture_brv_dist
    #         col_ports = tnn_func.append_port3(col_ports, capture_brv_dist, c, num_neurons.value, num_dend.value, num_seg.value)
    #         # capture_brv_prox
    #         col_ports = tnn_func.append_port3(col_ports, capture_brv_prox, c, num_neurons.value, num_dend.value, num_seg.value)
    #         # minus_brv_dist
    #         col_ports = tnn_func.append_port3(col_ports, minus_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # minus_brv_prox
    #         col_ports = tnn_func.append_port3(col_ports, minus_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # search_brv_dist
    #         col_ports = tnn_func.append_port3(col_ports, search_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # search_brv_prox
    #         col_ports = tnn_func.append_port3(col_ports, search_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # backoff_brv_dist
    #         col_ports = tnn_func.append_port3(col_ports, backoff_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # backoff_brv_prox
    #         col_ports = tnn_func.append_port3(col_ports, backoff_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # min_brv_dist
    #         col_ports = tnn_func.append_port3(col_ports, min_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # min_brv_prox
    #         col_ports = tnn_func.append_port3(col_ports, min_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # F_brv_dist
    #         col_ports = tnn_func.append_port3(col_ports, F_brv_dist, c, num_neurons.value,  num_dend.value, num_seg.value)
    #         # F_brv_prox
    #         col_ports = tnn_func.append_port3(col_ports, F_brv_prox, c, num_neurons.value,  num_dend.value, num_seg.value)

    #         m.Instance(comp_col, 'L'+str(self.layer_id)+'_comp_col_inst_'+str(c), params=[num_neurons.value, num_dend.value, p_dist.value, p_prox.value, num_seg.value, wres_dist.value, wres_prox.value, threshold.value],
    #                    ports = col_ports)
        
    #     return m