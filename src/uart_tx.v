`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2026 12:50:12
// Design Name: 
// Module Name: uart_tx
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


// UART Transmitter (UART TX)
//--------------------------------------------------------------
// This module transmits 8-bit parallel data serially using UART
// protocol.
//
// Features:
// - FSM-based design
// - 8-bit data transmission
// - Start bit and Stop bit generation
// - Tick-based timing control
//
// UART Frame Format:
// -------------------------------------------------------------
// | Start Bit | 8 Data Bits (LSB First) | Stop Bit |
// |     0     |        D0 -> D7         |     1    |
// -------------------------------------------------------------
//
// Inputs:
// clk   -> System clock
// tick  -> Baud-rate timing pulse
// data  -> 8-bit parallel input data
// start -> Signal to begin transmission
//
// Outputs:
// tx    -> Serial output line
// busy  -> Indicates transmitter is active

module uart_tx(
    input clk,   //clock input
    
    input tick,  //baud tick signal
    
    input [7:0] data, //8-bit parallel data input
    
    input start,  // start transmission signal
    
    output reg tx = 1,    // Serial transmit output
    // UART line remains HIGH during idle state
    
    output reg busy = 0 //if busy = 1 then Tx is working and if busy  = 0 then Tx is free
      );
      
//FSM states
localparam Idle = 2'b00;
localparam Start = 2'b01;
localparam Data = 2'b10;
localparam Stop = 2'b11;

reg [1:0] state = Idle; // Initialize the state to idle state
reg [2:0] bit_index = 0;  //track which data bit is being transmitted
reg [7:0] data_reg = 0;  //stores input data temporarily during tansmission


//UART Transimitter FSM

always @(posedge clk) begin
 case(state)
     Idle: begin
       tx <=1;
       busy <=0;
       
      if(start) begin
        data_reg <= data;
        state <= Start;
        busy <= 1;
      end
    end
    
     Start: begin
       tx <= 0;
       if(tick) begin
         state <= Data;
         bit_index <= 0; 
        end
      end
         
     Data: begin
       tx <= data_reg[bit_index];
       if(tick) begin
         if (bit_index < 7)
            bit_index <= bit_index + 1;
          else
           state <= Stop;
         end
       end
  
     Stop: begin
       tx <= 1;
       if(tick) begin
         state <= Idle;
        end
      end
      
     default: state <= Idle;
     
    endcase
  end      
         
endmodule