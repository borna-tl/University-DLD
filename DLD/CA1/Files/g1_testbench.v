`timescale 1ns/1ns
module g1_testbench();
	reg k1 = 1, g0 = 1;
	wire g1;
	g1_module CUT(.k(k1), .g(g0), .w(g1));
	initial begin
	#100 g0 = 0; //to0 delay
	#1000 k1 = 1; g0 = 0;
	#100 g0 = 1; //to1 delay
	#1000 $stop;
	end
endmodule
