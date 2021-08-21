`timescale 1ns/1ns

module D_latch_shift_register(input Sin, Clock, reset, output [7:0]Res, output Sout);
	wire [8:0]w;
	assign w[8] = Sin;
	genvar i;
	generate
		for (i = 7; i >= 0; i--) begin
			D_latch_res my_latch(w[i + 1], Clock, reset, w[i]);
		end
	endgenerate
	assign Res = w[7:0];
	assign Sout = w[0];
endmodule

