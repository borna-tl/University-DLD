`timescale 1ns/1ns

module Question_6_TB();
	logic clk = 1'b1, d = 1'b1, sin = 1'b1, reset = 1'b0;
	wire [7:0]Result;
	wire sout;
	D_latch_shift_register my_latch(sin, clk, reset, Result, sout);
//	initial begin
//		repeat (10) begin
//			#80 clk <= ~clk;
//		end
//	end
//	always #40 clk = ~clk
    	initial begin
	clk = 1'b1;
	#200 reset = 1'b1;
	#100 sin = 1'b0;
	#100 sin = 1'b1;
        #100 sin = 1'b0;
        #100 sin = 1'b1;
        #100 sin = 1'b0;
        #100 sin = 1'b0;
        #1000 sin = 1'b0; //as presented, whatever the numbers are, with the clock = 1, the output will always be = sin!
	$stop;
	end
endmodule
