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
    console.print("[bold magenta]    [3] Yuyang Kang <yuyangk@andrew.cmu.edu>")

    # currently supported modules/submodules
    m_choice = ['column', 'dendrite']
    sm_choice = ['less_equal', 'pulse2edge', 'edge2pulse', 'adder', 'incdec', 'wta',
                 't_wta', 'stabilize_func', 'stdp_casegen', 'fsm_convert', 'fsm_synapse',
                 'stdp', 'pac', 'neuron_body', 'neuron_rnl', 'segment']
    l_choice = ['simple']

    # parse command line arguments
    parser = argparse.ArgumentParser(description = 'TNNGen: A Framework for Temporal Neural Network Ecosystem')
    parser.add_argument('-f', type=str, required=True, help='Provide text file containing arguments.')
    module_group = parser.add_mutually_exclusive_group(required=True)
    module_group.add_argument('-m', type=str, metavar='module', choices=m_choice, help='Module name of interest')
    module_group.add_argument('-sm', type=str, metavar='submodule', choices=sm_choice, help='Submodule of interest')
    module_group.add_argument('-l', type=str, metavar='layer', choices=l_choice, help='Layer of interest')

    args = parser.parse_args()
    in_file = args.f
    module_name = args.m
    submodule_name = args.sm
    layer_name = args.l

    args = text_parser(in_file)
    sim_dict, syn_dict = args_divide(args)

    if args['sim_switch'] == 'on':
        tnn_sim(sim_dict)
    elif args['syn_switch'] == 'on':
        tnn_syn(module_name, submodule_name, layer_name, syn_dict)
    else:
        console.print("[bold blue]  -> Mode not selected. Ending the program.")

