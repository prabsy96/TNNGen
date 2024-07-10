from tnn_mdls.func_mdls import *
from tnn_mdls.sim_utils import *
from layer import Layer

class Test_Layers():


    def Tb_Simple():   
        
        m = Module('test_simple')

        # parameters
        num_col = 1
        num_neurons = 4
        num_synapse = 18
        tres = 1
        wres = 7
        thres = 64

        # Initial inputs
        layer_in = 0
        w_init = 0
        capture_brv = -1
        minus_brv = -1
        search_brv = -1
        backoff_brv = -1
        min_brv = -1
        F_brv = -1

        L = Layer(layer_type="Simple", num_col=num_col, num_neurons=num_neurons, p_dist=num_synapse, wres_dist=wres, thres=thres)
        simple = L.Simple_Layer(0)
        dut = Submodule(m, simple, 'dut')

        # Setup waveform dump and simulation environment
        dump, clk, grst, rstb = init_dump(dut, m)

        input_init = [[0], # layer_in
                    [0], # w_init
                    [capture_brv], # capture_brv
                    [minus_brv], # minus_brv
                    [search_brv], # search_brv
                    [backoff_brv], # backoff_brv
                    [min_brv], # min_brv
                    [F_brv]] # F_brv
        delay_init = [0]

        add_to_dump(dump, dut, input_init, delay_init, 1)

        rstb_gen(dump, rstb, 8)
        grst_gen(m, ((2**tres)+(2**wres)))

        add_to_dump_from_file(dump, dut, "tnn_mdls/tests/MNIST_single_column")

        return m