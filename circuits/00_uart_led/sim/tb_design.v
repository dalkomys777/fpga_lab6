`timescale 1ns/1ps
module tb;
localparam DIV=8; reg clk=0,rst=1,rxd=1; wire txd; wire [7:0] led;
always #5 clk=~clk;
lab6_uart_led #(.DIV(DIV)) dut(clk,rst,rxd,txd,led);
wire [7:0] echo_data; wire echo_valid;
uart_rx #(.DIV(DIV)) monitor(clk,rst,txd,echo_data,echo_valid);
task send_byte(input [7:0] b); integer k; begin
 rxd=0; repeat(DIV) @(posedge clk);
 for(k=0;k<8;k=k+1) begin rxd=b[k];repeat(DIV) @(posedge clk);end
 rxd=1;repeat(DIV) @(posedge clk);
end endtask
task command(input [7:0] b,input expected); begin
 send_byte(b); wait(echo_valid); #1;
 if(echo_data!==b) $fatal(1,"echo expected=%h got=%h",b,echo_data);
 if(led[0]!==expected) $fatal(1,"LED cmd=%c expected=%b got=%b",b,expected,led[0]);
 repeat(2) @(posedge clk);
end endtask
initial begin
 $dumpfile("wave.vcd");$dumpvars(0,tb);
 repeat(3) @(posedge clk);rst=0;
 command("1",1);command("1",1);command("2",0);command("2",1);command("0",0);command("A",0);
 rst=1;@(posedge clk);#1;if(led!==0||txd!==1)$fatal(1,"reset");
 $display("PASS UART LED: 8N1 echo, 0/1/2 commands, repeat, other, reset");$finish;
end
initial begin #200000;$fatal(1,"timeout");end
endmodule
