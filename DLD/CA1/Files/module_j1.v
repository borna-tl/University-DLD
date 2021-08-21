`timescale 1ns/1ns
module j1_module(input aa, bb, output ww);
	myxor xor_1(.a(aa), .b(bb), .w(ww));
endmodule
