////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: mux4to1_16bit.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This is a model of a 16-bit wide 4-to-1 multiplexer.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module mux4to1_16bit(select, ins0, ins1, ins2, ins3, mux_out);
	input   [1:0] select;
	input  [15:0] ins0, ins1, ins2, ins3;
	output [15:0] mux_out;
	
	assign mux_out = (select == 2'b00) ? ins0 :
	                 (select == 2'b01) ? ins1 :
						  (select == 2'b10) ? ins2 :
						  (select == 2'b11) ? ins3 : 16'bxxxxxxxxxxxxxxxx; // Default should never happen.

endmodule
