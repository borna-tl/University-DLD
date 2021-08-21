`timescale 1ns/1ns
module q3_testbench();
	logic  aa1, aa0, bb1, bb0, eqq, gtt;
	wire EQQ, GTT;
	TCS my_tcs(.a1(aa1), .a0(aa0), .b1(bb1), .b0(bb0), .eq(eqq), .gt(gtt), .EQ(EQQ), .GT(GTT));
	initial begin
		#100 aa1 = 1; aa0 = 1; bb1 = 1; bb0 = 1; eqq = 1; gtt = 0;
		#1000 bb0 = 0; eqq = 1; gtt = 0;
		#1000 eqq = 0; gtt = 1;
		#1000 $stop;
	end
endmodule

