### Importing libraries ###

import torch
import torch.nn as nn


### Author: Harideep Nair ###
### Excitatory Column (EC) ###

    # Consists of 'q' excitatory neurons with 'p' synapses each.
    # Implements an SRM0 neuron model.
    
    # Args: tin_max - Maximum input spiketime.
    #       p       - Number of synapses per neuron.
    #       q       - Number of neurons.
    #       wres    - Bit resolution for synaptic weights.
    #       theta   - Excitation threshold for neuron. An output spike is generated when neuron's body potential reaches
    #                 this threshold.
    #       ntype   - Type of neuron response function. Supports step-no-leak and ramp-no-leak response functions.
    #       w_init  - Type of initialization for synaptic weights. Supports 'zero', 'random uniform' and
    #                 'random normal' initializations.
    #       ramp    - Slope of ramp for ramp-no-leak response function. Default is 1.

class ExcitatoryColumn():
    def __init__(self, tin_max, p, q, wres, theta, ntype="rnl", w_init="zero", ramp=1):
        self.p             = p
        self.q             = q
        self.wmax          = 2**wres-1
        self.theta         = theta
        self.ntype         = ntype
        self.ramp          = ramp
        
        # Synaptic weight initialization. Shape of weights is [self.q,self.p].
        if w_init       == "zero":
            self.weights       = torch.zeros(self.q, self.p)
        elif w_init     == "uniform":
            self.weights       = torch.randint(low=0, high=self.wmax+1, size=(self.q, self.p)).type(torch.FloatTensor)
        elif w_init     == "normal":
            self.weights       = torch.round(((self.wmax+1)/2+torch.randn(self.q, self.p)).clamp_(0,self.wmax))
        
        # Calculates length of the time dimension (self.time) required for each response function model.
        # self.time relates to the maximum output spike time (say, tout_max). In fact, self.time = tout_max + 1.
        if self.ntype   == "snl":
            self.time      = tin_max + 1
        elif self.ntype == "rnl":
            self.time      = tin_max + self.wmax
            
        self.pot           = torch.zeros(self.time, self.q)
        self.ec_spiketimes = float('Inf')*torch.ones(self.q)
        self.const         = torch.arange(self.time).repeat(self.q, self.p, 1).permute(2,0,1)
    
    
    # Implements a step-no-leak response function model.
    
        # Args: input_spiketimes - Tensor of input spiketimes with shape [self.p].
        # Returns 1) a tensor of output spiketimes with shape [self.q].
        #         2) a tensor of body potentials with shape [self.time, self.q].
    
    def StepNoLeak(self, input_spiketimes):
        weights                                             = self.weights.repeat(self.time, 1, 1)
        spikes                                              = input_spiketimes.repeat(self.time, self.q, 1)
        spikes                                              = self.const - spikes
        spikes[spikes>=0]                                   = 1
        spikes[spikes<0]                                    = 0
        responses                                           = torch.mul(spikes, weights)
        pot                                                 = torch.sum(responses, dim=2)
        
        temp                                                = pot.clone()
        temp[temp<self.theta]                               = 0
        temp[temp>=self.theta]                              = 1
        tempsum                                             = torch.sum(temp, dim=0)
        
        ec_spiketimes                                       = self.time - tempsum
        ec_spiketimes[ec_spiketimes == self.time]           = float('Inf')
        return ec_spiketimes, pot
    
    
    # Implements a ramp-no-leak response function model.
    
        # Args: input_spiketimes - Tensor of input spiketimes with shape [self.p].
        # Returns 1) a tensor of output spiketimes with shape [self.q].
        #         2) a tensor of body potentials with shape [self.time, self.q].
    
    def RampNoLeak(self, input_spiketimes, ramp=1):
        weights                                             = self.weights.repeat(self.time, 1, 1)
        spikes                                              = input_spiketimes.repeat(self.time, self.q, 1)
        spikes                                              = self.const - spikes
        spikes[spikes>=0]                                   = 1
        spikes[spikes<0]                                    = 0
        responses                                           = ramp * torch.cumsum(spikes,dim=0)
        responses[responses>=weights]                       = weights[responses>=weights]
        pot                                                 = torch.sum(responses, dim=2)
        
        temp                                                = pot.clone()
        temp[temp<self.theta]                               = 0
        temp[temp>=self.theta]                              = 1
        tempsum                                             = torch.sum(temp, dim=0)
        
        ec_spiketimes                                       = self.time - tempsum
        ec_spiketimes[ec_spiketimes == self.time]           = float('Inf')
        return ec_spiketimes, pot
    
    def __call__(self, data):
        if self.ntype == "snl":
            #step-no-leak response
            self.ec_spiketimes, self.pot = self.StepNoLeak(data)
            
        elif self.ntype == "rnl":
            #ramp-no-leak response
            self.ec_spiketimes, self.pot = self.RampNoLeak(data, self.ramp)
            
        return self.ec_spiketimes



