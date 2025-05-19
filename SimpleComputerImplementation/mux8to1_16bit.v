////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: mux8to1_16bit.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This is a model of a 16-bit wide 8-to-1 multiplexer.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module mux8to1_16bit(select, ins0, ins1, ins2, ins3, ins4, ins5, ins6, ins7, mux_out);
	input   [2:0] select;
	input  [15:0] ins0, ins1, ins2, ins3, ins4, ins5, ins6, ins7;
	output [15:0] mux_out;
	
	assign mux_out = (select == 3'b000) ? ins0 :
	                 (select == 3'b001) ? ins1 :
						  (select == 3'b010) ? ins2 :
						  (select == 3'b011) ? ins3 :
						  (select == 3'b100) ? ins4 :
						  (select == 3'b101) ? ins5 :
						  (select == 3'b110) ? ins6 :
						  (select == 3'b111) ? ins7 : 16'bxxxxxxxxxxxxxxxx; // Default should never happen.

endmodule
