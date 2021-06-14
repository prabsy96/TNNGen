### Importing libraries ###

import torch
import torch.nn.functional as F


### Author: Harideep Nair ###
### Rectangular Cropping ###

    # Crops a tensor into a given rectangular shape starting from a given position.
    
    # Args: pos         - Top left co-ordinates of the crop position. Could be a scalar or tuple.
    #       size        - Rectangular crop size. Could be a scalar or tuple.
    #       tensor      - Input tensor of any shape. Typical shape is [in_channels,height,width].   
    # Returns a corresponding cropped tensor with the last two dimensions of its shape equal to crop size

class Crop(object):
    def __init__(self, pos, size):
        if not isinstance(pos,tuple):
            self.pos  = (pos,pos)
        else:
            self.pos  = pos
        if not isinstance(size,tuple):
            self.size  = (size,size)
        else:
            self.size  = size
            
    def __call__(self, tensor):
        return tensor[:,self.pos[0]:self.pos[0]+self.size[0],self.pos[1]:self.pos[1]+self.size[1]]


### Author: Harideep Nair ###
### On-Off filtering ###

    # Performs On and Off filtering on a given tensor as a preliminary edge-detection mechanism.
    # On filter  - Takes a pixel value and subtracts the mean of its surrounding pixels from it.
    # Off filter - Subtracts a pixel value from the mean of its surrounding pixels.
    
    # Args: window_size - Scalar window size of the filter. Filter's shape is assumed to be a square.
    #       tensor      - Input tensor of shape [in_channels,height,width].
    # Returns concatenated On and Off versions of the input tensor with output shape [in_channels,2*height,width].

class OnOff(object):
    def __init__(self, window_size=3):
        self.window_size = window_size
        
    def __call__(self, tensor):
        tensor                 = torch.unsqueeze(tensor, 0)
        mid                    = int((self.window_size-1)/2)
        
        onfilter               = -1*torch.ones((tensor.shape[1],1,self.window_size, self.window_size))
        onfilter[0,:,mid,mid]  = (self.window_size**2)-1
        
        offfilter = torch.ones((tensor.shape[1],1,self.window_size, self.window_size))
        offfilter[0,:,mid,mid] = 1-(self.window_size**2)
        
        on                     = F.conv2d(tensor, onfilter, stride=1,\
                                          padding=((self.window_size-1)//2,(self.window_size-1)//2), groups=tensor.shape[1])
        off                    = F.conv2d(tensor, offfilter, stride=1,\
                                          padding=((self.window_size-1)//2,(self.window_size-1)//2), groups=tensor.shape[1])
        out                    = torch.cat([on.squeeze_(0),off.squeeze_(0)], dim=1)
        out[out<0]             = 0
        
        return out



### Author: Harideep Nair ###
### Pos-Neg filtering ###

    # Performs Positive and Negative filtering on a given tensor.
    # The input tensor is binarized first and then it's negative is appended.
    # This ensures all RFs have equal number of spikes.
    
    # Args: window_size - Scalar window size of the filter. Filter's shape is assumed to be a square.
    #       tensor      - Input tensor of shape [in_channels,height,width].
    # Returns concatenated On and Off versions of the input tensor with output shape [in_channels,2*height,width].

class PosNeg(object):
    def __init__(self, pn_threshold):
        self.pn_thresh = pn_threshold
        
    def __call__(self, tensor):
        maxt                                    = torch.max(tensor)
        tensor[tensor >= (self.pn_thresh*maxt)] = maxt
        tensor[tensor < (self.pn_thresh*maxt)]  = 0
        
        tensor                                  = tensor - maxt
        tensor[tensor == -maxt]                 = float('Inf')
        tensor_neg                              = tensor.clone()
        tensor_neg[tensor_neg == 0]             = 1
        tensor_neg[tensor_neg == float('Inf')]  = 0
        tensor_neg[tensor_neg == 1]             = float('Inf')
        
        out                    = torch.cat([tensor,tensor_neg], dim=0)
        
        return out



### Author: Harideep Nair ###
### On-Off filtering with channel creation ###

    # Performs On and Off filtering on a given tensor as a preliminary edge-detection mechanism.
    # On filter  - Takes a pixel value and subtracts the mean of its surrounding pixels from it.
    # Off filter - Subtracts a pixel value from the mean of its surrounding pixels.
    
    # Args: window_size - Scalar window size of the filter. Filter's shape is assumed to be a square.
    #       tensor      - Input tensor of shape [in_channels,height,width].
    # Returns On and Off versions of the input tensor as two separate channels with output shape [in_channels*2,height,width].

class OnOff_Channels(object):
    def __init__(self, window_size=3):
        self.window_size = window_size
        
    def __call__(self, tensor):
        tensor                 = torch.unsqueeze(tensor, 0)
        mid                    = int((self.window_size-1)/2)
        
        onfilter               = -1*torch.ones((tensor.shape[1],1,self.window_size, self.window_size))
        onfilter[0,:,mid,mid]  = (self.window_size**2)-1
        
        offfilter = torch.ones((tensor.shape[1],1,self.window_size, self.window_size))
        offfilter[0,:,mid,mid] = 1-(self.window_size**2)
        
        on                     = F.conv2d(tensor, onfilter, stride=1,\
                                          padding=((self.window_size-1)//2,(self.window_size-1)//2), groups=tensor.shape[1])
        off                    = F.conv2d(tensor, offfilter, stride=1,\
                                          padding=((self.window_size-1)//2,(self.window_size-1)//2), groups=tensor.shape[1])
        out                    = torch.cat([on.squeeze_(0),off.squeeze_(0)], dim=0)
        out[out<0]             = 0
        
        return out


### Author: Harideep Nair ###
### Black-and-white temporal encoding ###

    # Converts a given tensor to black-and-white, and generates its corresponding temporally encoded spiketimes.
    # "Black" is given a spiketime of 'infinity' (no spike), whereas "white" corresponds to a spike at time '0'.
    
    # Args: threshold   - Any value equal to or higher than the threshold is considered "white"; else "black".
    #       tensor      - Input tensor of any shape. Typical shape is [in_channels,height,width].
    # Returns a corresponding black-and-white tensor of spiketimes with the same shape as input tensor.

class BlackAndWhite(object):
    def __init__(self, threshold = 0.5):
        self.threshold = threshold
        
    def __call__(self, tensor):
        maxt   = torch.max(tensor)
        tensor[tensor >= (self.threshold*maxt)] = maxt
        tensor[tensor < (self.threshold*maxt)]  = 0
        tensor = tensor - maxt
        tensor[tensor==-maxt] = float('Inf')
        return tensor
    

### Author: Harideep Nair ###
### Grayscale temporal encoding ###

    # Generates temporally encoded spiketimes from a given grayscale tensor.
    # Higher the input value, earlier the corresponding spiketime.
    
    # Args: timeres     - Bit resolution for the output spiketime window. Relates to maximum output spiketime.
    #       threshold   - (optional) Any spiketime equal to or higher than the threshold is considered as "no spike".
    #       tensor      - Input tensor of any shape. Typical shape is [in_channels,height,width].   
    # Returns a corresponding tensor of spiketimes with the same shape as input tensor.

class GrayScale(object):
    def __init__(self, timeres, threshold):
        self.time      = (2**timeres)-1
        self.threshold = threshold
        
    def __call__(self, tensor):
        maxt   = torch.max(tensor)
        tensor = torch.round((tensor/maxt)*self.time)
        tensor = self.time-tensor
        tensor[tensor>=self.threshold] = float('Inf')
        return tensor