### Author: Harideep Nair ###
### Lateral inhibition (LI) ###

    # Implements a k-WTA lateral inhibition with lowest-index tie-breaking.
    # Passes the first 'k' spikes (in time) intact and nulls out the remaining spikes.
    
    # Args: k      - Maximum number of winners to allow uninhibited.
    #       ec_out - Tensor of EC's output spiketimes with shape [self.q].
    # Returns 1) a tensor of LI output spiketimes consisting of upto k non-null spikes, with shape [self.q].
    #         2) winning neuron index/indices. '-1' indicates no winner, i.e., none of the neurons spiked.

class LateralInhibition():
    def __init__(self, k=1):
        self.k                       = k
        
    def __call__(self, ec_out):
        wintime                      = torch.min(ec_out)
        
        if wintime != float('Inf'):
            sort_times, sort_idx     = torch.sort(ec_out)
            win_times, win_idx       = sort_times[:self.k], sort_idx[:self.k]
            li_out                   = float('Inf')*torch.ones(ec_out.shape)
            li_out[win_idx]          = win_times
        
        else:
            li_out                   = ec_out
            win_idx                  = -1
        
        return li_out, win_idx



### Author: Harideep Nair ###
### TNN Column ###

    # Implements a single configurable pxq TNN column with EC, LI and STDP.
    # Consists of an excitatory column with 'q' neurons and 'p' synapses per neuron, followed by lateral inhibition.
    # Capable of online continuous learning via STDP/R-STDP.
    
    # Args: timeres - Bit resolution for input spiketimes.
    #       p       - Number of synapses per neuron.
    #       q       - Number of neurons.
    #       wres    - Bit resolution for synaptic weights.
    #       theta   - Excitation threshold for neuron. An output spike is generated when neuron's body potential reaches
    #                 this threshold.
    #       ntype   - Type of neuron response function. Supports step-no-leak and ramp-no-leak response functions.
    #       w_init  - Type of initialization for synaptic weights. Supports 'zero', 'random uniform' and
    #                 'random normal' initializations.
    #       k       - Maximum number of winners to allow uninhibited.
    # Returns 1) a tensor of LI output spiketimes consisting of upto k non-null spikes, with shape [self.q].
    #         2) winning neuron index/indices. '-1' indicates no winner, i.e., none of the neurons spiked.

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



### Author: Harideep Nair ###
### TNN Voter ###

    # Implements a single configurable pxq TNN voter with R-STDP.
    # Generates upto 'q' votes from 'p' inputs (outputs of last layer of columns).
    # Input is one-hot, i.e., at most only 1 out of p inputs will have a spike.
    # The number of votes is usually equal to the number of classes or label.
    # Capable of online continuous learning via R-STDP.
    
    # Args: p            - Number of 1-hot input spikes. Typically equal to the number of neurons in the previous column.
    #       q            - Number of labels or classes.
    #       wres         - Bit resolution for synaptic weights.
    #       thresh       - Threshold for selecting winning weights. Given a 1-hot input, those labels are voted whose 
    #                      synaptic weights are greater than or equal to (thresh * maxweight). 'maxweight' is the maximum 
    #                      weight across all synapses corresponding to the 1-hot input.
    #       w_init       - Type of initialization for synaptic weights. Supports 'zero', 'random uniform' and
    #                      'random normal' initializations.
    #       input_spikes - 1-hot input spikes to the voter. They are typically the outputs of the previous TNN column.
    # Returns a tensor of votes consisting of upto q non-null values, with shape [q]. Each non-null vote has a value equal
    # to 1, else 0.

class TNNVoter():
    def __init__(self, p, q, wres, thresh, w_init):
        self.q           = q
        self.thresh      = thresh
        wmax             = 2**wres
        
        # Synaptic weight initialization. Shape of weights is [p,q].
        if w_init == "zero":
            self.weights = torch.zeros(p, q)
        elif w_init == "uniform":
            self.weights = torch.randint(low=0, high=wmax, size=(p, q)).type(torch.FloatTensor)
        elif w_init == "normal":
            self.weights = torch.round((wmax/2+torch.randn(p, q)).clamp_(0,wmax))
        
        self.votes       = torch.zeros(q)
        
    def __call__(self, input_spikes):
        self.votes               = torch.zeros(self.q)
        min_time                 = torch.min(input_spikes)
        win_idx                  = torch.nonzero(input_spikes == min_time)
        
        if min_time != float('Inf'):
            win_wts              = weights[win_idx[0]]
            maxw                 = torch.max(win_wts)
            vote_idx             = torch.nonzero(win_wts >= maxw * self.thresh)
            self.votes[vote_idx] = 1
        
        return self.votes



### Author: Harideep Nair ###
### TNN Tally ###

    # Implements a pxq TNN tally block.
    # Selects 1 out of q labels as the final prediction based on the input votes from p voters.
    # Essentially implements q p-input parallel counters.
    # There is no learning.
    
    # Args: p            - Number of voters.
    #       q            - Number of labels or classes.
    #       input_votes  - q votes each from p voters. Size is [p,q].
    # Returns a tensor of labels consisting of atmost 1 non-null value, with shape [q]. The non-null value is 1 and indicates
    # predicted label.

class TNNTally():
    def __init__(self, p, q):
        self.p                = p
        self.q                = q
        
        self.labels           = torch.zeros(q)
        
    def __call__(self, input_votes):
        self.labels           = torch.zeros(q)
        total_votes           = torch.sum(input_votes, dim=0)  
        max_votes             = torch.max(total_votes)
        win_idx               = torch.nonzero(total_votes == max_votes)[0]
        self.labels[win_idx]  = 1
        
        return self.labels



