////////////////////////////////////////////////////////////////////////////////
//
// File: decoder3to8enable.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: A basic 3-to-8 decoder with enable.
//
//
///////////////////////////////////////////////////////////////////////////////

module decoder3to8enable(enable, ins, out);
	input        enable;
   input  [2:0] ins;
   output [7:0] out;

   wire   [7:0] decoder;

// Model a decoder without enable.

   assign decoder = (ins == 3'b000) ? 8'b00000001 :
                    (ins == 3'b001) ? 8'b00000010 :
                    (ins == 3'b010) ? 8'b00000100 :
                    (ins == 3'b011) ? 8'b00001000 :
                    (ins == 3'b100) ? 8'b00010000 :
                    (ins == 3'b101) ? 8'b00100000 :
                    (ins == 3'b110) ? 8'b01000000 :
                    (ins == 3'b111) ? 8'b10000000 : 8'bxxxxxxxx; // Default won't happen.
	
// Use the enable to determine the true output.

   assign out = (enable == 1'b1) ? decoder : (enable == 1'b0) ? 8'b00000000 : 8'bxxxxxxxx;	// Default won't happen.

endmodule
