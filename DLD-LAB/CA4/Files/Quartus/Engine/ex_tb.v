`timescale 1 ns/1 ns

module ex_tb();
	
	reg clk = 1'b0, rst = 1'b0, start = 1'b0;
	reg [15:0] x;
	wire done;
	wire [1:0] int_part;
	wire [15:0] frac_part;
	
	exponential exp(clk, rst, start, x, done, int_part, frac_part);
	
	always #5 clk = ~clk;

	initial begin
             	#10 rst = 1'b1;
        	#30 rst = 1'b0;

		#10 start = 1'b1;
        	#50 x = 16'b0000000000000000; //0
		#50 start = 1'b0;

		#10000 x = 16'b0100000000000000;//0.25
		#1000 start = 1'b1;
		#50 start = 1'b0;

		#10000 x = 16'b0010000000000000; //0.125
		#1000 start = 1'b1;
		#50 start = 1'b0;

         	#10000 $stop;

	end
	
endmodule 

