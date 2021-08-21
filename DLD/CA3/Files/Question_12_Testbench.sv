`timescale 1ns/1ns
module Q12_testbench();
	logic [7:0] aa, bb, reff;
	wire [7:0] refdiff;
	LessDistance my_diff(reff, aa, bb, refdiff);
	initial begin
		//#100 aa = 8'b00000000; bb = 8'b00000000;
		//#200 aa = 8'b10101010;
		//#200 bb = 8'b10001000;
		#300
		reff = 8'b01101111;
		aa = 8'b01010110;
		bb = 8'b00110101;
		repeat(10) begin
			#1000
			reff = $urandom % 256;
			aa = $urandom % 256;
			bb = $urandom % 256;
		end
		#1000 $stop;
	end
endmodule
