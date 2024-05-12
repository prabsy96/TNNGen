from layer import Layer
from submodule import *
from backend.backend import * 
from rich.console import Console
from tnn_mdls.func_mdls import *
from tnn_mdls.tb_func_mdls import *
from veriloggen import *
import copy

class Model:
    def __init__(self, name):
        self.model = Module(name)
        self.layers = []

    def add(self, layer):

        # Check layer type (wip)
        if (layer.layer_type == "TNN"):
            pass
        elif (layer.layer_type == "CV"):
            pass
        elif (layer.layer_type == "Kernel"):
            pass
        else:
            raise ValueError("layer_type: '" + layer.layer_type + "' does not exist!")
        
        if (layer.layer_type == "TNN"):
            self.layers.append(self.check_params(layer.TNN_Layer_V2(len(self.layers))))
        elif (layer.layer_type == "CV"):
            self.layers.append(self.check_params(layer.CV_Layer(len(self.layers))))
        elif (layer.layer_type == "Kernel"):
            self.layers.append(self.check_params(layer.Kernel_Layer(len(self.layers))))
        

    def check_params(self, layer):
        
        # Check all layers but the first
        if (len(self.layers)==0):
            return layer
        
        prev_params = self.layers[-1].get_params()
        params = layer.get_params()
        in_size = params['IN_WIDTH'].value
        prev_out_size = prev_params['OUT_WIDTH'].value

        if (in_size != prev_out_size):
            raise ValueError("Incompatible input width")
        else:
            return layer
        
    def summary(self):
        for i in range(len(self.layers)):
            print(self.layers[i].name)
            params = self.layers[i].get_params()
            for key in params:
                print("    ", key, params[key].value)

        
    def compile(self):
        
        clk = self.model.Input('clk')
        grst = self.model.Input('grst')
        rstb = self.model.Input('rstb')

        self.generatePort()
        self.connectPort()

    def connectPort(self):
        model_ports = self.model.get_ports()
        model_params = self.model.get_params()

        for i in range(len(self.layers)):
            layer = self.layers[i]
            # Only add clk and rst ports to NN layer types
            if (layer.get_params()['is_clk'].value == 1):
                layer_ports = [model_ports['clk'], model_ports['grst'], model_ports['rstb']]
            else:
                layer_ports = []
            layer_params = []

            # Add params
            for key in model_params:
                if (key).startswith('L'+str(i)):
                    layer_params.append(model_params[key])
            
            # For first layer, add all ports with prefix L0
            if i == 0:
                for key in model_ports:
                    if ((key).startswith('L'+str(i)) | (key).startswith('model_input')):
                        layer_ports.append(model_ports[key])
                        
                # Instantiate wire to connect output to next layer's input
                if (i != (len(self.layers)-1)):
                    #neuron_count = self.layers[i].get_params()['NUM_NEURONS'].value * self.layers[i].get_params()['NUM_COL'].value
                    last_out_width = self.layers[i].get_params()['OUT_WIDTH']
                    last_out = self.model.Wire('out_'+str(i)+'_in_'+str(i+1), last_out_width.value)
                    layer_ports.append(last_out)
                else:
                    layer_ports.append(model_ports['model_output'])
            else:
                # distal input is last layer's output
                layer_ports.append(last_out)
                
                for key in model_ports:
                    if (key).startswith('L'+str(i)):
                        layer_ports.append(model_ports[key])
                        
                # Instantiate wire to connect output to next layer's input
                if (i != (len(self.layers)-1)):
                    #neuron_count = self.layers[i].get_params()['NUM_NEURONS'].value * self.layers[i].get_params()['NUM_COL'].value
                    last_out_width = self.layers[i].get_params()['OUT_WIDTH']
                    last_out = self.model.Wire('out_'+str(i)+'_in_'+str(i+1), last_out_width.value)
                    layer_ports.append(last_out)
                else:
                    layer_ports.append(model_ports['model_output'])

            self.model.Instance(layer, 'layer_inst_'+str(i), params=layer_params,
                        ports = layer_ports)


    def generatePort(self):
        # Generate model (wrapper) ports
        for i in range(len(self.layers)):
            layer = self.layers[i]
            ports = copy.deepcopy(layer.get_ports())
            params = copy.deepcopy(layer.get_params())

            # Copy all params to model
            for key in params:
                param = params[key]
                param_name = param.name
                param.name = 'L'+str(i)+'_'+param_name
                self.model.add_object(param)

            # model input ports should match layer 1 input ports
            if (i==0):
                # iterate through ports
                for key in ports:
                    port = ports[key]
                    port_name = port.name
                    # skip clk, grst, rstb
                    if ((port_name!='clk') & (port_name!='grst') & (port_name!='rstb')):
                        # add input ports to model
                        if (isinstance(port, core.vtypes.Input)):
                            if (port_name.startswith('layer_in')):
                                port.name = 'model_input'
                            else:
                                port.name = 'L0_'+port.name
                            self.model.add_object(port)
            # add non-connecting input ports to model for other layers
            else:
                # iterate through ports
                for key in ports:
                    port = ports[key]
                    port_name = port.name
                    # skip clk, grst, rstb
                    if ((port_name!='clk') & (port_name!='grst') & (port_name!='rstb')):
                        # add input ports to model
                        if (isinstance(port, core.vtypes.Input)):
                            # filter out connecting ports
                            if (not(port_name.startswith('layer_in'))):
                                port.name = 'L'+str(i)+'_'+port.name
                                self.model.add_object(port)
                                
            # generate output port
            if (i == len(self.layers)-1):
                for key in ports:
                    port = ports[key]
                    port_name = port.name
                    if (isinstance(port, core.vtypes.Output)):
                        port.name = 'model_output'
                        self.model.add_object(port)
