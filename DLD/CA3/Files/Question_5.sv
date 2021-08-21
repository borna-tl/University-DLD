`timescale 1ns/1ns
module NMA #(parameter n = 2)(input [n - 1:0]a, [n - 1:0]b, input carry_in, output logic CO, output logic [n - 1:0] S);
	wire [n/2:0] ci;
	assign ci[0] = carry_in;
	assign CO = ci[n/2];
	genvar i;
	generate
		for (i = 0; i < n/2; i++) begin
			TMA tma(a[2*i + 1:2*i], b[2*i + 1:2*i], ci[i], S[2*i + 1:2*i], ci[i + 1]);
		end
  	endgenerate
endmodule
