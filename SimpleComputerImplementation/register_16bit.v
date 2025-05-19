////////////////////////////////////////////////////////////////////////////////
//
// File: register_16bit.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: A basic 16-bit register with synchronous active-high load enable
//              and syncronous active-high reset.
//
//
////////////////////////////////////////////////////////////////////////////////

module register_16bit(clock, reset, load, in, out);
   input         clock;		// cpu clock
   input         reset;		// Active-high reset signal
   input         load;		// Active-high load control
   input  [15:0] in;			// Input data
   output [15:0] out;		// Value held in register
   reg    [15:0] out;		

   always@(posedge clock) begin
		if(reset == 1'b1)
			out <= 16'h0000;
		else if(load == 1'b1)
			out <= in;
	end
	
endmodule
