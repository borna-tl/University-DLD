`timescale 1ns/1ns
module TCS(input a1, a0, b1, b0, eq, gt, output EQ, GT);
	//assign #65 GT = (gt & ((a1 > b1) | ((a1 == b1) & (a0 > b0))));
	//assign #43 EQ = (eq & ((a1 == b1) & (a0 == b0)));
	logic[1:0] a, b;
	assign a[1] = a1;
	assign a[0] = a0;
	assign b[1] = b1;
	assign b[0] = b0;
	assign #65 GT = ((((a[0]&~b[1]&~b[0])|(a[1]&~b[1])|(a[1]&a[0]&~b[0]))&eq)|gt);
	assign #43 EQ = ((~(a[1]^b[1])&(~a[0]^b[0]))&eq);
endmodule
