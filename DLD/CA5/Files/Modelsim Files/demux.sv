`timescale 1ns/1ns


module demux (input [1:0] s, input sin, en, output logic [3:0] P);
	logic [3:0] temp = 4'b0000;
	always @(s) begin
	case (s)
		2'b00 : begin temp[0] = sin; end
		2'b01 : begin temp[1] = sin; end
		2'b10 : begin temp[2] = sin; end
		2'b11 : begin temp[3] = sin; end
	endcase
	end
	assign P = en ? temp: 4'bz;
endmodule
