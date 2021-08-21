`timescale 1ns/1ns

module Question_3_TB();
	logic clk = 1'b1, d = 1'b1;
	wire q, qb;
	//if we do have glitch clock should be 1 (o.w. both nands are 1)
	D_latch my_latch(d, clk, q, qb);
//	initial begin
//		repeat (100) begin
//			#80 clk <= ~clk;
//		end
//	end
	always #100 clk = ~clk;
    	initial begin
        #70 d = 1;
	#138 d = 0; //glitch
        #200 d = 1; //for transparency
	#35 d = 0; //for transparency
	#35 d = 1; //for transparency
        #100 $stop;
    	end
	//clock 0 -> 1, d = 1 -> 0;
endmodule
