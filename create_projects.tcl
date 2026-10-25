set root [file normalize [file dirname [info script]]]
set part "xc7s75fgga484-1"
proc mk {name dir top sources xdc tb} {global part;create_project $name $dir -part $part -force;set_property target_language Verilog [current_project];set_property simulator_language Mixed [current_project];set_property target_simulator XSim [current_project];add_files -norecurse $sources;add_files -fileset constrs_1 -norecurse $xdc;add_files -fileset sim_1 -norecurse $tb;set_property top $top [get_filesets sources_1];set_property top tb [get_filesets sim_1];set_property xsim.simulate.runtime all [get_filesets sim_1];update_compile_order -fileset sources_1;update_compile_order -fileset sim_1;puts "CREATED $name";close_project}
set c "$root/circuits"
mk lab6_uart_led "$c/00_uart_led" lab6_uart_led [list "$c/00_uart_led/src/uart.v" "$c/00_uart_led/src/lab6_uart_led.v"] "$c/00_uart_led/constraints/lab6_uart_led.xdc" "$c/00_uart_led/sim/tb_design.v"
mk lab6_servo "$c/01_servo" servo_ctrl [list "$c/01_servo/src/servo.v"] "$c/01_servo/constraints/lab6_servo.xdc" "$c/01_servo/sim/tb_design.v"
mk lab6_sram "$c/02_sram" sram [list "$c/02_sram/src/sram.v"] "$c/02_sram/constraints/lab6_sram.xdc" "$c/02_sram/sim/tb_design.v"
mk lab6_dac "$c/03_dac" dac [list "$c/03_dac/src/dac.v"] "$c/03_dac/constraints/lab6_dac.xdc" "$c/03_dac/sim/tb_design.v"