### Author: Harideep Nair ###
### Unsupervised Spike Timing Dependent Plasticity (STDP) ###

    # Implements 4 separate cases (capture, minus, search, backoff) depending on the presence or absence
    # of input and output spikes, and their timing relationships.
    # Performs unit infrequent updates based on Bernoulli random variables (BRVs).
    
    # Args: wres          - Bit resolution for weights.
    #       stochasticity - Decides how correlated or uncorrelated weight updates will be, for a column's synapses. Could
    #                       be low or high.
    #       layer         - Determines if STDP is done for a single cloumn (laye = 0) or on a layer level (layer = 1). 
    #       intimes       - Tensor of input spiketimes with shape [1,in_channels,height,width]. However, the actual shape
    #                       doesn't matter since it's flattened later. After flattening, the shape becomes [self.p].
    #       outtimes      - Tensor of LI's output spiketimes with shape [self.q].
    #       weights       - Tensor of synaptic weights with shape [self.q,self.p].
    #       rvcapture     - BRV for 'capture' and 'minus' cases.
    #       rvsearch      - BRV for 'search' case.
    #       rvbackoff     - BRV for 'backoff' case.
    #       rvmin         - BRV for enforcing a minimum probability of update.
    #       rvstickup     - BRV for sticking the weights towards wmax. Helps in generating a bimodal weight distribution.
    #       rvstickdown   - BRV for sticking the weights towards 0. Helps in generating a bimodal weight distribution.
    # Returns a tensor of STDP-updated synaptic weights of shape [self.q,self.p].

class STDP():
    def __init__(self, wres, stochasticity="low", layer=0):
        self.wmax           = 2**(wres)-1
        self.stoch          = stochasticity
        self.layer          = layer
        
    def __call__(self, intimes, outtimes, weights, rvcapture, rvsearch, rvbackoff, rvmin, rvF):
        if self.layer == 0:
            intimes         = torch.flatten(intimes)
            q               = outtimes.shape[0]
            p               = intimes.shape[0]
            ec_in           = intimes.repeat(q,1)
            li_out          = outtimes.repeat(p,1).permute(1,0)
        elif self.layer==1:
            ec_in           = intimes
            li_out          = outtimes
        
        # Low stochasticity - All Bernoulli random variables are shared across the entire column.
        if self.stoch == "low":
            
            # Case 1 (capture)
            weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                           += rvcapture * torch.max(rvmin, \
                              rvF[weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)].long()])
            
            # Case 2 (minus)
            weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                           -= rvbackoff * torch.max(rvmin, \
                              rvF[weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)].long()])
            
            # Case 3 (search)
            weights[(ec_in!=float('Inf'))*(li_out==float('Inf'))] \
                           += rvsearch
            
            # Case 4 (backoff)
            weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                           -= rvbackoff * torch.max(rvmin, \
                              rvF[weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))].long()])
        
        # High stochasticity - Each synapse has a separate Bernoulli random variable associated with it.  
        elif self.stoch == "high":
            
            # Case 1 (capture)
            weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                           += rvcapture[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                            * torch.max(rvmin[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)], \
                              torch.diagonal(rvF[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                              [:,weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)].long()],0))
            
            # Case 2 (minus)
            weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                           -= rvcapture[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                            * torch.max(rvmin[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)], \
                              torch.diagonal(rvF[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                              [:,weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)].long()],0))
            
            # Case 3 (search)
            weights[(ec_in!=float('Inf'))*(li_out==float('Inf'))] \
                           += rvsearch[(ec_in!=float('Inf'))*(li_out==float('Inf'))]
            
            # Case 4 (backoff)
            weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                           -= rvbackoff[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                            * torch.max(rvmin[(ec_in==float('Inf'))*(li_out!=float('Inf'))], \
                              torch.diagonal(rvF[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                              [:,weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))].long()],0))
        
        return weights.clamp_(0, self.wmax)



### Author: Harideep Nair ###
### Spike Timing Dependent Plasticity (STDP) with Reward for TNN Column ###

# Adds partial reinforcement to baseline unsupervised STDP.
# If the winner neuron's index matches the desired index corresponding to the assigned label, then proceed with
# conventional STDP cases except for search.
# Else if the winner neuron does not correspond to the assigned label, do reverse STDP for capture case with
# backoff probability. Backoff and minus cases are not required. Search is executed as usual.

    # Args: wres          - Bit resolution for weights.
    #       stochasticity - Decides how correlated or uncorrelated weight updates will be, for a column's synapses. Could
    #                       be low or high.
    #       layer         - Determines if STDP is done for a single cloumn (laye = 0) or on a layer level (layer = 1).
    #       reward        - Reward signal to guide STDP to learn the desired output label assignments.
    #                       When the winning neuron index matches the desired label, reward is '1' -> perform conventional STDP.
    #                       When there is no winning neuron, reward is '0' -> just perform search.
    #                       When the winning neuron index doesn't match the desired label, reward is '-1' -> perform anti-STDP.
    #       intimes       - Tensor of input spiketimes with shape [1,in_channels,height,width]. However, the actual shape
    #                       doesn't matter since it's flattened later. After flattening, the shape becomes [self.p].
    #       outtimes      - Tensor of LI's output spiketimes with shape [self.q].
    #       weights       - Tensor of synaptic weights with shape [self.q,self.p].
    #       rvcapture     - BRV for 'capture' and 'minus' cases.
    #       rvsearch      - BRV for 'search' case.
    #       rvbackoff     - BRV for 'backoff' case.
    #       rvmin         - BRV for enforcing a minimum probability of update.
    #       rvstickup     - BRV for sticking the weights towards wmax. Helps in generating a bimodal weight distribution.
    #       rvstickdown   - BRV for sticking the weights towards 0. Helps in generating a bimodal weight distribution.
    # Returns a tensor of RSTDP-updated synaptic weights of shape [self.q,self.p].

