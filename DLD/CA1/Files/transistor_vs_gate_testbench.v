`timescale 1ns/1ns
module transistor_vs_gate_testbench();
	reg aa1 = 0, bb1 = 0, ee0 = 0, gg0 = 0;
	wire transistor_e1, transistor_g1, gate_e1, gate_g1;
	mybcs UUT1(.a1(aa1), .b1(bb1), .e0(ee0), .g0(gg0), .e1(transistor_e1), .g1(transistor_g1));
	mybcs_gatelevel UUT2(.a1(aa1), .b1(bb1), .e0(ee0), .g0(gg0), .e1(gate_e1), .g1(gate_g1));
	initial begin
	#100 aa1 = 0; bb1 = 1; ee0 = 1; gg0 = 1; //worst delay
	#1000 aa1 = 0; bb1 = 0; ee0 = 0; gg0 = 0;
	#1000 aa1 = 0; bb1 = 0; ee0 = 0; gg0 = 1;
	#1000 aa1 = 0; bb1 = 0; ee0 = 1; gg0 = 0;
	#1000 aa1 = 0; bb1 = 0; ee0 = 1; gg0 = 1;
	#1000 aa1 = 0; bb1 = 1; ee0 = 0; gg0 = 0;
	#1000 aa1 = 0; bb1 = 1; ee0 = 0; gg0 = 1;
	#1000 aa1 = 0; bb1 = 1; ee0 = 1; gg0 = 0;
	#1000 aa1 = 0; bb1 = 1; ee0 = 1; gg0 = 1;
	#1000 $stop;
	end
endmodule
