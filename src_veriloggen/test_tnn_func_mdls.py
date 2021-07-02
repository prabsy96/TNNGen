# Author = Prabhu Vellaisamy

# TNN testbench generation using VerilogGen library to check correctness

from veriloggen import *
import numpy as np
from tnn_func_mdls import * 
import os

def mkTest_less_equal():

	m = Module('test_less_equal')
	lq = mkLessequal()

	dut = Submodule(m, lq, name = 'dut')

	data_in = dut['data_in']
	inhibit_in = dut['inhibit_in']
	aclk = dut['aclk']
	rst = dut['rst']
	out = dut['out']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [data_in, inhibit_in, aclk, rst, out])
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

	pulse = mkPulse2edge()

	dut = Submodule(m, pulse, 'dut')

	edge_out = dut['edge_out']
	pulse_in = dut['pulse_in']
	aclk = dut['aclk']
	grst = dut['grst']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [pulse_in, aclk, grst, edge_out])
	clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
	
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

	m.Always(aclk) (i(i%23), \
		If(i==0) (
			grst(1)) 
		.Else(
			grst(0))
		, i.inc())



	return m


def mkTest_Adder():
	m = Module('test_adder')

	adder = mkAdder(4)

	dut = Submodule(m, adder, 'dut')

	out = dut['out']
	a = dut['a']
	b = dut['b']
	cin = dut['cin']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [a, b, cin, out])
	#clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
	
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


def mkTest_Edge2pulse():
	m = Module('test_edge2pulse')

	edge = mkEdge2pulse()

	dut = Submodule(m, edge, 'dut')

	edge_in = dut['edge_in']
	clk_in = dut['clk_in']
	pulse_out = dut['pulse_out']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [edge_in, clk_in, pulse_out])
	clock = simulation.setup_clock(m, clk_in, hperiod = 0.5)
	
	dump.add(
		edge_in(0),
		Delay(5),

		edge_in(1),
        Delay(100),

        simulation.finish()
		)

	m.Always(clk_in) (i(i%23), 
		If(i==0) (
			edge_in(~edge_in)) 
		, i.inc())



	return m

def mkTest_Incdec():
	m = Module('test_incdec')

	incdec = mkIncdec()

	dut = Submodule(m, incdec, 'dut')

	inc = dut['inc']
	dec = dut['dec']
	cases = dut['stdp_cases']
	capture = dut['capture']
	minus = dut['minus']
	backoff = dut['backoff']
	search = dut['search']
	min_v = dut['min']
	F = dut['F']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [cases, capture, minus, search, backoff, min_v, F, inc, dec])
	#clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
	
	dump.add(
		cases(0),
		capture(0),
		minus(0),
		search(0),
		backoff(0),
		min_v(0),
		F(0),
		Delay(5),

		cases(int('1000', 2)),
        Delay(5),

        capture(1),
        Delay(5),

        F(1),
        Delay(5),

        cases(int('0100', 2)),
        Delay(5),

        minus(1),
        F(0),
        Delay(5),

        F(1),
        Delay(5),

        cases(int('0010', 2)),
        Delay(5),

        search(1),
        F(0),
        Delay(5),

        F(1),
        Delay(5),

        cases(1),
        Delay(5),

        backoff(1),
        F(0),
        Delay(5),

        F(1),
        Delay(10),

        cases(0),
        Delay(200),

        simulation.finish()
		)


	return m


def mkTest_Wta():

	m = Module('test_wta')

	wta = mkWta(4)

	dut = Submodule(m, wta, 'dut')

	ec_spikes = dut['ec_spikes']
	aclk = dut['aclk']
	grst = dut['grst']
	li_out = dut['li_out']	

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [ec_spikes, aclk, grst, li_out])
	clock = simulation.setup_clock(m, aclk, hperiod = 0.5)
	
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

	m.Always(aclk) (i(i%23), \
		If(i==0) (
			grst(1)) 
		.Else(
			grst(0))
		, i.inc())

	return m

