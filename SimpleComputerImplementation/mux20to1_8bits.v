////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: mux20to1_8bits.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description:	This is a model of an 8-bit wide 20-to-1 multiplexor used to
//                direct various signals within the Simple Computer to the LEDs.
//
// Created by Addison Ferrari, 23 July 2019
// Modified by JST, November 2019
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module mux20to1_8bits(select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, mux_out);
	input  [4:0] select;
	input  [7:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19;
	output [7:0] mux_out;
	
	assign mux_out =  (select == 5'b00000) ? in0  : (select == 5'b00001) ? in1  : (select == 5'b00010) ? in2  :
                   	(select == 5'b00011) ? in3  : (select == 5'b00100) ? in4  : (select == 5'b00101) ? in5  :
							(select == 5'b00110) ? in6  : (select == 5'b00111) ? in7  : (select == 5'b01000) ? in8  :
							(select == 5'b01001) ? in9  : (select == 5'b01010) ? in10 : (select == 5'b01011) ? in11 :
							(select == 5'b01100) ? in12 : (select == 5'b01101) ? in13 : (select == 5'b01110) ? in14 :
							(select == 5'b01111) ? in15 : (select == 5'b10000) ? in16 : (select == 5'b10001) ? in17 :
							(select == 5'b10010) ? in18 : (select == 5'b10011) ? in19 : 8'bxxxxxxxx; // Default will happen, but set to don't care.
endmodule
