set_property PACKAGE_PIN B6 [get_ports clk_50mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50mhz]
create_clock -period 20.000 -name sys_clk [get_ports clk_50mhz]
set_property PACKAGE_PIN K4 [get_ports rst_p]
set_property IOSTANDARD LVCMOS33 [get_ports rst_p]
# TODO 교재의 DAC 전용 핀표를 보고 dac_csn/ldacn/wen/a_b/d[7:0]를 지정한다.
# add_sel 및 led_out도 실험에 사용할 보드 스위치·LED 핀으로 지정한다.
