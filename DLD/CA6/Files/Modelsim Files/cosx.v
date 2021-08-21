`timescale 1ns/1ns
module cosx_org (input clk, rst, start, input[9:0] x, input[7:0] y, output done, output [9:0] result, output [2:0] pss, output coo, output is_negg);
	wire co, gt, initr, initt, zc, ldx, s, ldt, enc, ldr, is_neg;
	wire [2:0] ps;
	controller control(clk, rst, start, co, gt, done, initr, initt, zc, ldx, s, ldt, enc, ldr, is_neg, ps);	
	dp datapath(clk, rst, initr, initt, zc, ldx, s, ldt, enc, ldr, is_neg, x, y, result, co, gt);
	assign pss = ps;
	assign coo = co;
	assign is_negg = is_neg;
endmodule

module cosx_tb();
	reg clk = 1, rst = 0, start = 0;
	//reg [9:0] x=10'b0110010010;//pi/2=0
	reg [9:0] x = 10'b0100001100; //=1/2 ->0010000000
  	reg [7:0] y = 8'b00000000;
	wire done_org, done_new;
	wire [9:0] result_org, result_new;
	wire [2:0] ps_org, ps_new;
	wire co_org, co_new, is_negg_org, is_negg_new;
	cosx_org original_one (clk, rst, start, x, y, done_org, result_org, ps_org, co_org, is_negg_org);
	cosx new_one (clk, rst, start, x, y, done_new, result_new, ps_new, co_new, is_negg_new);
	always #110 clk = ~clk;
	initial begin
    		#300 start=1;
    		#300 start=0;
    		#10000
    		#800 $stop;
  	end
endmodule
