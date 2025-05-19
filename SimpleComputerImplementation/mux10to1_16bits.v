/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: mux10to1_16bits.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This is a model of an 16-bit wide 10-to-1 multiplexer used to
//              direct various signals within the Simple Computer to the seven segment displays.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module mux10to1_16bits(select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, mux_out);
	input   [3:0] select;
	input  [15:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9;
	output [15:0] mux_out;
	
	assign mux_out =  (select == 4'b0000) ? in0  : (select == 4'b0001) ? in1  : (select == 4'b0010) ? in2  :
							(select == 4'b0011) ? in3  : (select == 4'b0100) ? in4  : (select == 4'b0101) ? in5  :
							(select == 4'b0110) ? in6  : (select == 4'b0111) ? in7  : (select == 4'b1000) ? in8  :
							(select == 4'b1001) ? in9  : 16'bxxxxxxxxxxxxxxxx; // Default will happen, but set to don't care.
endmodule
