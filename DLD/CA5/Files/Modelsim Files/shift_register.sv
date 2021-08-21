`timescale 1ns/1ns



module shift_register (input clk, sin, en, rst, output logic[7:0] Out);
	always@ (posedge clk, posedge rst) begin
		if (rst) Out <= 8'b00000000;
		else if (en)
			Out <= {sin, Out[7:1]};
	end
endmodule
