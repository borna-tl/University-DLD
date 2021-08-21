`timescale 1ns/1ns
module BCS(input a, b, eq, gt, output EQ, GT);
	wire j1, k1;
	assign #(12, 12) j1 = a ~^ b;
	assign #(12, 14) EQ = j1 & eq;
	assign #(12, 12) k1 = ~a & b & eq;
	assign #(12, 12) GT = k1 | gt;
endmodule
