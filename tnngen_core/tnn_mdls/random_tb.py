import numpy as np
import random

def neuronbody_random(ip_size=4, thres=13, tres=4, wres=4, wave=10, verbose=False):
    f = open("tnn_mdls/tests/neuronbody_test_random", "w")
    for w in range(wave):
        f.write('# Wave: '+ str(w) +'\n')
        
        # Generate spike times
        spike_times = []
        for i in range(ip_size):
            spike_times += [random.randint(1, (2**tres)-1)]
        spike_times = np.array(spike_times)
        reset_times = spike_times+(2**wres)-(2**tres)
        
        if verbose:
            print('spike_times: ', spike_times)
        
        # tres window
        if verbose:
            print('t-window')
            
        in_bits = ['0'] * ip_size
        delays = []
        acc_ins = [0]
        delay = 0
        for t in range(2**tres):
            if t in spike_times:
                delays += [delay]
                delay = 0
                time_matches = np.where(spike_times == t)[0]

                # Flip bits of time spikes
                for i in range(len(time_matches)):
                    index = time_matches[i]
                    in_bits[index] = '1'

                # Calculate acc_in
                acc_string = ''
                for i in range(ip_size):
                    acc_string += in_bits[i]
                acc_ins += [int(acc_string, 2)]
            
            if verbose:
                print(in_bits)

            delay+=1

        acc_ins += [int(acc_string, 2)]
        delays+=[delay]
        
        # wres window
        if verbose:
            print('w-window')
        delay = 0
        for t in range(2**wres-1):
            if t in reset_times:
                delays += [delay]
                delay = 0
                time_matches = np.where(reset_times == t)[0]
                for i in range(len(time_matches)):
                    index = time_matches[i]
                    in_bits[index] = '0'

                # Calculate acc_in
                acc_string = ''
                for i in range(ip_size):
                    acc_string += in_bits[i]
                acc_ins += [int(acc_string, 2)]
                
            if verbose:
                print(in_bits)

            delay+=1
        delays+=[delay]
        
        if verbose:
            print(acc_ins, delays)
        
        # Write loop
        for i in range(len(acc_ins)):
            f.write('acc_in('+str(acc_ins[i])+'),\n')
            f.write('Delay('+str(delays[i])+'),\n')
            f.write('\n')
    f.close()
    
def stdp_random(tres=3, wres=4, input_prob=0.75, output_prob=0.75, wave=10, verbose=False):
    f = open("tnn_mdls/tests/stdp_test_random", "w")
    for w in range(wave):
        
        f.write('# Wave: '+ str(w) +'\n')
        
        weight_in = random.randint(0, (2**wres-1))
        f.write('weight_in('+str(weight_in)+'),\n')
        
        e_in = 0
        e_out = 0
        delay = 0
        e_ins = [0]
        e_outs = [0]
        delays = []
        if_input_spike = np.random.choice([0,1], p=[1-input_prob, input_prob])
        if_output_spike = np.random.choice([0,1], p=[1-output_prob, output_prob])

        # Generate spike times
        if if_input_spike:
            e_in_time = random.randint(1, (2**tres)-1)
        else:
            e_in_time = -1
            e_in_reset = -1
        if if_output_spike:
            e_out_time = random.randint(1, (2**tres))
        else:
            e_out_time = -1
            e_out_reset = -1

        # t-window
        for t in range(2**tres):
            if e_in_time == t:
                e_in = 1
                e_ins += [1]
                e_outs += [e_out]
                delays += [delay]
                delay = 0
            if e_out_time == t:
                e_out = 1
                e_outs += [1]
                e_ins += [e_in]
                delays += [delay]
                delay = 0
            delay += 1

        # w-window
        e_ins += [e_in]
        e_outs += [e_out]
        delays += [delay+2**wres-1]
        
        if verbose:
            print('delays:', delays)
            print('ein:', e_ins)
            print('eout:', e_outs)
            print('weight_in: ', weight_in)
        
        # Write loop
        for i in range(len(delays)):
            f.write('ein('+str(e_ins[i])+'),\n')
            f.write('eout('+str(e_outs[i])+'),\n')
            f.write('Delay('+str(delays[i])+'),\n')
            f.write('\n')
            
