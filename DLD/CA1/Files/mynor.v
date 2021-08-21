`timescale 1ns/1ns
module mynor(input a, b, output w);
	wire y;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5, 6, 7) T1(w, y, a), T2(y, Vdd, b);
	nmos #(3, 4, 5) T3(w, Gnd, a), T4(w, Gnd, b);
endmodule