`timescale 1ns/1ns
module mux8to1 (input [2:0]S, [0:7]D, output logic w); 
	//CMOS representation 20 + 40 + 7
	assign #67 w = (D[0] & ~S[2] & ~S[1] & ~S[0]) |
			(D[1] & ~S[2] & ~S[1] & S[0]) |
			(D[2] & ~S[2] & S[1] & ~S[0]) |
			(D[3] & ~S[2] & S[1] & S[0]) |
			(D[4] & S[2] & ~S[1] & ~S[0]) |
			(D[5] & S[2] & ~S[1] & S[0]) |
			(D[6] & S[2] & S[1] & ~S[0]) |
			(D[7] & S[2] & S[1] & S[0]);
endmodule

module mux2to1 (input S, [0:1]D, output logic w);
	//CMOS representation 10 + 10 + 7
	assign #27 w = (D[0] & ~S) | (D[1] & S);
endmodule

module TMA (input [1:0] A, B, input ci, output [1:0] s, output co);
	wire[5:0] w;
	mux8to1 my_8_1({B[1], A[1], A[0]}, {B[0], ~B[0], B[0], ~B[0], B[0], ~B[0], B[0], ~B[0]}, w[0]);
	mux8to1 my_8_2({B[1], A[1], A[0]}, {~B[0], B[0], ~B[0], B[0], ~B[0], B[0], ~B[0], B[0]}, w[1]);
	mux8to1 my_8_3({B[1], A[1], A[0]}, {1'b0, B[0], 1'b1, ~B[0], 1'b1, ~B[0], 1'b0, B[0]}, w[2]);
	mux8to1 my_8_4({B[1], A[1], A[0]}, {B[0], 1'b1, ~B[0], 1'b0, ~B[0], 1'b0, B[0], 1'b1}, w[3]);
	mux8to1 my_8_5({B[1], A[1], A[0]}, {1'b0, 1'b0, 1'b0, B[0], 1'b0, B[0], 1'b1, 1'b1}, w[4]);
	mux8to1 my_8_6({B[1], A[1], A[0]}, {1'b0, 1'b0, B[0], 1'b1, B[0], 1'b1, 1'b1, 1'b1}, w[5]);
	mux2to1 my_2_1(ci, {w[0], w[1]}, s[0]);
	mux2to1 my_2_2(ci, {w[2], w[3]}, s[1]);
	mux2to1 my_2_3(ci, {w[4], w[5]}, co);
endmodule