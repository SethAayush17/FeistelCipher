////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: function_unit.v
//
// Description: This module implements the function unit for the Simple Computer from Chapter 8.
//              It generates status flags for Overflow, Carry-out, Negative, and Zero: (V, C, N, Z).
//              The Simple Computer uses N and Z in the Instruction Decoder.
//
// Created: 06/2012, Xin Xin, Virginia Tech
// Modified by P. Athanas, 3/2013
//   --> Transformed into a structural model
// Modified by JST, 6/2013 
//   --> Overflow flag fixed (was a carry-out)
// Modified by JST, 6/2015 
//   --> Reformulated to match structure of the Function Unit described in the text.
// Modified by JST, 11/2019 
//   --> Impoved structural modeling.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module function_unit(FS, A, B, result, V, C, N, Z);
	input   [3:0] FS;				// Function Unit select code.
   input  [15:0] A;				// Function Unit operand A
   input  [15:0] B;				// Function Unit operand B
   output [15:0] result;		// Function Unit result
   output        V;				// Overflow status bit
   output        C;				// Carry-out status bit
   output        N;				// Negative status bit
   output        Z;				// Zero status bit

	wire   [15:0] addendB;		// Arithmetic unit addend B
	wire   [15:0] arith_out;	// Arithmetic unit output
	wire          carry_out;	// Arithmetic unit carry-out
	wire   [15:0] logic_out;	// Logic unit output
	wire   [15:0] shift_out;	// Shift unit output
	wire   [15:0] alu_out;		// ALU output
	wire          MF;				// Function Unit output bus select

//////////// ARITHMETIC UNIT ////////////

// A 16-bit bus uses FS[2:1] to choose the form of addendB.
// - 00: addendB = 0
// - 01: addendB = B
// - 10: addendB = ~B
// - 11: addendB = -1

	mux4to1_16bit selectB(FS[2:1], 16'h0000, B, ~B, 16'hFFFF, addendB);

// A 16-bit adder performs (A + addendB + FS[0]). 

	adder_16bit arith_unit(A, addendB, FS[0], arith_out, carry_out);

////////////   LOGIC  UNIT   ////////////

// A 16-bit bus uses FS[1:0] to choose the logic operation.
// - 00: logic_out = A & B (AND)
// - 01: logic_out = A | B (OR)
// - 10: logic_out = A ^ B (XOR)
// - 11: logic_out = ~A    (NOT)

	mux4to1_16bit logic_unit(FS[1:0], (A & B), (A | B), (A ^ B), ~A, logic_out);

////////////   SHIFT  UNIT   ////////////

// A 16-bit bus uses FS[1:0] to choose the shift operation.
// - 00: shift_out = B               (MOVB)
// - 01: shift_out = {1'b0, B[15:1]} (SHR)
// - 10: shift_out = {B[14:0], 1'b0} (SHL)
// - 11: NOT USED

	mux4to1_16bit shifter(FS[1:0], B, {1'b0, B[15:1]}, {B[14:0], 1'b0}, 16'hXXXX, shift_out);

////////////       ALU       ////////////

// A 16-bit bus uses FS[3] to choose the ALU operation. 
// - 0: alu_out = arith_out
// - 1: alu_out = logic_out

	mux2to1_16bit alu(FS[3], arith_out, logic_out, alu_out);

////////////  FUNCTION UNIT  ////////////
	
// The bus that chooses between the ALU and shifter has a select equal to (FS[3] & FS[2]). 

	assign MF = FS[3] & FS[2];
	
// A 16-bit bus uses MF to choose the Function Unit result.
// - 0: result = alu_out
// - 1: result = shift_out

	mux2to1_16bit func_unit(MF, alu_out, shift_out, result);

////////////   STATUS BITS   ////////////
	
// The overflow bit is not used in the Simple Computer.
// It is defined here for completeness in terms of A, B, and result.
// V is only valid for arithmetic operations, which means that FS[3] must equal 0.
// For non-arithmetic operations, V = 0.

   assign V = ~FS[3] & ((A[15] & B[15] & ~result[15]) | (~A[15] & ~ B[15] & result[15]));

// The carry-out bit is not used in the Simple Computer.
// It is defined here for completeness in terms of carry_out.
// C is only valid for arithmetic operations, which means that FS[3] must equal 0.
// For non-arithmetic operations, C = 0.

   assign C = ~FS[3] & carry_out;

// The negative bit is used in the Simple Computer as the condition for Branch on Negative.
// N is valid for non-shift operations, which means that FS[3:2] must NOT equal 11.
// For shift operations, N = 0.

   assign N = ~(FS[3] & FS[2]) & result[15];

// The zero bit is used in the Simple Computer as the condition for Branch on Zero.
// Z is valid for non-shift operations, which means that FS[3:2] must NOT equal 11.
// For shift operations, Z = 0.

   assign Z = ~(FS[3] & FS[2]) & (result == 16'h0000);

endmodule
