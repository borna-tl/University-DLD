`timescale 1ns/1ns
module mybcs_gatelevel(input a1, b1, e0, g0, output e1, g1);
	wire j1, k1;
	assign #(12, 12) j1 = a1 ~^ b1;
	assign #(12, 14) e1 = j1 & e0;
	assign #(12, 12) k1 = ~a1 & b1 & e0;
	assign #(12, 12) g1 = k1 | g0;
endmodule
