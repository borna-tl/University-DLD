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

module Reg_TB();
	
	reg clk = 1'b1, rst = 1'b1, preset = 1'b0, DN = 1'b1;
	wire ring_clk, msb_co;
	reg [7:0]setPeriod = 8'd125;
	wire [7:0]adjustedDiv;
	/*wire [7:0]divider_out;
	regulator CUT (clk, rst, psi, setPeriod, adjustedDiv);
	freq_div_tff freq_div (.MSBA(adjustedDiv[4]), .MSBB(adjustedDiv[5]), .MSBC(adjustedDiv[6]), .MSBD(adjustedDiv[7]),
			.LSBA(adjustedDiv[0]), .LSBB(adjustedDiv[1]), .LSBC(adjustedDiv[2]), .LSBD(adjustedDiv[3]),
			.MSBQA(divider_out[4]), .MSBQB(divider_out[5]), .MSBQC(divider_out[6]), .MSBQD(divider_out[7]), 
			.LSBQA(divider_out[0]), .LSBQB(divider_out[1]), .LSBQC(divider_out[2]), .LSBQD(divider_out[3]),
			.LSBUP(ring_clk), .LSBDN(DN), .PRESET(preset), .MSBCO(msb_co), .TFFOUT(psi)); */
	freq_div_reg freq_div (.MSBQA(adjustedDiv[4]), .MSBQB(adjustedDiv[5]), .MSBQC(adjustedDiv[6]), .MSBQD(adjustedDiv[7]), 
			.LSBQA(adjustedDiv[0]), .LSBQB(adjustedDiv[1]), .LSBQC(adjustedDiv[2]), .LSBQD(adjustedDiv[3]),
			.LSBUP(ring_clk), .LSBDN(DN), .PRESET(preset), .MSBCO(msb_co),
			.reg_clk(clk), .reg_rst(rst), .setPeriod(setPeriod));
	ring_oscillator #(5, 5) ring_clock (1'b0, ring_clk);
	always #10 clk = ~clk; //clk is 20
	//always #8 clk = ~clk; //clk is 16
	initial begin
		#13 rst = 1'b0;
		#13 preset = 1'b1;
		#2000000 $stop;
	end



endmodule



module SyncCount_TB();
	wire out[7:0];
  	reg DN = 1'b1, preset = 1'b0;
  	wire CO, CLK, CLK_TFF;
  	ring_oscillator #(1, 5) CLK_CUT(1'b0, CLK);
	freq_div_tff sync_cnt(.MSBA(1'b0), .MSBB(1'b0), .MSBC(1'b0), .MSBD(1'b1)
			, .LSBA(1'b0), .LSBB(1'b1), .LSBC(1'b1), .LSBD(1'b1)
                        , .MSBQA(out[4]), .MSBQB(out[5]), .MSBQC(out[6]), .MSBQD(out[7])
			, .LSBQA(out[0]), .TFFOUT(CLK_TFF)
                        , .LSBQB(out[1]), .LSBQC(out[2]), .LSBQD(out[3])
			, .MSBCO(CO), .LSBUP(CLK), .LSBDN(DN), .PRESET(preset));
	initial begin
    	#50 preset = 1'b1;
    	#50000 $stop;
  	end
endmodule