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

parser = argparse.ArgumentParser(description="A multilayer Temporal Neural Network")

parser.add_argument('--enc',            type=str, default='bw',\
                    help='bw for black and white; gray for grayscale')

parser.add_argument('--bw_thresh',      type=float, default=0.1,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--gray_thresh',    type=int, default=8,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--resize',         type=int, default=0,\
                    help='0 for no resizing; 1 for resizing')

parser.add_argument('--resize_param',   type=tuple, default=(16,16),\
                    help='output size after resizing')

parser.add_argument('--crop',           type=int, default=0,\
                    help='0 for no cropping; 1 for cropping')

parser.add_argument('--crop_size',      type=tuple, default=(4,4),\
                    help='output size after cropping')

parser.add_argument('--crop_pos',       type=tuple, default=(12,12),\
                    help='top left corner of crop position')

parser.add_argument('--filter',         type=int, default=0,\
                    help='0 for no On-Off filtering; 1 for On-Off filtering')

parser.add_argument('--filter_size',    type=int, default=3,\
                    help='OnOff filter window size')

parser.add_argument('--timeres',        type=int, default=3,\
                    help='bit resolution for maximum input spiketime')

parser.add_argument('--q',              type=int, default=10,\
                    help='number of neurons in the excitatory column')

parser.add_argument('--wres',           type=int, default=3,\
                    help='bit resolution for weights')

parser.add_argument('--theta',          type=int, default=91,\
                    help='neuron threshold')

parser.add_argument('--ntype',          type=str, default='rnl',\
                    help='snl for step-no-leak; rnl for ramp-no-leak')

parser.add_argument('--weight_init',    type=str, default='zero',\
                    help='zero for initializing weights to zero;\
                    uniform for random uniform initialization in {0,wmax};\
                    normal for random normal initialization in with mean=(wmax+1)/2 and std=1')

parser.add_argument('--k',              type=int, default=1,\
                    help='for k-WTA')

parser.add_argument('--stoch',          type=str, default="low",\
                    help='level of stochasticity for STDP')

parser.add_argument('--ucapture',       type=int, default=240,\
                    help='STDP capture Bernoulli random variable probability')

parser.add_argument('--usearch',        type=int, default=16,\
                    help='STDP capture Bernoulli random variable probability')

parser.add_argument('--ubackoff',       type=int, default=768,\
                    help='STDP capture Bernoulli random variable probability')

parser.add_argument('--umin',           type=int, default=32,\
                    help='STDP capture Bernoulli random variable probability')

parser.add_argument('--inc_learn',      type=int, default=0,\
                    help='0 for no STDP during testing; 1 for incremental learning during testing via STDP')

args = parser.parse_args()



### Parameters ###

imgsize = (28,28)

if args.resize == 1:
    if args.filter == 0:
        imgsize = args.resize_param                             # Size of input image
    elif args.filter == 1:
        imgsize = (2*args.resize_param[0],args.resize_param[1]) # Size of input image

if args.crop == 1:
    if args.filter == 0:
        imgsize = args.crop_size                                # Size of input image
    elif args.filter == 1:
        imgsize = (2*args.crop_size[0],args.crop_size[1])       # Size of input image                 

timeres         = args.timeres            # Bit resolution for maximum input spiketime
wres            = args.wres               # Bit resolution for weights
theta           = args.theta              # Threshold of neuron
ntype           = args.ntype              # SRM0 neuron response function model
w_init          = args.weight_init        # Weight initialization
k               = args.k                  # For k-WTA
stoch           = args.stoch              # Level of stochasticity for STDP

ucapture        = args.ucapture           # STDP's "capture" Bernoulli random variable probability
usearch         = args.usearch            # STDP's "search" Bernoulli random variable probability
ubackoff        = args.ubackoff           # STDP's "backoff" Bernoulli random variable probability
umin            = args.umin               # STDP's "min" Bernoulli random variable probability

inc_learn       = args.inc_learn          # Enable/disable unsupervised STDP incremental learning during testing

train_display   = 0                       # Display weights after training
weights_save    = 0                       # Save weights after training
test_display    = 0                       # Display weights after testing



### MNIST dataset loading and preprocessing ###

transforms_list = []

if args.resize == 1:
    transforms_list.append(transforms.Resize(args.resize_param))

transforms_list.append(transforms.ToTensor())

if args.crop == 1:
    transforms_list.append(Crop(pos=args.crop_pos, size=args.crop_size))

if args.filter == 1:
    transforms_list.append(OnOff(args.filter_size))

if args.enc == "bw":
    transforms_list.append(BlackAndWhite(args.bw_thresh))
elif args.enc == "gray":
    transforms_list.append(GrayScale(args.timeres, args.gray_thresh))

