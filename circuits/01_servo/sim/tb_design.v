`timescale 1ns/1ps
module tb; localparam CLK_HZ=100000,FRAME=2000; reg clk=0,rst=1,l=0,r=0; wire servo; integer i,high;
always #5 clk=~clk; servo_ctrl #(.CLK_HZ(CLK_HZ)) dut(clk,rst,l,r,servo);
task pulse_left;begin @(negedge clk);l=1;@(negedge clk);l=0;end endtask
task pulse_right;begin @(negedge clk);r=1;@(negedge clk);r=0;end endtask
task frame_check(input integer expected);begin
 if(servo) wait(servo===0); @(posedge servo); high=0; for(i=0;i<FRAME;i=i+1)begin @(posedge clk);#1;if(servo)high=high+1;end
 if(high!=expected)$fatal(1,"pulse expected=%0d got=%0d",expected,high);
end endtask
initial begin $dumpfile("wave.vcd");$dumpvars(0,tb);repeat(3)@(posedge clk);rst=0;
 frame_check(150);repeat(5)pulse_left();frame_check(100);pulse_left();frame_check(100);
 repeat(10)pulse_right();frame_check(200);pulse_right();frame_check(200);
 @(negedge clk);l=1;r=1;@(negedge clk);l=0;r=0;frame_check(200);
 rst=1;@(posedge clk);#1;if(servo!==0)$fatal(1,"reset");
 $display("PASS servo: 20ms frame, 1/1.5/2ms pulse, limits, simultaneous input, reset");$finish;end
initial begin #1000000;$fatal(1,"timeout");end endmodule
