`timescale 1ns/1ns
module mybcs(input a1, b1, e0, g0, output e1, g1);
	wire j1, k1;
	j1_module function_1(a1, b1, j1);
	e1_module function_2(j1, e0, e1);
	k1_module function_3(a1, b1, e0, k1);
	g1_module function_4(k1, g0, g1);
endmodule
