////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: mux2to1_16bit.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This model implements a 16-bit wide 2-to-1 multiplexer.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module mux2to1_16bit(select, in0, in1, q);
	input         select;
	input  [15:0] in0, in1;
	output [15:0] q;

	assign q = (select == 1'b0) ? in0 :
              (select == 1'b1) ? in1 : 16'bxxxxxxxxxxxxxxxx;	// Default won't happen.

endmodule
