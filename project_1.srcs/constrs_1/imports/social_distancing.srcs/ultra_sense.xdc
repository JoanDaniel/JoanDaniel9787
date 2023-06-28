set_property -dict { PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports {trigger_pin}];
set_property -dict { PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports {pulse_pin}];
 set_property -dict { PACKAGE_PIN L19 IOSTANDARD LVCMOS33 } [get_ports {alarm}];
# set_property -dict { PACKAGE_PIN J3 IOSTANDARD LVCMOS33 } [get_ports { motor[0] }];#LSB
#set_property -dict { PACKAGE_PIN H3 IOSTANDARD LVCMOS33 } [get_ports { motor[1] }];
#set_property -dict { PACKAGE_PIN J1 IOSTANDARD LVCMOS33 } [get_ports { motor[2] }];
#set_property -dict { PACKAGE_PIN K1 IOSTANDARD LVCMOS33 } [get_ports { motor[3] }];

#set_property -dict { PACKAGE_PIN L5 IOSTANDARD LVCMOS33 } [get_ports { meters[0] }];#LSB
#set_property -dict { PACKAGE_PIN L4 IOSTANDARD LVCMOS33 } [get_ports { meters[1] }];
#set_property -dict { PACKAGE_PIN M4 IOSTANDARD LVCMOS33 } [get_ports { meters[2] }];
#set_property -dict { PACKAGE_PIN M2 IOSTANDARD LVCMOS33 } [get_ports { meters[3] }];

#set_property -dict { PACKAGE_PIN N6 IOSTANDARD LVCMOS33 } [get_ports { gesture[0] }];
#set_property -dict { PACKAGE_PIN T7 IOSTANDARD LVCMOS33 } [get_ports { gesture[1] }];
#set_property -dict { PACKAGE_PIN P8 IOSTANDARD LVCMOS33 } [get_ports { gesture[2] }];
#set_property -dict { PACKAGE_PIN M6 IOSTANDARD LVCMOS33 } [get_ports { gesture[3] }];

## Clock signal

set_property -dict { PACKAGE_PIN W20 IOSTANDARD LVCMOS33 } [get_ports {data[0]}];
set_property -dict { PACKAGE_PIN Y18 IOSTANDARD LVCMOS33 } [get_ports {data[1]}];
set_property -dict { PACKAGE_PIN Y19 IOSTANDARD LVCMOS33 } [get_ports {data[2]}];
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports {data[3]}];
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports {data[4]}];
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports {data[5]}];
set_property -dict { PACKAGE_PIN V18 IOSTANDARD LVCMOS33 } [get_ports {data[6]}];
set_property -dict { PACKAGE_PIN W18 IOSTANDARD LVCMOS33 } [get_ports {data[7]}];
set_property -dict { PACKAGE_PIN V20 IOSTANDARD LVCMOS33 } [get_ports {lcd_e}];
set_property -dict { PACKAGE_PIN U20 IOSTANDARD LVCMOS33 } [get_ports {lcd_rs}];

set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { clock }];

## Switches
set_property -dict { PACKAGE_PIN W19 IOSTANDARD LVCMOS33 } [get_ports { reset }];#LSB

set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports {an[0]}]; #LSB
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports {an[1]}];
set_property -dict { PACKAGE_PIN T12 IOSTANDARD LVCMOS33 } [get_ports {an[2]}];

set_property -dict { PACKAGE_PIN V13 IOSTANDARD LVCMOS33 } [get_ports {sseg[0]}];#A
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports {sseg[1]}];#B
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports {sseg[2]}];#C
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports {sseg[3]}];#D
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports {sseg[4]}];#E
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {sseg[5]}];#F
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports {sseg[6]}];#G
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports {sseg[7]}];#DP
    
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pulse_pin_IBUF]
set_property -dict { PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {scl}];
set_property -dict { PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports {sda}];
#set_property -dict { PACKAGE_PIN L5 IOSTANDARD LVCMOS33 } [get_ports { reset_n }];#LSB
set_property -dict { PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports { relay[0] }];
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports { relay[1] }];
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports {servo}];
#set_property -dict { PACKAGE_PIN C4 IOSTANDARD LVCMOS33 } [get_ports {txd}];

#set_property -dict { PACKAGE_PIN K12 IOSTANDARD LVCMOS33 } [get_ports {buzzer_out}];