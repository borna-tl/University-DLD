`timescale 1ns/1ns

module FF_shift_register_always(input Sin, Clock, reset, output [7:0]Res, output Sout);
	wire [8:0]w;
	assign w[8] = Sin;
	genvar i;
	generate
		for (i = 7; i >= 0; i--) begin
			DFF_always my_dff(w[i + 1], Clock, reset, w[i]);
		end
	endgenerate
	assign Res = w[7:0];
	assign Sout = w[0];
endmodule


module Question_10_TB();
	logic clk = 1'b1, reset = 1'b1, sin = 1'b1;
	wire[7:0] out_always, out_gate;
	wire sout1, sout2;
	FF_shift_register shifter_1(sin, clk, reset, out_gate, sout1);
	FF_shift_register_always shifter_2(sin, clk, reset, out_always, sout2);
	always #70 clk = ~clk;
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
