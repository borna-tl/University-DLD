`timescale 1ns/1ns
module e1_testbench();
	reg j1 = 0, e0 = 1;
	wire e1;
	e1_module CUT(.j(j1), .e(e0), .ww(e1));
	initial begin
	#100 j1 = 1; //to0 delay
	#1000 j1 = 0; e0 = 0;
	#100 e0 = 1; //to1 delay
	#1000 $stop;
	end
endmodule
