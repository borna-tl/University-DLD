`timescale 1ns/1ns
module myxor(input a, b, output w);
	wire ai, bi;
	mynot not_1(a, ai);
	mynot not_2(b, bi);
	nmos #(3, 4, 5) T1(w, a, bi), T2(w, ai, b); 

endmodule