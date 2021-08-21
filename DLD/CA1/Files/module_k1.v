`timescale 1ns/1ns
module k1_module(input a, b, e, output w);
	wire ai;
	mynot not_1(a, ai);
	my3inputnand nand_1(ai, b, e, w);
endmodule
