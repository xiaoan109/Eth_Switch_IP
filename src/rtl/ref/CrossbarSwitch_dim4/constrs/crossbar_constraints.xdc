## This file WAS a general .xdc for the Arty A7-35 Rev. D

## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]

create_clock -period 15.787 -name clk -waveform {0.000 7.9} -add [get_ports clk]

## Reset signal
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports hard_reset]

set_input_delay -clock [get_clocks clk] -max 5 [get_ports hard_reset]
set_input_delay -clock [get_clocks clk] -min 5 [get_ports hard_reset]

set_output_delay -clock [get_clocks clk] -max 5 [get_ports req]
set_output_delay -clock [get_clocks clk] -min 5 [get_ports req]

## LEDs
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {req[0]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {req[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {req[2]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {req[3]}]


