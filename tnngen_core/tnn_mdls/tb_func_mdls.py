# Original Author: Prabhu Vellaisamy
#
# Migrated to separate file <YoungSeok Na>
#
# Additional Testbenches <Wei-Che Huang>
#
# Testbench class

from tnn_mdls.func_mdls import *
from tnn_mdls.sim_utils import *

class Test_TNN_Functions(TNN_Functions):

    tnn = TNN_Functions()
    tnn.layer_id = str(0)

    #############################################
    # less_equal
    #############################################
    def Tb_Less_equal(self):

        m = Module('test_less_equal')
        lq, lq_clk = self.tnn.Less_equal()

        dut = Submodule(m, lq, name='dut')

        data_in = dut['data_in']
        inhibit_in = dut['inhibit_in']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        out = dut['out']
        tres = 3
        wres = 3

        dump = simulation.setup_waveform(
            m, dut, [data_in, inhibit_in, clk, grst, rstb, out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0], # data_in
                  [1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0]] # inhibit_in
        delays = [5, 1, 5, 11, 5, 3, 5, 9, 5, 3, 5, 9, 5, 8, 9, 10, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # pulse2edge
    #############################################
    def Tb_Pulse2edge(self):
        m = Module('test_pulse2edge')
    
        pulse, pulse_clk = self.tnn.Pulse2edge()
    
        dut = Submodule(m, pulse, 'dut')
    
        pulse_in = dut['pulse_in']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        edge_out = dut['edge_out']
        tres = 3
        wres = 3
    
        dump = simulation.setup_waveform(m, dut, [pulse_in, clk, grst, rstb, edge_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 1, 0, 1, 0, 1, 1, 0]] # pulse_in
        delays = [5, 1, 5, 1, 22, 8, 10, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # adder
    #############################################
    def Tb_Adder(self, RES=4):
        m = Module('test_adder')
    
        res = m.Parameter('RES', 3)
    
        adder, add_clk = self.tnn.Adder(res.value)
    
        dut = Submodule(m, adder, 'dut')
    
        out = dut['out']
        a = dut['a']
        b = dut['b']
        cin = dut['cin']
    
        dump = simulation.setup_waveform(m, dut, [a, b, cin, out])

        # Hard coded for now
        inputs = [[0, 3, 0, 3, 2, 5, 0], # a
                  [0, 0, 5, 5, 4, 4, 0], # b
                  [0, 0, 0, 0, 1, 1, 0]] # cin
        delays = [4, 4, 4, 4, 4, 4, 100]

        add_to_dump(dump, dut, inputs, delays)
    
        return m

    #############################################
    # edge2pulse
    #############################################
    def Tb_Edge2pulse(self):
        m = Module('test_edge2pulse')

        edge, edge_clk = self.tnn.Edge2pulse()

        dut = Submodule(m, edge, 'dut')

        edge_in = dut['edge_in']
        clk = dut['clk']
        pulse_out = dut['pulse_out']

        dump = simulation.setup_waveform(m, dut, [edge_in, clk, pulse_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Hard coded for now
        inputs = [[0, 1, 0, 1, 0, 1, 0]] # edge_in
        delays = [5, 5, 8, 8, 2, 4, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # incdec
    #############################################
    def Tb_Incdec(self):
        m = Module('test_incdec')

        incdec, inc_clk = self.tnn.Incdec()

        dut = Submodule(m, incdec, 'dut')

        cases = dut['stdp_cases']
        capture = dut['capture_brv']
        minus = dut['minus_brv']
        search = dut['search_brv']
        backoff = dut['backoff_brv']
        min_v = dut['min_brv']
        fout = dut['fout_brv']
        inc = dut['inc']
        dec = dut['dec']

        dump = simulation.setup_waveform(
            m, dut, [cases, capture, minus, search, backoff, min_v, fout, inc, dec])
        
        inputs = [[0, 1, 0, 2, 0, 4, 0, 8, 0], # cases
                  [0, 1, 1, 1, 1, 1, 1, 1, 1], # capture
                  [0, 1, 1, 1, 1, 1, 1, 1, 1], # minus
                  [0, 1, 1, 1, 1, 1, 1, 1, 1], # search
                  [0, 1, 1, 1, 1, 1, 1, 1, 1], # backoff
                  [0, 1, 1, 1, 1, 1, 1, 1, 1], # min_v
                  [0, 1, 1, 1, 1, 1, 1, 1, 1]] # fout
        delays = [5, 5, 5, 5, 5, 5, 5, 5, 20]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # wta
    #############################################
    def Tb_Wta(self, Q=4):
        self.tnn.layer_id = str(0)

        m = Module('test_wta')

        q = m.Parameter('Q', 4)
        wta, wta_clk = self.tnn.Wta(q.value)

        dut = Submodule(m, wta, 'dut')

        ec_spikes = dut['ec_spikes']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        li_out = dut['li_out']
        tres = 3
        wres = 3
    
        dump = simulation.setup_waveform(m, dut, [ec_spikes, clk, grst, rstb, li_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[int('0000', 2), int('0110', 2), int('1110', 2), int('1111', 2), 
                   int('1001', 2), int('0001', 2), int('0000', 2), int('1111', 2),
                   int('0000', 2), int('1100', 2), int('1110', 2), int('1111', 2), 
                   int('0011', 2), int('0001', 2), int('0000', 2), int('0000', 2)]] # ec_spikes
        delays = [5, 1, 5, 2, 1, 5, 9, 8, 15, 1, 5, 6, 1, 5, 10, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # t_wta - TODO
    #############################################
    def Tb_T_wta(self, Q=4):
        self.tnn.layer_id = str(0)

        m = Module('test_t_wta')

        q = m.Parameter('Q', Q)
        wta, wta_clk = self.tnn.Wta(q.value)

        dut = Submodule(m, wta, 'dut')

        ec_spikes = dut['ec_spikes']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        li_out = dut['li_out']
        tres = 3
        wres = 3

        dump = simulation.setup_waveform(m, dut, [ec_spikes, clk, grst, rstb, li_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[int('0000', 2), int('0110', 2), int('1110', 2), int('1111', 2), 
                   int('1001', 2), int('0001', 2), int('0000', 2), int('1111', 2),
                   int('0000', 2), int('1100', 2), int('1110', 2), int('1111', 2), 
                   int('0011', 2), int('0001', 2), int('0000', 2), int('0000', 2)]] # ec_spikes
        delays = [5, 1, 5, 2, 1, 5, 9, 8, 15, 1, 5, 6, 1, 5, 10, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # stabilize - previously: flogic
    #############################################
    def Tb_Flogic(self, wres = 3):
        self.tnn.layer_id = str(0)

        m = Module('test_stabilize')
        flogic, flogic_clk = self.tnn.Stabilize_func(wres)

        dut = Submodule(m, flogic, 'dut')

        weight = dut['weight']
        F_brv = dut['F_brv']
        out = dut['out']

        dump = simulation.setup_waveform(m, dut, [weight, F_brv, out])

        # Hard coded for now
        inputs = [[0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7], # weight
                  [0,
                   int('111111', 2), int('111111', 2), int('011111', 2),
                   int('111111', 2), int('101111', 2), int('111111', 2), 
                   int('110111', 2), int('110111', 2), int('111011', 2), 
                   int('111011', 2), int('111101', 2), int('111101', 2),
                   int('111110', 2), int('111110', 2),
                   0]] # F_brv
        delays = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # stdp_case_gen
    #############################################
    def Tb_Stdp_case_gen(self):

        m = Module('test_stdp_case_gen')
        stdp_case, case_clk = self.tnn.Stdp_case_gen()

        dut = Submodule(m, stdp_case, 'dut')

        ein = dut['ein']
        eout = dut['eout']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        stdp_cases = dut['stdp_cases']
        tres = 3
        wres = 3

        dump = simulation.setup_waveform(m, dut, [ein, eout, clk, grst, rstb, stdp_cases])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0], # ein
                  [0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]] # eout
        delays = [5, 2, 16, 5, 2, 16, 5, 18, 16, 7, 5, 2, 6, 9, 10, 100]


        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # fsm_convert
    #############################################
    def Tb_Fsm_convert(self, wres = 3):
        self.tnn.layer_id = str(0)

        m = Module('test_fsm_convert')
        fsm_convert, simple_clk = self.tnn.Fsm_convert(wres)
        dut = Submodule(m, fsm_convert, 'dut')

        in_v = dut['in']
        clk = dut['clk']
        rstb = dut['rstb']
        out_v = dut['out']

        dump = simulation.setup_waveform(m, dut, [in_v, clk, rstb, out_v])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        rstb_gen(dump, rstb, 5)

        # Hard coded for now
        inputs = [[0, 1, 0, 1, 0, 0]] # in_v
        delays = [5, 1, 12, 5, 3, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # fsm_synapse - TODO: fix
    #############################################
    def Tb_Fsm_synapse(self, wres = 3):
        self.tnn.layer_id = str(0)

        m = Module('test_fsm_synapse')
        synapse, synapse_clk= self.tnn.Fsm_synapse(wres)
        dut = Submodule(m, synapse, 'dut')

        input_spike = dut['input_spike']
        w_init = dut['w_init']
        inc = dut['inc']
        dec = dut['dec']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        w_out = dut['w_out']
        syn_out = dut['syn_out']
        tres = 3
        wres = 3

        dump = simulation.setup_waveform(m, dut,
            [input_spike, w_init, inc, dec, clk, grst, rstb, w_out, syn_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(w_init(0))

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 1, 0,  1, 0, 0, 1, 0,  0, 1, 0,  0, 1, 0,  0], # input_spike
                  [0, 0, 0,  0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0,  0], # w_init
                  [0, 1, 1,  1, 1, 1, 1, 1,  0, 0, 0,  0, 0, 0,  0], # inc
                  [0, 0, 0,  0, 0, 0, 0, 0,  1, 1, 1,  1, 1, 1,  0]] # dec
        delays = [2, 3, 15,  4, 9, 1, 2, 13, 1, 5, 10, 1, 3, 12, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # stdp
    #############################################
    def Tb_Stdp(self, wres = 3):
        self.tnn.layer_id = str(0)

        m = Module('test_stdp')
        stdp, stdp_clk = self.tnn.Stdp(wres)
        dut = Submodule(m, stdp, 'dut')

        input_weight = dut['weight_in']
        ein = dut['ein']
        eout = dut['eout']
        capture = dut['capture_brv']
        minus = dut['minus_brv']
        search = dut['search_brv']
        backoff = dut['backoff_brv']
        min_v = dut['min_brv']
        F = dut['F_brv']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        inc = dut['inc']
        dec = dut['dec']
        tres = 3
        wres = 3

        dump = simulation.setup_waveform(m, dut,
           [input_weight, ein, eout, capture, minus, search, backoff, min_v, F, clk, grst, rstb, inc, dec])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        input_init = [[5],[0],[0],[1],[1],[1],[1],[1],[int('111111', 2)]]
        delay_init = [5]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 5)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[5, 5, 5, 5, 5, 5,  5, 5,  5,  5, 5, 5, 5, 5,  5, 5, 5,  5, 5, 5,  5, 5, 5,  5, 5, 5, 5, 5, 5, 5], # weight_in
                  [0, 1, 1, 0, 0, 1,  0, 1,  0,  0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 1,  0, 1, 0,  0, 0, 0, 0, 0, 0, 0], # ein
                  [0, 0, 1, 0, 1, 1,  0, 0,  0,  1, 0, 0, 0, 0,  0, 0, 1,  0, 1, 1,  0, 0, 0,  1, 0, 0, 0, 0, 0, 0], # eout
                  [1, 1, 1, 1, 1, 1,  1, 1,  1,  1, 1, 1, 1, 1,  1, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0], # capture_brv
                  [1, 1, 1, 1, 1, 1,  1, 1,  1,  1, 1, 1, 1, 1,  1, 1, 1,  1, 1, 1,  1, 1, 1,  1, 1, 1, 1, 1, 1, 1], # minus_brv
                  [1, 1, 1, 1, 1, 1,  1, 1,  1,  1, 1, 1, 1, 1,  1, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0], # search_brv
                  [1, 1, 1, 1, 1, 1,  1, 1,  1,  1, 1, 1, 1, 1,  1, 1, 1,  1, 1, 1,  1, 1, 1,  1, 1, 1, 1, 1, 1, 1], # backoff_brv
                  [1, 1, 1, 1, 1, 1,  1, 1,  1,  1, 1, 1, 1, 1,  1, 1, 1,  0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0], # min_brv
                  [63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
                   61, 61, 61, 63, 63, 63, 63, 63, 63, 63, 63, 63]] # F_brv
        delays = [5, 2, 16, 5, 2, 16, 5, 18, 16, 7, 5, 2, 6, 10, 5, 2, 16, 5, 2, 16, 5, 18, 16, 7, 5, 2, 6, 9, 10, 10]

        add_to_dump(dump, dut, inputs, delays)
    
        return m

    #############################################
    # pac
    #############################################
    def Tb_Pac(self, ip_size=4, thres=13):
        self.tnn.layer_id = str(0)

        m = Module('test_pac')
        # ip_size = m.Parameter('IP_SIZE', ip_size)
        # thres = m.Parameter('THRESHOLD', thres)
        ip_size = m.Parameter('IP_SIZE', 4)
        thres = m.Parameter('THRESHOLD', 13)

        pac, pac_clk = self.tnn.Pac(ip_size=ip_size.value, thres=thres.value)
        dut = Submodule(m, pac, 'dut')

        in_v = dut['in']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        out_v = dut['pac_out']
        tres = 3
        wres = 3

        dump = simulation.setup_waveform(m, dut, [in_v, clk, grst, rstb, out_v])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        input_init = [[0]]
        delay_init = [5]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 4)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[int('0001', 2), int('1001', 2), int('1000', 2), int('1100', 2), int('1000', 2), int('0000', 2), int('0000', 2), int('0000', 2)]] # in_v
        delays = [3, 2, 2, 2, 2, 3, 20, 100]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # neuron_body
    #############################################
    def Tb_Neuronbody(self, ip_size=4, thres=13, wres = 3):

        m = Module('test_neuron_body')

        # parameters
        tres = 3
        wres = 3
        ip_size = m.Parameter('IP_SIZE', 4)
        thres = m.Parameter('THRESHOLD', 6)
        wres_v = m.Parameter('WRES', wres)

        nb, bdy_clk = self.tnn.Neuronbody(ip_size=ip_size.value, thres=thres.value, wres=wres_v.value)
        dut = Submodule(m, nb, 'dut')

        # Setup waveform dump and simulation environment
        dump, clk, grst, rstb = init_dump(dut, m)

        input_init = [[0]]
        delay_init = [5]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 4)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 0, int('0001', 2), int('1001', 2), int('1000', 2), int('1100', 2), int('0100', 2), int('0000', 2), 0, 0, 0]] # acc_in
        delays = [32, 1, 1, 4, 2, 1, 1, 20, 20, 20, 200]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # segment - TODO
    #############################################
    def Tb_Segment(self, ip_size_dist=16, ip_size_prox=1, wres_dist=3, wres_prox=3, thres=13):

        m = Module('test_segment')

        # parameters
        tres = 3
        wres = 3
        ip_size_dist = m.Parameter('INP_DIST', 4)
        ip_size_prox = m.Parameter('INP_PROX', 1)
        wres_dist = m.Parameter('WRES_DIST', 3)
        wres_prox = m.Parameter('WRES_PROX', 3)
        thres = m.Parameter('THRESHOLD', 4)

        # Instantiate the segment module
        segment_mod, segment_clk = self.tnn.segment(ip_size_dist=ip_size_dist, ip_size_prox=ip_size_prox, wres_dist=wres_dist, wres_prox=wres_prox, thres=thres)
        dut = Submodule(m, segment_mod, 'dut')
        
        # Setup waveform dump and simulation environment
        dump, clk, grst, rstb = init_dump(dut, m)

        input_init = [[0], # input_spikes_dist
                      [1], # input_spikes_prox
                      [0], # inc_dist
                      [0], # inc_prox
                      [0], # dec_dist
                      [0], # dec_prox
                      [0], # w_init_dist
                      [0]] # w_init_prox
        delay_init = [0]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 8)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # input_spikes_dist
                  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], # input_spikes_prox
                  [0, 1, 1, 1, 3, 0, 2, 0, 0, 0, 0], # inc_dist
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # inc_prox
                  [0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], # dec_dist
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # dec_prox
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # w_init_dist
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]] # w_init_prox
        delays = [0, 16, 1, 8, 8, 8, 8, 8, 8, 8, 8]

        add_to_dump(dump, dut, inputs, delays)

        return m

    #############################################
    # Dendrite - TODO
    #############################################
    def Tb_Dendrite(self, ip_size_dist=16, ip_size_prox=1, wres_dist=3, wres_prox=3, thres=13):
        self.tnn.layer_id = str(0)

        m = Module('test_segment')

        # parameters
        ip_size_dist = m.Parameter('INP_DIST', 4)
        ip_size_prox = m.Parameter('INP_PROX', 1)
        wres_dist = m.Parameter('WRES_DIST', 3)
        wres_prox = m.Parameter('WRES_PROX', 3)
        thres = m.Parameter('THRESHOLD', 4)

        # Instantiate the segment module
        segment_mod, segment_clk = self.tnn.segment(ip_size_dist=ip_size_dist, ip_size_prox=ip_size_prox, wres_dist=wres_dist, wres_prox=wres_prox, thres=thres)
        dut = Submodule(m, segment_mod, 'dut')

        # Connect simulation ports
        #here = m.copy_sim_ports(segment_mod)
        
        input_spikes_dist = dut['input_spikes_dist']
        input_spikes_prox = dut['input_spikes_prox']
        inc_dist = dut['inc_dist']
        inc_prox = dut['inc_prox']
        dec_dist = dut['dec_dist']
        dec_prox = dut['dec_prox']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        output_spike = dut['output_spike']
        w_init_dist = dut['w_init_dist']
        w_init_prox = dut['w_init_prox']
        weights_dist = [dut['weights_dist_'+str(i)] for i in range(ip_size_dist.value)]
        weights_prox = [dut['weights_prox_'+str(i)] for i in range(ip_size_prox.value)]
        tres = 3
        wres = 3

        #dut = m.Instance(segment_mod, 'dut', ports=m.connect_ports(segment_mod))

        # Setup waveform dump and simulation environment
        #dump = simulation.setup_waveform(m, dut, ports=m.connect_ports(segment_mod))
        dump = simulation.setup_waveform(m, dut, [input_spikes_dist, input_spikes_prox, inc_dist, inc_prox, dec_dist, dec_prox, clk, grst, rstb, output_spike, w_init_dist, w_init_prox] + weights_dist + weights_prox)
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        input_init = [[0], # input_spikes_dist
                      [1], # input_spikes_prox
                      [0], # inc_dist
                      [0], # inc_prox
                      [0], # dec_dist
                      [0], # dec_prox
                      [0], # w_init_dist
                      [0]] # w_init_prox
        delay_init = [0]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 8)
        grst_gen(m, ((2**tres)+(2**wres)))

        # Hard coded for now
        inputs = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # input_spikes_dist
                  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], # input_spikes_prox
                  [0, 1, 1, 1, 3, 0, 2, 0, 0, 0, 0], # inc_dist
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # inc_prox
                  [0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], # dec_dist
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # dec_prox
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # w_init_dist
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]] # w_init_prox
        delays = [0, 16, 1, 8, 8, 8, 8, 8, 8, 8, 8]

        add_to_dump(dump, dut, inputs, delays)

        return m