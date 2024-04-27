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
