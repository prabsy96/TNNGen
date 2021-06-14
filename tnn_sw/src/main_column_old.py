### Author: Harideep Nair ###

# This code implements a single configurable pxq TNN column
# Consists of an excitatory column with 'q' neurons and 'p' synapses per neuron, followed by lateral inhibition
# Capable of online continuous learning via STDP
# No spike is represented using 'float('Inf')'



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

parser = argparse.ArgumentParser(description="A single TNN Column")

parser.add_argument('--enc',            type=str, default='bw',\
                    help='bw for black and white; gray for grayscale')

parser.add_argument('--bw_thresh',      type=float, default=0.1,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--gray_thresh',    type=int, default=8,\
                    help='fraction of pixel values that are considered black')

parser.add_argument('--resize',         type=int, default=1,\
                    help='0 for no resizing; 1 for resizing')

parser.add_argument('--resize_param',   type=tuple, default=(8,8),\
                    help='output size after resizing')

parser.add_argument('--crop',           type=int, default=0,\
                    help='0 for no cropping; 1 for cropping')

parser.add_argument('--crop_size',      type=tuple, default=(4,4),\
                    help='output size after cropping')

parser.add_argument('--crop_pos',       type=tuple, default=(12,12),\
                    help='top left corner of crop position')

parser.add_argument('--filter',         type=int, default=1,\
                    help='0 for no On-Off filtering; 1 for On-Off filtering')

parser.add_argument('--filter_size',    type=int, default=3,\
                    help='OnOff filter window size')

parser.add_argument('--timeres',        type=int, default=3,\
                    help='bit resolution for maximum input spiketime')

parser.add_argument('--q',              type=int, default=10,\
                    help='number of neurons in the excitatory column')

parser.add_argument('--wres',           type=int, default=3,\
                    help='bit resolution for weights')

parser.add_argument('--theta',          type=int, default=35,\
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

parser.add_argument('--reward_en',      type=int, default=1,\
                    help='0 for regular STDP; 1 for reward-based STDP')

parser.add_argument('--inc_learn',      type=int, default=0,\
                    help='0 for no STDP during testing; 1 for incremental learning during testing via STDP')

args = parser.parse_args()



### Parameters ###

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
p               = imgsize[0]*imgsize[1]   # Number of synapses per neuron
q               = args.q                  # Number of neurons in the excitatory column
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

reward_en       = args.reward_en          # Enable/disable reward-based STDP for training
inc_learn       = args.inc_learn          # Enable/disable unsupervised STDP incremental learning during testing

train_display   = 0                       # Display weights after training
weights_save    = 1                       # Save weights after training
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
    timeres = 0
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
    def __init__(self, timeres, p, q, wres, theta, ntype, w_init, k, stoch):
        tin_max         = 2**timeres-1
        
        self.ec         = ExcitatoryColumn(tin_max, p, q, wres, theta, ntype, w_init)
        self.li         = LateralInhibition(k)
        self.stdp       = STDP(wres, stoch)
        self.rstdp      = RSTDP(wres, stoch)
        
    def __call__(self, data):
        data            = torch.flatten(data)
        ec_out          = self.ec(data)
        li_out, winidx  = self.li(ec_out)
        return li_out, winidx



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



### Column Initialization ###

MyColumn = TNNColumn(timeres, p, q, wres, theta, ntype, w_init, k, stoch)



### Training ###

if train_display == 1:
    f, ax     = plt.subplots(18,q,figsize=(18,q))

for epochs in range(1):
    start = time.time()
    count = 0
    
    for idx, (data,target) in enumerate(train_loader):
        out, winner = MyColumn(data)
        
        if reward_en == 1:
            if winner == -1:
                reward = 0
            elif winner == target[0]:
                reward = 1
            else:
                reward = -1
            MyColumn.ec.weights = MyColumn.rstdp(reward, data, out, MyColumn.ec.weights, rvcapture[idx],\
                                             rvsearch[idx], rvbackoff[idx], rvmin[idx], rvstickup[idx],\
                                             rvstickdown[idx])
        else:
            MyColumn.ec.weights = MyColumn.stdp(data, out, MyColumn.ec.weights, rvcapture[idx], rvsearch[idx],\
                                            rvbackoff[idx], rvmin[idx], rvstickup[idx], rvstickdown[idx])
        if train_display == 1:
            if idx%100 == 0 and idx <= 1000:
                for i in range(q):
                    ax[idx//100][i].imshow(MyColumn.ec.weights[i].reshape(imgsize[0],imgsize[1]))
            if idx == 2000:
                for i in range(q):
                    ax[11][i].imshow(MyColumn.ec.weights[i].reshape(imgsize[0],imgsize[1]))
            if idx == 5000:
                for i in range(q):
                    ax[12][i].imshow(MyColumn.ec.weights[i].reshape(imgsize[0],imgsize[1]))
            if idx%10000 == 0 and idx >= 10000:
                count += 1
                for i in range(q):
                    ax[12+count][i].imshow(MyColumn.ec.weights[i].reshape(imgsize[0],imgsize[1]))
    
    end = time.time()
    print("Training done in ", end-start)



### Display and save weights as images ###

if weights_save == 1:
    plt.figure()
    f, ax = plt.subplots(2,q//2)

    image_list = []
    for i in range(2):
        for j in range(q//2):
            temp = MyColumn.ec.weights[i*q//2+j].reshape(imgsize[0],imgsize[1])
            ax[i][j].imshow(temp)
            image_list.append(temp)

    out = torch.stack(image_list, dim=0).unsqueeze(1)
    save_image(out, '../images/weights8x8x2.png', nrow=q//2)



### Testing and computing metrics ###

if test_display == 1:
    f, ax    = plt.subplots(19,10,figsize=(19,10))
    count    = 0

table        = torch.zeros((q,10))
pred         = torch.zeros(q)
totals       = torch.zeros(q)

start        = time.time()

for idx, (data,target) in enumerate(test_loader):
    tid         = idx + len(train_loader)
    out, winner = MyColumn(data)
    
    if inc_learn == 1:
        MyColumn.ec.weights = MyColumn.stdp(data, out, MyColumn.ec.weights, rvcapture[tid], rvsearch[tid],\
                                            rvbackoff[tid], rvmin[tid], rvstickup[tid], rvstickdown[tid])
    if winner  != -1:
        table[winner.long(), target[0]] += 1
    
    if test_display == 1:
        if idx%100 == 0 and idx <= 1000:
            for i in range(10):
                ax[idx//100][i].imshow(MyColumn.ec.weights[i].reshape(imgsize[0],imgsize[1]))
        if idx%1000 == 0 and idx > 1000:
            count += 1
            for i in range(10):
                ax[10+count][i].imshow(MyColumn.ec.weights[i].reshape(imgsize[0],imgsize[1]))

end           = time.time()
print("Testing done in ", end-start)

print("Confusion Matrix:")
print(table.long())

maxval        = torch.max(table, 1)[0]
totals        = torch.sum(table, 1)
pred          = torch.sum(maxval)
covg_cnt      = torch.sum(totals)

print("Purity: ", pred/covg_cnt)
print("Coverage: ", covg_cnt/(idx+1))