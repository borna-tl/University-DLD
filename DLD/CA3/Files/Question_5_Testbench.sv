`timescale 1ns/1ns
module Q5_testbench();
	logic [7:0] aa, bb;
	wire [7:0] sum;
	wire co;
	NMA#8 my_nma(aa, bb, {1'b0}, co, sum);
	initial begin
		#100 aa = 8'b00000000; bb = 8'b00000000;
		#200 aa = 8'b10101010; //94NS delay
		#200 bb = 8'b10000000;
		#1000 $stop;
	end
endmodule

