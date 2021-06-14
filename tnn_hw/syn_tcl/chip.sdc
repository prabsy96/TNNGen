set CLK_PERIOD1 10000.00
set CLK_PERIOD2 150000.00

# Clock
set CLK_PORT1 [get_ports aclk]
set CLK_PORT2 [get_ports gclk]
create_clock -period $CLK_PERIOD1 -name my_clock $CLK_PORT1
create_clock -period $CLK_PERIOD2 -name my_clock $CLK_PORT2
