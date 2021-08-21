`timescale 1ns/1ns

module noise(input clk, pulse, rst, output reg out);
	parameter [1:0] waitforone = 2'b00, noisecheckone = 2'b01, stableone = 2'b10, noisecheckzero = 2'b11;
	reg [1:0] ps, ns;
	
	always@(ps, pulse) begin
		ns = 2'b00;
		case (ps)
			waitforone: begin ns = pulse ? noisecheckone : waitforone; end
			noisecheckone: begin ns = pulse ? stableone : waitforone; end
			stableone: begin ns = pulse ? stableone : noisecheckzero; end
			noisecheckzero: begin ns = pulse ? stableone : waitforone; end
		endcase

	end
	always @(ps) begin
		out = ps[1];
	end
	always @(posedge clk, posedge rst) begin
		if(rst)
			ps = 2'b00;
		else
			ps = ns;
	end
	
endmodule
