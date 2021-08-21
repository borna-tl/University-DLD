`timescale 1ns/1ns
module g1_module(input k, g, output w);
	wire gi;
	mynot not_1(g, gi);
	my2inputnand nand_1(gi, k, w);
	
endmodule
