`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2026 01:49:34
// Design Name: 
// Module Name: baud_gen
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


// Baud Rate Generator
// This module generates a periodic tick signal used for UART
// timing control.
// Function:
// - Divides the system clock frequency
// - Produces a short pulse called "tick"
// - Tick controls when UART TX/RX move to next bit
// Concept:
// Fast System Clock  --->  Baud Generator  --->  Tick Pulse
// The tick signal acts like a timing reference for UART
// communication.
// Inputs:
// clk  -> System clock
// Outputs:
// tick -> Baud timing pulse

module baud_gen(
    input clk,
    output reg tick = 0
);

reg [3:0] count = 0;

always @(posedge clk) begin

    if(count == 4) begin
        count <= 0;
        tick <= 1;
    end
    else begin
        count <= count + 1;
        tick <= 0;
    end

end

endmodule
