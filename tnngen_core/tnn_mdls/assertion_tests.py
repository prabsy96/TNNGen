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

        # Initial block
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
        for scenario in scenarios:
            scenario_block = m.Initial()
            scenario_block.add(
                data_in(scenario['data_in']),
                inhibit_in(scenario['inhibit_in']),
                Delay(10),
                If(out == scenario['expected_out'])(
                    Display("Success: Output is %d as expected for inputs data_in=%d, inhibit_in=%d",
                            out, scenario['data_in'], scenario['inhibit_in'])
                ).Else(
                    Display("Error: Output is %d, expected %d for inputs data_in=%d, inhibit_in=%d",
                            out, scenario['expected_out'], scenario['data_in'], scenario['inhibit_in']),
                    Finish()
                ),
                Delay(10)
            )

        # End the simulation
        m.Initial().add(
            Delay(200),
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
        ]

        # Initial block
        init_block = m.Initial()
        init_block.add(
            pulse_in(0),
            Delay(1),
            rstb(0),
            grst(0),
            Delay(1),
            rstb(1),
            grst(1),
            Delay(1),
            grst(0)
        )

        # Applying scenarios
        for scenario in scenarios:
            scenario_block = m.Initial()
            scenario_block.add(
                pulse_in(scenario['pulse_in']),
                Delay(10),
                If(edge_out == scenario['expected_edge_out'])(
                    Display("Success: Edge output is %d as expected for pulse_in=%d",
                            edge_out, scenario['pulse_in'])
                ).Else(
                    Display("Error: Edge output is %d, expected %d for pulse_in=%d",
                            edge_out, scenario['expected_edge_out'], scenario['pulse_in']),
                    Finish()
                ),
                Delay(10)
            )

        # End the simulation
        m.Initial().add(
            Delay(200),
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
    
        adder, add_clk = self.tnn.Adder(res.value)
    
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
        ]

        # Initial block
        init_block = m.Initial()
        init_block.add(
            a(0),
            b(0),
            cin(0),
            Delay(1)
        )

        # Applying scenarios
        for scenario in scenarios:
            scenario_block = m.Initial()
            scenario_block.add(
                a(scenario['a']),
                b(scenario['b']),
                cin(scenario['cin']),
                Delay(10),
                If(out == scenario['expected_out'])(
                    Display("Success: Output is %d as expected for a=%d, b=%d, cin=%d",
                            out, scenario['a'], scenario['b'], scenario['cin'])
                ).Else(
                    Display("Error: Output is %d, expected %d for a=%d, b=%d, cin=%d",
                            out, scenario['expected_out'], scenario['a'], scenario['b'], scenario['cin']),
                    Finish()
                ),
                Delay(10)
            )

        # End the simulation
        m.Initial().add(
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

        # Applying scenarios
        for scenario in scenarios:
            scenario_block = m.Initial()
            scenario_block.add(
                edge_in(scenario['edge_in']),
                Delay(10),
                If(pulse_out == scenario['expected_pulse_out'])(
                    Display("Success: Pulse output is %d as expected for edge_in=%d",
                            pulse_out, scenario['edge_in'])
                ).Else(
                    Display("Error: Pulse output is %d, expected %d for edge_in=%d",
                            pulse_out, scenario['expected_pulse_out'], scenario['edge_in']),
                    Finish()
                ),
                Delay(10)
            )

        m.Initial().add(
            Delay(200),
            simulation.finish()
        )

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

        # Define expected logic
        def expected_inc_dec(cases, capture, minus, search, backoff, fout, min_v):
            stabilize_brv = fout | min_v
            expected_inc = (cases == 0b0001 and capture and stabilize_brv) or (cases == 0b0100 and search)
            expected_dec = (cases == 0b0010 and minus and stabilize_brv) or (cases == 0b1000 and backoff and stabilize_brv)
            return expected_inc, expected_dec

        # Setup initial conditions and test cases
        m.Initial(
            cases(0),
            capture(0),
            minus(0),
            search(0),
            backoff(0),
            min_v(0),
            fout(0),
            Delay(5)
        )

        test_vectors = [
            (0b0001, 1, 0, 0, 0, 1, 0),
            (0b0100, 0, 0, 1, 0, 1, 0),
            (0b0010, 0, 1, 0, 0, 0, 1),
            (0b1000, 0, 0, 0, 1, 1, 0),
            (0, 0, 0, 0, 0, 0, 0)
        ]

        for index, (c, cap, minu, sea, back, f, minv) in enumerate(test_vectors):
            m.Initial(
                cases(c),
                capture(cap),
                minus(minu),
                search(sea),
                backoff(back),
                min_v(minv),
                fout(f),
                Delay(5),
                If((inc, dec) == expected_inc_dec(c, cap, minu, sea, back, f, minv))(
                    Display(f"Test Case {index+1} Success: Outputs are correct.")
                ).Else(
                    Display(f"Test Case {index+1} Error: Outputs are incorrect.")
                ),
                Delay(10)
            )

        m.Initial().add(
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

        for pattern in input_patterns:
            expected = expected_output(pattern, Q)

            dump.add(
                ec_spikes(Cat(*[Int(x, width=1) for x in pattern])),
                Delay(1),
                If(li_out != Cat(*[Int(x, width=1) for x in expected]))(
                    Systask('display', "Assertion Failed: Output %b does not match expected %b", li_out, Cat(*[Int(x, width=1) for x in expected])),
                    Systask('finish')
                ),
                Delay(10)
            )

        dump.add(
            Delay(100),
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

        # Define expected output function
        def expected_output(spikes):
            if spikes == 0:
                return 0
            for i in range(Q):
                if (spikes >> i) & 1:
                    return 1 << i
            return 0

        # Test sequence
        m.Initial(
            ec_spikes(0),
            Delay(5),
            If(li_out == expected_output(0))(
                Display("Success: Correct output for no spikes")
            ).Else(
                Display("Error: Incorrect output for no spikes, expected 0")
            ),
        )

        for index in range(1, Q):
            m.Initial(
                ec_spikes(1 << index),
                Delay(1),
                If(li_out == expected_output(1 << index))(
                    Display("Success: Correct output for spike at position %d", index)
                ).Else(
                    Display("Error: Incorrect output for spike at position %d, expected %d",
                            index, expected_output(1 << index))
                ),
                ec_spikes(0),
                Delay(4)
            )

        m.Initial(
            Delay(100),
            simulation.finish()
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

        # Define expected outputs
        def expected_cases(ein, eout, greater):
            e_both = ein & eout
            e_one = ein ^ eout
            return [
                not greater and e_both,
                greater and e_both,
                not greater and e_one,
                greater and e_one
            ]

        # Define greater logic for this context
        greater = False

        # Test different scenarios
        scenarios = [
            (0, 0, greater),
            (1, 0, greater),
            (0, 1, greater),
            (1, 1, greater),
        ]

        for index, (ein_val, eout_val, greater_val) in enumerate(scenarios):
            exp_cases = expected_cases(ein_val, eout_val, greater_val)
            m.Initial(
                ein(ein_val),
                eout(eout_val),
                Delay(1),
                [
                    If(stdp_cases[k] == exp_cases[k])(
                        Display(f"Scenario {index + 1}: Case {k+1} Success")
                    ).Else(
                        Display(f"Scenario {index + 1}: Case {k+1} Error - Expected {exp_cases[k]}, Got {stdp_cases[k]}")
                    )
                    for k in range(4)
                ],
                Delay(10)
            )

        m.Initial(
            ein(0),
            eout(0),
            Delay(10),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i=i+1;')
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

        # Simulation state to manage the current weight
        current_weight = m.Reg('current_weight', wres)

        m.Initial(
            current_weight(3)
        )

        # Define expected output
        def expected_output(inc, dec, current_weight, spike):
            if inc:
                new_weight = min(current_weight + 1, (1 << wres) - 1)
            elif dec:
                new_weight = max(current_weight - 1, 0)
            else:
                new_weight = current_weight
            return new_weight, (spike and new_weight > 0)

        # Test sequence
        test_vectors = [
            (0, 0, 0),
            (1, 0, 0),
            (0, 1, 0),
            (0, 0, 1),
        ]

        for idx, (spike, increment, decrement) in enumerate(test_vectors):
            expected_w, expected_syn_out = expected_output(increment, decrement, current_weight, spike)

            m.Initial(
                input_spike(spike),
                inc(increment),
                dec(decrement),
                If((w_out, syn_out) == (expected_w, expected_syn_out))(
                    Display(f"Test {idx+1}: Pass")
                ).Else(
                    Display(f"Test {idx+1}: Fail - Expected ({expected_w}, {expected_syn_out}), Got ({w_out}, {syn_out})")
                ),
                current_weight(expected_w),
                Delay(10)
            )

        m.Initial(
            Delay(200),
            simulation.finish()
        )

        m.Always(clk)(
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i=i+1;')
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

        dump = simulation.setup_waveform(m, dut, 
            [input_weight, ein, eout, capture, minus, search, backoff, min_v, F, clk, grst, rstb, inc, dec])
        clock = simulation.setup_clock(m, clk, hperiod=0.5)

        # Define the expected behavior
        def expected_behavior(capture, minus, search, backoff, min_v, weight, F):
            inc_expected = (capture and search) or (weight > 3 and not min_v)
            dec_expected = (minus and backoff) or (weight < 2 and min_v)
            return inc_expected, dec_expected

        # Set initial conditions
        m.Initial(
            input_weight(3),
            ein(0),
            eout(0),
            capture(0),
            minus(0),
            search(0),
            backoff(0),
            min_v(0),
            F(0b111111),
            rstb(1),
            Delay(10),
            rstb(0),
            Delay(5)
        )

        # Cycle through test conditions
        test_conditions = [
            (1, 0, 1, 0, 1, 0),
            (0, 1, 0, 1, 0, 0),
            (1, 1, 1, 1, 1, 0),
            (0, 0, 0, 0, 0, 1)
        ]

        for idx, (cap, minu, sea, back, minv, weight) in enumerate(test_conditions):
            m.Initial(
                capture(cap),
                minus(minu),
                search(sea),
                backoff(back),
                min_v(minv),
                input_weight(weight),
                Delay(10),
                If((inc, dec) == expected_behavior(cap, minu, sea, back, minv, weight, F))(
                    Display(f"Test {idx+1}: Pass - Expected behavior matched.")
                ).Else(
                    Display(f"Test {idx+1}: Fail - Behavior did not match.")
                ),
                Delay(20)
            )

        m.Initial(
            Delay(500),
            simulation.finish()
        )

        m.Always(Posedge(clk))(
            EmbeddedCode('i = i%23;'),
            If(i == 0)(
                grst(1)
            ).Else(
                grst(0)
            ),
            EmbeddedCode('i=i+1;')
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
