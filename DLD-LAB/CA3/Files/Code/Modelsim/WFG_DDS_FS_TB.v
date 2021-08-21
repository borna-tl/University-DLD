`timescale 1ns/1ns
module WFG_DDS_FS_TB();
    	reg rst = 1, inp = 1, ld = 1, preset = 0;
    	reg[7:0] phaseControll = 8'd1;
    	reg[10:0] sel = 11'b01111111101;
    	wire[7:0] wave;
    	wire clk_50, divided_clk;
    	
	WFG_DDS_FS cut_fs (.wave(wave), .preset(preset), .divided_clk(divided_clk), .clk(clk_50), .SW(sel), .rst(rst), .ld(ld), .phaseControll(phaseControll));
    	ring_oscillator  #(5, 2) ro(inp, clk_50);
	
	initial begin
        #20 inp = 0;
        #1000 preset = 1'b1;
        #10 rst = 1'b0;
        #15000 rst = 1'b1; preset = 1'b0;
            sel = 11'b01111111011;
        #50 rst = 1'b0; preset = 1'b1;
        #30000 rst = 1'b1;
            sel = 11'b01111110111;
        #50 rst = 1'b0;
	#60000 rst = 1'b1;
            sel = 11'b10011111101;
        #50 rst = 1'b0;
        #15000 rst = 1'b1;
            sel = 11'b10011111011;
        #50 rst = 1'b0;
        #30000 rst = 1'b1;
            sel = 11'b10011110111;
        #50 rst = 1'b0;
        #60000 rst = 1'b1;
            sel = 11'b11111111110;
        #50 rst = 1'b0;
        #6000 rst = 1'b1;
              phaseControll = 8'd2;
        #50 rst = 1'b0;
        #6000 rst = 1'b1;
              phaseControll = 8'd4;
        #50 rst = 1'b0;
        #10000 $stop;
    end
endmodule
