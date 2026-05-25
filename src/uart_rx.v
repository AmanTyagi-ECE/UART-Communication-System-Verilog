// UART Receiver (UART RX)
//--------------------------------------------------------------
// This module receives serial UART data and converts it into
// 8-bit parallel data.
//
// Features:
// - FSM-based UART receiver
// - Detects start bit
// - Receives 8-bit serial data
// - Uses shift register for serial-to-parallel conversion
// - Generates done signal after successful reception
//
// UART Frame Format:
// -------------------------------------------------------------
// | Start Bit | 8 Data Bits (LSB First) | Stop Bit |
// |     0     |        D0 -> D7         |     1    |
// -------------------------------------------------------------
//
// Inputs:
// clk  -> System clock
// tick -> Baud-rate timing pulse
// rx   -> Serial input line
//
// Outputs:
// data_out -> Received 8-bit parallel data
// done     -> Reception complete indicator

module uart_rx(
    input clk,  //system signal input
     
    input tick, //baud tick signal
    
    input rx,  //serail recieve signal

    output reg [7:0] data_out = 0,  //parallel recieved data output
    
    output reg done = 0   //reception complete signal
);

//FSM States
localparam Idle  = 2'b00;
localparam Start = 2'b01;
localparam Data  = 2'b10;
localparam Stop  = 2'b11;

reg [1:0] state = Idle;  //store current FSM state
reg [2:0] bit_index = 0;  // Tracks received bit position (0 to 7)
reg [7:0] data_reg = 0;   //Shift register used to store incoming serial data

// UART Receiver FSM
always @(posedge clk) begin

    case(state)

    Idle: begin
        done <= 0;

        // Detect start bit
        if(rx == 0)
            state <= Start;
    end

    Start: begin
        if(tick) begin
            bit_index <= 0;
            state <= Data;
        end
    end

    Data: begin

        if(tick) begin

            // Shift incoming bit into register
            data_reg <= {rx, data_reg[7:1]};

            if(bit_index < 7)
                bit_index <= bit_index + 1;
            else
                state <= Stop;

        end

    end

    Stop: begin

        if(tick) begin
            data_out <= data_reg;
            done <= 1;
            state <= Idle;
        end

    end

    default: state <= Idle;

    endcase

end

endmodule