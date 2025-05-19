//////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: dual_port_ram.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This is a model of a simple synchronous dual-port RAM for the Simple Computer of
//              Chapter 9. The dual_port_ram module implements the register file.
//
// Created: 06/2012, Xin Xin, Virginia Tech
// Modified by Addison Ferrari 07/2019, Rewritten using structural models
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module dual_port_ram(clock, reset, data, we, DA, AA, BA, opA, opB, r0, r1, r2, r3, r4, r5, r6, r7);
	input         clock;	// CPU Clock
   input         reset;	// Syncronous active-high reset
   input  [15:0] data;	// Input Data
   input         we;		// Write Enable
   input   [2:0] DA;		// Destination Address
   input   [2:0] AA;		// Operand A Address
   input   [2:0] BA;		// Operand B Address
   output [15:0] opA;	// Operand A output
   output [15:0] opB;	// Operand B output
	output [15:0] r0;		// Register values
	output [15:0] r1;
	output [15:0] r2;
	output [15:0] r3;
	output [15:0] r4;
	output [15:0] r5;
	output [15:0] r6;
	output [15:0] r7;

   // load signal
   wire    [7:0] load;

   // Eight 16-bit registers
   register_16bit reg0(clock, reset, load[0], data, r0);
   register_16bit reg1(clock, reset, load[1], data, r1);
   register_16bit reg2(clock, reset, load[2], data, r2);
   register_16bit reg3(clock, reset, load[3], data, r3);
   register_16bit reg4(clock, reset, load[4], data, r4);
   register_16bit reg5(clock, reset, load[5], data, r5);
   register_16bit reg6(clock, reset, load[6], data, r6);
   register_16bit reg7(clock, reset, load[7], data, r7);

	// Load signal decoder using Destination Address (DA) and enabled with Write Enable (we)
	decoder3to8enable addr_dec(we, DA, load);
	
   // Bus control logic, controls OperandA output using A Address (AA)
   mux8to1_16bit operandA(AA, r0, r1, r2, r3, r4, r5, r6, r7, opA);

   // Bus control logic, controls OperandB output using B Address (BA)
   mux8to1_16bit operandB(BA, r0, r1, r2, r3, r4, r5, r6, r7, opB);

endmodule
