`timescale 1ns/1ns

module ring_oscillator #(parameter N =  5, parameter d = 5)(input inp, output reg out);
	reg [N:0] w;
	integer i, j;
	always @(inp) begin
		w[N] = inp;
		for (j = 0; j < 2; j = j) begin: xx
			w[0] = w[N];
			for(i = 0; i < N; i = i + 1) begin: yy
      				#d w[i + 1] = ~w[i];
			end
			out = w[N];
		end
	end
endmodule


module Ring_Oscillator_TB();
	reg inp = 1'b1;
	wire my_clock;
	ring_oscillator #(5,2) CUT1(inp, my_clock); //10ns here!
	initial begin
  		#1000 $stop;
 	end
endmodule
