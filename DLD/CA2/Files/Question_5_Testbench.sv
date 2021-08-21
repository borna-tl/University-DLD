`timescale 1ns/1ns
module q5_testbench();
	logic [0:7] aa, bb;
	logic eqq, gtt;
	wire EQQ1, GTT1, EQQ2, GTT2;
	cmp8tbc my_tbccmp(.a(aa), .b(bb), .eq(eqq), .gt(gtt), .EQ(EQQ1), .GT(GTT1));
	cmp8 my_cmp(.a(aa), .b(bb), .eq(eqq), .gt(gtt), .EQ(EQQ2), .GT(GTT2));
	initial begin
		#100 aa = 8'b00000000; bb = 8'b00000000; eqq = 1; gtt = 0;
		#1000 aa = 8'b00000001;
		#1000 eqq = 0; gtt = 1; 
		#1000 aa = 8'b0000000; eqq = 1; gtt = 0;
		#1000 $stop;
	end
endmodule