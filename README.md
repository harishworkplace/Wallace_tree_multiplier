# Wallace Tree Multiplier (64-bit)

This repository contains an HDL implementation of a 64-bit Wallace Tree Multiplier designed for efficient high-speed multiplication of two 32-bit inputs. The multiplier combines full adders (FA) and a carry-lookahead adder (CLA) to reduce partial products, ensuring minimal propagation delay.

## Table of Contents

- [Overview](#overview)
- [Design](#design)
- [Modules](#modules)
  - [FA (Full Adder)](#fa-full-adder)
  - [CLA (Carry-Lookahead Adder)](#cla-carry-lookahead-adder)
  - [Wallace Tree Multiplier](#wallace-tree-multiplier)
- [Simulation](#simulation)

## Overview

The Wallace Tree Multiplier efficiently computes the product of two 32-bit numbers by generating partial products and reducing them using a balanced tree of adders. The final summation is handled by a 64-bit carry-lookahead adder (CLA). This design minimizes propagation delays and increases the speed of the multiplication process.

## Design

The design is broken down into three main components:

1. **Partial Products Generation**: The partial products are generated by shifting the multiplicand `a` by the respective positions of the multiplier `b` bits.
2. **Reduction Tree (Wallace Tree)**: The partial products are reduced in multiple levels using full adders (FA), reducing the number of operands to two at the final level.
3. **Final Addition**: The final sum of the reduced operands is computed using a carry-lookahead adder (CLA).

## Modules

### FA (Full Adder)

The `FA` module is a 64-bit full adder that takes three inputs and produces a sum and a carry-out.

#### Inputs
- `x`, `y`, `z`: 64-bit operands to be added.

#### Outputs
- `u`: Sum of `x`, `y`, and `z`.
- `v`: Carry-out from the addition process.

verilog
module FA (
    input [63:0] x,
    input [63:0] y,
    input [63:0] z,
    output [63:0] u,
    output [63:0] v
);

### CLA (Carry-Lookahead Adder)
The CLA module is a parameterized carry-lookahead adder designed for fast addition with reduced delay by pre-calculating carry signals.

#### Inputs
-`a`, `b`: Two n-bit operands.
-`cin`: Carry-in signal.
#### Outputs
-`s`: Sum of a and b.
-`cout`: Carry-out from the addition process.

module cla #(parameter n = 32) (
    input [n-1:0] a, b,
    input cin,
    output [n-1:0] s,
    output court
);

### Wallace Tree Multiplier
The wallace module integrates the partial product generation, full adders, and carry-lookahead adder into a complete Wallace Tree structure for multiplying two 32-bit numbers.

#### Inputs
-`a`: 32-bit multiplicand.
-`b`: 32-bit multiplier.
#### Output
-`out`: 64-bit result of the multiplication.

module wallace (
    input [31:0] a,
    input [31:0] b,
    output [63:0] out
);

### Simulation
The modules are designed for simulation in any Verilog-compatible simulator like ModelSim, Vivado, nclaunch, or Icarus Verilog. You can write a testbench to validate the functionality of the Wallace Tree Multiplier and verify its performance for various test cases, including edge cases such as multiplication by zero or large numbers.

