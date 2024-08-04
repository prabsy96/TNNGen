from tnn_mdls.func_mdls import *
from tnn_mdls.sim_utils import *
from layer import Layer

class Test_Layers():


    def Tb_Simple():   
        
        m = Module('test_simple')

        # parameters
        num_col = 1
        num_neurons = 1
        num_synapse = 18
        tres = 1
        wres = 3
        thres = 5
        extra_delay = 8

        # Initial inputs
        layer_in = 0
        w_init = 0
        capture_brv = 0
        minus_brv = 0
        search_brv = 0
        backoff_brv = 0
        min_brv = 0
        F_brv = 0

        L = Layer(layer_type="Simple", num_col=num_col, num_neurons=num_neurons, p_dist=num_synapse, wres_dist=wres, thres=thres)
        simple = L.Simple_Layer(0)
        dut = Submodule(m, simple, 'dut')

        # Setup waveform dump and simulation environment
        dump, clk, grst, rstb = init_dump(dut, m)

        input_init = [[0], # layer_in
                    [w_init], # w_init
                    [capture_brv], # capture_brv
                    [minus_brv], # minus_brv
                    [search_brv], # search_brv
                    [backoff_brv], # backoff_brv
                    [min_brv], # min_brv
                    [F_brv]] # F_brv
        delay_init = [0]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 8)
        grst_gen(m, ((2**tres)+(2**wres))+extra_delay)

        add_to_dump_from_file(dump, dut, "tnn_mdls/tests/MNIST_multi_column")

        return m