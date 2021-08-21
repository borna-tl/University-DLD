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

module WFG_TB();
    reg [2:0] func = 3'd6;
    wire clk;
    reg rst = 1, inp = 1;
    wire[7:0] wave;
    ring_oscillator #(5, 2) ro(inp, clk);
    WFG wgp(func, clk, rst, wave);
    initial begin
        #20 inp = 0;
        #10 rst = 0;
        #50000 $stop;
    end
endmodule
