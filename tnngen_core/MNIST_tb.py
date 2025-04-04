import numpy as np
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import DataLoader
import torchvision
from torchvision.datasets import MNIST
from torchvision import transforms
from torch.distributions.bernoulli import Bernoulli
from utils import *
from tnn import *

### Random Variable Generation ###

def gen_brv(wave=10, ucapture=256, usearch=16, ubackoff=768, umin=32, wres=3):
    
    wmax        = 2**(wres)-1
    bcapture    = Bernoulli(ucapture/1024)
    bsearch     = Bernoulli(usearch/1024)
    bbackoff    = Bernoulli(ubackoff/1024)
    bmin        = Bernoulli(umin/1024)
    w           = torch.Tensor([float(l) for l in range(wmax+1)])
    bF          = Bernoulli((w/wmax)*(1-w/wmax))

    datasize    = wave
    rvcapture   = bcapture.sample([datasize])
    rvsearch    = bsearch.sample([datasize])
    rvbackoff   = bbackoff.sample([datasize])
    rvmin       = bmin.sample([datasize])
    rvF = bF.sample([datasize])

    return rvcapture, rvsearch, rvbackoff, rvmin, rvF

def MNIST_multi_column(inputsize=3, rfsize=3, stride=3, nprev=2, num_neuron=1, num_synapse=18, thres=5, tres=1, wres=3, wave=10, ucapture=128, usearch=128, ubackoff=128, umin=128, extra_delay=8, verbose=False):
    
    num_column = int(((inputsize-rfsize)/stride + 1)**2)

    print("Testbench configuration: ")
    print("num_column: ", num_column)
    print("num_neuron: ", num_neuron)
    print("num_synapse: ", num_synapse)
    print("wres: ", wres)
    print("waves: ", wave)
    
    mnist_posneg = MNIST(root='./data', train=True, download=True, transform=transforms.Compose([transforms.ToTensor(),PosNeg(0.5),transforms.CenterCrop(inputsize)]))
    
    # Generate brv random variables
    rvcapture, rvsearch, rvbackoff, rvmin, rvF = gen_brv(wave=wave, ucapture=ucapture, usearch=usearch, ubackoff=ubackoff, umin=umin, wres=wres)
    
    # Initialze PyTorch model
    layer = TNNColumnLayer(inputsize=inputsize, rfsize=rfsize, stride=stride, nprev=nprev, neurons=num_neuron, theta=thres,\
    timeres=tres, wres=wres, ntype="rnl", ramp=1, w_init="zero", k=1, stoch="low", reward_en=0)
    
    f = open("tnn_mdls/tests/MNIST_multi_column", "w")
    f.write('# Init: \n')
    f.write('layer_in(0),\n\n')
    
    for w in range(wave):
        
        f.write('# Wave: '+ str(w) +'\n')
        img, label = mnist_posneg[w]
        
        output_spiketimes, input_spiketimes, li_spiketimes = layer(img)
        layer.weights = layer.stdp(input_spiketimes, output_spiketimes, layer.weights,\
                         rvcapture[w], rvsearch[w], rvbackoff[w], rvmin[w], rvF[w])
        
        if verbose:
            print('wave: ', w)
            print('input spikes: ', input_spiketimes)
            print('li_spike: ', li_spiketimes)
            print('weights_out: ', layer.weights)
            print('capture: ', rvcapture[w])
            print('search: ', rvsearch[w])
            print('backoff: ', rvbackoff[w])
            print('min: ', rvmin[w])
            print('minus: ', rvbackoff[w])
            print('F: ', rvF[w])
            print('')
        
        img_flat = (input_spiketimes[0::num_neuron, :]).flatten()
        img_flat += 1
        
        # generate input spike times
        img_flat[img_flat==float('inf')] = -1
        in_spike_times = np.array(img_flat)
        in_reset_times = np.zeros(in_spike_times.shape)
        for i in range(num_column * num_synapse):
            if in_spike_times[i]>0:
                in_reset_times[i] = in_spike_times[i]+(2**wres)
            else:
                in_reset_times[i] = -1
                
        # generate output spike time
        li_spike_reformat = torch.tensor([])
        for i in range(int(np.sqrt(num_column))):
            for j in range(int(np.sqrt(num_column))):
                li_spike_reformat = torch.cat((li_spike_reformat, torch.flip(li_spiketimes[:, i, j], [0])))
        li_spiketimes = li_spike_reformat        
        li_spiketimes += 1
        li_spiketimes[li_spiketimes==float('inf')] = -1
        out_spike_times = li_spiketimes.flatten()
        out_reset_times = np.zeros(out_spike_times.shape)
        for i in range(num_column * num_neuron):
            if out_spike_times[i]>0:
                out_reset_times[i] = out_spike_times[i]+(8)
            else:
                out_reset_times[i] = -1

        in_bits = ['0'] * num_column * num_synapse
        out_bits = ['0'] * num_column * num_neuron
        delays = []
        layer_in = []
        layer_out = []
        delay = 0
        layer_in_string = '0'
        layer_out_string = '0'
        
        for t in range(2**tres + 2**wres - 1 + extra_delay):
            if (t in in_spike_times) or (t in out_spike_times):
                delays += [delay]
                delay = 0
                in_time_matches = np.where(in_spike_times == t)[0]
                out_time_matches = np.where(out_spike_times == t)[0]

                # Calculate layer_in vector
                for i in range(len(in_time_matches)):
                    index = in_time_matches[i]
                    in_bits[index] = '1'

                layer_in_string = ''
                for i in range(num_column * num_synapse):
                    layer_in_string += in_bits[i]
                layer_in += [hex(int(layer_in_string, 2))]
                                
                # Calculate layer_out vector
                for i in range(len(out_time_matches)):
                    index = out_time_matches[i]
                    out_bits[index] = '1'
                    
                layer_out_string = ''
                for i in range(num_column * num_neuron):
                    layer_out_string += out_bits[i]
                layer_out += [hex(int(layer_out_string, 2))]
                
            elif (t in in_reset_times) or (t in out_spike_times) or (t in out_reset_times):
                delays += [delay]
                delay = 0
                in_time_matches = np.where(in_reset_times == t)[0]
                out_time_matches = np.where(out_spike_times == t)[0]
                out_reset_matches = np.where(out_reset_times == t)[0]

                # Calculate layer_in vector
                for i in range(len(in_time_matches)):
                    index = in_time_matches[i]
                    in_bits[index] = '0'

                layer_in_string = ''
                for i in range(num_column * num_synapse):
                    layer_in_string += in_bits[i]
                layer_in += [hex(int(layer_in_string, 2))]
                                
                # Calculate layer_out vector
                for i in range(len(out_time_matches)):
                    index = out_time_matches[i]
                    out_bits[index] = '1'
                    
                for i in range(len(out_reset_matches)):
                    index = out_reset_matches[i]
                    out_bits[index] = '0'
                    
                layer_out_string = ''
                for i in range(num_column * num_neuron):
                    layer_out_string += out_bits[i]
                layer_out += [hex(int(layer_out_string, 2))]

            delay+=1

        layer_in += [hex(0)]
        layer_out += [hex(0)]
        delays += [delay]
        delays[0]-=0.5

        if verbose:
            print('layer_in, layer_out, delays')
            print(layer_in, layer_out, delays)
            print('')
            
        # write brv variables
        f.write('Delay(0.5),\n')
        f.write('capture_brv('+str(int(rvcapture[w].item()))+'),\n')
        f.write('search_brv('+str(int(rvsearch[w].item()))+'),\n')
        f.write('backoff_brv('+str(int(rvbackoff[w].item()))+'),\n')
        f.write('min_brv('+str(int(rvmin[w].item()))+'),\n')
        f.write('minus_brv('+str(int(rvbackoff[w].item()))+'),\n')
        f.write('F_brv('+str(int(''.join(map(str,rvF[w][1:-1].int().tolist()))[::-1], base=2))+'),\n')
        f.write('\n')
            
        # write input vector and delay
        layer_in_prev = -1
        layer_out_prev = -1
        for i in range(len(layer_in)):
            f.write('Delay('+str(delays[i])+'),\n')
            if layer_in[i] != layer_in_prev:
                #f.write('layer_in('+str(layer_in[i])+'),\n')
                f.write('EmbeddedCode("""dut_layer_in = ' +'\'h'+ layer_in[i][2:] +';"""),\n')
                layer_in_prev = layer_in[i]
            if layer_out[i] != 0 and layer_out[i] != layer_out_prev and layer_out[i] != '0x0':
                f.write('Delay(0.1),\n')
                f.write('EmbeddedCode("""assert (dut_layer_out == ' +'\'h'+ layer_out[i][2:] +') else $error(\\"Output error: %h\\", dut_layer_out); """),\n')
                delays[i+1] -= 0.1
                layer_out_prev = layer_out[i]
            f.write('\n')
            
    f.write('layer_in(0),\n')
    f.write('Delay(100),\n')

