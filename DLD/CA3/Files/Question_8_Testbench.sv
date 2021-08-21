`timescale 1ns/1ns
module Q8_testbench();
	logic [7:0] aa;
	wire [7:0] sum;
	wire co;
	NMI#8 my_nmi(aa, co, sum);
	initial begin
		#100 aa = 8'b00000001;
		#200 aa = 8'b00000011; //84NS delay
		#200 aa = 8'b00000111;
		#200 aa = 8'b00001111;
		#200 aa = 8'b00011111;
		#1000 $stop;
	end
endmodule

