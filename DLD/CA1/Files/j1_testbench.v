`timescale 1ns/1ns
module j1_testbench();
	reg aa1 = 0, bb1 = 0;
	wire jj1;
	j1_module CUT(.aa(aa1), .bb(bb1), .ww(jj1));
	initial begin
	#100 bb1 = 1;
	#100 $stop;
	end
endmodule