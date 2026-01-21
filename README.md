# RISC-V 32-Bit Single Cycle Processor

This project is a Verilog-based implementation of a **32-bit Single Cycle RISC-V Processor (RV32I)**.  
It is designed for educational purposes, demonstrating how the fundamental blocks of a RISC-V processor interact in a single-cycle datapath.

---

## Features

- Implements core RV32I instruction set (loads, stores, arithmetic, branches, etc.)
- Single-cycle datapath (all operations complete in one cycle)
- Includes essential modules:
  - Program Counter (PC)
  - PC + 4 Adder
  - Instruction Memory
  - Register File
  - Immediate Generator
  - Control Unit
  - ALU & ALU Control
  - Data Memory
  - Multiplexers
  - Branch Logic
- Simple top-level `main` module to connect all components

---

## Datapath Diagram

![RISC-V Single Cycle Datapath](datapth.png)

The above diagram illustrates how the different modules of the processor are connected and how data flows between them during execution.

![RTL View](rtl.png)

---

### To run the  Project use: 

```bash

docker build -t riscv-project

docker run -it riscv-project

```
