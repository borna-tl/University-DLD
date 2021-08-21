`timescale 1ns/1ns
module WFG_DDS_TB();
	reg [2:0] func0 = 3'd0, func1 = 3'd1, func2 = 3'd2, func3 = 3'd3, func4 = 3'd4, func5 = 3'd5, func6 = 3'd6, func7 = 3'd7;
	wire clk_50;
    	reg rst = 1, inp = 1, ld = 1;
    	reg[7:0] phaseControll = 8'd1;
    	wire[7:0] wave0, wave1, wave2, wave3, wave4, wave5, wave6, wave7;
    	ring_oscillator #(5, 2) ro(inp, clk_50);
    	WFG_DDS cut0(.func(func0), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave0), .phaseControll(phaseControll), .dds_ld(ld));
	WFG_DDS cut1(.func(func1), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave1), .phaseControll(phaseControll), .dds_ld(ld));
	WFG_DDS cut2(.func(func2), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave2), .phaseControll(phaseControll), .dds_ld(ld));
    	WFG_DDS cut3(.func(func3), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave3), .phaseControll(phaseControll), .dds_ld(ld));
	WFG_DDS cut4(.func(func4), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave4), .phaseControll(phaseControll), .dds_ld(ld));
	WFG_DDS cut5(.func(func5), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave5), .phaseControll(phaseControll), .dds_ld(ld));
	WFG_DDS cut6(.func(func6), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave6), .phaseControll(phaseControll), .dds_ld(ld));
	WFG_DDS cut7(.func(func7), .dds_clk(clk_50), .rst(rst), .wfg_clk(clk_50), .out(wave7), .phaseControll(phaseControll), .dds_ld(ld));

	initial begin
        	//#20 inp = 0;
        	#10 rst = 0;
        	#13000 $stop;
    	end
endmodule
