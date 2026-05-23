# Sequence-Detector-1011
# FSM Sequence Detector (Moore vs Mealy) — SystemVerilog Project

## Overview
This project implements a sequence detector for the bit pattern 1011 using both Moore and Mealy FSMs in SystemVerilog. The design is verified using a self-checking testbench with assertions.

The testbench compares DUT output against a reference expected sequence and reports mismatches automatically.

## Design

### Sequence Detected
1011

### Implementations
- Moore FSM (5 states, output depends only on state)
- Mealy FSM (4 states, output depends on state + input)

## Key Features

### DUT Features
- FSM-based sequence detection
- Overlapping pattern support
- Active-low reset
- Synthesizable SystemVerilog code

### Testbench Features
- Clock generation using always #5 clk
- Task-based stimulus (send_bit)
- Self-checking using assertions
- Cycle-by-cycle comparison with expected output
- Automatic error reporting

## Test Input Sequence
1011011001011

## Expected Output
00010001000001

## Verification Method

The testbench uses:
- Expected output stored as an unpacked array
- Cycle counter to track simulation time
- Assertion-based checking:

assert (detected == expected[cycle])

If mismatch occurs:
$error: Mismatch at cycle X

## Files
- moore.sv → Moore FSM implementation
- mealy.sv → Mealy FSM implementation
- tb.sv → Self-checking testbench

## How It Works
1. Reset is applied for initialization
2. Input bitstream is applied using send_bit() task
3. DUT processes input on each clock edge
4. Testbench compares output with expected reference
5. Assertions validate correctness per cycle

## Key Learning Outcomes
- FSM design (Moore vs Mealy)
- Sequence detection logic
- SystemVerilog tasks
- Assertions-based verification
- Self-checking testbench design
- Cycle-accurate validation

## Notes
- Mealy FSM produces output in same cycle as transition condition
- Moore FSM produces output one cycle later (state-based output)
- Overlapping detection is supported in both implementations
