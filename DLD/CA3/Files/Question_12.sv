`timescale 1ns/1ns
module LessDistance (input [7:0]refI, [7:0]dataA, [7:0]dataB, output logic [7:0]diff);
	wire [7:0] diffA, diffB;
	wire EQQ, GTT;
	AbsDiff A_diff(refI, dataA, diffA);
	AbsDiff B_diff(refI, dataB, diffB);
	NCS#8 my_cmp(diffA, diffB, EQQ, GTT);
	assign #27 diff = GTT ? dataB : dataA;
endmodule





