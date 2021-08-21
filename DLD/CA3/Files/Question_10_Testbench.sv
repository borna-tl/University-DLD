`timescale 1ns/1ns
module Q10_testbench();
	logic [7:0] aa, bb;
	wire [7:0] absdiff;
	AbsDiff my_diff(aa, bb, absdiff);
	initial begin
		//#100 aa = 8'b00000000; bb = 8'b00000000;
		//#200 aa = 8'b10101010; //94NS delay
		//#200 bb = 8'b10001000;
		repeat(10) begin
			#1000
			aa = $urandom % 256;
			bb = $urandom % 256;
		end
		#1000 $stop;
	end
endmodule

