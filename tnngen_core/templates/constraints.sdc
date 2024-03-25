#create_clock [get_ports aclk]  -period $ACLKP -name aclk
#create_clock [get_ports gclk]  -period $GCLKP  -waveform {0 120000000} -name gclk

create_clock [get_ports aclk]  -period 10000000.00  -waveform {0 5000000} -name aclk
create_clock [get_ports gclk]  -period 240000000.00  -waveform {0 120000000} -name gclk
