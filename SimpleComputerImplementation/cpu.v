////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: cpu.v
//
// Description: This module specifies the top-level component for a single-cycle computer as shown
//              in Figure 8-15 on Page 460. It is mainly a structural module whose units are 
//              implemented in other modules in this project.
//    
//
////////////////////////////////////////////////////////////////////////////////////////////////////

// You must not change the module or port declarations.

module cpu(clock, reset, r0, r1, r2, r3, r4, r5, r6, r7, IR, PC);
	input clock;
	input reset;

	output [15:0] r0						/* synthesis keep */ ;	// CPU registers
	output [15:0] r1						/* synthesis keep */ ;
	output [15:0] r2						/* synthesis keep */ ;
	output [15:0] r3						/* synthesis keep */ ;
	output [15:0] r4						/* synthesis keep */ ;
	output [15:0] r5						/* synthesis keep */ ;
	output [15:0] r6						/* synthesis keep */ ;
	output [15:0] r7						/* synthesis keep */ ;
	output [15:0] IR						/* synthesis keep */ ;	// CPU Instruction Register
	output [15:0] PC						/* synthesis keep */ ;	// CPU Program Counter

// End module and port declaration

// Wire declaration

	wire   [15:0] instr					/* synthesis keep */ ;	// Machine Instruction 
	wire    [2:0] DA						/* synthesis keep */ ;	// Decoded Destination Register Address field
	wire    [2:0] AA						/* synthesis keep */ ;	// Decoded Operand A Register Address field
	wire    [2:0] BA						/* synthesis keep */ ;	// Decoded Operand B Register Address field
	wire          MB						/* synthesis keep */ ;	// Decoded Multiplexer B Select
	wire    [3:0] FS						/* synthesis keep */ ;	// Decoded Function Unit Select
	wire          MD						/* synthesis keep */ ;	// Decoded Multiplexer D Select
	wire          RW						/* synthesis keep */ ;	// Decoded Register Write
	wire          MW						/* synthesis keep */ ;	// Decoded Memory Write
	wire          PL						/* synthesis keep */ ;	// Decoded Program Counter Load
	wire          JB						/* synthesis keep */ ;	// Decoded Jump/Branch Control
	wire          BC						/* synthesis keep */ ;	// Decoded Branch Condition 
	wire   [15:0] AD						/* synthesis keep */ ;	// Sign-extended address offset.
	wire          V						/* synthesis keep */ ;	// Overflow status bit
	wire          C						/* synthesis keep */ ;	// Carry-out status bit
	wire          N						/* synthesis keep */ ;	// Negative status bit
	wire          Z						/* synthesis keep */ ;	// Zero status bit
	wire   [15:0] data_mem_out			/* synthesis keep */ ;	// Data Memory output
	wire   [15:0] Bus_D           	/* synthesis keep */ ;	// Register file input	
	wire   [15:0] constant				/* synthesis keep */ ;	// Immediate operand
	wire   [15:0] A						/* synthesis keep */ ;	// Register file output A
	wire   [15:0] B						/* synthesis keep */ ;	// Register file output B
	wire   [15:0] mux_b_out				/* synthesis keep */ ;	// Multiplexer B output
	wire   [15:0] function_unit_out	/* synthesis keep */ ;	// Function Unit output
	wire   [15:0] mux_d_out				/* synthesis keep */ ;	// Multiplexer D output

// End wire declaration 
	
////////////  CONTROL UNIT  ////////////
	
// PC CONTROLLER
// - Generate the 16-bit sign-extended address offset.

	assign AD = {{10{instr[8]}}, instr[8:6], instr[2:0]};

// - PC Controller Instantiation

	pc_controller pc_ctrl(clock, reset, V, C, N, Z, PL, JB, BC, AD, A, PC);

// INSTUCTION MEMORY
// - Instruction Memory instantiation, as 1K x 16 unit.
// - These parameters control the size of the memory. DO NOT CHANGE THEM.

	single_port_rom #(10, 16) instr_mem(clock, reset, PC[9:0], instr);

// INSTRUCTION DECODER
// - Instruction Decoder instantiation

	instruction_decoder instr_decoder(instr, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);

////////////  DATA  MEMORY  ////////////

// DATA MEMORY
// - Data Memory instantiation, as 256 x 16 unit.
// - These parameters control the size of the memory. Do not change them.

	single_port_ram #(8, 16) data_mem(clock, MW, A[7:0], mux_b_out, data_mem_out);

////////////    DATAPATH    //////////// 
	
// REGISTER FILE
// - Clear the data input to the register file on a reset.

	assign Bus_D = (reset == 1'b0) ? mux_d_out : (reset == 1'b1) ? 8'b00000000 : 8'bxxxxxxxx;

// - Register file instantiation.	

	dual_port_ram register_file(clock, reset, Bus_D, RW, DA, AA, BA, A, B, r0, r1, r2, r3, r4, r5, r6, r7);

// MULTIPLEXER B
// - Generate the 16-bit zero filled immediate operand. 

	assign constant = {13'b0000000000000, instr[2:0]};

// - Instantiate Multiplexer B.

	mux2to1_16bit mux_b(MB, B, constant, mux_b_out);

// FUNCTION UNIT
// - Instantiate Function Unit.

	function_unit func_unit(FS, A, mux_b_out, function_unit_out, V, C, N, Z);
	
// MULTIPLEXER D
// - Instatiate Multiplexer D.

	mux2to1_16bit mux_d(MD, function_unit_out, data_mem_out, mux_d_out);

// Make the instruction register value visible outside the CPU.

	assign IR = instr;

endmodule
