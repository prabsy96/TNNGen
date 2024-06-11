# Original Author: Prabhu Vellaisamy
#
# Migrated to separate file <YoungSeok Na>
#
# Additional Testbenches <Yuyang Kang>
#
# Testbench class

from tnn_mdls.func_mdls import *
from tnn_mdls.sim_utils import *

class Test_TNN_Functions(TNN_Functions):

    tnn = TNN_Functions()

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
        grst_gen(m, ((tres**2)+(wres**2)))

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
        grst_gen(m, ((tres**2)+(wres**2)))

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
        grst_gen(m, ((tres**2)+(wres**2)))

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
        grst_gen(m, ((tres**2)+(wres**2)))

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

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [ein, eout, clk, grst, rstb, stdp_cases])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            ein(0),
            eout(0),
            Delay(5),

            ein(1),
            Delay(2),

            eout(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            eout(1),
            Delay(2),

            ein(1),
            Delay(16),
    
            ein(0),
            eout(0),
    
            Delay(5),
            ein(1),
    
            Delay(18),
            ein(0),
    
            Delay(16),
            eout(1),
    
            Delay(7),
            eout(0),
    
            Delay(5),
            ein(0),
    
            Delay(2),
            eout(0),
    
            Delay(6),
            ein(0),
    
            Delay(9),
            eout(0),
    
            Delay(10),
            ein(0),
            eout(0),
    
            Delay(10),
    
            Delay(100),
    
            simulation.finish()
        )
    
        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                grst(1)
            )
            .Else(
                grst(0)
            ),
            EmbeddedCode('i=i+1;')
        )

        return m

    #############################################
    # fsm_convert
    #############################################
    def Tb_Fsm_convert(self, wres = 3):

        m = Module('test_fsm_convert')
        fsm_convert, simple_clk = self.tnn.Fsm_convert(wres)
        dut = Submodule(m, fsm_convert, 'dut')

        in_v = dut['in']
        clk = dut['clk']
        rstb = dut['rstb']
        out_v = dut['out']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [in_v, clk, rstb, out_v])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(

            in_v(0),
            rstb(1),
            Delay(25),

            rstb(0),
            Delay(5.001),

            in_v(1),
            Delay(1),

            in_v(0),
            Delay(12),

            in_v(1),
            Delay(5),

            in_v(0),
            Delay(3),

            rstb(0),
            Delay(200),

            simulation.finish()
        )

        return m

    #############################################
    # fsm_synapse - TODO: improve
    #############################################
    def Tb_Fsm_synapse(self, wres = 3):

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

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut,
            [input_spike, w_init, inc, dec, clk, grst, rstb, w_out, syn_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
    
            input_spike(0),
            inc(0),
            dec(0),
            clk(0),
            grst(1),
            Delay(25),
    
            grst(0),
            Delay(5),
    
            input_spike(1),
            Delay(8),
    
            input_spike(0),
            Delay(2),
    
            inc(1),
            Delay(14),
    
            input_spike(1),
            Delay(8),
    
            input_spike(0),
            Delay(17),
    
            input_spike(1),
            Delay(8),
    
            input_spike(0),
            Delay(5),
    
            inc(0),
            dec(1),
            Delay(20),
    
            input_spike(1),
            Delay(8),
    
            input_spike(0),
            Delay(5),
    
            inc(0),
            dec(1),
            Delay(25),
    
            grst(1),
            Delay(5),
    
            grst(0),
            inc(0),
            dec(0),
            Delay(5),
    
            Delay(200),
    
            simulation.finish()
        )

        m.Always(clk)(
            EmbeddedCode('i = i%23;'),
            # If(i == 0)(
            #     EmbeddedCode('gclk = ~gclk;')
            # ),
            EmbeddedCode('i=i+1;')
        )

        return m

    #############################################
    # stdp
    #############################################
    def Tb_Stdp(self, wres = 3):
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

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut,
           [input_weight, ein, eout, capture, minus, search, backoff, min_v, F, clk, grst, rstb, inc, dec])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(

            ein(0),
            input_weight(int('101', 2)),
            eout(0),
            clk(1),
            capture(1),
            minus(1),
            search(1),
            backoff(1),
            min_v(1),
            F(int('111111', 2)),
            Delay(5),

            ein(1),
            Delay(2),

            eout(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            eout(1),
            Delay(2),

            ein(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            ein(1),
            Delay(18),

            ein(0),
            Delay(16),

            eout(1),
            Delay(7),

            eout(0),
            Delay(5),

            ein(0),
            Delay(2),

            eout(0),
            Delay(6),

            ein(0),
            Delay(10),

            eout(0),
            Delay(5),

            search(0),
            capture(0),
            ein(0),
            Delay(2),

            eout(1),
            Delay(16),

            min_v(0),
            ein(0),
            eout(0),
            Delay(5),

            F(int('111101', 2)),
            eout(1),
            Delay(2),

            ein(1),
            Delay(16),

            ein(0),
            eout(0),
            Delay(5),

            F(int('111111', 2)),
            ein(1),
            Delay(18),

            ein(0),
            Delay(16),

            eout(1),
            Delay(7),

            eout(0),
            Delay(5),

            ein(0),
            Delay(2),

            eout(0),
            Delay(6),

            ein(0),
            Delay(9),

            eout(0),
            Delay(10),

            ein(0),
            eout(0),
            Delay(10),

            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%23;'),
            # TODO: fix
            # If(i == 0)(
            #     clk(1))
            # .Else(
            #     clk(0)
            # ),
            EmbeddedCode('i=i+1;')
        )
    
        return m

    #############################################
    # pac
    #############################################
    def Tb_Pac(self, ip_size=4, thres=13):
        m = Module('test_pac')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)

        pac, pac_clk = self.tnn.Pac(ip_size=ip_size.value, thres=thres.value)
        dut = Submodule(m, pac, 'dut')

        in_v = dut['in']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        out_v = dut['pac_out']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [in_v, clk, grst, rstb, out_v])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            i(0),
            in_v(0),
            Delay(5),
    
            in_v(int('0001', 2)),
            Delay(3),

            in_v(int('1001', 2)),
            Delay(2),

            in_v(int('1000', 2)),
            Delay(2),

            in_v(int('1100', 2)),
            Delay(2),

            in_v(int('1000', 2)),
            Delay(2),

            in_v(int('0000', 2)),
            Delay(3),

            in_v(int('0000', 2)),
            Delay(20),

            in_v(int('0000', 2)),
            Delay(200),

            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                grst(1)
            )
            .Else(
                grst(0)
            ),
            EmbeddedCode('i=i+1;')
        )

        return m

    #############################################
    # neuron_body
    #############################################
    def Tb_Neuronbody(self, ip_size=4, thres=13, wres = 3):

        m = Module('test_neuron_body')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        wres = m.Parameter('WRES', wres)

        nb, bdy_clk = self.tnn.Neuronbody(ip_size=ip_size.value, thres=thres.value, wres=wres.value)
        dut = Submodule(m, nb, 'dut')

        acc_in = dut['acc_in']
        clk = dut['clk']
        pac_rst = dut['grst']
        rst = dut['rstb']
        out_v = dut['output_spike']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(
            m, dut, [acc_in, clk, pac_rst, rst, out_v])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            i(0),
            acc_in(0),
            rst(1),
            Delay(5),

            rst(0),
            Delay(46),

            rst(0),
            Delay(1),

            acc_in(int('0001', 2)),
            Delay(1),

            acc_in(int('1001', 2)),
            Delay(4),

            acc_in(int('1000', 2)),
            Delay(2),

            acc_in(int('1100', 2)),
            Delay(1),

            acc_in(int('0100', 2)),
            Delay(1),

            acc_in(int('0000', 2)),
            Delay(20),

            rst(1),
            Delay(20),

            acc_in(0),
            Delay(20),

            acc_in(0),
            Delay(200),

            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i= i%23;'),
            If(i == 0)(
                pac_rst(1)
            )
            .Else(
                pac_rst(0)
            ),
            EmbeddedCode('i = i+1;')
        )
    
        return m

    #############################################
    # neuron_rnl
    #############################################
    def Tb_NeuronRNL(self, ip_size=4, thres=13, wres = 3):
        m = Module('test_neuron_rnl')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        wres = m.Parameter('WRES', wres)

        rnl, rnl_clk = self.tnn.NeuronRNL(ip_size=ip_size.value, thres=thres.value, wres=wres)

        here = m.copy_sim_ports(rnl)

        input_spikes = here['input_spikes']
        inc = here['inc']
        dec = here['dec']
        weight_en = here['weight_update_en']
        aclk = here['aclk']
        gclk = here['gclk']
        grst = here['grst']
        rst = here['rst']
        out_v = here['out_spike']

        dut = m.Instance(rnl, 'dut', ports=m.connect_ports(rnl))

        i = m.Integer('i', 32, value=0)
        j = m.Integer('j', 32, value=0)

        dump = simulation.setup_waveform(m, dut, ports=m.connect_ports(rnl))
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)

        dump.add(
            input_spikes(0),
            inc(0),
            dec(0),
            rst(1),
            Delay(18),

            rst(0),
            # /* Computational Wave 1 */

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

            # /* Computational Wave 2 */

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
    
            # /* Computational Wave 3 */
    
            Delay(5),
            inc[0](1),
            inc[1](1),
            inc[3](1),
    
            Delay(1),
            inc(0),
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
    
            # /* Computational Wave 4 */
    
            Delay(5),
            inc(1),
    
            Delay(1),
            inc(0),
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
    
            # /* Computational Wave 5 */
    
            Delay(5),
            inc(1),
    
            Delay(1),
            inc(0),
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

            # /* Computational Wave 6 */

            Delay(5),
            inc(1),

            Delay(1),
            inc(0),
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

            # /* Computational Wave 7 */

            Delay(5),
            inc[0](1),
            inc[1](1),
            inc[3](1),

            Delay(1),
            inc(0),
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
    
            # /* Computational Wave 8 */
    
            Delay(5),
            inc[0](1),
            inc[1](1),
            dec[2](1),
            inc[3](1),
    
            Delay(1),
            inc(0),
            dec(0),
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
    
            # /* Computational Wave 9 */
    
            Delay(5),
            inc(1),
    
            Delay(1),
            inc(0),
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
    
            # /* Computational Wave 10 */
    
            Delay(5),
            inc(1),
    
            Delay(1),
            inc(0),
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
    
        m.Initial(i(0))
        m.Always(aclk)(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                EmbeddedCode('gclk = ~gclk;')
            ),
            EmbeddedCode('i = i+1;')
        )
    
        m.Initial(j(0))
        m.Always(Posedge(aclk))(
            EmbeddedCode('j = j%23;'),
            If(j == 0)(
                grst(1)
            )
            .Else(
                grst(0)
            ),
            EmbeddedCode('j = j+1;')
        )
    
        return m

    #############################################
    # segment - TODO
    #############################################
    def Tb_Segment(self, ip_size_dist=16, ip_size_prox=1, wres_dist=3, wres_prox=3, thres=13):
        m = Module('test_segment')
        
        j = m.Integer('j', 32, value=0)

        # Instantiate the segment module
        segment_mod, segment_clk = self.segment(ip_size_dist=ip_size_dist, ip_size_prox=ip_size_prox, wres_dist=wres_dist, wres_prox=wres_prox, thres=thres)

        # Connect simulation ports
        here = m.copy_sim_ports(segment_mod)
        
        input_spikes_dist = here['input_spikes_dist']
        input_spikes_prox = here['input_spikes_prox']
        inc_dist = here['inc_dist']
        inc_prox = here['inc_prox']
        dec_dist = here['dec_dist']
        dec_prox = here['dec_prox']
        clk = here['clk']
        grst = here['grst']
        rstb = here['rstb']
        output_spike = here['output_spike']
        
        weights_dist = [here['weights_dist_'+str(i)] for i in range(ip_size_dist)]
        weights_prox = [here['weights_prox_'+str(i)] for i in range(ip_size_prox)]

        dut = m.Instance(segment_mod, 'dut', ports=m.connect_ports(segment_mod))

        # Setup waveform dump and simulation environment
        dump = simulation.setup_waveform(m, dut, ports=m.connect_ports(segment_mod))
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Reset and weight initialization in the simulation sequence
        dump.add(rstb(1), Delay(1), rstb(0), Delay(1))
        for index in range(ip_size_dist):
            dump.add(here['w_init_dist_' + str(index)](1))
        for index in range(ip_size_prox):
            dump.add(here['w_init_prox_' + str(index)](1))
        
        # Simulate input spikes and control operations for distal synapses
        for cycle in range(5):
            dump.add(
                input_spikes_dist(1),
                inc_dist(1),
                Delay(15),
                dec_dist(1),
                Delay(15),
                dec_dist(0),
                Delay(15)
            )

        # Simulate input spikes and control operations for proximal synapses
        for cycle in range(5):
            dump.add(
                input_spikes_prox(1),
                inc_prox(1),
                Delay(15),
                dec_prox(1),
                Delay(15),
                dec_prox(0),
                Delay(15)
            )
            
        dump.add(simulation.finish())

        m.Initial(j(0))
        m.Always(Posedge(clk))(
            EmbeddedCode('j = j%8;'),
            If(j == 0)(
                grst(1)
            )
            .Else(
                grst(0)
            ),
            EmbeddedCode('j = j+1;')
        )

        return m