class RSTDP():
    def __init__(self, wres, stochasticity="low", layer=0):
        self.wmax           = 2**(wres)-1
        self.stoch          = stochasticity
        self.layer          = layer
        
    def __call__(self, reward, intimes, outtimes, weights, rvcapture, rvsearch, rvbackoff, rvmin, rvstickup, rvstickdown):
        if self.layer == 0:
            intimes         = torch.flatten(intimes)
            q               = outtimes.shape[0]
            p               = intimes.shape[0]
            ec_in           = intimes.repeat(q,1)
            li_out          = outtimes.repeat(p,1).permute(1,0)
        elif self.layer == 1:
            ec_in           = intimes
            li_out          = outtimes
        
        # Low stochasticity - All Bernoulli random variables are shared across the entire column.
        if self.stoch == "low":
            
            if reward == 1:
                # Case 1 (capture)
                weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                               += rvbackoff * torch.max(rvmin, rvstickup \
                                  [weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)].long()])
                
                # Case 2 (minus)
                weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                               -= rvbackoff * torch.max(rvmin, rvstickdown \
                                  [weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)].long()])
                
                # Case 4 (backoff)
                weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                               -= rvbackoff * torch.max(rvmin, rvstickdown \
                                  [weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))].long()])
                
            elif reward == 0:
                
                # Case 3 (search)
                weights[(ec_in!=float('Inf'))*(li_out==float('Inf'))] \
                               += rvsearch
                
            elif reward == -1:
                # Case 1 (capture)
                weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                               -= rvbackoff * torch.max(rvmin, rvstickdown \
                                  [weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)].long()])

                # Case 3 (search)
                weights[(ec_in!=float('Inf'))*(li_out==float('Inf'))] \
                               += rvsearch
                
        # High stochasticity - Each synapse has a separate Bernoulli random variable associated with it.  
        elif self.stoch == "high":
            
            if reward == 1:
                # Case 1 (capture)
                weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                               += rvbackoff[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                                * torch.max(rvmin[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)], \
                                  torch.diagonal(rvstickup[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                                  [:,weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)].long()],0))

                # Case 2 (minus)
                weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                               -= rvbackoff[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                                * torch.max(rvmin[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)], \
                                  torch.diagonal(rvstickdown[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)] \
                                  [:,weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in>li_out)].long()],0))

                # Case 4 (backoff)
                weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                               -= rvbackoff[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                                * torch.max(rvmin[(ec_in==float('Inf'))*(li_out!=float('Inf'))], \
                                  torch.diagonal(rvstickdown[(ec_in==float('Inf'))*(li_out!=float('Inf'))] \
                                  [:,weights[(ec_in==float('Inf'))*(li_out!=float('Inf'))].long()],0))
                
            elif reward == 0:

                # Case 3 (search)
                weights[(ec_in!=float('Inf'))*(li_out==float('Inf'))] \
                               += rvsearch[(ec_in!=float('Inf'))*(li_out==float('Inf'))]
                
            elif reward == -1:
                # Case 1 (capture)
                weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                               -= rvbackoff[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                                * torch.max(rvmin[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)], \
                                  torch.diagonal(rvstickdown[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)] \
                                  [:,weights[(ec_in!=float('Inf'))*(li_out!=float('Inf'))*(ec_in<=li_out)].long()],0))

                # Case 3 (search)
                weights[(ec_in!=float('Inf'))*(li_out==float('Inf'))] \
                               += rvsearch[(ec_in!=float('Inf'))*(li_out==float('Inf'))]
        
        return weights.clamp_(0, self.wmax)



### Author: Harideep Nair ###
### Spike Timing Dependent Plasticity (STDP) with Reward for TNN Voter ###

