`timescale 1ns/1ns
module k1_testbench();
	reg a1 = 0, b1 = 1, e0 = 1;
	wire k1;
	k1_module CUT(.a(a1), .b(b1), .e(e0), .w(k1));
	initial begin
	#100 a1 = 1; //to1 delay
	#1000 a1 = 0; b1 = 1; e0 = 0;
	#100 e0 = 1; //to0 delay
	#1000 $stop;
	end
endmodule