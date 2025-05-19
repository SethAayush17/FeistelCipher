///////////////////////////////////////////////////////////////////////////////////////////////
//
// file: hexDecoder_7seg.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description:   This is a model of a decoder that takes a hex value and creates signals for
//						the seven segment display that display the hex value.
//						Assumes common anode seven-segment displays on the DE10-Lite board.
// 
//
///////////////////////////////////////////////////////////////////////////////////////////////

module hexDecoder_7seg(value, sevenSegUpper, sevenSegLower);
   input  [7:0] value;
	output [6:0] sevenSegUpper;
	output [6:0] sevenSegLower;

	wire   [3:0] upper;
	wire   [3:0] lower;

	assign upper = value[7:4];
	assign lower = value[3:0];
	
	assign sevenSegUpper =  (upper == 4'h0) ? 7'h40 :
                           (upper == 4'h1) ? 7'h79 :
   								(upper == 4'h2) ? 7'h24 :
   								(upper == 4'h3) ? 7'h30 :
   								(upper == 4'h4) ? 7'h19 :
   								(upper == 4'h5) ? 7'h12 :
   								(upper == 4'h6) ? 7'h02 :
   								(upper == 4'h7) ? 7'h78 :
   								(upper == 4'h8) ? 7'h00 :
   								(upper == 4'h9) ? 7'h18 :
   								(upper == 4'ha) ? 7'h08 :
   								(upper == 4'hb) ? 7'h03 :
   								(upper == 4'hc) ? 7'h46 :
   								(upper == 4'hd) ? 7'h21 :
   								(upper == 4'he) ? 7'h06 :
   								(upper == 4'hf) ? 7'h0e : 7'hXX; // Default should never happen.

   assign sevenSegLower =  (lower == 4'h0) ? 7'h40 :
                           (lower == 4'h1) ? 7'h79 :
   								(lower == 4'h2) ? 7'h24 :
   								(lower == 4'h3) ? 7'h30 :
   								(lower == 4'h4) ? 7'h19 :
   								(lower == 4'h5) ? 7'h12 :
   								(lower == 4'h6) ? 7'h02 :
   								(lower == 4'h7) ? 7'h78 :
   								(lower == 4'h8) ? 7'h00 :
   								(lower == 4'h9) ? 7'h18 :
   								(lower == 4'ha) ? 7'h08 :
   								(lower == 4'hb) ? 7'h03 :
   								(lower == 4'hc) ? 7'h46 :
   								(lower == 4'hd) ? 7'h21 :
   								(lower == 4'he) ? 7'h06 :
   								(lower == 4'hf) ? 7'h0e : 7'hXX; // Default should never happen.

endmodule
