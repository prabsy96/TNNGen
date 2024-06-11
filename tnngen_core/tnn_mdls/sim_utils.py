from veriloggen import *

def grst_gen(m=None, g_period=16):
    i = m.Integer('i', 32, value=0)
    m.EmbeddedCode('''
initial i = 0;
always @ (posedge dut_clk)
    begin
        i = i % ''' + str(g_period) + ''';
        if (i==0) dut_grst = 1;
        if (i==1) dut_grst = 0;
        i = i + 1;
    end''')

def rstb_gen(dump=None, rstb=None, delay_cycles=5):
    dump.add(
        rstb(0),
        Delay(delay_cycles),
        rstb(1)
    )
    
def add_to_dump(dump, dut, inputs, delays):
    ports = dut.get_raw_inst_ports()
    ports = list(ports.items())

    input_ports = []
    output_ports = []
    for port in ports:
        port_name, port_obj = port
        # if port is input and not clk, grst, rstb
        if isinstance(port_obj, core.vtypes.Reg):
            if ((port_name!='dut_clk') & (port_name!='dut_grst') & (port_name!='dut_rstb')):
                input_ports += [port_obj]
        else:
            output_ports += [port_obj]
            
    sim_waves = len(inputs[0])
    num_ports = len(input_ports)
    for i in range(sim_waves):
        for j in range(num_ports):
            dump.add(input_ports[j](inputs[j][i]))
        dump.add(Delay(delays[i]))

    dump.add(simulation.finish())
