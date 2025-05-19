////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: pc_controller.v
//
// Description: This is a model of the Program Counter controller for the Simple Computer.
//
//              The Program Counter's next value depends on the kind of instruction being executed.
//              - The Jump instruction uses an address value from the instruction's target register
//                as its destination.
//              - The Branch instructions use an address offset contained in the instruction code,
//                and are also dependent in part upon status flags N and Z.
//              - All other instructions cause PC to advance to the next consecutive instruction.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module pc_controller(clock, reset, V, C, N, Z, PL, JB, BC, branch_offset, jump_addr, PC);
	input         clock;				// CPU clock
	input         reset;				// CPU reset
	input         V;					// Overflow status bit
	input         C;					// Carry status bit
	input         N;					// Negative status bit
	input         Z;					// Zero status bit
	input         PL;					// Program Counter Load
	input         JB;					// Jump/Branch Control
	input         BC;					// Branch Condition
	input  [15:0] jump_addr;		// Jump Address
	input  [15:0] branch_offset;	// Branch Offset
	output [15:0] PC;					// PC value
	reg    [15:0] PC;

	wire   [15:0] next_pc;
	wire   [15:0] pc_add;
	wire   [15:0] pc_offset;
	wire          w;

	// Register that increments the PC at every positive clock edge
	always@(posedge clock) begin
		if(reset)
			PC <= 16'h0000;
		else
			PC <= next_pc;
	end
	
	// Logic to decide what is the next PC value based upon the control bits (PL, JB, BC) and the status bits (N, Z)
   assign next_pc = (reset)  ? 16'h0000           :	// Reset: next_PC = 0
                    (PL&JB)  ? jump_addr          :	// JUMP: next_PC = jump_address
                               pc_add;                // BRZ, BRN or default: next_PC = PC + pc_offset

   assign pc_offset = (PL & ~JB & ~BC & Z) ? branch_offset :    //BRZ: PC = PC + branch_offset
                      (PL & ~JB & BC & N)  ? branch_offset :    //BRN: PC = PC + branch_offset
                      16'h0001;                                 //Default or branch fails: PC = PC + 1

   adder_16bit PC_ADDER (PC, pc_offset, 1'b0, pc_add, w);

endmodule

