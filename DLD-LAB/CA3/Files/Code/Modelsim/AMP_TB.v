`timescale 1ns/1ns
module AMP_TB();
	reg rst = 1, inp = 1, ld = 1, preset = 0;
    	reg[7:0] phaseControll = 8'd1;
    	reg[12:0] SW = 13'b0000111111101;
    	wire[7:0] wave;
	wire clk;

    	WFG_DDS_FS_AMP CUT(.wave(wave), .preset(preset), .clk(clk), .SW(SW), .rst(rst), .ld(ld), .phaseControll(phaseControll));
    	ring_oscillator  #(5, 2) ro(inp, clk);
    	initial begin
        	#20 inp = 0;
        	#10 preset = 1'b1;
        	#10 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b0100111111101;
        	#50 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b1000111111101;
        	#50 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b1100111111101;
        	#50 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b0001111111101;
        	#50 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b0101111111101;
        	#50 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b1001111111101;
        	#50 rst = 1'b0;
        	#20000 rst = 1'b1;
        	    SW = 13'b1101111111101;
        	#50 rst = 1'b0;
        	#10000 $stop;
    	end
endmodule