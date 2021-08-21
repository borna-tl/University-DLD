`timescale 1ns/1ns

module DFF_always(input D, Clock, Reset, output logic Q, Qb);
	assign Qb = ~Q;
	always@(posedge Clock)
		#38 Q <= Reset ? 0 : D; //32 + 6 //gets the value of t+38
			
endmodule


module Question_9_TB();
	logic clk = 1'b1, d = 1'b1, reset = 1'b1;
	wire q, qb;
	DFF_always my_dff(d, clk, reset, q, qb);
	always #70 clk = ~clk;
    	initial begin
		#200 reset = 1'b0;
		#600 d = 1'b0;
		#500 d = 1'b1;
        	#500 d = 1'b0;
        	#500 d = 1'b1;
        	#500 d = 1'b0;
        	#500 d = 1'b1;
		#500 d = 1'b0;
        	#2000 d = 1'b1;
		#100 reset = 1'b1;
		#200 $stop;
	end
endmodule
