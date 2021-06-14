### Author: Harideep Nair ###

# This code implements a multilayer TNN built from columns



### Importing libraries ###

import torch
import torch.nn.functional as F
from torch.utils.data import DataLoader
from torch.distributions.bernoulli import Bernoulli

from tnn import *
from preproc import *

import torchvision
from torchvision.datasets import MNIST
from torchvision import transforms
from torchvision.utils import save_image

import argparse
import matplotlib.pyplot as plt
import time



### Argument parsing ###

parser = argparse.ArgumentParser(description="A multilayer CVT Temporal Neural Network")

parser.add_argument('--seed',           type=int, default=0,\
                    help='seeed for randomization')

parser.add_argument('--imgsize',        type=int, default=28,\
                    help='size of input image')

parser.add_argument('--rfsize',         type=int, default=4,\
                    help='size of receptive field')

parser.add_argument('--stride',         type=int, default=1,\
                    help='stride for sliding receptive field')

parser.add_argument('--neurons',        type=int, default=12,\
                    help='number of neurons per TNN column')

parser.add_argument('--theta',          type=int, default=40,\
                    help='spiking threshold of neuron')

parser.add_argument('--num_classes',    type=int, default=10,\
                    help='number of classes or labels')

parser.add_argument('--voter_thresh',   type=float, default=0.5,\
                    help='theshold for weight selection in voter')


parser.add_argument('--enc',            type=str, default='bw',\
                    help='bw for black and white; gray for grayscale')