def fsm_synapse_random(w_init=5, tres=4, wres=4, wave=10, verbose=False):    
    f = open("tnn_mdls/tests/fsm_synapse_test_random", "w")
    
    # set w_init
    f.write('w_init(str(w_init)),\n\n')
    
    # inc test
    f.write('# Increment tests\n\n')
    
    for w in range(wave):
        f.write('# Wave: '+ str(w) +'\n')
        f.write('dec(0),\n')
        f.write('inc(0),\n')
        
        input_spike_time = random.randint(1, (2**tres)-1)
        total_wave_time = 2**tres + 2**wres - 1

        f.write('Delay('+str(input_spike_time)+'),\n')
        f.write('input_spike(1),\n')
        f.write('inc(1),\n')
        f.write('Delay('+str((2**wres))+'),\n')
        f.write('input_spike(0),\n')
        total_wave_time -= input_spike_time+(2**wres)
        f.write('Delay('+str(total_wave_time)+'),\n')
        f.write('\n')
        
    # dec test
    f.write('# Decrement tests\n\n')

    for w in range(wave):
        f.write('# Wave: '+ str(w) +'\n')
        f.write('dec(0),\n')
        f.write('inc(0),\n')
        
        input_spike_time = random.randint(1, (2**tres)-1)
        inc = random.randint(0,1)
        total_wave_time = 2**tres + 2**wres - 1

        f.write('Delay('+str(input_spike_time)+'),\n')
        f.write('input_spike(1),\n')
        f.write('dec(1),\n')
        f.write('Delay('+str((2**wres))+'),\n')
        f.write('input_spike(0),\n')
        total_wave_time -= input_spike_time+(2**wres)
        f.write('Delay('+str(total_wave_time)+'),\n')
        f.write('\n')
        
    f.write('input_spike(0),\n')
    f.write('Delay(100),\n')

def wta_random(Q=4, tres=4, wres=4, wave=10, verbose=False):
    f = open("tnn_mdls/tests/wta_test_random", "w")
    for w in range(wave):
        f.write('# Wave: '+ str(w) +'\n')
        
        # Generate spike times
        spike_times = []
        for i in range(Q):
            spike_times += [random.randint(1, (2**tres)-1)]
        spike_times = np.array(spike_times)
        reset_times = spike_times+(2**wres)-(2**tres)
        
        if verbose:
            print('spike_times: ', spike_times)
        
        # tres window
        if verbose:
            print('t-window')
            
        in_bits = ['0'] * Q
        delays = []
        ec_spikes = [0]
        delay = 0
        for t in range(2**tres):
            if t in spike_times:
                delays += [delay]
                delay = 0
                time_matches = np.where(spike_times == t)[0]

                # Flip bits of time spikes
                for i in range(len(time_matches)):
                    index = time_matches[i]
                    in_bits[index] = '1'

                # Calculate ec_spike
                ec_string = ''
                for i in range(Q):
                    ec_string += in_bits[i]
                ec_spikes += [int(ec_string, 2)]
            
            if verbose:
                print(in_bits)

            delay+=1

        ec_spikes += [int(ec_string, 2)]
        delays+=[delay]
        
        # wres window
        if verbose:
            print('w-window')
        delay = 0
        for t in range(2**wres-1):
            if t in reset_times:
                delays += [delay]
                delay = 0
                time_matches = np.where(reset_times == t)[0]
                for i in range(len(time_matches)):
                    index = time_matches[i]
                    in_bits[index] = '0'

                # Calculate ec_spike
                ec_string = ''
                for i in range(Q):
                    ec_string += in_bits[i]
                ec_spikes += [int(ec_string, 2)]
                
            if verbose:
                print(in_bits)

            delay+=1
        delays+=[delay]
        
        if verbose:
            print(ec_spikes, delays)
        
        # Write loop
        for i in range(len(ec_spikes)):
            f.write('ec_spikes('+str(ec_spikes[i])+'),\n')
            f.write('Delay('+str(delays[i])+'),\n')
            f.write('\n')
    f.close()
    