# Adds partial reinforcement to baseline unsupervised STDP (according to Jim's RL document).
# If the predicted label matches the actual label, all the voters who contributed to the correct votes receive positive
# reinforcement on their corresponding synapses while others receive negative reinforcement.
# Implements capture, backoff, backoff_simp and search as per the five cases in Jim's RL document.

    # Args: wres           - Bit resolution for weights.
    #       stochasticity  - Decides how correlated or uncorrelated weight updates will be, for a column's synapses. Could
    #                        be low or high.
    #       label          - Actual integer label for the input data
    #       tally_out      - 1-hot output of tally, i.e., final prediction. Shape is [q].
    #       voter_in       - Tensor of binarized input spikes (or outputs of last layer of columns), with shape [rows*cols*p, q].
    #                        This is already re-dimensionalized to have the same shape as weights.
    #       voter_out      - Tensor of output votes with shape [rows*cols*p, q]. Each of the (rows*cols) voters actually produces
    #                        q votes, but the output of voter is already re-dimensionalized to have the same shape as weights.
    #       weights        - Tensor of synaptic weights with shape [rows*cols*p, q].
    #       rvcapture      - BRV for 'capture' and 'minus' cases.
    #       rvsearch       - BRV for 'search' case.
    #       rvbackoff      - BRV for 'backoff' case.
    #       rvbackoff_simp - BRV for 'backoff_simp' case.
    #       rvmin          - BRV for enforcing a minimum probability of update.
    #       rvstickup      - BRV for sticking the weights towards wmax. Helps in generating a bimodal weight distribution.
    #       rvstickdown    - BRV for sticking the weights towards 0. Helps in generating a bimodal weight distribution.
    # Returns a tensor of RSTDP-updated synaptic weights of shape [rows*cols*p, q].

class RSTDP_Voter():
    def __init__(self, wres, stochasticity="low"):
        self.wmax           = 2**(wres)-1
        self.stoch          = stochasticity
#         self.count          = 0
        
    def __call__(self, label, tally_out, voter_in, voter_out, weights, rvcapture, rvsearch, rvbackoff, rvbackoff_simp, rvmin,\
                 rvstickup, rvstickdown):
#         print("*****************************************************************************************")
#         print("Iteration Number: ", self.count)
#         print("Before:")
#         print(weights)
        p_tot, q            = weights.shape[0], weights.shape[1]
        label_onehot        = torch.zeros(q)
        label_onehot[label] = 1
        label_onehot        = label_onehot.repeat(p_tot, 1)
        zr                  = label_onehot #* (tally_out.repeat(p_tot,1))
        vr                  = torch.max((label_onehot * voter_out), dim=1)[0].repeat(q,1).permute(1,0)
        
        # Five cases (conditions) for voter's RSTDP (Jim)
#         print("Label:")
#         print(label)
#         print("Tally Out:")
#         print(tally_out)
        cond1           = (voter_in==1)*(voter_out==1)*(zr==1)
        cond2           = (voter_in==1)*(voter_out==1)*(zr==0)*(vr==1)
        cond3           = (voter_in==1)*(voter_out==1)*(zr==0)*(vr==0)
        cond4           = (voter_in==1)*(voter_out==0)*(vr==1)
        cond5           = (voter_in==1)*(voter_out==0)*(vr==0)
#         cond6           = (voter_in==1)*(voter_out==0)*(zr==0)*(vr==0)
        
        # Low stochasticity - All Bernoulli random variables are shared across the entire column.
        if self.stoch == "low":
#             print("Voter In:")
#             print(voter_in)
#             print("Voter Out:")
#             print(voter_out)
#             print("ZR:")
#             print(zr)
#             print("VR:")
#             print(vr)
            # Case 1 (capture)
            weights[cond1] += rvcapture * torch.max(rvmin, rvstickup[weights[cond1].long()])

            # Case 2 (backoff)
            weights[cond2] -= rvbackoff * torch.max(rvmin, rvstickdown[weights[cond2].long()])

            # Case 3 (backoff_simp)
            weights[cond3] -= rvbackoff_simp * torch.max(rvmin, rvstickdown[weights[cond3].long()])
            
            # Case 4 (backoff)
            weights[cond4] -= rvbackoff * torch.max(rvmin, rvstickdown[weights[cond4].long()])
            
            # Case 5 (search)
            weights[cond5] += rvsearch #* torch.max(rvmin, rvstickup[weights[cond5].long()])
            
            # Case 6 (backoff)
            #weights[cond6] -= rvbackoff * torch.max(rvmin, rvstickdown[weights[cond6].long()])
                
        # High stochasticity - Each synapse has a separate Bernoulli random variable associated with it.  
        elif self.stoch == "high":
#             print("Voter In:")
#             print(voter_in)
#             print("Voter Out:")
#             print(voter_out)
#             print("ZR:")
#             print(zr)
#             print("VR:")
#             print(vr)
            # Case 1 (capture)
            weights[cond1] += rvcapture[cond1] * torch.max(rvmin[cond1], torch.diagonal(rvstickup[cond1] \
                              [:,weights[cond1].long()],0))

            # Case 2 (backoff)
            weights[cond2] -= rvbackoff[cond2] * torch.max(rvmin[cond2], torch.diagonal(rvstickdown[cond2] \
                              [:,weights[cond2].long()],0))

            # Case 3 (backoff_simp)
            weights[cond3] -= rvbackoff_simp[cond3] * torch.max(rvmin[cond3], torch.diagonal(rvstickdown[cond3] \
                              [:,weights[cond3].long()],0))
            
            # Case 4 (backoff)
            weights[cond4] -= rvbackoff[cond4] * torch.max(rvmin[cond4], torch.diagonal(rvstickdown[cond4] \
                              [:,weights[cond4].long()],0))
            
            # Case 5 (search)
            weights[cond5] += rvsearch[cond5]
        
