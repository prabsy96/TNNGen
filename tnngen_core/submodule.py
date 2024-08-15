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
        elif name == 'stabilize_func':
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
            obj = self.tb_f.Tb_Wta()
        elif name == 't_wta':
            obj = self.tb_f.Tb_T_wta()
        elif name == 'stabilize_func':
            obj = self.tb_f.Tb_Flogic()
        elif name == 'stdp_casegen':
            obj = self.tb_f.Tb_Stdp_case_gen()
        elif name == 'fsm_convert':
            obj = self.tb_f.Tb_Fsm_convert()
        elif name == 'fsm_synapse':
            obj = self.tb_f.Tb_Fsm_synapse()
        elif name == 'stdp':
            obj = self.tb_f.Tb_Stdp()
        elif name == 'pac':
            obj = self.tb_f.Tb_Pac()
        elif name == 'neuron_body':
            obj = self.tb_f.Tb_Neuronbody()
        elif name == 'neuron_rnl':
            #obj = self.tb_f.Tb_NeuronRNL()
            pass
        elif name == 'segment':
            obj = self.tb_f.Tb_Segment()
        else:
            raise ValueError(f"Unknown testbench name: {name}")
        return obj

