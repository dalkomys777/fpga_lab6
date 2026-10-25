`timescale 1ns/1ps
module uart_rx #(parameter DIV=5208)(input wire clk,rst,input wire rxd,output reg [7:0] data,output reg valid);
reg r1=1,r2=1,busy=0; reg [15:0] count=0; reg [3:0] bitno=0; reg [7:0] shift=0;
always @(posedge clk) begin
 if(rst) begin r1<=1;r2<=1;busy<=0;count<=0;bitno<=0;data<=0;valid<=0; end
 else begin r1<=rxd;r2<=r1;valid<=0;
  if(!busy) begin if(!r2) begin busy<=1;count<=DIV/2;bitno<=0; end end
  else if(count==0) begin
   if(bitno==0) begin if(!r2) begin bitno<=1;count<=DIV-1; end else busy<=0; end
   else if(bitno<=8) begin shift[bitno-1]<=r2;bitno<=bitno+1'b1;count<=DIV-1; end
   else begin busy<=0; if(r2) begin data<=shift;valid<=1; end end
  end else count<=count-1'b1;
 end
end
endmodule

module uart_tx #(parameter DIV=5208)(input wire clk,rst,start,input wire [7:0] data,output reg txd,output reg busy);
reg [9:0] frame=10'h3ff; reg [15:0] count=0; reg [3:0] bitno=0;
always @(posedge clk) begin
 if(rst) begin txd<=1;busy<=0;count<=0;bitno<=0;frame<=10'h3ff; end
 else if(!busy) begin txd<=1; if(start) begin frame<={1'b1,data,1'b0};txd<=0;busy<=1;count<=DIV-1;bitno<=0; end end
 else if(count==0) begin
  if(bitno==9) begin txd<=1;busy<=0; end
  else begin bitno<=bitno+1'b1;txd<=frame[bitno+1'b1];count<=DIV-1; end
 end else count<=count-1'b1;
end
endmodule
