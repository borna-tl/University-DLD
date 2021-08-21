`timescale 1ns/1ns

module DFF(input D, Clock, Reset, output Q, Qb); //rising edge master slave D flip flop
	logic Dp, Q1, Q1b;
	assign #14 Dp = D & ~Reset;
	D_latch my_latch1 (Dp, ~Clock, Q1, Q1b);
	D_latch my_latch2 (Q1, Clock, Q, Qb);
endmodule


module Question_7_TB();
	logic clk = 1'b1, d = 1'b1, reset = 1'b1;
	wire q, qb;
	DFF my_dff(d, clk, reset, q, qb);
	always #40 clk = ~clk;
    	initial begin
		#200 reset = 1'b0;
		#210 d = 1'b0;
		#210 d = 1'b1;
        	#210 d = 1'b0;
        	#210 d = 1'b1;
        	#210 d = 1'b0;
        	#210 d = 1'b1;
		#210 d = 1'b0;
        	#2010 d = 1'b1;
		#100 reset = 1'b1;
		#200 $stop;
	end
endmodule