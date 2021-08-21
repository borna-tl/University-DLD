`timescale 1ns/1ns
module local_testbench();
	reg aa1 = 0, bb1 = 0, ee0 = 0, gg0 = 0;
	wire ee1, gg1;
	mybcs UUT(.a1(aa1), .b1(bb1), .e0(ee0), .g0(gg0), .e1(ee1), .g1(gg1));
	initial begin
	#100 aa1 = 0; bb1 = 1; ee0 = 1; gg0 = 1; //worst delay
	#1000 aa1 = 0; bb1 = 0; ee0 = 0; gg0 = 0;
	#1000 aa1 = 1; bb1 = 1; ee0 = 1; gg0 = 1;
	
	#1000 $stop;
	end
endmodule