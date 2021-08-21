`timescale 1ns/1ns

module Monitor_TB();
	
	reg clk = 1'b1, rst = 1'b1, preset = 1'b0, DN = 1'b1;
	wire ring_clk, msb_co, ro_external, FAIL;
	wire [7:0]adjustedDiv, setPeriod;
	reg[7:0] FRO_MIN = 8'd100, PSI_MIN = 8'd160, PSI_MAX = 8'd90, PSI_SET = 8'd150;
	/*freq_div_reg freq_div (.MSBQA(adjustedDiv[4]), .MSBQB(adjustedDiv[5]), .MSBQC(adjustedDiv[6]), .MSBQD(adjustedDiv[7]), 
			.LSBQA(adjustedDiv[0]), .LSBQB(adjustedDiv[1]), .LSBQC(adjustedDiv[2]), .LSBQD(adjustedDiv[3]),
			.LSBUP(ring_clk), .LSBDN(DN), .PRESET(preset), .MSBCO(msb_co),
			.reg_clk(clk), .reg_rst(rst), .setPeriod(setPeriod));

	clock_monitor clk_mntr (ring_clk, rst, ro_external, fro_min, 8'd160, 8'd90, psi_set, set_p_dum, FAIL); */
	reg_clk_mntr clock_monitor(.MSBQA(adjustedDiv[4]), .MSBQB(adjustedDiv[5]), .MSBQC(adjustedDiv[6]), .MSBQD(adjustedDiv[7]), 
			.LSBQA(adjustedDiv[0]), .LSBQB(adjustedDiv[1]), .LSBQC(adjustedDiv[2]), .LSBQD(adjustedDiv[3]),
			.main_clock(clk), .LSBDN(DN), .MSBCO(msb_co), .SET_PERIOD(setPeriod),
			.freq_clk(ring_clk), .main_reset(rst), .fail(FAIL), .ro_external(ro_external), 
			.FRO_MIN0(FRO_MIN[0]), .FRO_MIN1(FRO_MIN[1]), .FRO_MIN2(FRO_MIN[2]), .FRO_MIN3(FRO_MIN[3]),
			.FRO_MIN4(FRO_MIN[4]), .FRO_MIN5(FRO_MIN[5]), .FRO_MIN6(FRO_MIN[6]), .FRO_MIN7(FRO_MIN[7]),
			.PSI_MIN0(PSI_MIN[0]), .PSI_MIN1(PSI_MIN[1]), .PSI_MIN2(PSI_MIN[2]), .PSI_MIN3(PSI_MIN[3]),
			.PSI_MIN4(FRO_MIN[4]), .PSI_MIN5(PSI_MIN[5]), .PSI_MIN6(PSI_MIN[6]), .PSI_MIN7(PSI_MIN[7]),
			.PSI_MAX0(PSI_MAX[0]), .PSI_MAX1(PSI_MAX[1]), .PSI_MAX2(PSI_MAX[2]), .PSI_MAX3(PSI_MAX[3]),
			.PSI_MAX4(PSI_MAX[4]), .PSI_MAX5(PSI_MAX[5]), .PSI_MAX6(PSI_MAX[6]), .PSI_MAX7(PSI_MAX[7]),
			.PSI_SET0(PSI_SET[0]), .PSI_SET1(PSI_SET[1]), .PSI_SET2(PSI_SET[2]), .PSI_SET3(PSI_SET[3]),
			.PSI_SET4(PSI_SET[4]), .PSI_SET5(PSI_SET[5]), .PSI_SET6(PSI_SET[6]), .PSI_SET7(PSI_SET[7]));
	ring_oscillator #(5, 5) ring_clock (1'b0, ring_clk); //20MHz
	ring_oscillator #(3, 7) ring_clock_external (1'b0, ro_external);
	always #10 clk = ~clk; //clk is 20ns, 50MHz
	//always #8 clk = ~clk; //clk is 16
	initial begin
		#13 rst = 1'b0;
		#13 preset = 1'b1;
		#10000 PSI_SET = 8'd190;
		#10000 PSI_SET = 8'd30;
		#10000 PSI_SET = 8'd141;
		#10000 FRO_MIN = 8'd2;
		#10000 FRO_MIN = 8'd200;
		#10000 FRO_MIN = 8'd3;
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