#         print("After:")
#         print(weights)
#         print("*****************************************************************************************")
#         self.count = self.count + 1
        
        return weights.clamp_(0, self.wmax)



### Author: Harideep Nair ###
### TNN Column Layer - Naive Implementation ###

    # Implements a single TNN layer with multiple TNN columns arranged as a 2D array of size [rows,cols].
    # Naively instantiates all the components in an iterative fashion.
    # Each column consists of an excitatory column with 'q' neurons and 'p' synapses per neuron, followed by lateral inhibition.
    # Capable of online continuous learning via STDP/R-STDP.
    
    # Args: input_size - Size of input 2D data (e.g. input image size in a dataset). Can be given as (height,width) tuple
    #                    or integer, in which case both height and width will be set as that integer.
    #       rf_size    - Size of 2D receptive field. Can be given as (height,width) tuple or integer, in which case both
    #                    height and width will be set as that integer.
    #       stride     - Stride for sliding the receptive field across the input 2D data.
    #       nprev      - Number of neurons per column in the previous layer. For first layer, channels added due to filtering
    #                    can be accounted using nprev. For example, for OnOff filter, nprev = 2. Else, if there is no filtering,
    #                    nprev = 1 for first layer.
    #       neurons    - Number of neurons per column in the current layer.
    #       theta      - Excitation threshold for neuron. An output spike is generated when neuron's body potential reaches
    #                    this threshold.
    #       timeres    - Bit resolution for input spiketimes.
    #       wres       - Bit resolution for synaptic weights.
    #       ntype      - Type of neuron response function. Supports step-no-leak and ramp-no-leak response functions.
    #       w_init     - Type of initialization for synaptic weights. Supports 'zero', 'random uniform' and
    #                    'random normal' initializations.
    #       k          - Maximum number of winners to allow uninhibited.
    #       stoch      - Decides how correlated or uncorrelated weight updates will be, for a column's synapses. Could
    #                    be low or high.
    #       reward_en  - Enable reinforcement for STDP (R-STDP).
    #       data       - Input 2D data.
    # Returns 1) a tensor of LI output spiketimes consisting of upto k non-null spikes, with shape [rows,cols,q].
    #         2) a tensor of winning neuron indices consisting of 1 winner per TNN column, with shape [rows,cols].
    #            '-1' indicates no winner, i.e., none of the neurons spiked.
    #         3) a tensor with concatenated re-dimensionalized input spiketimes of all TNN columns for use in STDP/R-STDP.
    #            Its shape is [q*rows*cols,p].
    #         4) a tensor with concatenated re-dimensionalized output spiketimes of all TNN columns for use in STDP/R-STDP.
    #            Its shape is [q*rows*cols,p].
    #         5) a tensor with concatenated weights of all TNN columns for use in STDP/R-STDP. Its shape is [q*rows*cols,p].

