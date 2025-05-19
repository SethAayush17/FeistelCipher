////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: adder_16bit.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This is a model of a 16-bit adder with carry-in.
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module adder_16bit(a, b, cin, s, cout);
	input  [15:0] a, b;
	input         cin;
	output [15:0] s;
	output        cout;
	
	wire          c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
	
	adder_1bit a00(a[0] , b[0] , cin, s[0] , c1  );
	adder_1bit a01(a[1] , b[1] , c1 , s[1] , c2  );
	adder_1bit a02(a[2] , b[2] , c2 , s[2] , c3  );
	adder_1bit a03(a[3] , b[3] , c3 , s[3] , c4  );
	adder_1bit a04(a[4] , b[4] , c4 , s[4] , c5  );
	adder_1bit a05(a[5] , b[5] , c5 , s[5] , c6  );
	adder_1bit a06(a[6] , b[6] , c6 , s[6] , c7  );
	adder_1bit a07(a[7] , b[7] , c7 , s[7] , c8  );
	adder_1bit a08(a[8] , b[8] , c8 , s[8] , c9  );
	adder_1bit a09(a[9] , b[9] , c9 , s[9] , c10 );
	adder_1bit a10(a[10], b[10], c10, s[10], c11 );
	adder_1bit a11(a[11], b[11], c11, s[11], c12 );
	adder_1bit a12(a[12], b[12], c12, s[12], c13 );
	adder_1bit a13(a[13], b[13], c13, s[13], c14 );
	adder_1bit a14(a[14], b[14], c14, s[14], c15 );
	adder_1bit a15(a[15], b[15], c15, s[15], cout);

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File: adder_1bit.v
//
// ******************************************
// YOU ARE NOT PERMITTED TO MODIFY THIS FILE.
// ******************************************
//
// Description: This is a model of a 1-bit full adder.
//
// Created by JST, November 2019
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module adder_1bit(a, b, cin, s, cout);
	input  a, b, cin;
	output s, cout;
	
	assign s    = a ^ b ^ cin;
	assign cout = a & b | a & cin | b & cin;

endmodule
