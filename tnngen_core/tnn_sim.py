### Author: Harideep Nair ###

# This code implements a multilayer TNN built from columns



### Importing libraries ###

import torch
import torch.nn.functional as F
import sklearn
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
from rich.console import Console
import re

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import PolynomialFeatures
import pandas as pd
import os
import pathlib


### Argument parsing ###

def tnn_sim(params):

    console = Console()
    console.print("[bold magenta]   --> Starting TNN Sim!")

    ### Parameters ###

    imgsize         = int(params['imgsize'])           # Size of input image
    rfsize          = int(params['rfsize'])            # Size of receptive field (first layer)
    stride          = int(params['stride'])            # Stride for sliding the receptive field (first layer)
    neurons         = int(params['neurons'])           # Number of neurons per TNN Column (first layer)
    theta           = int(params['theta'])             # Spiking threshold of neurons (first layer)
    num_classes     = int(params['num_classes'])       # Number of labels or classes (first layer)

    timeres         = int(params['timeres'])           # Bit resolution for maximum input spiketime
    wres            = int(params['wres'])              # Bit resolution for weights
    ntype           = 'rnl'                            # SRM0 neuron response function model
    ramp            = float(params['ramp'])            # Slope of ramp-no-leak response function
    w_init          = params['w_init']                 # Weight initialization
    k               = int(params['k'])                 # For k-WTA
    stoch           = params['stoch']                  # Level of stochasticity for STDP
    resize          = int(params['resize'])            # Resize image
    resize_param    = tuple(map(int, re.findall(r'[0-9]+', params['resize_param'])))     # Output size after resizing
    filter          = int(params['filter'])            # Choose if On-Off filter needed
    crop            = int(params['crop'])              # Crop image
    crop_size       = tuple(map(int, re.findall(r'[0-9]+', params['crop_size'])))  # Output size after cropping
    crop_pos        = tuple(map(int, re.findall(r'[0-9]+', params['crop_pos'])))   # Top left corner of crop position
    pn_thresh       = float(params['pn_thresh'])       # fraction of pixel values that are considered black
    ucapture        = int(params['ucapture'])          # STDP's "capture" Bernoulli random variable probability
    usearch         = int(params['usearch'])           # STDP's "search" Bernoulli random variable probability
    ubackoff        = int(params['ubackoff'])          # STDP's "backoff" Bernoulli random variable probability
    ubackoff_simp   = int(params['ubackoff_simp'])     # STDP's "backoff_simp" Bernoulli random variable probability
    umin            = int(params['umin'])              # STDP's "min" Bernoulli random variable probability

    inc_learn       = int(params['inc_learn'])         # Enable/disable unsupervised STDP incremental learning during testing
    
    stats_file      = os.path.join(os.getcwd(), 'stats.txt')

    nprev           = 1                       # Number of channels in the first layer 
    weights_save    = 1                       # Save weights after training

    if not isinstance(imgsize,tuple):
        imgsize     = (imgsize,imgsize)

    if not isinstance(rfsize,tuple):
        rfsize      = (rfsize,rfsize)

    rows            = (imgsize[0]-rfsize[0])//stride + 1
    cols            = (imgsize[1]-rfsize[1])//stride + 1



    if resize == 1:
        imgsize = resize_param                             # Size of input image



    if crop == 1:
        imgsize = crop_size                            # Size of input image



    ### MNIST dataset loading and preprocessing ###

    transforms_list = []

    if resize == 1:
        transforms_list.append(transforms.Resize(resize_param))

    transforms_list.append(transforms.ToTensor())

    if crop == 1:
        transforms_list.append(Crop(pos=crop_pos, size=crop_size))

    if filter == 1:
        transforms_list.append(PosNeg(pn_thresh))
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
    #         if idx == 10000:
    #             break
            print("Iteration: {0}\r".format(idx), end="")
            data                   = data[0]
            layer_out, layer_in, _ = layer1(data)
            arg                    = torch.nonzero(layer_out[:,0] != float('Inf'))
            if arg.shape[0] == 0:
                reward = 0
            elif arg[0] == target[0]:
                reward = 1
            else:
                reward = -1
    #         print(target[0])
    #         print(layer_out[:,0])
    #         print(reward)
            weights_out            = layer1.stdp(layer_in, layer_out, layer1.weights, rvcapture[idx], rvsearch[idx],\
                                              rvbackoff[idx], rvmin[idx], rvstickup[idx], rvstickdown[idx])
    #         layer1.weights         = nn.Parameter(weights_out, requires_grad=False)
            endt                   = time.time()
            print("                                 Time elapsed: {0}\r".format(endt-start), end="")
        
        end   = time.time()
        print("First layer training done in ", end-start)



    ### Display and save weights as images ###

    if weights_save == 1:
        
        image_list = []
        for i in range(neurons):
            temp = layer1.weights[i].reshape(rfsize[0]*nprev,rfsize[1])
            image_list.append(temp)

        out = torch.stack(image_list, dim=0).unsqueeze(1)
        save_image(out, '../tnn_sw/images/column/column_visweights.png', nrow=neurons//2)



    ### Testing and computing metrics ###

    table    = torch.zeros((neurons,10))
    pred     = torch.zeros(10)
    totals   = torch.zeros(10)

    print("Starting testing")
    start    = time.time()

    for idx, (data,target) in enumerate(test_loader):
        print("Iteration: {0}\r".format(idx), end="")
        tid         = idx + len(train_loader)   
        
        data = data[0]
        layer_out, layer_in, _             = layer1(data)
        arg = torch.nonzero(layer_out[:,0] != float('Inf'))
        if arg.shape[0] != 0:
            table[arg[0].long(), target[0]] += 1
        
        endt = time.time()
        print("                                 Time elapsed: {0}\r".format(endt-start), end="")

    end = time.time()
    print("Testing done in ", end-start)

    print("Confusion Matrix:")
    print(table)

    maxval   = torch.max(table, 1)[0]
    totals   = torch.sum(table, 1)
    pred     = torch.sum(maxval)
    covg_cnt = torch.sum(totals)

    print("Purity: ", pred/covg_cnt)
    print("Coverage: ", covg_cnt/(idx+1))
    print("Accuracy: ", pred/(idx+1))


    if os.path.isfile(stats_file):
        print()
        print("Creating PPA Regression:")

        # Set variables according to args.txt
        neurons         = int(params['neurons'])
        theta           = int(params['theta'])
        rfsize          = int(params['rfsize'])
        nprev           = int(params['nprev'])
        wres            = int(params['wres'])


        # Read in stats file
        df = pd.read_csv(stats_file)
        df.drop_duplicates(subset = ['Neurons','Theta', 'rfsize', 'nprev', 'wres'], keep = 'last').reset_index(drop = True)

        # If there are less than 5 PPA data points, return and ask user to generate more data
        if (len(df) < 5):
            print("Less than 5 datapoints in stats file, please gather more data")
            print("Tip: Run small designs with synthesis and place and route to gather sample data")
            return
        
        # Gather Relevant Variables
        df['p'] = df['rfsize']**2 * df['nprev']
        df['Synapse Count'] = df['p'] * df['Neurons']
        synapse_count = df[['Synapse Count']].values
        area = df['Area (Cell Count)'].values
        area_um2 = df['Area (um^2)'].values
        slack = df['Slack (ns)'].values
        power = df['Power (uW)'].values

        # Create a Polynomial Regression for area, area_um2, slack, and power 
        area_model = LinearRegression()
        area_model.fit(synapse_count, area)
        area_um2_model = LinearRegression()
        area_um2_model.fit(synapse_count, area_um2)
        slack_model = LinearRegression()
        slack_model.fit(synapse_count, slack)
        power_model = LinearRegression()
        power_model.fit(synapse_count, power)

        # Predict all 4 PPA values
        input_synapse_count = rfsize**2 * nprev * neurons
        area_pred = area_model.predict([[input_synapse_count]])
        area_um2_pred = area_um2_model.predict([[input_synapse_count]])
        slack_pred = slack_model.predict([[input_synapse_count]])
        power_pred = power_model.predict([[input_synapse_count]])

        print("Predicted PPA Values: Area (Cell Count): {}, Area (um^2): {}, Slack (ns): {}, Power (uW): {}".format(area_pred, area_um2_pred, slack_pred, power_pred))