class TNNColumnLayerNaive():
    def __init__(self, inputsize, rfsize, stride, nprev, neurons, theta, timeres=3, wres=3,\
                 ntype="rnl", w_init="zero", k=1, stoch="low", reward_en=0):
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
        self.time          = 2**timeres-1
        
        if reward_en == 0:
            self.stdp   = STDP(wres, stoch, layer=1)
        else:
            self.stdp   = RSTDP(wres, stoch, layer=1)
        
        self.columns       = [[None]*self.cols for _ in range(self.rows)]
        for r in range(self.rows):
            for c in range(self.cols):
                self.columns[r][c] = TNNColumn(self.time, self.p, self.q, wres, theta, ntype, w_init, k)
        
        self.outspiketimes = float('Inf')*torch.ones(self.rows,self.cols,self.q)
        self.winners       = -1*torch.ones(self.rows,self.cols)
        
    def insert_weights(self, weights):
        wtuple = torch.split(weights, self.q, dim=0)
        for r in range(self.rows):
            for c in range(self.cols):   
                self.columns[r][c].ec.weights = wtuple[r*self.cols+c]
    
    def __call__(self, data):
        dtemp = torch.flatten(data[:,0:self.rfsize[0],0:self.rfsize[1]])
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
                dtemp = torch.flatten(data[:,r*self.stride:r*self.stride+self.rfsize[0],\
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



### Author: Harideep Nair ###
### TNN Column Layer - Efficient Implementation ###

    # Implements a single TNN layer with multiple TNN columns arranged as a 2D array of size [rows,cols].
    # Each column consists of an excitatory column with 'q' neurons and 'p' synapses per neuron, followed by lateral inhibition.
    # Capable of online continuous learning via STDP/R-STDP.
    
    # Args: input_size - Size of input 2D data (e.g. input image size in a dataset). Can be given as (height,width) tuple
    #                    or integer, in which case both height and width will be set as that integer.
    #       rf_size    - Size of 2D receptive field. Can be given as (height,width) tuple or integer, in which case both
    #                    height and width will be set as that integer.
    #       stride     - Stride for sliding the receptive field across the input 2D data.
    #       nprev      - Number of neurons per column in the previous layer. For first layer, channels added due to filtering
    #                    can be accounted using nprev. For example, for OnOff filter, nprev = 2. Else, if there is no filtering,
    #                    nprev = 1 for first layer.
    #       neurons    - Number of neurons per column in the current layer.
    #       theta      - Excitation threshold for neuron. An output spike is generated when neuron's body potential reaches
    #                    this threshold.
    #       timeres    - Bit resolution for input spiketimes.
    #       wres       - Bit resolution for synaptic weights.
    #       ntype      - Type of neuron response function. Supports step-no-leak and ramp-no-leak response functions.
    #       ramp       - Slope of ramp for ramp-no-leak response function. Default is 1.
    #       w_init     - Type of initialization for synaptic weights. Supports 'zero', 'random uniform' and
    #                    'random normal' initializations.
    #       k          - Maximum number of winners to allow uninhibited.
    #       stoch      - Decides how correlated or uncorrelated weight updates will be, for a column's synapses. Could
    #                    be low or high.
    #       reward_en  - Enable reinforcement for STDP (R-STDP).
    #       data       - Input 2D data.
    # Returns 1) a tensor of LI output spiketimes consisting of upto k non-null spikes for each column. Shape is [rows*cols*q,p].
    #         2) a tensor with concatenated re-dimensionalized input spiketimes of all TNN columns. Shape is [rows*cols*q,p].

class TNNColumnLayer(nn.Module):
    def __init__(self, inputsize, rfsize, stride, nprev, neurons, theta, timeres=3, wres=3,\
                 ntype="rnl", ramp=1, w_init="zero", k=1, stoch="low", reward_en=0):
        super(TNNColumnLayer, self).__init__()
        if not isinstance(inputsize,tuple):
            inputsize      = (inputsize,inputsize)
        if not isinstance(rfsize,tuple):
            rfsize         = (rfsize,rfsize)
        
        self.rfsize        = rfsize
        self.stride        = stride
        self.rows          = ((inputsize[0]-rfsize[0])//stride) + 1
        self.cols          = ((inputsize[1]-rfsize[1])//stride) + 1
        
        self.p             = rfsize[0]*rfsize[1]*nprev
        self.q             = neurons
        self.theta         = theta
        self.wres          = wres
        self.ntype         = ntype
        self.ramp          = ramp
        self.k             = k
        
        max_tin            = 2**timeres-1
        if self.ntype   == "snl":
            self.time      = max_tin + 1
        elif self.ntype == "rnl":
            self.time      = max_tin + (2**self.wres-2)
        
        # Synaptic weight initialization. Shape of weights is [self.q,self.p].
        wmax               = 2**self.wres - 1
        if w_init       == "zero":
            self.weights   = nn.Parameter(torch.zeros(self.rows*self.cols*self.q, self.p), requires_grad=False)
        elif w_init     == "uniform":
            self.weights   = nn.Parameter(torch.randint(low=0, high=wmax+1, \
                                          size=(self.rows*self.cols*self.q, self.p)).type(torch.FloatTensor),\
                                          requires_grad=False)
        elif w_init     == "normal":
            self.weights   = nn.Parameter(torch.round(((wmax+1)/2+torch.randn(self.rows*self.cols*self.q,\
                                                                              self.p)).clamp_(0,wmax)), requires_grad=False)
        
        if reward_en == 0:
            self.stdp      = STDP(wres, stoch, layer=1)
        else:
            self.stdp      = RSTDP(wres, stoch, layer=1)
        
        self.const         = torch.arange(self.time).repeat(self.rows*self.cols*self.q, self.p, 1).permute(2,0,1)
        self.pot           = torch.zeros(self.time, self.rows*self.cols*self.q)
        self.ec_spiketimes = float('Inf')*torch.ones(self.rows*self.cols, self.q)
        self.li_spiketimes = float('Inf')*torch.ones(self.rows*self.cols, self.q)
    
    def __call__(self, data):
        sliced_data                            = data.unfold(1, self.rfsize[0], self.stride).unfold(2, self.rfsize[1],\
                                                                                                  self.stride).permute(1,2,0,3,4)
        a, b, c, d, e      = sliced_data.shape
        input_spiketimes   = sliced_data.reshape(a*b, c*d*e).repeat_interleave(self.q, dim=0)
        
        ### Excitatory Columns
        temp_weights                           = self.weights.repeat(self.time, 1, 1)
        spikes                                 = input_spiketimes.repeat(self.time, 1, 1)
        spikes                                 = self.const - spikes
        spikes[spikes>=0]                      = 1
        spikes[spikes<0]                       = 0
        
        if self.ntype == "snl":
            responses                          = torch.mul(spikes, temp_weights)
            self.pot                           = torch.sum(responses, dim=2)
        elif self.ntype == "rnl":
            responses                          = self.ramp * torch.cumsum(spikes,dim=0)
            responses                          = responses.type(torch.FloatTensor)
            responses[responses>=temp_weights] = temp_weights[responses>=temp_weights]
            self.pot                           = torch.sum(responses, dim=2)
        
        temp                                   = self.pot.clone()
        temp[temp<self.theta]                  = 0
        temp[temp>=self.theta]                 = 1
        tempsum                                = torch.sum(temp, dim=0)
        
        ec_out                                 = self.time - tempsum
        ec_out[ec_out == self.time]            = float('Inf')
        self.ec_spiketimes                     = ec_out.reshape(self.rows*self.cols,self.q)
        
        ### Lateral Inhibition
        self.li_spiketimes                     = float('Inf')*torch.ones(self.rows*self.cols, self.q)
        sort_times, sort_idx                   = torch.sort(self.ec_spiketimes, dim=1)
        
        if self.k == 1:
            self.li_spiketimes.scatter_(1, sort_idx[:,0].reshape(-1,1), sort_times[:,0].reshape(-1,1))
        else:
            self.li_spiketimes.scatter_(1, sort_idx[:,:self.k], sort_times[:,:self.k])
        
        output_spiketimes                      = self.li_spiketimes.flatten().repeat(self.p, 1).permute(1, 0)
        
        return output_spiketimes, input_spiketimes, self.li_spiketimes.permute(1,0).reshape(-1,a,b)



### Author: Harideep Nair ###
### TNN Voter-Tally Layer ###

    # Implements a TNN layer with multiple TNN voters and a final tally.
    # Each voter is connected to a single column in the previous layer.
    # Each voter generates upto 'q' votes from 'p' inputs (outputs of last layer of TNN columns).
    # 'q' is equal to the number of classes or labels. 'p' is equal to the number of neurons per column in the previous layer.
    # Capable of online continuous learning via R-STDP.
    # Final tally block finds the label with maximum vote and selects that as the prediction. In case of ties, winning
    # label with the highest index is chosen.
    
    # Args: rows         - Number of rows of TNN columns/voters, when the previous layer of TNN columns or the current layer of
    #                      TNN voters is viewed as a 2D array.
    #       cols         - Number of cols of TNN columns/voters, when the previous layer of TNN columns or the current layer of
    #                      TNN voters is viewed as a 2D array.
    #       nprev        - Number of neurons per column in the previous layer.
    #       num_classes  - Number of output classes or labels.
    #       voter_thresh - Threshold for selecting winning weights. For each voter, given a 1-hot input, those labels are voted 
    #                      whose synaptic weights are greater than or equal to (voter_thresh * maxweight). 'maxweight' is the 
    #                      maximum weight across all synapses corresponding to the 1-hot input.
    #       wres         - Bit resolution for synaptic weights.
    #       w_init       - Type of initialization for synaptic weights. Supports 'zero', 'random uniform' and
    #                      'random normal' initializations.
    #       stoch        - Decides how correlated or uncorrelated weight updates will be, for a column's synapses. Could
    #                      be low or high.
    #       input_spikes - Input spiketimes from the previous layer of TNN columns.
    # Returns 1) a tensor with concatenated re-dimensionalized binarized input spikes of all TNN columns for use in STDP/R-STDP.
    #            Its shape is [p*rows*cols, q].
    #         2) a tensor with concatenated re-dimensionalized output votes of all TNN voters for use in STDP/R-STDP.
    #            Its shape is [p*rows*cols, q].
    #         3) a tensor of 1-hot final prediction. Its shape is [q].

class TNNVoterTallyLayer(nn.Module):
    def __init__(self, rows, cols, nprev, num_classes, voter_thresh, wres=3, w_init="zero", stoch="low"):
        super(TNNVoterTallyLayer, self).__init__()
        self.rows          = rows
        self.cols          = cols
        self.p             = nprev
        self.q             = num_classes
        self.voter_thresh  = voter_thresh
        
        self.wmax          = 2**wres - 1
        
        if w_init       == "zero":
            self.weights   = nn.Parameter(torch.zeros(self.rows*self.cols*self.p, self.q), requires_grad=False)
        elif w_init     == "uniform":
            self.weights   = nn.Parameter(torch.randint(low=0, high=self.wmax+1, size=(self.rows*self.cols*self.p, self.q))\
                                          .type(torch.FloatTensor), requires_grad=False)
        elif w_init     == "normal":
            self.weights   = nn.Parameter(torch.round(((self.wmax+1)/2+torch.randn(self.rows*self.cols*self.p, self.q))\
                                                      .clamp_(0,self.wmax)), requires_grad=False)
        
        self.stdp          = RSTDP_Voter(wres, stoch)
        
        self.votes         = torch.zeros(self.rows*self.cols*self.p, self.q)
        self.prediction    = torch.zeros(self.q)
    
    def __call__(self, input_spikes):
        self.votes         = torch.zeros(self.rows*self.cols*self.p, self.q)
        self.prediction    = torch.zeros(self.q)
        
        voter_in           = input_spikes.permute(1,0)[0].repeat(self.q,1).permute(1,0)
        voter_in[voter_in != float('Inf')] = 1
        voter_in[voter_in == float('Inf')] = 0
        selected_weights   = voter_in * self.weights
        max_weights        = torch.max(selected_weights, dim=1)[0].repeat(self.q,1).permute(1,0)
#         max_weights        = torch.sum(selected_weights, dim=1).repeat(self.q,1).permute(1,0)
        self.votes[(selected_weights != 0)*(selected_weights >= self.voter_thresh*max_weights)] = 1
        tally = torch.sum(self.votes, dim=0)
        self.prediction[torch.argmax(tally)] = 1
        
        return voter_in, self.votes, self.prediction