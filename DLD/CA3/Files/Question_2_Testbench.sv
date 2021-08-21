`timescale 1ns/1ns
module Q2_testbench();
	logic [7:0] aa, bb;
	wire EQQ, GTT;
	NCS#8 my_cmp(.a(aa), .b(bb), .EQ(EQQ), .GT(GTT));
	initial begin
		#100 aa = 8'b00000000; bb = 8'b00000000;
		#200 aa = 8'b10000000; 
		#200 aa = 8'b00000000;
		#1000 $stop;
	end
endmodule
