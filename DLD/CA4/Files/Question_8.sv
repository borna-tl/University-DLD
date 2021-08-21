`timescale 1ns/1ns
module FF_shift_register(input Sin, Clock, reset, output [7:0]Res, output Sout);
	wire [8:0]w;
	assign w[8] = Sin;
	genvar i;
	generate
		for (i = 7; i >= 0; i--) begin
			DFF my_dff(w[i + 1], Clock, reset, w[i]);
		end
	endgenerate
	assign Res = w[7:0];
	assign Sout = w[0];
endmodule


module FF_register(input [7:0]inp, Clock, reset, output [7:0]Res);
	genvar i;
	generate
		for (i = 7; i >= 0; i--) begin
			DFF my_dff(inp[i], Clock, reset, Res[i]);
		end
	endgenerate
endmodule

module Question_8_TB();
	logic clk = 1'b1, reset = 1'b1, sin = 1'b1;
	logic [7:0] inpp = 8'b0;
	wire[7:0] res;
	wire sout;
	FF_register my_ff(inpp, clk, reset, res);
	FF_shift_register my_shift_ff (sin, clk, reset, inpp, sout);
	always #50 clk = ~clk;
	initial begin
		clk = 1'b1;
		#200 reset = 1'b0;
		#100 sin = 1'b0;
		#100 sin = 1'b1;
        	#100 sin = 1'b0;
        	#100 sin = 1'b1;
        	#100 sin = 1'b0;
        	#100 sin = 1'b0;
        	#1000 sin = 1'b0;
		#200 reset = 1'b1;
		$stop;
	end
endmodule