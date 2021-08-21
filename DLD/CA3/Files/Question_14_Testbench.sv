`timescale 1ns/1ns
module Q14_testbench();
	logic [7:0] aa, bb, reff;
	wire [7:0] structural_diff, behavioral_diff;
	LessDistance str_diff(reff, aa, bb, structural_diff);
	LessDistanceBehavioral bhv_diff(reff, aa, bb, behavioral_diff);
	initial begin
		#1000 aa = 8'b00000000; bb = 8'b00000000; reff = 8'b00000000;
		#1000 aa = 8'b00000101; bb = 8'b11100011; reff = 8'b11011011;
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
