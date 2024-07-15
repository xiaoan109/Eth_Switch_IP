## This file WAS a general .xdc for the Arty A7-35 Rev. D

## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]

#Round Robin Max Freq
create_clock -period 7.202 -name clk -waveform {0.000 3.601} -add [get_ports clk]
#WWFA Max Freq
#create_clock -period 7.719 -name clk -waveform {0.000 3.8} -add [get_ports clk]


## Reset signal
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports hard_reset]

set_input_delay -clock [get_clocks clk] -max 1 [get_ports hard_reset]
set_input_delay -clock [get_clocks clk] -min 1 [get_ports hard_reset]

set_output_delay -clock [get_clocks clk] -max 1 [get_ports req]
set_output_delay -clock [get_clocks clk] -min 1 [get_ports req]

## LEDs
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {req[0]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {req[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {req[2]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {req[3]}]