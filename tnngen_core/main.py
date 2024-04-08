from rich.console import Console
from backend.backend import *
from tnn_sim import tnn_sim
from tnn_syn import tnn_syn
import argparse
import os

if __name__=='__main__':

    console = Console()
    console.print("[bold magenta]  /------------------------------------------------------------\\")
    console.print("[bold magenta]  |                                                            |")
    console.print("[bold magenta]  |  Welcome to TNNGen (Temporal Neural Network Generator)!    |")
    console.print("[bold magenta]  |  TNNGen is a Python framework for building TNN ecosystems  |")
    console.print("[bold magenta]  |                                                            |")
    console.print("[bold magenta]  |  Prabhu Vellaisamy <pvellais@andrew.cmu.edu>               |")
    console.print("[bold magenta]  |  CMU-NCAL, Carnegie Mellon University                      |")
    console.print("[bold magenta]  |                                                            |")
    console.print("[bold magenta]  \\-----------------------------------------------------------/")

    console.print("[bold magenta]    TNNGen framework incorporates TNNSim[1] + TNNSyn[2]")
    console.print("[bold magenta]    Provide specifications in args.txt in_file (refer to README for more information)")
    console.print("[bold magenta]    ")
    console.print("[bold magenta]    [1] Prabhu Vellaisamy <pvellais@andrew.cmu.edu>")
    console.print("[bold magenta]    [2] Harideep Nair <hpnair@sv.cmu.edu>")
    console.print("[bold magenta]    [3] YoungSeok Na <youngsen@andrew.cmu.edu>")
    console.print("[bold magenta]    [3] Wei-Che Huang <weichehu@andrew.cmu.edu>")

    # parse command line arguments

    parser = argparse.ArgumentParser(description = 'TNNGen: A Framework for Temporal Neural Network Ecosystem')
    parser.add_argument('-f', type=str, required=True, help='Provide text file containing arguments.')
    module_group = parser.add_mutually_exclusive_group(required=True)
    module_group.add_argument('-m', type=str, help='Module name of interest - Available options: column (default), dendrite')
    module_group.add_argument('-sm', type=str, help='Submodule of interest')

    args = parser.parse_args()
    in_file = args.f
    module_name = args.m
    submodule_name = args.sm

    args = text_parser(in_file)

    sim_dict, syn_dict = {}, {}

    # segregate params
    for x in args:
        if x in ('neurons', 'rfsize', 'theta', 'nprev', 'wres'):
            sim_dict[x] = args[x]
            syn_dict[x] = args[x]
        elif x in ('imgsize', 'rfsize', 'stride', 'pn_thresh', 'num_classes', 'resize', 'resize_param', 'filter', 'crop', 'crop_size', 'crop_pos', 'timeres', 'ntype', 'ramp', 'w_init', 'k', 'stoch', 'ucapture', 'usearch', 'ubackoff', 'ubackoff_simp', 'umin', 'inc_learn', 'weights_save'):
            sim_dict[x] = args[x]
        elif x in ('flow', 'aclk_freq', 'gclk_freq', 'gen_eff', 'tool', 'node', 'lib_path', 'lef_path'):
            syn_dict[x] = args[x]

    # find mode
    for y in args:
        if y == 'sim_switch':
            if args[y] == 'on':
                tnn_sim(sim_dict)
            elif args[y] == 'off':
                pass
            else:
                raise ValueError('Only on/off allowed')
        elif y == 'syn_switch':
            if args[y] == 'on':
                tnn_syn(module_name, submodule_name, syn_dict)
            elif args[y] == 'off':
                pass
            else:
                raise ValueError('Only on/off allowed')


