`timescale 1ns/1ns
module AbsDiff (input [7:0]reff, [7:0]data, output logic [7:0]diff);
	wire [7:0] comp, not_comp;
	wire EQQ, GTT, Co_1, Co_2;
	NMA#8 my_nma(reff, ~data, {1'b1}, Co_1, not_comp);
	NMI#8 my_nmi(~not_comp, Co_2, comp);
	assign diff = Co_1 ? not_comp : comp;
endmodule