train_loader = DataLoader(MNIST('../data', True, download=True, transform=transforms.Compose(transforms_list)),
                          batch_size=1,
                          shuffle=True
                         )

test_loader = DataLoader(MNIST('../data', False, download=True, transform=transforms.Compose(transforms_list)),
                          batch_size=1,
                          shuffle=False
                         )



### A single TNN column with EC, LI and STDP ###

class TNNColumn():
    def __init__(self, timeres, p, q, wres, theta, ntype, w_init, k):
        tin_max         = 2**timeres-1
        
        self.ec         = ExcitatoryColumn(tin_max, p, q, wres, theta, ntype, w_init)
        self.li         = LateralInhibition(k)
        
    def __call__(self, data):
        data            = torch.flatten(data)
        ec_out          = self.ec(data)
        li_out, winidx  = self.li(ec_out)
        return li_out, winidx



### A single TNN layer ###

class TNNLayer():
    def __init__(self, inputsize, rfsize, nprev, stride, neurons, max_tin, wres, theta, ntype, reward_en, k=1):
        if not isinstance(inputsize,tuple):
            inputsize  = (inputsize,inputsize)
        if not isinstance(rfsize,tuple):
            rfsize     = (rfsize,rfsize)
        
        self.rfsize        = rfsize
        self.stride        = stride
        self.rows          = ((inputsize[0]-rfsize[0])//stride) + 1
        self.cols          = ((inputsize[1]-rfsize[1])//stride) + 1
        self.p             = rfsize[0]*rfsize[1]*nprev
        self.q             = neurons
        self.time          = max_tin
        
        if reward_en == 0:
            self.stdp   = STDP(wres)
        else:
            self.stdp   = RSTDP(wres)
        
        self.columns       = [[None]*self.cols for _ in range(self.rows)]
        for r in range(self.rows):
            for c in range(self.cols):
                self.columns[r][c] = TNNColumn(self.time, self.p, self.q, wres, theta, ntype, k)
        
        self.outspiketimes = float('Inf')*torch.ones(self.rows,self.cols,self.q)
        self.winners       = -1*torch.ones(self.rows,self.cols)
        
    def insert_weights(self, weights):
        wtuple = torch.split(weights, self.q, dim=0)
        for r in range(self.rows):
            for c in range(self.cols):   
                self.columns[r][c].ec.weights = wtuple[r*self.cols+c]
    
    def __call__(self, data):
        dtemp = torch.flatten(data[0:self.rfsize[0],0:self.rfsize[1]])
        self.outspiketimes[0][0], self.winners[0][0] = self.columns[0][0](dtemp)
        qtemp           = self.outspiketimes[0][0].shape[0]
        ptemp           = dtemp.shape[0]
        layer_in        = dtemp.repeat(qtemp,1)
        layer_out       = self.outspiketimes[0][0].repeat(ptemp,1).permute(1,0)
        weights_in      = self.columns[0][0].ec.weights
        
        for r in range(self.rows):
            for c in range(self.cols):
                if r == 0 and c == 0:
                    continue
                dtemp = torch.flatten(data[r*self.stride:r*self.stride+self.rfsize[0],\
                                     c*self.stride:c*self.stride+self.rfsize[1]])
                self.outspiketimes[r][c], self.winners[r][c] = self.columns[r][c](dtemp)
                qtemp           = self.outspiketimes[r][c].shape[0]
                ptemp           = dtemp.shape[0]
                intemp          = dtemp.repeat(qtemp,1)
                outtemp         = self.outspiketimes[r][c].repeat(ptemp,1).permute(1,0)
                layer_in        = torch.cat([layer_in,intemp], dim=0)
                layer_out       = torch.cat([layer_out,outtemp], dim=0)
                weights_in      = torch.cat([weights_in,self.columns[r][c].ec.weights], dim=0)
        
        return self.outspiketimes, self.winners, layer_in, layer_out, weights_in



### Random Variable Generation ###

start       = time.time()

wmax        = 2**(wres)-1
bcapture    = Bernoulli(ucapture/1024)
bsearch     = Bernoulli(usearch/1024)
bbackoff    = Bernoulli(ubackoff/1024)
bmin        = Bernoulli(umin/1024)
w           = torch.Tensor([float(l) for l in range(wmax+1)])
bstickup    = Bernoulli((w/wmax)*(2-w/wmax))
bstickdown  = Bernoulli((1-w/wmax)*(1+w/wmax))

datasize    = len(train_loader) + len(test_loader)

if stoch == "low":
    rvcapture   = bcapture.sample([datasize])
    rvsearch    = bsearch.sample([datasize])
    rvbackoff   = bbackoff.sample([datasize])
    rvmin       = bmin.sample([datasize])
    rvstickup   = bstickup.sample([datasize])
    rvstickdown = bstickdown.sample([datasize])

elif stoch == "high":
    rvcapture   = bcapture.sample([datasize,q,p])
    rvsearch    = bsearch.sample([datasize,q,p])
    rvbackoff   = bbackoff.sample([datasize,q,p])
    rvmin       = bmin.sample([datasize,q,p])
    rvstickup   = bstickup.sample([datasize,q,p])
    rvstickdown = bstickdown.sample([datasize,q,p])

end         = time.time()
print("Random variables generated in ", end-start)



### Layer Initialization ###

layer1 = TNNLayer(imgsize, 14, 14, 1, 16, 64, timeres, wres, ntype)
layer2 = TNNLayer(2, 2, 2, 16, 10, 12, timeres, wres, ntype, reward_en=1)



### Training ###

display   = 0

if display == 1:
    f, ax     = plt.subplots(18,10,figsize=(18,10))

for epochs in range(1):
    start = time.time()
    count = 0
    
    for idx, (data,target) in enumerate(train_loader):
        data = data[0][0]
        out1, winner1, layer_in, layer_out, weights_in = layer1(data)
        weights_out = layer1.stdp(layer_in, layer_out, weights_in, rvcapture[idx], rvsearch[idx],\
                                  rvbackoff[idx], rvmin[idx], rvstickup[idx], rvstickdown[idx])
        layer1.insert_weights(weights_out)
        
        if display == 1:
            if idx%100 == 0 and idx <= 1000:
                for i in range(10):
                    ax[idx//100][i].imshow(MyColumn.ec.weights[i].resize(imgsize[0],imgsize[1]))
            if idx == 2000:
                for i in range(10):
                    ax[11][i].imshow(MyColumn.ec.weights[i].resize(imgsize[0],imgsize[1]))
            if idx == 5000:
                for i in range(10):
                    ax[12][i].imshow(MyColumn.ec.weights[i].resize(imgsize[0],imgsize[1]))
            if idx%10000 == 0 and idx >= 10000:
                count += 1
                for i in range(10):
                    ax[12+count][i].imshow(MyColumn.ec.weights[i].resize(imgsize[0],imgsize[1]))
    
    end = time.time()
    print("Training done in ", end-start)

for epochs in range(1):
    start = time.time()
    
    for idx, (data,target) in enumerate(train_loader):
        data = data[0][0]
        out1, winner1, layer_in1, layer_out1, weights_in1 = layer1(data)
        out2, winner2, layer_in2, layer_out2, weights_in2 = layer2(out1)

        if winner2 == -1:
            reward = 0
        elif winner2 == target[0]:
            reward = 1
        else:
            reward = -1
        
        weights_out = layer2.stdp(reward, layer_in2, layer_out2, weights_in2, rvcapture[idx], rvsearch[idx],\
                                  rvbackoff[idx], rvmin[idx], rvstickup[idx], rvstickdown[idx])
        layer2.insert_weights(weights_out)
    
    end = time.time()
    print("Training done in ", end-start)



### Testing and computing metrics ###

if display == 1:
    f, ax    = plt.subplots(19,10,figsize=(19,10))
    count    = 0

table    = torch.zeros((10,10))
pred     = torch.zeros(10)
totals   = torch.zeros(10)

start    = time.time()

for idx, (data,target) in enumerate(test_loader):
    tid         = idx + len(train_loader)   
    data = data[0][0]
    
    out1, winner1, layer_in1, layer_out1, weights_in1 = layer1(data)
    out2, winner2, layer_in2, layer_out2, weights_in2 = layer2(out1)
    
    if winner2  != -1:
        table[winner2.long(), target[0]] += 1
    
    if display == 1:
        if idx%100 == 0 and idx <= 1000:
            for i in range(10):
                ax[idx//100][i].imshow(MyColumn.ec.weights[i].resize(imgsize[0],imgsize[1]))
        if idx%1000 == 0 and idx > 1000:
            count += 1
            for i in range(10):
                ax[10+count][i].imshow(MyColumn.ec.weights[i].resize(imgsize[0],imgsize[1]))

end = time.time()
print("Testing done in ", end-start)

print("Confusion Matrix:")
print(table)

maxval = torch.max(table, 1)[0]
totals = torch.sum(table, 1)
pred = torch.sum(maxval)
covg_cnt = torch.sum(totals)

print("Purity: ", pred/covg_cnt)
print("Coverage: ", covg_cnt/(idx+1))



plt.figure()

f, ax = plt.subplots(4,4)

for i in range(4):
    for j in range(4):
        ax[i][j].imshow(layer1.columns[1][1].ec.weights[i*4+j].resize(14,14))