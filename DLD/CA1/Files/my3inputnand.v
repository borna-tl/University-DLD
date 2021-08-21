`timescale 1ns/1ns
module my3inputnand(input a, b, c, output w);
	wire y, z;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5, 6, 7) T1(w, Vdd, a), T2(w, Vdd, b), T3(w, Vdd, c);
	nmos #(3, 4, 5) T4(y, Gnd, c), T5(z, y, b), T6(w, z, a);
endmodule
