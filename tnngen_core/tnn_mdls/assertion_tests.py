# Original Author: Prabhu Vellaisamy
#
# Migrated to separate file <YoungSeok Na>
#
# Assertion-based testbenches <Yuyang Kang>
#
# Assertion-based testbench class

from tnn_mdls.func_mdls import *
from veriloggen import simulation, types

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

        # Setup waveform and clock
        dump = simulation.setup_waveform(m, dut, [data_in, inhibit_in, clk, grst, rstb, out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Define scenarios with expected results
        scenarios = [
            {'data_in': 0, 'inhibit_in': 1, 'expected_out': 0},
            {'data_in': 1, 'inhibit_in': 0, 'expected_out': 1},
            {'data_in': 0, 'inhibit_in': 0, 'expected_out': 0},
            {'data_in': 1, 'inhibit_in': 1, 'expected_out': 0},
        ]

        # Initial block for reset and input initialization
        init_block = m.Initial()
        init_block.add(
            data_in(0),
            inhibit_in(0),
            rstb(0),
            grst(0),
            Delay(1),
            rstb(1)
        )

        # Applying scenarios in the simulation
        for idx, scenario in enumerate(scenarios):
            scenario_block = m.Initial()
            scenario_block.add(
                Delay(20 * idx),
                data_in(scenario['data_in']),
                inhibit_in(scenario['inhibit_in']),
                Delay(10),
                If(out == scenario['expected_out'])(
                    Display("Step %0d: Success - Output is %0d as expected for inputs data_in=%0d, inhibit_in=%0d",
                            idx, out, scenario['data_in'], scenario['inhibit_in'])
                ).Else(
                    Display("Step %0d: Error - Output is %0d, expected %0d for inputs data_in=%0d, inhibit_in=%0d",
                            idx, out, scenario['expected_out'], scenario['data_in'], scenario['inhibit_in'])
                )
            )

        # End the simulation
        m.Initial().add(
            Delay(100 * len(scenarios)),
            simulation.finish()
        )

        # Generate clock and reset logic
        m.Always(clk)(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
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

        # Define scenarios
        scenarios = [
            {'pulse_in': 0, 'expected_edge_out': 0},
            {'pulse_in': 1, 'expected_edge_out': 1},
            {'pulse_in': 0, 'expected_edge_out': 1},
            {'pulse_in': 0, 'expected_edge_out': 0},
            {'pulse_in': 1, 'expected_edge_out': 1},
        ]

        # Initial block for reset and input initialization
        init_block = m.Initial()
        init_block.add(
            pulse_in(0),
            rstb(0),
            grst(0),
            Delay(1),
            rstb(1),
            grst(1),
            Delay(1),
            grst(0)
        )

        # Applying scenarios in the simulation
        for idx, scenario in enumerate(scenarios):
            scenario_block = m.Initial()
            scenario_block.add(
                Delay(20 * idx),
                pulse_in(scenario['pulse_in']),
                Delay(10),
                If(edge_out == scenario['expected_edge_out'])(
                    Display("Step %0d: Success - Edge output is %0d as expected for pulse_in=%0d",
                            idx, edge_out, scenario['pulse_in'])
                ).Else(
                    Display("Step %0d: Error - Edge output is %0d, expected %0d for pulse_in=%0d",
                            idx, edge_out, scenario['expected_edge_out'], scenario['pulse_in'])
                )
            )

        # End the simulation
        m.Initial().add(
            Delay(20 * len(scenarios)),
            simulation.finish()
        )

        # Clock and reset logic
        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # adder
    #############################################
    def Tb_Adder(self, RES=4):
        m = Module('test_adder')

        res = m.Parameter('RES', RES)

        adder, _ = self.Adder(res.value)

        dut = Submodule(m, adder, 'dut')

        out = dut['out']
        a = dut['a']
        b = dut['b']
        cin = dut['cin']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [a, b, cin, out])

        # Define scenarios with expected results
        scenarios = [
            {'a': 0, 'b': 0, 'cin': 0, 'expected_out': 0},
            {'a': 3, 'b': 0, 'cin': 0, 'expected_out': 3},
            {'a': 3, 'b': int('1100', 2), 'cin': 0, 'expected_out': 15},
            {'a': 3, 'b': int('1100', 2), 'cin': 1, 'expected_out': 16},
            {'a': 1, 'b': 1, 'cin': 1, 'expected_out': 3},                             # Single bit overflow
            {'a': int('1111', 2), 'b': 1, 'cin': 0, 'expected_out': 16},               # Boundary check
            {'a': int('1010', 2), 'b': int('0101', 2), 'cin': 1, 'expected_out': 16},  # Mid-range check
            {'a': int('0110', 2), 'b': int('1001', 2), 'cin': 1, 'expected_out': 16},  # Random mid-range
            {'a': int('0011', 2), 'b': int('1100', 2), 'cin': 0, 'expected_out': 15},  # Random mid-range
            {'a': int('1000', 2), 'b': int('1000', 2), 'cin': 1, 'expected_out': 17},  # Boundary + carry
        ]

        # Initial block for reset
        init_block = m.Initial()
        init_block.add(
            a(0),
            b(0),
            cin(0),
            Delay(1)
        )

        # Applying scenarios in the simulation
        for idx, scenario in enumerate(scenarios):
            scenario_block = m.Initial()
            scenario_block.add(
                Delay(20 * idx),
                a(scenario['a']),
                b(scenario['b']),
                cin(scenario['cin']),
                Delay(10),
                If(out == scenario['expected_out'])(
                    Display("Step %0d: Success - Output is %0d as expected for a=%0d, b=%0d, cin=%0d",
                            idx, out, scenario['a'], scenario['b'], scenario['cin'])
                ).Else(
                    Display("Step %0d: Error - Output is %0d, expected %0d for a=%0d, b=%0d, cin=%0d",
                            idx, out, scenario['expected_out'], scenario['a'], scenario['b'], scenario['cin'])
                ),
                Delay(10)
            )

        # End the simulation
        m.Initial().add(
            Delay(20 * len(scenarios)),
            simulation.finish()
        )

        return m

    #############################################
    # edge2pulse
    #############################################
    def Tb_Edge2pulse(self):
        m = Module('test_edge2pulse')

        edge, edge_clk = self.Edge2pulse()

        dut = Submodule(m, edge, 'dut')

        edge_in = dut['edge_in']
        clk = dut['clk']
        pulse_out = dut['pulse_out']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [edge_in, clk, pulse_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Define scenarios with expected results
        scenarios = [
            {'edge_in': 0, 'expected_pulse_out': 0},
            {'edge_in': 1, 'expected_pulse_out': 1},
            {'edge_in': 1, 'expected_pulse_out': 0},
            {'edge_in': 0, 'expected_pulse_out': 0},
        ]

        init_block = m.Initial()
        init_block.add(
            edge_in(0),
            Delay(1)
        )

        # Applying scenarios in the simulation
        for idx, scenario in enumerate(scenarios):
            scenario_block = m.Initial()
            scenario_block.add(
                Delay(20 * idx),
                edge_in(scenario['edge_in']),
                Delay(10),
                If(pulse_out == scenario['expected_pulse_out'])(
                    Display("Step %0d: Success - Pulse output is %0d as expected for edge_in=%0d",
                            idx, pulse_out, scenario['edge_in'])
                ).Else(
                    Display("Step %0d: Error - Pulse output is %0d, expected %0d for edge_in=%0d",
                            idx, pulse_out, scenario['expected_pulse_out'], scenario['edge_in'])
                ),
                Delay(10)
            )

        # End the simulation
        m.Initial().add(
            Delay(20 * len(scenarios)),
            simulation.finish()
        )

        # Clock and toggle edge_in based on counter
        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                edge_in(~edge_in)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # incdec
    #############################################
    def Tb_Incdec(self):
        m = Module('test_incdec')

        incdec, _ = self.Incdec()

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

        dump = simulation.setup_waveform(m, dut, [cases, capture, minus, search, backoff, min_v, fout, inc, dec])

        # Define scenarios with expected results
        scenarios = [
            {'cases': 0b0001, 'capture': 1, 'minus': 0, 'search': 0, 'backoff': 0, 'fout': 1, 'min_v': 0, 'expected_inc': 1, 'expected_dec': 0},
            {'cases': 0b0100, 'capture': 0, 'minus': 0, 'search': 1, 'backoff': 0, 'fout': 1, 'min_v': 0, 'expected_inc': 1, 'expected_dec': 0},
            {'cases': 0b0010, 'capture': 0, 'minus': 1, 'search': 0, 'backoff': 0, 'fout': 0, 'min_v': 1, 'expected_inc': 0, 'expected_dec': 1},
            {'cases': 0b1000, 'capture': 0, 'minus': 0, 'search': 0, 'backoff': 1, 'fout': 1, 'min_v': 0, 'expected_inc': 0, 'expected_dec': 1},
            {'cases': 0, 'capture': 0, 'minus': 0, 'search': 0, 'backoff': 0, 'fout': 0, 'min_v': 0, 'expected_inc': 0, 'expected_dec': 0},
        ]

        init_block = m.Initial()
        init_block.add(
            cases(0),
            capture(0),
            minus(0),
            search(0),
            backoff(0),
            min_v(0),
            fout(0),
            Delay(1)
        )

        # Applying scenarios in the simulation
        for idx, scenario in enumerate(scenarios):
            scenario_block = m.Initial()
            scenario_block.add(
                Delay(20 * idx),
                cases(scenario['cases']),
                capture(scenario['capture']),
                minus(scenario['minus']),
                search(scenario['search']),
                backoff(scenario['backoff']),
                min_v(scenario['min_v']),
                fout(scenario['fout']),
                Delay(10),
                If((inc == scenario['expected_inc']) & (dec == scenario['expected_dec']))(
                    Display("Step %0d: Success - inc=%0d, dec=%0d as expected for stdp_cases=%0b, capture=%0d, minus=%0d, search=%0d, backoff=%0d, fout=%0d, min=%0d",
                            idx, inc, dec, scenario['cases'], scenario['capture'], scenario['minus'], scenario['search'], scenario['backoff'], scenario['fout'], scenario['min_v'])
                ).Else(
                    Display("Step %0d: Error - inc=%0d, dec=%0d, expected inc=%0d, expected dec=%0d for stdp_cases=%0b, capture=%0d, minus=%0d, search=%0d, backoff=%0d, fout=%0d, min=%0d",
                            idx, inc, dec, scenario['expected_inc'], scenario['expected_dec'], scenario['cases'], scenario['capture'], scenario['minus'], scenario['search'], scenario['backoff'], scenario['fout'], scenario['min_v'])
                ),
                Delay(10)
            )

        # End the simulation
        m.Initial().add(
            Delay(20 * len(scenarios)),
            simulation.finish()
        )

        return m

    #############################################
    # wta
    #############################################
    def Tb_Wta(self, Q=4):
        m = Module('test_wta')

        q = m.Parameter('Q', Q)
        wta, wta_clk = self.Wta(q.value)

        dut = Submodule(m, wta, 'dut')

        ec_spikes = dut['ec_spikes']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        li_out = dut['li_out']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [ec_spikes, clk, grst, rstb, li_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Define expected logic based on the control inputs
        def expected_output(ec_spikes, Q):
            output = [0] * Q
            first_spike_found = False
            for i in range(Q):
                if ec_spikes[i] == 1 and not first_spike_found:
                    output[i] = 1
                    first_spike_found = True
            return output

        # Input Patterns
        input_patterns = [
            [0, 0, 1, 0],
            [1, 0, 0, 1],
            [0, 1, 0, 0],
            [0, 0, 0, 1],
        ]

        for idx, pattern in enumerate(input_patterns):
            expected = expected_output(pattern, Q)
            m.Initial(
                Delay(20 * idx),
                ec_spikes(Cat(*[Int(x, width=1) for x in pattern])),
                Delay(10),
                If(li_out == Cat(*[Int(x, width=1) for x in expected]))(
                    Display("Step %0d: Success - Output %b matches expected %b for ec_spikes=%b",
                            idx, li_out, Cat(*[Int(x, width=1) for x in expected]), Cat(*[Int(x, width=1) for x in pattern]))
                ).Else(
                    Display("Step %0d: Error - Output %b does not match expected %b for ec_spikes=%b",
                            idx, li_out, Cat(*[Int(x, width=1) for x in expected]), Cat(*[Int(x, width=1) for x in pattern]))
                ),
                Delay(10)
            )

        m.Initial().add(
            Delay(100 * len(input_patterns)),
            simulation.finish()
        )

        # Reset handling
        m.Initial(
            rstb(1),
            Delay(1),
            rstb(0),
            Delay(10)
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # t_wta
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

        # Initial reset
        init = m.Initial()
        init.add(
            rstb(0),
            grst(1),
            Delay(2),
            rstb(1),
            grst(0)
        )

        # Define test sequence with expected outputs
        test_sequence = [
            (0b0000, 0b0000),  # No spikes
            (0b0110, 0b0010),  # Spikes at positions 1 and 2, expect output at position 1
            (0b1000, 0b1000),  # Spike at position 3
            (0b0001, 0b0001),  # Spike at position 0
            (0b0000, 0b0000),  # No spikes
            (0b1111, 0b0001),  # All spikes, expect output at position 0
            (0b0000, 0b0000),  # No spikes
            (0b1100, 0b0100),  # Spikes at positions 2 and 3, expect output at position 2
            (0b1110, 0b0010),  # Spikes at positions 1, 2, and 3, expect output at position 1
            (0b0000, 0b0000)   # No spikes
        ]

        for idx, (spikes, expected) in enumerate(test_sequence):
            init.add(
                ec_spikes(spikes),
                Delay(20),
                If(li_out == expected)(
                    Display("Step %0d: Success - Output %b matches expected %b for ec_spikes=%b",
                            idx, li_out, expected, spikes)
                ).Else(
                    Display("Step %0d: Error - Output %b does not match expected %b for ec_spikes=%b",
                            idx, li_out, expected, spikes)
                ),
                Delay(10)
            )

        # Finish the simulation
        init.add(
            Delay(100),
            simulation.finish()
        )

        # Clock generation and reset logic
        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # stabilize
    #############################################
    def Tb_Stabilize(self, wres=3):
        m = Module('test_stabilize')
        stabilize, _ = self.Stabilize_func(wres)

        dut = Submodule(m, stabilize, 'dut')

        weight = dut['weight']
        F_brv = dut['F_brv']
        out = dut['out']

        dump = simulation.setup_waveform(m, dut, [weight, F_brv, out])

        # Test sequence with expected outputs
        test_sequence = [
            (0, 0b000000, 0),
            (0, 0b111111, 0),
            (1, 0b111111, 1),
            (1, 0b011111, 0),
            (2, 0b111111, 1),
            (2, 0b101111, 0),
            (3, 0b111111, 1),
            (3, 0b110111, 0),
            (4, 0b111011, 1),
            (5, 0b111101, 1),
            (6, 0b111110, 1),
            (7, 0b000000, 1),
        ]

        for idx, (w, f, expected) in enumerate(test_sequence):
            dump.add(
                weight(w),
                F_brv(f),
                Delay(5),
                If(out == expected)(
                    Display("Step %0d: Success - Output %b matches expected %b for weight=%b, F_brv=%b",
                            idx, out, expected, w, f)
                ).Else(
                    Display("Step %0d: Error - Output %b does not match expected %b for weight=%b, F_brv=%b",
                            idx, out, expected, w, f)
                ),
                Delay(5)
            )

        dump.add(
            Delay(100),
            simulation.finish()
        )

        return m

    #############################################
    # stdp_case_gen
    #############################################
    def Tb_Stdp_case_gen(self):
        m = Module('test_stdp_case_gen')
        stdp_case, case_clk = self.Stdp_case_gen()

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

        # Define expected outputs for stdp_cases based on inputs
        def expected_cases(ein, eout, greater):
            e_both = ein & eout
            e_one = ein ^ eout
            return [
                int(not greater and e_both),
                int(greater and e_both),
                int(not greater and e_one),
                int(greater and e_one)
            ]

        # Test different scenarios
        scenarios = [
            (0, 0, False),
            (1, 0, False),
            (0, 1, True),
            (1, 1, False),
        ]

        for index, (ein_val, eout_val, greater_val) in enumerate(scenarios):
            exp_cases = expected_cases(ein_val, eout_val, greater_val)
            init = m.Initial()
            init.add(
                ein(ein_val),
                eout(eout_val),
                Delay(1),
                *[
                    If(stdp_cases[k] == exp_cases[k])(
                        Display(f"Scenario {index + 1}: Case {k + 1} Success - Expected {exp_cases[k]}, Got {stdp_cases[k]}")
                    ).Else(
                        Display(f"Scenario {index + 1}: Case {k + 1} Error - Expected {exp_cases[k]}, Got {stdp_cases[k]}")
                    )
                    for k in range(4)
                ],
                Delay(10)
            )

        # Reset scenario
        m.Initial(
            ein(0),
            eout(0),
            Delay(10),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # fsm_convert
    #############################################
    def Tb_Fsm_convert(self, wres=3):
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

        # Define expected output
        def expected_output(rstb, in_v, current_state):
            if not rstb:
                return 1
            return int(not current_state) or (current_state and in_v)

        # Test sequence
        m.Initial(
            rstb(1),
            in_v(0),
            Delay(5),

            rstb(0),
            Delay(5),
            If(out_v == expected_output(0, 0, 0))(
                Display("Success: Correct output during reset")
            ).Else(
                Display("Error: Incorrect output during reset")
            ),
            Delay(20),

            rstb(1),
            in_v(1),
            Delay(1),
            If(out_v == expected_output(1, 1, 1))(
                Display("Success: Correct output with input 1 at state 1")
            ).Else(
                Display("Error: Incorrect output with input 1 at state 1")
            ),

            in_v(0),
            Delay(12),
            If(out_v == expected_output(1, 0, 2))(
                Display("Success: Correct output with input 0 at state 2")
            ).Else(
                Display("Error: Incorrect output with input 0 at state 2")
            ),

            in_v(1),
            Delay(5),
            If(out_v == expected_output(1, 1, 3))(
                Display("Success: Correct output with input 1 at state 3")
            ).Else(
                Display("Error: Incorrect output with input 1 at state 3")
            ),

            in_v(0),
            Delay(3),
            If(out_v == expected_output(1, 0, 4))(
                Display("Success: Correct output with input 0 at state 4")
            ).Else(
                Display("Error: Incorrect output with input 0 at state 4")
            ),

            Delay(200),
            simulation.finish()
        )

        return m

    #############################################
    # fsm_synapse - TODO: improve
    #############################################
    def Tb_Fsm_synapse(self, wres=3):
        m = Module('test_fsm_synapse')
        synapse, synapse_clk = self.tnn.Fsm_synapse(wres)
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

        dump = simulation.setup_waveform(m, dut, [input_spike, w_init, inc, dec, clk, grst, rstb, w_out, syn_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Initial reset
        init = m.Initial()
        init.add(
            rstb(0),
            grst(1),
            Delay(10),
            rstb(1),
            grst(0),
            w_init(5),
            Delay(10)
        )

        # Test different scenarios
        scenarios = [
            (0, 1, 0, 0, 5),
            (1, 0, 0, 0, 5),
            (1, 0, 1, 0, 6),
            (1, 0, 0, 1, 5),
            (1, 1, 0, 0, 0),
        ]

        for index, (rstb_val, grst_val, inc_val, dec_val, expected_w) in enumerate(scenarios):
            init.add(
                rstb(rstb_val),
                grst(grst_val),
                inc(inc_val),
                dec(dec_val),
                Delay(10),
                If(w_out == expected_w)(
                    Display(f"Scenario {index + 1}: Success - Expected {expected_w}, Got %0d", w_out)
                ).Else(
                    Display(f"Scenario {index + 1}: Error - Expected {expected_w}, Got %0d", w_out)
                ),
                Delay(10)
            )

        # Additional scenarios with input_spike
        spike_scenarios = [
            (1, 1, 0, 0, 5),
            (1, 0, 0, 0, 4),
            (1, 0, 0, 1, 3),
        ]

        for index, (input_spike_val, inc_val, dec_val, grst_val, expected_w) in enumerate(spike_scenarios, start=len(scenarios)):
            init.add(
                input_spike(0),
                rstb(1),
                grst(grst_val),
                inc(inc_val),
                dec(dec_val),
                Delay(10),
                input_spike(input_spike_val),
                Delay(10),
                If(w_out == expected_w)(
                    Display(f"Spike Scenario {index + 1}: Success - Expected {expected_w}, Got %0d", w_out)
                ).Else(
                    Display(f"Spike Scenario {index + 1}: Error - Expected {expected_w}, Got %0d", w_out)
                ),
                Delay(10)
            )

        # Final reset and finish
        init.add(
            rstb(0),
            grst(1),
            Delay(10),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # stdp
    #############################################
    def Tb_Stdp(self, wres=3):
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

        dump = simulation.setup_waveform(m, dut, [input_weight, ein, eout, capture, minus, search, backoff, min_v, F, clk, grst, rstb, inc, dec])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Define expected outputs for inc and dec
        def expected_outputs(ein, eout):
            if ein and eout:
                return 1, 0  # Expected: inc = 1, dec = 0
            elif eout:
                return 0, 1  # Expected: inc = 0, dec = 1
            else:
                return 0, 0  # Expected: inc = 0, dec = 0

        # Test different scenarios
        scenarios = [
            (0, 0, 1, 1, 1, 1, 1, int('111111', 2), int('101', 2)),
            (1, 1, 1, 1, 1, 1, 1, int('111111', 2), int('101', 2)),
            (0, 1, 1, 1, 1, 1, 1, int('111111', 2), int('101', 2)),
            (1, 0, 1, 1, 1, 1, 1, int('111111', 2), int('101', 2)),
        ]

        init = m.Initial()
        for index, (ein_val, eout_val, capture_val, minus_val, search_val, backoff_val, min_v_val, F_val, weight_in_val) in enumerate(scenarios):
            exp_inc, exp_dec = expected_outputs(ein_val, eout_val)
            init.add(
                rstb(0),
                grst(1),
                Delay(5),
                rstb(1),
                grst(0),
                Delay(5),
                ein(ein_val),
                eout(eout_val),
                capture(capture_val),
                minus(minus_val),
                search(search_val),
                backoff(backoff_val),
                min_v(min_v_val),
                F(F_val),
                input_weight(weight_in_val),
                Delay(10),
                If(inc == exp_inc)(
                    Display(f"Scenario {index + 1}: inc Success - Expected {exp_inc}, Got %0d", inc)
                ).Else(
                    Display(f"Scenario {index + 1}: inc Error - Expected {exp_inc}, Got %0d", inc)
                ),
                If(dec == exp_dec)(
                    Display(f"Scenario {index + 1}: dec Success - Expected {exp_dec}, Got %0d", dec)
                ).Else(
                    Display(f"Scenario {index + 1}: dec Error - Expected {exp_dec}, Got %0d", dec)
                ),
                Delay(10)
            )

        # Reset scenario
        init.add(
            ein(0),
            eout(0),
            Delay(10),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # pac
    #############################################
    def Tb_Pac(self, ip_size=5, thres=13):
        m = Module('test_pac')
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)

        pac, pac_clk = self.tnn.Pac(ip_size=ip_size.value, thres=thres.value)
        dut = Submodule(m, pac, 'dut')

        in_v = dut['in']
        clk = dut['clk']
        grst = dut['grst']
        rstb = dut['rstb']
        pac_out = dut['pac_out']

        i = m.Integer('i', 32, value=0)

        dump = simulation.setup_waveform(m, dut, [in_v, clk, grst, rstb, pac_out])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        def assert_equal(expected, actual, msg):
            return If(expected == actual)(
                Display("Success: " + msg + " Expected: %0d, Got: %0d", expected, actual)
            ).Else(
                Display("Error: " + msg + " Expected: %0d, Got: %0d", expected, actual)
            )

        input_sequence = [
            int('0001', 2),
            int('1001', 2),
            int('1000', 2),
            int('1100', 2),
            int('1000', 2),
            int('0000', 2),
        ]

        expected_outputs = []
        running_sum = 0
        for value in input_sequence:
            running_sum += value
            expected_outputs.append(int(running_sum >= thres.value))

        init = m.Initial()
        init.add(
            # Initial conditions
            rstb(1),
            grst(0),
            in_v(0),
            Delay(5),

            # Assert initial state
            assert_equal(0, pac_out, "Initial state"),
            
            # Reset signal handling
            rstb(0),
            Delay(5),
            rstb(1)
        )

        for idx in range(len(input_sequence)):
            init.add(
                in_v(input_sequence[idx]),
                Delay(5),
                assert_equal(expected_outputs[idx], pac_out, f"After input {bin(input_sequence[idx])[2:].zfill(ip_size.value)}")
            )

        init.add(
            Delay(200),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # neuron_body
    #############################################
    def tb_neuronbody(self, ip_size=5, thres=13, wres=3):
        m = Module('test_neuron_body')

        # Parameters setup
        ip_size = m.Parameter('IP_SIZE', ip_size)
        thres = m.Parameter('THRESHOLD', thres)
        wres = m.Parameter('WRES', wres)

        # Instantiate the Neuronbody
        nb, bdy_clk = self.tnn.Neuronbody(ip_size=ip_size.value, thres=thres.value, wres=wres.value)
        dut = Submodule(m, nb, 'dut')
        
        acc_in = dut['acc_in']
        clk = dut['clk']
        pac_rst = dut['grst']
        rst = dut['rstb']
        out_v = dut['output_spike']

        i = m.Integer('i', 32, value=0)
        dump = simulation.setup_waveform(m, dut, [acc_in, clk, pac_rst, rst, out_v])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Define scenarios
        scenarios = [
            {'input': 0b0001, 'expected_output': 0},
            {'input': 0b1001, 'expected_output': 1},
            {'input': 0b1000, 'expected_output': 1},
            {'input': 0b1100, 'expected_output': 1},
            {'input': 0b0100, 'expected_output': 0},
            {'input': 0b0000, 'expected_output': 0}
        ]

        # Test each scenario
        for scenario in scenarios:
            test_block = m.Initial()
            test_block.add(
                rst(1),
                pac_rst(0),
                Delay(5),
                rst(0),
                Delay(1),
                acc_in(scenario['input']),
                Delay(1),
                If(out_v == scenario['expected_output'])(
                    Display("Success: Input %b produces expected output %d", scenario['input'], out_v)
                ).Else(
                    Display("Error: Input %b produces unexpected output %d", scenario['input'], out_v),
                    Finish()
                ),
                Delay(10)
            )

        # Reset and general clock handling
        m.Initial().add(
            Delay(200),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                pac_rst(1)
            ).Else(
                pac_rst(0)
            ),
            EmbeddedCode('i = i + 1;')
        )

        return m

    #############################################
    # neuron_rnl
    #############################################
    def Tb_NeuronRNL(self, ip_size=5, thres=13, wres=3):
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
        weights = [here[f'weights_{i}'] for i in range(ip_size.value)]

        dut = m.Instance(rnl, 'dut', ports=m.connect_ports(rnl))

        i = m.Integer('i', 32, value=0)
        j = m.Integer('j', 32, value=0)

        dump = simulation.setup_waveform(m, dut, ports=m.connect_ports(rnl))
        clock = simulation.setup_clock(m, aclk, hperiod=0.5)

        # Define initial weights
        initial_weights = [5] * ip_size.value

        # Define expected output calculation
        def expected_output(input_spikes, inc, dec, weights):
            new_weights = weights.copy()
            for i in range(ip_size.value):
                if inc[i]:
                    new_weights[i] = min(new_weights[i] + 1, (1 << wres.value) - 1)
                if dec[i]:
                    new_weights[i] = max(new_weights[i] - 1, 0)
            total_input = sum(input_spikes[i] * new_weights[i] for i in range(ip_size.value))
            return 1 if total_input >= thres.value else 0, new_weights

        # Test scenarios
        scenarios = [
            {'input_spikes': [0, 0, 0, 0, 0], 'inc': [0, 0, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [1, 0, 0, 0, 0], 'inc': [0, 0, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [1, 1, 0, 0, 0], 'inc': [0, 0, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [1, 1, 1, 0, 0], 'inc': [0, 0, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [1, 1, 1, 1, 0], 'inc': [0, 0, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 1},
            {'input_spikes': [0, 0, 0, 0, 0], 'inc': [1, 0, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [0, 0, 0, 0, 0], 'inc': [0, 1, 0, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [0, 0, 0, 0, 0], 'inc': [0, 0, 1, 0, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [0, 0, 0, 0, 0], 'inc': [0, 0, 0, 1, 0], 'dec': [0, 0, 0, 0, 0], 'expected_out': 0},
            {'input_spikes': [1, 1, 1, 1, 1], 'inc': [1, 1, 1, 1, 1], 'dec': [0, 0, 0, 0, 0], 'expected_out': 1},
            {'input_spikes': [1, 1, 1, 1, 1], 'inc': [0, 0, 0, 0, 0], 'dec': [1, 1, 1, 1, 1], 'expected_out': 1},
        ]

        init = m.Initial()
        for index, scenario in enumerate(scenarios):
            expected_out, updated_weights = expected_output(
                scenario['input_spikes'], scenario['inc'], scenario['dec'], initial_weights)
            initial_weights = updated_weights
            init.add(
                rst(1),
                grst(0),
                Delay(10),
                rst(0),
                Delay(10),
                *[input_spikes[i](scenario['input_spikes'][i]) for i in range(ip_size.value)],
                *[inc[i](scenario['inc'][i]) for i in range(ip_size.value)],
                *[dec[i](scenario['dec'][i]) for i in range(ip_size.value)],
                Delay(10),
                If(out_v == expected_out)(
                    Display(f"Scenario {index + 1}: Success - Expected {expected_out}, Got %0d", out_v)
                ).Else(
                    Display(f"Scenario {index + 1}: Error - Expected {expected_out}, Got %0d", out_v)
                ),
                Delay(10)
            )

        # Final reset and finish
        init.add(
            rst(0),
            grst(1),
            Delay(10),
            simulation.finish()
        )

        m.Always(Posedge(aclk))(
            EmbeddedCode('i = i % 23;'),
            If(i == 0)(
                EmbeddedCode('gclk = ~gclk;')
            ),
            EmbeddedCode('i = i + 1;')
        )

        m.Initial(j(0))
        m.Always(Posedge(aclk))(
            EmbeddedCode('j = j % 23;'),
            If(j == 0)(
                grst(1)
            )
            .Else(
                grst(0)
            ),
            EmbeddedCode('j = j + 1;')
        )

        return m
