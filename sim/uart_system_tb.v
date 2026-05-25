`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2026 11:47:47
// Design Name: 
// Module Name: uart_system_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// UART System Testbench
// This testbench verifies the complete UART communication
// system by connecting:
// UART TX  --->  UART RX
// The transmitter sends serial data which is directly received
// by the UART receiver.
// Modules Used:
// - baud_gen
// - uart_tx
// - uart_rx
// Functionality Verified:
// - Serial data transmission
// - Serial data reception
// - FSM operation
// - Tick synchronization
// - End-to-end UART communication

module uart_system_tb;
//test bench signlas
reg clk = 0;
reg start = 0;
reg [7:0] data_in;
wire tick;

//tx signals
wire tx;
wire busy;

//rx signals
wire [7:0] data_out;
wire done;

// Baud Rate Generator Instantiation
baud_gen baud_unit(
  .clk(clk),
  .tick(tick)
  );
  
// UART Transmitter Instantiation
uart_tx tx_unit(
  .clk(clk),
  .tick(tick),
  .data(data_in),
  .start(start),
  .tx(tx),
  .busy(busy)
  );
  
//UART Reciever Instantiation  
uart_rx rx_unit(
   .clk(clk),
   .tick(tick),
   .rx(tx),            // TX output is directly connected to RX input.
   .data_out(data_out),
   .done(done)
 );
 
 always #5 clk = ~clk;  // Clock Generation

// Test Sequence
initial begin


    start = 0;
    data_in = 8'b10101010;

   
    #50;

    start = 1;
    #10;
    start = 0;

   
    #10000;

    $stop;

end

endmodule
