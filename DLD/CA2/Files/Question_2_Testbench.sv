`timescale 1ns/1ns
module q2_testbench();
	logic [0:7] aa, bb;
	logic eqq, gtt;
	wire EQQ, GTT;
	cmp8 my_cmp(.a(aa), .b(bb), .eq(eqq), .gt(gtt), .EQ(EQQ), .GT(GTT));
	initial begin
		#100 aa = 8'b0; bb = 8'b0; eqq = 1; gtt = 0;
		#1000 aa = 00000001; eqq = 0; gtt = 1; //112NS to0 delay for EQQ / 96NS to1 delay for GTT
		#1000 aa = 8'b0; eqq = 1; gtt = 0; //108NS to1 delay for EQQ  / 96NS to0 delay for GTT
		#1000 $stop;
	end
endmodule