def segment_random(ip_size_dist=16, ip_size_prox=1, thres=13, tres=4, wres=4, wave=10, verbose=False):
    f = open("tnn_mdls/tests/segment_test_random", "w")
    cat_ip_size = ip_size_dist + ip_size_prox
    f.write('# Set w_inits:\n')
    f.write('w_init_dist(5),\n')
    f.write('w_init_prox(5),\n\n')
    # Test 4 different inc and dec
    for n in range(4):
        if n == 0:
            f.write('# Test inc dist:\n')
            f.write('inc_dist(' + str(2**ip_size_dist-1) + '),\n')
            f.write('inc_prox(0),\n')
            f.write('dec_dist(0),\n')
            f.write('dec_prox(0),\n\n')
        elif n == 1:
            f.write('# Test inc prox:\n')
            f.write('inc_dist(0),\n')
            f.write('inc_prox(' + str(2**ip_size_prox-1) + '),\n')
            f.write('dec_dist(0),\n')
            f.write('dec_prox(0),\n\n')
        elif n == 2:
            f.write('# Test dec dist:\n')
            f.write('inc_dist(0),\n')
            f.write('inc_prox(0),\n')
            f.write('dec_dist(' + str(2**ip_size_dist-1) + '),\n')
            f.write('dec_prox(0),\n\n')
        elif n == 3:
            f.write('# Test dec prox:\n')
            f.write('inc_dist(0),\n')
            f.write('inc_prox(0),\n')
            f.write('dec_dist(0),\n')
            f.write('dec_prox(' + str(2**ip_size_prox-1) + '),\n\n')
            
        for w in range(wave):
            f.write('# Wave: '+ str(w) +'\n')

            # Generate spike times
            spike_times = []
            for i in range(cat_ip_size):
                spike_times += [random.randint(1, (2**tres)-1)]
            spike_times = np.array(spike_times)
            reset_times = spike_times+(2**wres-1)-(2**tres-1)

            if verbose:
                print('spike_times: ', spike_times)

            # tres window
            if verbose:
                print('t-window')

            in_bits = ['0'] * cat_ip_size
            delays = []
            input_spikes = [0]
            delay = 0
            for t in range(2**tres):
                if t in spike_times:
                    delays += [delay]
                    delay = 0
                    time_matches = np.where(spike_times == t)[0]

                    # Flip bits of time spikes
                    for i in range(len(time_matches)):
                        index = time_matches[i]
                        in_bits[index] = '1'

                    # Calculate input_spike
                    in_string = ''
                    for i in range(cat_ip_size):
                        in_string += in_bits[i]
                    input_spikes += [int(in_string, 2)]

                if verbose:
                    print(in_bits)

                delay+=1

            input_spikes += [int(in_string, 2)]
            delays+=[delay]

            # wres window
            if verbose:
                print('w-window')
            delay = 0
            for t in range(2**wres-1):
                if t in reset_times:
                    delays += [delay]
                    delay = 0
                    time_matches = np.where(reset_times == t)[0]
                    for i in range(len(time_matches)):
                        index = time_matches[i]
                        in_bits[index] = '0'

                    # Calculate input_spike
                    in_string = ''
                    for i in range(cat_ip_size):
                        in_string += in_bits[i]
                    input_spikes += [int(in_string, 2)]

                if verbose:
                    print(in_bits)

                delay+=1
            delays+=[delay]

            if verbose:
                print(input_spikes, delays)

            # Write loop
            input_format = '0'+str(cat_ip_size)+'b'
            for i in range(len(input_spikes)):
                dist_spikes = format(input_spikes[i], input_format)[ip_size_prox:ip_size_prox+ip_size_dist]
                prox_spikes = format(input_spikes[i], input_format)[0:ip_size_prox]
                f.write('input_spikes_dist('+str(int(dist_spikes, 2))+'),\n')
                f.write('input_spikes_prox('+str(int(prox_spikes, 2))+'),\n')
                f.write('Delay('+str(delays[i])+'),\n')
                f.write('\n')
    f.close()