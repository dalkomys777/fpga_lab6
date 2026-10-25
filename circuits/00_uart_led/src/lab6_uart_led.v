`timescale 1ns/1ps
module lab6_uart_led #(parameter DIV=5208)(input wire clk_50mhz,rst_p,uart_rxd,output wire uart_txd,output wire [7:0] led_out);
wire [7:0] rx_data; wire rx_valid,tx_busy; reg tx_start=0; reg [7:0] tx_data=0; reg led_state=0;
uart_rx #(.DIV(DIV)) u_rx(clk_50mhz,rst_p,uart_rxd,rx_data,rx_valid);
uart_tx #(.DIV(DIV)) u_tx(clk_50mhz,rst_p,tx_start,tx_data,uart_txd,tx_busy);
always @(posedge clk_50mhz) begin
 if(rst_p) begin tx_start<=0;tx_data<=0;led_state<=0; end
 else begin
  tx_start<=0;
  if(rx_valid) begin
   if(!tx_busy) begin tx_data<=rx_data;tx_start<=1; end
   case(rx_data) 8'h30:led_state<=0; 8'h31:led_state<=1; 8'h32:led_state<=~led_state; default:led_state<=led_state; endcase
  end
 end
end
assign led_out={7'b0,led_state};
endmodule
