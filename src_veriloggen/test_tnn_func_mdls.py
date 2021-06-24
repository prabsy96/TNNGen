from veriloggen import *
import numpy as np
from tnn_func_mdls import * 
import os

def mkTest_less_equal():

	m = Module('test_less_equal')
	lq = mkLessequal()

	dut = Submodule(m, lq, 'dut')

	data_in = dut['data_in']
	inhibit_in = dut['inhibit_in']
	aclk = dut['aclk']
	rst = dut['rst']
	out = dut['out']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, m.get_vars())
	clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
	
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

	m.Always(aclk) (i(i%23), \
		If(i==0) (
			rst(1)) 
		.Else(
			rst(0))
		, i.inc())



	return m

def mkTest_Pulse2edge():
	m = Module('test_pulse2edge')

	pulse = mkTest_Pulse2edge()


if __name__ == '__main__':
	test_lq = mkTest_less_equal()
	if not os.path.exists('out_test'):
		os.mkdir('out_test')
	test_lq_v = test_lq.to_verilog()
	print(test_lq_v)

	sim = simulation.Simulator(test_lq)
	rslt = sim.run()
	print(rslt)
	sim.view_waveform()