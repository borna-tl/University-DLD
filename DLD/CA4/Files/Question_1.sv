`timescale 1ns/1ns

module D_latch_clock_no_delay(input D, Clock, output Q);
	wire w1, w2, Qb;
	nand nand_1(w1, Clock, D);
	nand nand_2(w2, Clock, w1);
	nand nand_3(Q, w1, Qb);
	nand nand_4(Qb, w2, Q);
endmodule
