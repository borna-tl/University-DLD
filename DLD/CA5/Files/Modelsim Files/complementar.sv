`timescale 1ns/1ns


module complementar (input [5:0]inp, output [8:0]out);
	wire [5:0] temp = ~inp + 1;
 	assign out = {temp, 3'b000};
endmodule
