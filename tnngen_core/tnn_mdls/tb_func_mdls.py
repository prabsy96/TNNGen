# Original Author: Prabhu Vellaisamy
#
# Migrated to separate file <YoungSeok Na>
#
# Testbench class

from tnn_mdls.func_mdls import *

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

        i = m.Integer('i', 32, 0)

        dump = simulation.setup_waveform(
            m, dut, [data_in, inhibit_in, clk, grst, rstb, out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            data_in(0),
            inhibit_in(1),
            Delay(5),

            data_in(1),
            Delay(1),

            data_in(0),
            Delay(5),

            inhibit_in(1),
            Delay(11),

            inhibit_in(0),
            Delay(5),

            data_in(1),
            Delay(3),

            inhibit_in(1),
            Delay(5),

            data_in(0),
            Delay(9),

            inhibit_in(0),
            Delay(5),

            inhibit_in(1),
            Delay(3),

            data_in(1),
            Delay(5),

            data_in(0),
            Delay(9),

            inhibit_in(0),
            Delay(5),

            data_in(1),
            inhibit_in(1),
            Delay(8),

            data_in(0),
            Delay(9),

            inhibit_in(0),
            Delay(10),

            data_in(0),
            Delay(100),

            simulation.finish()
        )

        m.Always(clk)(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                grst(1)
            )
            .Else(
                grst(0)
            ),
            EmbeddedCode('i = i+1;')
        )

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
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [pulse_in, clk, grst, rstb, edge_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)
    
        dump.add(
            pulse_in(0),
            Delay(5),
    
            pulse_in(1),
            Delay(1),
    
            pulse_in(0),
            Delay(5),
    
            pulse_in(1),
            Delay(1),
    
            pulse_in(0),
            Delay(22),
    
            pulse_in(1),
            Delay(8),
    
            pulse_in(1),
            Delay(10),
    
            pulse_in(0),
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
    # adder
    #############################################
    def Tb_Adder(self, RES=4):
        m = Module('test_adder')
    
        res = m.Parameter('RES', RES)
    
        adder, add_clk = self.tnn.Adder(res.value)
    
        dut = Submodule(m, adder, 'dut')
    
        out = dut['out']
        a = dut['a']
        b = dut['b']
        cin = dut['cin']
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [a, b, cin, out])
    
        dump.add(
            a(0),
            b(0),
            cin(0),
            Delay(5),
    
            a(3),
            Delay(5),
    
            b(int('1100', 2)),
            Delay(10),
    
            cin(1),
            Delay(10),
    
            cin(0),
            Delay(22),
            Delay(200),
    
            simulation.finish()
        )
    
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

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [edge_in, clk, pulse_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            edge_in(0),
            Delay(5),

            edge_in(1),
            Delay(100),

            simulation.finish()
        )

        m.Always(clk)(
            EmbeddedCode('i = i%23;'),
            # TODO: fix
            # If(i == 0)(
            #     EmbeddedCode('edge_in = ~edge_in;')
            # ),
            EmbeddedCode('i = i+1;')
        )

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
    
        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(
            m, dut, [cases, capture, minus, search, backoff, min_v, fout, inc, dec])
        #clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

        dump.add(
            cases(0),
            capture(0),
            minus(0),
            search(0),
            backoff(0),
            min_v(0),
            fout(0),
            Delay(5),
    
            cases(int('1000', 2)),
            Delay(5),
    
            capture(1),
            Delay(5),
    
            fout(1),
            Delay(5),
    
            cases(int('0100', 2)),
            Delay(5),
    
            minus(1),
            fout(0),
            Delay(5),
    
            fout(1),
            Delay(5),
    
            cases(int('0010', 2)),
            Delay(5),
    
            search(1),
            fout(0),
            Delay(5),
    
            fout(1),
            Delay(5),
    
            cases(1),
            Delay(5),
    
            backoff(1),
            fout(0),
            Delay(5),
    
            fout(1),
            Delay(10),
    
            cases(0),
            Delay(200),
    
            simulation.finish()
        )
    
        return m

    #############################################
    # wta
    #############################################
    def Tb_Wta(self, Q=4):
    
        m = Module('test_wta')

        q = m.Parameter('Q', Q)
        wta, wta_clk = self.tnn.Wta(q.value)

        dut = Submodule(m, wta, 'dut')

        ec_spikes = dut['ec_spikes']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        li_out = dut['li_out']

        i = m.Integer('i', 32, value=0)
    
        dump = simulation.setup_waveform(m, dut, [ec_spikes, clk, grst, rstb, li_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            ec_spikes(0),
            Delay(5),
    
            ec_spikes[2](1),
            ec_spikes[1](1),
            Delay(1),
    
            ec_spikes[3](1),
            Delay(5),
    
            ec_spikes[0](1),
            Delay(2),
    
            ec_spikes[2](0),
            ec_spikes[1](0),
            Delay(1),
    
            ec_spikes[3](0),
            Delay(5),
    
            ec_spikes[0](0),
            Delay(9),
    
            ec_spikes[2](1),
            ec_spikes[1](1),
            ec_spikes[0](1),
            ec_spikes[3](1),
    
            Delay(8),
            ec_spikes[3](0),
            ec_spikes[2](0),
            ec_spikes[0](0),
            ec_spikes[1](0),
    
            Delay(15),
            ec_spikes[2](1),
            ec_spikes[3](1),
    
            Delay(1),
            ec_spikes[1](1),
    
            Delay(5),
            ec_spikes[0](1),
    
            Delay(6),
            ec_spikes[2](0),
            ec_spikes[3](0),
    
            Delay(1),
            ec_spikes[1](0),
    
            Delay(5),
            ec_spikes[0](0),
    
            Delay(10),
            ec_spikes(0),
    
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
    # t_wta - TODO
    #############################################
    def Tb_T_wta(self, Q=4):

        m = Module('test_t_wta')

        q = m.Parameter('Q', Q)
        wta, wta_clk = self.tnn.Wta(q.value)

        dut = Submodule(m, wta, 'dut')

        ec_spikes = dut['ec_spikes']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        li_out = dut['li_out']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [ec_spikes, clk, grst, rstb, li_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        dump.add(
            ec_spikes(0),
            Delay(5),

            ec_spikes[2](1),
            ec_spikes[1](1),
            Delay(1),

            ec_spikes[3](1),
            Delay(5),

            ec_spikes[0](1),
            Delay(2),

            ec_spikes[2](0),
            ec_spikes[1](0),
            Delay(1),

            ec_spikes[3](0),
            Delay(5),

            ec_spikes[0](0),
            Delay(9),

            ec_spikes[2](1),
            ec_spikes[1](1),
            ec_spikes[0](1),
            ec_spikes[3](1),

            Delay(8),
            ec_spikes[3](0),
            ec_spikes[2](0),
            ec_spikes[0](0),
            ec_spikes[1](0),

            Delay(15),
            ec_spikes[2](1),
            ec_spikes[3](1),

            Delay(1),
            ec_spikes[1](1),

            Delay(5),
            ec_spikes[0](1),

            Delay(6),
            ec_spikes[2](0),
            ec_spikes[3](0),

            Delay(1),
            ec_spikes[1](0),

            Delay(5),
            ec_spikes[0](0),

            Delay(10),
            ec_spikes(0),

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
    # stabilize - previously: flogic
    #############################################
    def Tb_Flogic(self, wres = 3):

        m = Module('test_stabilize')
        flogic, flogic_clk = self.tnn.Stabilize_func(wres)

        dut = Submodule(m, flogic, 'dut')

        weight = dut['weight']
        F = dut['F_brv']
        out = dut['out']

        dump = simulation.setup_waveform(m, dut, [weight, F, out])

        dump.add(
            F(0),
            weight(0),
            Delay(5),

            F(int('111111', 2)),
            Delay(5),

            weight(1),
            Delay(5),

            F(int('011111', 2)),
            Delay(5),

            weight(2),
            F(int('111111', 2)),
            Delay(5),

            F(int('101111', 2)),
            Delay(5),

            weight(3),
            F(int('111111', 2)),
            Delay(5),

            F(int('110111', 2)),
            Delay(5),

            weight(4),
            Delay(5),

            F(int('111011', 2)),
            Delay(5),

            weight(5),
            Delay(5),

            F(int('111101', 2)),
            Delay(5),

            weight(6),
            Delay(5),

            F(int('111110', 2)),
            Delay(5),

            weight(7),
            Delay(5),

            F(0),
            Delay(5),

            Delay(100),

            simulation.finish()
        )

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
    def Tb_Segment(self, ip_dist=16, ip_prox=1, wres_dist=3, wres_prox=3, thres=13):
        
        m = Module('test_segment')
        inp_dist = m.Parameter('INP_DIST', ip_dist)
        inp_prox = m.Parameter('INP_PROX', ip_prox)
        wres_dist = m.Parameter('WRES_DIST', wres_dist)
        wres_prox = m.Parameter('WRES_PROX', wres_prox)
        thres = m.Parameter('THRESHOLD', thres)

        segment_mod, segment_clk = self.tnn.segment(ip_size_dist=inp_dist.value, ip_size_prox=inp_prox.value, wres_dist=wres_dist.value, wres_prox=wres_prox.value, thres=thres.value)
        
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

        dut = m.Instance(segment_mod, 'dut', ports=m.connect_ports(segment_mod))

        # Setup the clock and simulation environment
        i = m.Integer('i', 32, value=0)
        dump = simulation.setup_waveform(m, dut, ports=m.connect_ports(segment_mod))
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Simulation events(simple one for test)
        dump.add(
            rstb(0),
            Delay(10),
            rstb(1),
            Delay(10),
        )

        # Computational Waves
        for wave in range(10):
            dump.add(
                here['input_spikes_dist'](0b1010101010101010 >> (wave % ip_dist)),
                here['input_spikes_prox'](1 if wave % 2 == 0 else 0),
                here['inc_dist'](0b1111000011110000 >> (wave % ip_dist)),
                here['inc_prox'](1 if wave % 3 == 0 else 0),
                here['dec_dist'](0b0000111100001111 >> (wave % ip_dist)),
                here['dec_prox'](1 if wave % 4 == 0 else 0),
                Delay(100),
            )

        # Clock toggle logic
        m.Initial(i(0))
        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%2;'),
            If(i == 0)(
                EmbeddedCode('clk = ~clk;')
            ),
            EmbeddedCode('i = i+1;')
        )

        return m
