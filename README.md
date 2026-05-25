# UART Communication System using Verilog

## Overview
This project implements a UART (Universal Asynchronous Receiver Transmitter) communication system using Verilog HDL.

The design includes:
- UART Transmitter (TX)
- UART Receiver (RX)
- Baud Rate Generator
- System-level Testbench

The UART TX converts 8-bit parallel data into serial data, and the UART RX reconstructs the serial data back into parallel form.

---

## Features
- FSM-based UART Transmitter
- FSM-based UART Receiver
- Baud-rate timing generation
- Serial-to-parallel data conversion
- Parallel-to-serial data conversion
- Verified through simulation in Vivado

---

## UART Frame Format

| Start Bit | Data Bits (LSB First) | Stop Bit |
|------------|----------------------|-----------|
|     0      |      8 bits          |     1     |

---

## File Structure

- `uart_tx.v` → UART transmitter module
- `uart_rx.v` → UART receiver module
- `baud_gen.v` → Tick/baud generator
- `uart_system_tb.v` → System testbench

---

## Simulation Result

The transmitted data was successfully received by the UART receiver.

Example:
- Input Data  = `8'b10101010`
- Output Data = `8'b10101010`

---

## Tools Used
- Verilog HDL
- Xilinx Vivado
- FSM Design Methodology

---

## Future Improvements
- Configurable baud rate
- Oversampling receiver
- Parity bit support
- FIFO integration
- FPGA implementation

---

## Author
Aman Tyagi