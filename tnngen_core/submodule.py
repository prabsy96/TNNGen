# Submodule invocation

from tnn_mdls.func_mdls import *
from tnn_mdls.tb_func_mdls import *

class TNN_Submod():
    def __init__(self, args):
        self.f = TNN_Functions()
        self.tb_f = Test_TNN_Functions()
        self.args = args

    def _param_query(self, name, def_v):
        res = def_v
        try:
            res = int(self.args[name])
        except IndexError:
            print(f'Parameter {name} not provided. Using its default value {def_v}...')
        return res

    def sm_rtl(self, name):
        if name == 'less_equal':
            obj, clk_name = self.f.Less_equal()
        elif name == 'pulse2edge':
            obj, clk_name = self.f.Pulse2edge()
        elif name == 'edge2pulse':
            obj, clk_name = self.f.Edge2pulse()
        elif name == 'adder':
            obj, clk_name = self.f.Adder()
        elif name == 'incdec':
            obj, clk_name = self.f.Incdec()
        elif name == 'wta':
            obj, clk_name = self.f.Wta()
        elif name == 't_wta':
            obj, clk_name = self.f.t_wta()
        elif name == 'stabilize':
            obj, clk_name = self.f.Stabilize_func()
        elif name == 'stdp_casegen':
            obj, clk_name = self.f.Stdp_case_gen()
        elif name == 'fsm_convert':
            obj, clk_name = self.f.Fsm_convert()
        elif name == 'fsm_synapse':
            obj, clk_name = self.f.Fsm_synapse()
        elif name == 'stdp':
            obj, clk_name = self.f.Stdp()
        elif name == 'pac':
            obj, clk_name = self.f.Pac()
        elif name == 'neuron_body':
            obj, clk_name = self.f.Neuronbody()
        elif name == 'neuron_rnl':
            obj, clk_name = self.f.NeuronRNL()
        elif name == 'segment':
            obj, clk_name = self.f.segment()
        return obj, clk_name

    def sm_testbench(self, name):
        if name == 'less_equal':
            obj = self.tb_f.Tb_Less_equal()
        elif name == 'pulse2edge':
            obj = self.tb_f.Tb_Pulse2edge()
        elif name == 'edge2pulse':
            obj = self.tb_f.Tb_Edge2pulse()
        elif name == 'adder':
            obj = self.tb_f.Tb_Adder()
        elif name == 'incdec':
            obj = self.tb_f.Tb_Incdec()
        elif name == 'wta':
            q = self._param_query('rfsize', 4)
            obj = self.tb_f.Tb_Wta(q)
        elif name == 't_wta':
            obj = self.tb_f.Tb_T_wta()
        elif name == 'stabilize':
            wres = self._param_query('wres', 3)
            obj = self.tb_f.Tb_Flogic(wres)
        elif name == 'stdp_casegen':
            obj = self.tb_f.Tb_Stdp_case_gen()
        elif name == 'fsm_convert':
            wres = self._param_query('wres', 3)
            obj = self.tb_f.Tb_Fsm_convert(wres)
        elif name == 'fsm_synapse':
            wres = self._param_query('wres', 3)
            obj = self.tb_f.Tb_Fsm_synapse(wres)
        elif name == 'stdp':
            wres = self._param_query('wres', 3)
            obj = self.tb_f.Tb_Stdp(wres)
        elif name == 'pac':
            neurons = self._param_query('neurons', 4)
            theta = self._param_query('theta', 13)
            obj = self.tb_f.Tb_Pac(ip_size=neurons, thres=theta)
        elif name == 'neuron_body':
            neurons = self._param_query('neurons', 4)
            theta = self._param_query('theta', 13)
            wres = self._param_query('wres', 3)
            obj = self.tb_f.Tb_Neuronbody(ip_size=neurons, thres=theta, wres=wres)
        elif name == 'neuron_rnl':
            neurons = self._param_query('neurons', 4)
            theta = self._param_query('theta', 13)
            wres = self._param_query('wres', 3)
            obj = self.tb_f.Tb_NeuronRNL(ip_size=neurons, thres=theta, wres=wres)
        elif name == 'segment':
            ip_size_dist = self._param_query('ip_size_dist', 16)
            ip_size_prox = self._param_query('ip_size_prox', 1)
            wres_dist = self._param_query('wres_dist', 3)
            wres_prox = self._param_query('wres_prox', 3)
            thres = self._param_query('threshold', 13)
            obj = self.tb_f.Tb_Segment(ip_size_dist=ip_size_dist, ip_size_prox=ip_size_prox, wres_dist=wres_dist, wres_prox=wres_prox, thres=thres)
        else:
            raise ValueError(f"Unknown testbench name: {name}")
        return obj

