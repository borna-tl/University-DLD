`timescale 1ns/1ns

module D_latch(input D, Clock, output Q, output Qb);
	//if we didn't want to find the Qb glitch, Qb would simply be a wire!
	wire w1, w2;
	nand #8 nand_1(w1, Clock, D);
	nand #8 nand_2(w2, Clock, w1);
	nand #8 nand_3(Q, w1, Qb);
	nand #8 nand_4(Qb, w2, Q);
endmodule
