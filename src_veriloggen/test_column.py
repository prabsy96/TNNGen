# Author = Prabhu Vellaisamy

# TNN column testbench generation using VerilogGen library to check correctness

from veriloggen import *
import numpy as np
from column import *
from tnn_func_mdls import * 
import os

def mkTest_Column(p = 4, q = 3, thres = 11):

	m = Module('test_column')
	p = m.Parameter('P', p)
	q = m.Parameter('Q', q)
	thres = m.Parameter('THRESHOLD', thres)
	col = mkColumn(p, q, thres)

	ports = m.copy_sim_ports(col)
	i = m.Integer('i', 32, value = 0)
	k = m.Integer('k', 32, value = 0)

	minus, capture, search, backoff, min_v, f = [], [], [], [], [], []
	minus_temp, capture_temp, search_temp, backoff_temp, min_v_temp, f_temp = [], [], [], [], [], []

	aclk = ports['aclk']
	input_spikes = ports['input_spikes']

	for j in range(q.value):
		capture.append(ports['capture_'+str(j)])
		minus.append(ports['minus_'+str(j)])
		search.append(ports['search_'+str(j)])
		backoff.append(ports['backoff_'+str(j)])
		min_v.append(ports['min_'+str(j)])
		f.append(ports['F_'+str(j)])


	# for j in range(q.value):
	# 	if (j != q.value-1):
	# 		capture_temp.append(ports['capture_'+str(j)])
	# 		minus_temp.append('minus_'+str(j)+',')
	# 		search_temp.append('search_'+str(j)+',')
	# 		backoff_temp.append('backoff_'+str(j)+',')
	# 		min_v_temp.append('min_'+str(j)+',')
	# 		f_temp.append('F_'+str(j)+',')

	# 	else:
	# 		capture_temp.append('capture_'+str(j))
	# 		minus_temp.append('minus_'+str(j))
	# 		search_temp.append('search_'+str(j))
	# 		backoff_temp.append('backoff_'+str(j))
	# 		min_v_temp.append('min_'+str(j))
	# 		f_temp.append('F_'+str(j))


	weight_en = ports['weight_update_en']
	gclk = ports['gclk']
	rst = ports['rst']
	out_spike = ports['output_spikes']

	dut = m.Instance(col, 'dut', params = [p, q, thres], ports = m.connect_ports(col))

	dump = simulation.setup_waveform(m, dut, ports = m.connect_ports(col))
	clock = simulation.setup_clock(m, aclk, hperiod = 0.5)

	#add_for = for j in range(q.value): capture[j](1), minus[j](1), search[j](1), backoff[j](1), min_v[j](1), f[j](1)

	for j in range(q.value):
		capture_temp.append(capture[j](1))
		minus_temp.append(minus[j](1))
		search_temp.append(search[j](1))
		backoff_temp.append(backoff[j](1))
		min_v_temp.append(min_v[j](1))
		f_temp.append(f[j](1))


	dump.add( 

		input_spikes(0),

		capture_temp,
		minus_temp,
		search_temp,
		backoff_temp,
		min_v_temp,
		f_temp,

		rst(1),
		gclk(0),
		Delay(18),
		rst(0),

		#/* Computational Wave 1 */
	
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

		#/* Computational Wave 2 */

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

		#/* Computational Wave 3 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 4 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 5 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 6 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 7 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 8 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 9 */

		Delay(5),

		Delay(1),
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

		#/* Computational Wave 10 */

		Delay(5),

		Delay(1),
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

	m.Always(aclk) (i(i%23), 
		If(i==0) (
			gclk(1)) 
		.Else(
			gclk(0))
		, i.inc())

	return m 

if __name__=='__main__':
    test_col = mkTest_Column()
    if not os.path.exists('out_test'):
        os.mkdir('out_test')
    test_col_v = test_col.to_verilog('out_test/test_column.v')
    print(test_col_v)
    sim = simulation.Simulator(test_col)
    rslt = sim.run()
    print(rslt)
    #sim.view_waveform()







