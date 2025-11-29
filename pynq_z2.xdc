# 125 MHz Clock from Ethernet PHY
set_property PACKAGE_PIN H16 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 8.000 -name sys_clk -waveform {0.000 4.000} [get_ports clk]

# On-board USB-UART (connects to FTDI chip)
set_property PACKAGE_PIN D19 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]

# Prevent optimization of ring oscillator paths
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -hier -filter {NAME =~ *ro_in*}]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -hier -filter {NAME =~ *xor_*}]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets -hier -filter {NAME =~ *ro_*}]

set_property KEEP TRUE [get_nets -hier -filter {NAME =~ *xor_*}]
set_property KEEP TRUE [get_nets -hier -filter {NAME =~ *ro_*}]# Protect all RO cells from synthesis/optimization
set_property DONT_TOUCH true [get_cells -hier -filter {NAME =~ *RO0*}]
set_property DONT_TOUCH true [get_cells -hier -filter {NAME =~ *RO1*}]
set_property DONT_TOUCH true [get_cells -hier -filter {NAME =~ *LUT2*}]
set_property DONT_TOUCH true [get_cells -hier -filter {NAME =~ *MUXF7*}]

# Protect associated nets
set_property DONT_TOUCH true [get_nets -hier -filter {NAME =~ *ro_*}]
set_property DONT_TOUCH true [get_nets -hier -filter {NAME =~ *xor_*}]
# Allow ring oscillator comb loops