parser.add_argument('--bw_thresh',      type=float, default=0.1,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--pn_thresh',      type=float, default=0.5,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--gray_thresh',    type=int, default=8,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--filter',         type=int, default=1,\
                    help='0 for no On-Off filtering; 1 for On-Off filtering')

parser.add_argument('--filter_size',    type=int, default=3,\
                    help='OnOff filter window size')

parser.add_argument('--timeres',        type=int, default=0,\
                    help='bit resolution for maximum input spiketime')

parser.add_argument('--wres',           type=int, default=3,\
                    help='bit resolution for weights')

parser.add_argument('--ntype',          type=str, default='rnl',\
                    help='snl for step-no-leak; rnl for ramp-no-leak')

parser.add_argument('--ramp',           type=float, default=1,\
                    help='slope of ramp-no-leak response function')

parser.add_argument('--weight_init',    type=str, default='zero',\
                    help='zero for initializing weights to zero;\
                    uniform for random uniform initialization in {0,wmax};\
                    normal for random normal initialization in with mean=(wmax+1)/2 and std=1')

parser.add_argument('--k',              type=int, default=1,\
                    help='for k-WTA')

parser.add_argument('--stoch',          type=str, default="low",\
                    help='level of stochasticity for STDP')

parser.add_argument('--stoch_v',        type=str, default="low",\
                    help='level of stochasticity for voter RSTDP')

parser.add_argument('--ucapture',       type=int, default=640,\
                    help='STDP capture Bernoulli random variable probability')

parser.add_argument('--usearch',        type=int, default=16,\
                    help='STDP search Bernoulli random variable probability')

parser.add_argument('--ubackoff',       type=int, default=952,\
                    help='STDP backoff Bernoulli random variable probability')

parser.add_argument('--umin',           type=int, default=70,\
                    help='STDP min Bernoulli random variable probability')

parser.add_argument('--ucapture_v',     type=int, default=952,\
                    help='STDP capture Bernoulli random variable probability for voter')

parser.add_argument('--usearch_v',      type=int, default=832,\
                    help='STDP search Bernoulli random variable probability for voter')

parser.add_argument('--ubackoff_v',     type=int, default=128,\
                    help='STDP backoff Bernoulli random variable probability for voter')

parser.add_argument('--ubackoff_simp',  type=int, default=512,\
                    help='STDP backoff_simp Bernoulli random variable probability for voter')

parser.add_argument('--umin_v',         type=int, default=32,\
                    help='STDP min Bernoulli random variable probability for voter')

parser.add_argument('--inc_learn',      type=int, default=0,\
                    help='0 for no STDP during testing; 1 for incremental learning during testing via STDP')

parser.add_argument('--train1',         type=int, default=10000,\
                    help='Number of training samples for Layer 1')

parser.add_argument('--train2',         type=int, default=20000,\
                    help='Number of training samples for Layer 2')

parser.add_argument('--test',           type=int, default=10000,\
                    help='Number of testing samples')

args = parser.parse_args()

torch.manual_seed(args.seed)

### Parameters ###

imgsize         = args.imgsize            # Size of input image
rfsize          = args.rfsize             # Size of receptive field (first layer)
stride          = args.stride             # Stride for sliding the receptive field (first layer)
neurons         = args.neurons            # Number of neurons per TNN Column (first layer)
theta           = args.theta              # Spiking threshold of neurons (first layer)
num_classes     = args.num_classes        # Number of labels or classes (first layer)
voter_thresh    = args.voter_thresh       # Threshold for weight selection in TNN voter (second layer)


timeres         = args.timeres            # Bit resolution for maximum input spiketime
wres            = args.wres               # Bit resolution for weights
ntype           = args.ntype              # SRM0 neuron response function model
ramp            = args.ramp               # Slope of ramp-no-leak response function
w_init          = args.weight_init        # Weight initialization
k               = args.k                  # For k-WTA
stoch           = args.stoch              # Level of stochasticity for STDP
stoch_v         = args.stoch_v            # Level of stochasticity for voter RSTDP

ucapture        = args.ucapture           # STDP's "capture" Bernoulli random variable probability
usearch         = args.usearch            # STDP's "search" Bernoulli random variable probability
ubackoff        = args.ubackoff           # STDP's "backoff" Bernoulli random variable probability
umin            = args.umin               # STDP's "min" Bernoulli random variable probability

ucapture_v      = args.ucapture_v         # STDP's "capture" Bernoulli random variable probability for voter
usearch_v       = args.usearch_v          # STDP's "search" Bernoulli random variable probability for voter
ubackoff_v      = args.ubackoff_v         # STDP's "backoff" Bernoulli random variable probability for voter
ubackoff_simp   = args.ubackoff_simp      # STDP's "backoff_simp" Bernoulli random variable probability for voter
umin_v          = args.umin_v             # STDP's "min" Bernoulli random variable probability for voter

inc_learn       = args.inc_learn          # Enable/disable unsupervised STDP incremental learning during testing

train1          = args.train1             # Number of training samples for Layer 1
train2          = args.train2             # Number of training samples for Layer 2
test            = args.test               # Number of testing samples

nprev           = 1                       # Number of channels in the first layer 
weights_save    = 1                       # Save weights after training

if not isinstance(imgsize,tuple):
    imgsize     = (imgsize,imgsize)

if not isinstance(rfsize,tuple):
    rfsize      = (rfsize,rfsize)

rows            = (imgsize[0]-rfsize[0])//stride + 1
cols            = (imgsize[1]-rfsize[1])//stride + 1



### MNIST dataset loading and preprocessing ###

transforms_list = []

transforms_list.append(transforms.ToTensor())

if args.filter == 1:
    transforms_list.append(PosNeg(args.pn_thresh))
    nprev = 2

# if args.filter == 1:
#     transforms_list.append(OnOff_Channels(args.filter_size))
#     nprev = 2

# if args.enc == "bw":
#     transforms_list.append(BlackAndWhite(args.bw_thresh))
# elif args.enc == "gray":
#     transforms_list.append(GrayScale(args.timeres, args.gray_thresh))

train_loader = DataLoader(MNIST('../data', True, download=True, transform=transforms.Compose(transforms_list)),
                          batch_size=1,
                          shuffle=True
                         )

test_loader = DataLoader(MNIST('../data', False, download=True, transform=transforms.Compose(transforms_list)),
                          batch_size=1,
                          shuffle=False
                         )



### Layer Initialization ###

layer1 = TNNColumnLayer(inputsize=imgsize, rfsize=rfsize, stride=stride, nprev=nprev, neurons=neurons, theta=theta,\
                        timeres=timeres, wres=wres, ntype=ntype, ramp=ramp, w_init=w_init, k=k, stoch=stoch, reward_en=0)

layer2 = TNNVoterTallyLayer(rows=rows, cols=cols, nprev=neurons, num_classes=num_classes, voter_thresh=voter_thresh,\
                            wres=wres, w_init=w_init, stoch=stoch_v)



### Random Variable Generation ###

start         = time.time()

wmax          = 2**(wres)-1
bcapture      = Bernoulli(ucapture/1024)
bsearch       = Bernoulli(usearch/1024)
bbackoff      = Bernoulli(ubackoff/1024)
bbackoff_simp = Bernoulli(ubackoff_simp/1024)
bmin          = Bernoulli(umin/1024)
w             = torch.Tensor([float(l) for l in range(wmax+1)])
bstickup      = Bernoulli((w/wmax)*(2-w/wmax))
bstickdown    = Bernoulli((1-w/wmax)*(1+w/wmax))

datasize      = len(train_loader) + len(test_loader)

if stoch == "low":
    rvcapture      = bcapture.sample([datasize])
    rvsearch       = bsearch.sample([datasize])
    rvbackoff      = bbackoff.sample([datasize])
    rvbackoff_simp = bbackoff_simp.sample([datasize])
    rvmin          = bmin.sample([datasize])
    rvstickup      = bstickup.sample([datasize])
    rvstickdown    = bstickdown.sample([datasize])

elif stoch == "high":
    p              = rfsize[0]*rfsize[1]*nprev
    q              = neurons
    rvcapture      = bcapture.sample([datasize,q,p]).repeat(1,rows*cols,1)
    rvsearch       = bsearch.sample([datasize,q,p]).repeat(1,rows*cols,1)
    rvbackoff      = bbackoff.sample([datasize,q,p]).repeat(1,rows*cols,1)
    rvbackoff_simp = bbackoff_simp.sample([datasize,q,p]).repeat(1,rows*cols,1)
    rvmin          = bmin.sample([datasize,q,p]).repeat(1,rows*cols,1)
    rvstickup      = bstickup.sample([datasize,q,p]).repeat(1,rows*cols,1,1)
    rvstickdown    = bstickdown.sample([datasize,q,p]).repeat(1,rows*cols,1,1)

end           = time.time()
print("Random variables generated in ", end-start)



### Training ###

print("Starting first layer training")
for epochs in range(1):
    start = time.time()
    
    for idx, (data,target) in enumerate(train_loader):
        if idx == train1:
            break
        print("Iteration: {0}\r".format(idx), end="")
        data                   = data[0]
        layer_out, layer_in, _ = layer1(data)
        weights_out            = layer1.stdp(layer_in, layer_out, layer1.weights, rvcapture[idx], rvsearch[idx],\
                                          rvbackoff[idx], rvmin[idx], rvstickup[idx], rvstickdown[idx])
        endt                   = time.time()
        print("                                 Time elapsed: {0}\r".format(endt-start), end="")
    
    end   = time.time()
    print("First layer training done for {0} in {1} seconds".format(idx, int(end-start)))



### Display and save weights as images ###

if weights_save == 1:
    image_list = []
    for i in range(rows*cols):
        temp = layer1.weights[(i*neurons)+(i%neurons)].reshape(rfsize[0]*nprev,rfsize[1])
        image_list.append(temp)

    out = torch.stack(image_list, dim=0).unsqueeze(1)
    save_image(out, '../images/cvt/layer1_visweights.png', nrow=cols)



### Random Variable Generation ###

# ucapture        = 952           # STDP's "capture" Bernoulli random variable probability
# usearch         = 832           # STDP's "search" Bernoulli random variable probability
# ubackoff        = 128           # STDP's "backoff" Bernoulli random variable probability
# ubackoff_simp   = 512           # STDP's "backoff_simp" Bernoulli random variable probability
# umin            = 32            # STDP's "min" Bernoulli random variable probability

start         = time.time()

wmax          = 2**(wres)-1
bcapture      = Bernoulli(ucapture_v/1024)
bsearch       = Bernoulli(usearch_v/1024)
bbackoff      = Bernoulli(ubackoff_v/1024)
bbackoff_simp = Bernoulli(ubackoff_simp/1024)
bmin          = Bernoulli(umin_v/1024)
w             = torch.Tensor([float(l) for l in range(wmax+1)])
bstickup      = Bernoulli((w/wmax)*(2-w/wmax))
bstickdown    = Bernoulli((1-w/wmax)*(1+w/wmax))

datasize      = len(train_loader) + len(test_loader)

if stoch_v == "low":
    rvcapture      = bcapture.sample([datasize])
    rvsearch       = bsearch.sample([datasize])
    rvbackoff      = bbackoff.sample([datasize])
    rvbackoff_simp = bbackoff_simp.sample([datasize])
    rvmin          = bmin.sample([datasize])
    rvstickup      = bstickup.sample([datasize])
    rvstickdown    = bstickdown.sample([datasize])

elif stoch_v == "high":
    p              = neurons
    q              = num_classes
    rvcapture      = bcapture.sample([datasize,p,q]).repeat(1,rows*cols,1)
    rvsearch       = bsearch.sample([datasize,p,q]).repeat(1,rows*cols,1)
    rvbackoff      = bbackoff.sample([datasize,p,q]).repeat(1,rows*cols,1)
    rvbackoff_simp = bbackoff_simp.sample([datasize,p,q]).repeat(1,rows*cols,1)
    rvmin          = bmin.sample([datasize,p,q]).repeat(1,rows*cols,1)
    rvstickup      = bstickup.sample([datasize,p,q]).repeat(1,rows*cols,1,1)
    rvstickdown    = bstickdown.sample([datasize,p,q]).repeat(1,rows*cols,1,1)

end           = time.time()
print("Random variables generated in ", end-start)



print("Starting second layer training")
for epochs in range(1):
#     count = 0
    start = time.time()
    
    for idx, (data,target) in enumerate(train_loader):
        if idx == train2:
            break
        print("Iteration: {0}\r".format(idx), end="")
        data                            = data[0]
        layer_out, layer_in, _          = layer1(data)
#         if torch.nonzero(layer_out != float('Inf')).shape[0] == 1568:
#             count = count + 1
        voter_in, voter_out, prediction = layer2(layer_out)
        weights_out                     = layer2.stdp(target[0], prediction, voter_in, voter_out,\
                                                      layer2.weights,rvcapture[idx], rvsearch[idx],\
                                                      rvbackoff[idx], rvbackoff_simp[idx], rvmin[idx], rvstickup[idx],\
                                                      rvstickdown[idx])
        endt = time.time()
        print("                                 Time elapsed: {0}\r".format(endt-start), end="")
    
#     print("First Layer Coverage: ", count/(idx+1))
    end = time.time()
    print("Second layer training done for {0} in {1} seconds".format(idx, (end-start)))



### Display and save weights as images ###

if weights_save == 1:   
#     image_list = []
#     for i in range(neurons):
#         temp = layer1.weights[i].reshape(rfsize[0]*nprev,rfsize[1])
#         image_list.append(temp)

#     out = torch.stack(image_list, dim=0).unsqueeze(1)
#     save_image(out, '../images/column/visweights.png', nrow=neurons//2)

    image_list = []
    for i in range(rows*cols):
        temp = layer1.weights[i*neurons:(i+1)*neurons]
        image_list.append(temp)

    out = torch.stack(image_list, dim=0).unsqueeze(1)
    save_image(out, '../images/cvt/layer1weights.png', nrow=cols)
    
    image_list = []
    for i in range(rows*cols):
        temp = layer2.weights[i*neurons:(i+1)*neurons]
        image_list.append(temp)

    out = torch.stack(image_list, dim=0).unsqueeze(1)
    save_image(out, '../images/cvt/layer2weights.png', nrow=cols)



### Testing and computing metrics ###

table    = torch.zeros((10,10))
pred     = torch.zeros(10)
totals   = torch.zeros(10)

print("Starting testing")
start    = time.time()

for idx, (data,target) in enumerate(test_loader):
    if idx == test:
        break
    print("Iteration: {0}\r".format(idx), end="")
    tid         = idx + len(train_loader)   
    
    data = data[0]
    layer_out, layer_in, _          = layer1(data)
    voter_in, voter_out, prediction = layer2(layer_out)
    
    arg = torch.nonzero(prediction)
    if arg.shape[0] != 0:
        table[arg[0].long(), target[0]] += 1
    
    endt = time.time()
    print("                                 Time elapsed: {0}\r".format(endt-start), end="")

end = time.time()
print("Testing done for {0} in {1} seconds".format((idx+1), (end-start)))

print("Confusion Matrix:")
print(table.int())

maxval   = torch.max(table, 1)[0]
totals   = torch.sum(table, 1)
pred     = torch.sum(maxval)
covg_cnt = torch.sum(totals)

print("Purity: ", pred/covg_cnt)
print("Coverage: ", covg_cnt/(idx+1))
print("Accuracy: ", pred/(idx+1))