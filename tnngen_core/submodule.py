# Submodule invocation

from tnn_mdls.func_mdls import *
from tnn_mdls.tb_func_mdls import *

class TNN_Submod():
    def __init__(self):
        self.f = TNN_Functions()
        self.tb_f = Test_TNN_Functions()

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
            obj = self.tb_f.Tb_Wta()
        elif name == 't_wta':
            obj = self.tb_f.Tb_T_wta()
        elif name == 'stabilize':
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
            obj = self.tb_f.Tb_NeuronRNL()
        elif name == 'segment':
            raise Exception
        return obj

"""
    def sm_invoke(self, name, tb):
        if name == 'less_equal':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Less_equal(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Less_equal()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Less_equal()
                else:
                    obj, clk_name = f.Less_equal(default)

        elif name == 'pulse2edge':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Pulse2edge(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Pulse2edge()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Pulse2edge()
            else:
                obj, clk_name = f.Pulse2edge(default)

        elif name == 'edge2pulse':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Edge2pulse(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Edge2pulse()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Edge2pulse()
            else:
                obj, clk_name = f.Edge2pulse(default)

        elif name == 'adder':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Adder(defaut)
            elif flow == 'sim':
                obj = tb_f.Tb_Adder()
            elif flow == 'rtl':
                if tb == 'yes':
                    obj = tb_f.Tb_Adder()
            else:
                obj, clk_name = f.Adder(default)

        elif name == 'incdec':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Incdec(default)
            elif flow == 'sim':
                obj = tb_f.Tb_Incdec()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Incdec()
            else:
                obj, clk_name = f.Incdec(default)

        elif name == 'wta':
            for i in args:
                if i == 'rfsize':
                    q = int(args[i])
                    console.print("[bold blue]  -> Selected # output neurons: "+str(q))

                if flow == 'syn' or flow == 'pnr':
                    obj, clk_name = f.Wta(q)
                elif flow == 'sim':
                    obj = tb_f.Tb_Wta(q)
                else:
                    if tb == 'yes':
                        obj = tb_f.Tb_Wta(q)
                    else:
                        obj, clk_name = f.Wta(q)

        elif name == 'flogic':
            for i in args:
                if i == 'wres':
                    wres = int(args[i])

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Flogic(default, wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Flogic()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Flogic()
                else:
                    obj, clk_name = f.Flogic(default, wres)

    else:
        elif name == 'stdp_case_gen':
            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Stdp_case_gen()
            elif flow == 'sim':
                obj = tb_f.Tb_Stdp_case_gen()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Stdp_case_gen()
                else:
                    obj, clk_name = f.Stdp_case_gen()

        elif name == 'fsm_convert':
            for i in args:
                if i == 'wres':
                    wres = int(args[i])

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Fsm_convert(default,wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Fsm_simple()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Fsm_simple()
                else:
                    obj, clk_name = f.Fsm_convert(default, wres)

        elif name == 'fsm_synapse':
            for i in args:
                if i == 'wres':
                wres = int(args[i])

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Fsm_synapse(default, wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Fsm_synapse()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Fsm_synapse()
                else:
                    obj, clk_name = f.Fsm_synapse(default, wres)

        elif name == 'stdp':
            for i in args:
                if i == 'wres':
                    wres = int(args[i])

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Stdp(default, wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Stdp()
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Stdp()
                else:
                    obj, clk_name = f.Stdp(default, wres)

        elif name == 'pac':
            for i in args:
                if i == 'neurons':
                    p = int(args[i])
                    console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
                elif i == 'theta':
                    theta = int(args[i])
                    console.print("[bold blue]  -> Selected threshold value: "+str(theta))

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(theta, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Pac(ip_size = p, thres = theta)
            elif flow == 'sim':
                obj = tb_f.Tb_Pac(ip_size = p, thres = theta)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Pac(ip_size = p, thres = theta)
                else:
                    obj, clk_name = f.Pac(ip_size = p, thres = theta)

        elif name == 'neuron_body':			
            for i in args:
                if i == 'neurons':
                    p = int(args[i])
                    console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
                elif i == 'theta':
                    theta = int(args[i])
                    console.print("[bold blue]  -> Selected threshold value: "+str(theta))
                elif i == 'wres':
                    wres = int(args[i])

            if not isinstance(p, int):
                raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

            if not isinstance(theta, int):
                raise TypeError('Invalid type for threshold value; provide in %d format')

            if not isinstance(wres, int):
                raise TypeError('Invalid type for wres value; provide in %d format')

            if flow == 'syn' or flow == 'pnr':
                obj, clk_name = f.Neuronbody(ip_size = p, thres = theta, wres = wres)
            elif flow == 'sim':
                obj = tb_f.Tb_Neuronbody(ip_size = p, thres = theta)
            else:
                if tb == 'yes':
                    obj = tb_f.Tb_Neuronbody(ip_size = p, thres = theta)
                else:
                    obj, clk_name = f.Neuronbody(ip_size = p, thres = theta, wres = wres)

    elif name == 'neuron_rnl_ptt':
        for i in args:
            if i == 'neurons':
                p = int(args[i])
                console.print("[bold blue]  -> Selected # synapse per neuron: "+str(p))
            elif i == 'theta':
                theta = int(args[i])
                console.print("[bold blue]  -> Selected threshold value: "+str(theta))
            elif i == 'wres':
                wres = int(args[i])

        if not isinstance(p, int):
            raise TypeError('Invalid type for synapse per neuron count; provide in %d format')

        if not isinstance(theta, int):
            raise TypeError('Invalid type for threshold value; provide in %d format')

        if not isinstance(wres, int):
            raise TypeError('Invalid type for wres value; provide in %d format')

        if flow == 'syn' or flow == 'pnr':
            obj, clk_name = f.NeuronRNL(ip_size = p, thres = theta, wres = wres)
        elif flow == 'sim':
            obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = theta)
        else:
            if tb == 'yes':
                obj = tb_f.Tb_NeuronRNL(ip_size = p, thres = theta)
            else:
                obj, clk_name = f.NeuronRNL(ip_size = p, thres = theta, wres = wres)

"""
