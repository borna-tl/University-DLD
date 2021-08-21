`timescale 1ns/1ns
module q4_testbench();
	logic [0:7] aa, bb;
	logic eqq, gtt;
	wire EQQ, GTT;
	cmp8tbc my_tbccmp(.a(aa), .b(bb), .eq(eqq), .gt(gtt), .EQ(EQQ), .GT(GTT));
	initial begin
		#100 aa = 8'b00000000; bb = 8'b00000000; eqq = 1; gtt = 0;
		#1000 aa = 8'b00000001; //172NS to0 delay for EQQ / 260NS to1 delay for GTT
		#1000 eqq = 0; gtt = 1; 
		#1000 aa = 8'b0000000; eqq = 1; gtt = 0; //172NS to1 delay for EQQ  / 260NS to0 delay for GTT
		#1000 $stop;
	end
endmodule

