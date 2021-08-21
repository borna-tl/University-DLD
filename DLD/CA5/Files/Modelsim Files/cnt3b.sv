`timescale 1ns/1ns

module cnt3b (input clk, en, rst, output logic [2:0] Cnt, output Co);
	always@ (posedge clk, posedge rst) begin
		if (rst) Cnt <= 3'b000;
		else if (en)
			Cnt <= Cnt + 1;
 	end
	assign Co = &{Cnt};
endmodule
