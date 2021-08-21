`timescale 1ns/1ns


module cnt9b (input [8:0]load_inp, input clk, en, rst, ld, output logic [8:0]Cnt, output logic Co);
	always @(posedge clk, posedge rst) begin
		if (rst) Cnt <= 9'b000000000;
		else if (ld) Cnt <= load_inp;
		else if (en)
			Cnt <= Cnt + 1;
	end
	assign Co = &{Cnt, ~ld};
endmodule
