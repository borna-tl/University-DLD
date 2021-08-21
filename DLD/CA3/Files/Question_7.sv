`timescale 1ns/1ns
module mux4to1 (input [1:0]S, [0:3]D, output logic w); 
	//CMOS representation 20 + 15 + 7
	assign #42 w = (D[0] & ~S[1] & ~S[0]) |
			(D[1] & ~S[1] & S[0]) |
			(D[2] & S[1] & ~S[0]) |
			(D[3] & S[1] & S[0]);
endmodule


module TMI (input [1:0] A, input ci, output [1:0] s, output co);
	mux4to1 my_4_1 (A, {1'b0, ci, 1'b1, ~ci}, s[1]);
	mux4to1 my_4_2 (A, {ci, ~ci, ci, ~ci}, s[0]);
	mux4to1 my_4_3 (A, {1'b0, 1'b0, 1'b0, ci}, co);
endmodule
