`timescale 1ns/1ns
module NCS #(parameter n = 2)(input [n - 1:0]a, [n - 1:0]b, output logic EQ, GT);
	wire [n/2:0] e, g;
	assign EQ = e[0];
	assign GT = g[0];
	assign e[n/2] = 1;
	assign g[n/2] = 0;
	genvar i;
	generate
		for (i = (n/2) - 1; i >= 0; i--) begin
			TCS tcs(a[2*i + 1:2*i], b[2*i + 1:2*i], e[i + 1], g[i + 1], e[i], g[i]);
		end
  	endgenerate
endmodule