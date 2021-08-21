`timescale 1ns/1ns

module BRGCKT_TB();
	reg ABAUD = 1'b0, rst = 1'b1, UXRX = 1'b1, preset = 1'b0;
  	wire UXRXIF, BRG, co, clock;
  	wire [7:0] out;
  	ring_oscillator #(3,2) CUT1 (1'b0, clock);
  	BRGCKT CUT (.clk_(clock), .rst_(rst), .uxrx_(UXRX), .abaud_(ABAUD), .preset_(preset), .lsbdn_(1'b1),
  	.lsbqa_(out[0]), .lsbqb_(out[1]), .lsbqc_(out[2]), .lsbqd_(out[3]), .msbqa_(out[4]), .msbqb_(out[5]),
	.msbqc_(out[6]), .msbqd_(out[7]), .msbco_(co),.uxrxif_(UXRXIF), .tffout_(BRG));
	initial begin
		#50 preset = 1;
    		#50 rst = 0;
    		#100 ABAUD = 1;
    		#19 UXRX = 0;
    		#19 UXRX = 1;
    		#19 UXRX = 0;
    		#19 UXRX = 1;
    		#19 UXRX = 0;
    		#19 UXRX = 1;
    		#19 UXRX = 0;
    		#19 UXRX = 1;
    		#19 UXRX = 0;
    		#19 UXRX = 1;
    		#100000 $stop;
  	end
endmodule



