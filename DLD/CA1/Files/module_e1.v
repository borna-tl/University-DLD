`timescale 1ns/1ns
module e1_module(input j, e, output ww);
	wire ei;
	mynot not_1(.a(e), .w(ei));
	mynor nor_1(.a(ei), .b(j), .w(ww));
endmodule