def mkTest_Flogic(): 

	m = Module('test_flogic')
	flogic = mkFlogic()

	dut = Submodule(m, flogic, 'dut')

	F = dut['F']
	input_weight = dut['input_weight']
	out = dut['out']

	dump = simulation.setup_waveform(m, dut, [F, input_weight, out])

	dump.add(
		F(0),
		input_weight (0),
		Delay(5),

		F(int('111111', 2)),
		Delay(5),

		input_weight(1),
		Delay(5),

		F(int('011111', 2)),
		Delay(5),

		input_weight(2),
		F(int('111111', 2)),
		Delay(5),

		F(int('101111', 2)),
		Delay(5),

		input_weight(3),
		F(int('111111', 2)),
		Delay(5),

		F(int('110111', 2)),
		Delay(5),

		input_weight(4),
		Delay(5),

		F(int('111011', 2)),
		Delay(5),

		input_weight(5),
		Delay(5),

		F(int('111101', 2)),
		Delay(5),

		input_weight(6),
		Delay(5),

		F(int('111110', 2)),
		Delay(5),

		input_weight(7),
		Delay(5),

		F(0),
		Delay(5),

        Delay(100),

        simulation.finish()
		)



	return m

def mkTest_Stdp_case_gen():

	m = Module('test_stdp_case_gen')
	stdp_case = mkStdp_case_gen()

	dut = Submodule(m, stdp_case, 'dut')

	stdp_cases = dut['stdp_cases']
	ein = dut['ein']
	eout = dut['eout']
	aclk = dut['aclk']
	grst = dut['grst']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [ein, eout, aclk, grst])
	clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

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

	m.Always(aclk) (i(i%23), \
		If(i==0) (
			grst(1)) 
		.Else(
			grst(0))
		, i.inc())

	return m


def Test_Fsm_simple():

	m = Module('test_fsm_simple')
	fsm_simple = Fsm_simple()
	dut = Submodule(m, fsm_simple, 'dut')

	aclk = dut['aclk']
	rst = dut['rst']
	in_v = dut['in']
	out_v = dut['out']

	i = m.Integer('i', 32, 0)

	dump = simulation.setup_waveform(m, dut, [aclk, rst, in_v, out_v])
	clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

	dump.add(

		in_v(0),
		rst(1),
		Delay(25),

		rst(0),
		Delay(5.001),

		in_v(1),
		


		)











if __name__ == '__main__':
	test_lq = mkTest_less_equal()
	test_pulse = mkTest_Pulse2edge()
	test_adder = mkTest_Adder()
	test_edge = mkTest_Edge2pulse()
	test_incdec = mkTest_Incdec()
	test_wta = mkTest_Wta()
	test_flogic = mkTest_Flogic()
	test_stdp_case = mkTest_Stdp_case_gen()

	if not os.path.exists('out_test'):
		os.mkdir('out_test')

	#test_lq_v = test_lq.to_verilog('out_test/less_equal_tb.v')
	#test_pulse_v = test_pulse.to_verilog('out_test/pulse2edge_tb.v')
	#test_adder_v = test_adder.to_verilog('out_test/adder_tb.v')
	#test_edge_v =test_edge.to_verilog('out_test/edge_tb.v')
	#test_incdec_v = test_incdec.to_verilog('out_test/incdec_tb.v')
	#test_wta_v = test_wta.to_verilog('out_test/wta_tb.v')
	#test_flogic_v = test_flogic.to_verilog('out_test/flogic_tb.v')
	test_stdp_case_v = test_stdp_case.to_verilog('out_test/stdp_cases_tb.v')

	#print(test_lq_v)
	#print(test_pulse_v)
	#print(test_adder_v)
	#print(test_edge_v)
	#print(test_incdec_v)
	#rint(test_wta_v)
	#print(test_flogic_v
	print(test_stdp_case_v)

	sim = simulation.Simulator(test_stdp_case)
	rslt = sim.run()
	print(rslt)
	sim.view_waveform()