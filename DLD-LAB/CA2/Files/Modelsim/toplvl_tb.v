`timescale 1ns/1ns
module TOPLVL_TB();
  	reg clk = 1'b1, flag_noise = 1'b0, rst = 1'b1, DN = 1'b1, powermode = 1'b0;
  	wire noise_out, CLK_NOISE, sample_clk, msb_co, ro_external, FAIL, MAIN_CLOCK_OUT, psi;
	wire [7:0]adjustedDiv, setPeriod;
	reg[7:0] FRO_MIN = 8'd100, PSI_MIN = 8'd160, PSI_MAX = 8'd90, PSI_SET = 8'd150;
	
	always #10 clk = ~clk; //original clk 50MHz
	ring_oscillator #(5, 20) test_clk (1'b0, sample_clk); //freqency of 5MHz
	assign CLK_NOISE = flag_noise ? ~sample_clk : sample_clk; //internal noisy clock 20MHz
	ring_oscillator #(3, 7) ring_clock_external (1'b0, ro_external); //external RO 24MHz

	toplvl toplvl(.MSBQA(adjustedDiv[4]), .MSBQB(adjustedDiv[5]), .MSBQC(adjustedDiv[6]), .MSBQD(adjustedDiv[7]), 
			.LSBQA(adjustedDiv[0]), .LSBQB(adjustedDiv[1]), .LSBQC(adjustedDiv[2]), .LSBQD(adjustedDiv[3]),
			.main_clock(clk), .LSBDN(DN), .MSBCO(msb_co), .SET_PERIOD(setPeriod), .noisy_out(noise_out),
			.noisy_clk(CLK_NOISE), .main_reset(rst), .fail(FAIL), .ro_external(ro_external), .PSI(psi),
			.FRO_MIN0(FRO_MIN[0]), .FRO_MIN1(FRO_MIN[1]), .FRO_MIN2(FRO_MIN[2]), .FRO_MIN3(FRO_MIN[3]),
			.FRO_MIN4(FRO_MIN[4]), .FRO_MIN5(FRO_MIN[5]), .FRO_MIN6(FRO_MIN[6]), .FRO_MIN7(FRO_MIN[7]),
			.PSI_MIN0(PSI_MIN[0]), .PSI_MIN1(PSI_MIN[1]), .PSI_MIN2(PSI_MIN[2]), .PSI_MIN3(PSI_MIN[3]),
			.PSI_MIN4(FRO_MIN[4]), .PSI_MIN5(PSI_MIN[5]), .PSI_MIN6(PSI_MIN[6]), .PSI_MIN7(PSI_MIN[7]),
			.PSI_MAX0(PSI_MAX[0]), .PSI_MAX1(PSI_MAX[1]), .PSI_MAX2(PSI_MAX[2]), .PSI_MAX3(PSI_MAX[3]),
			.PSI_MAX4(PSI_MAX[4]), .PSI_MAX5(PSI_MAX[5]), .PSI_MAX6(PSI_MAX[6]), .PSI_MAX7(PSI_MAX[7]),
			.PSI_SET0(PSI_SET[0]), .PSI_SET1(PSI_SET[1]), .PSI_SET2(PSI_SET[2]), .PSI_SET3(PSI_SET[3]),
			.PSI_SET4(PSI_SET[4]), .PSI_SET5(PSI_SET[5]), .PSI_SET6(PSI_SET[6]), .PSI_SET7(PSI_SET[7]), 
			.powermode(powermode), .toplvl_clk(MAIN_CLOCK_OUT));

	initial begin
		#150 rst = 1'b0;
    		#10000 powermode = 1'b1;
		#10000 powermode = 1'b0;
		#10000 FRO_MIN = 8'd2;
    		#2000000 $stop;
  	end

	
endmodule


module noise_tb_temp();
	reg clk = 1'b1, flag_noise = 1'b0, rst = 1'b1, preset = 1'b0, DN = 1'b1;
  	wire noise_out, CLK_NOISE, sample_clk;

	always #10 clk = ~clk; //original clk 50MHz
	ring_oscillator #(5, 20) test_clk (1'b0, sample_clk); //freqency of 10MHz
	assign CLK_NOISE = flag_noise ? ~sample_clk : sample_clk; //noisy clock 10MHz
	

	noise clock_noise_circuit(clk, CLK_NOISE, rst, noise_out);
	initial begin
		#100 rst = 1'b0;
    		#5000 flag_noise = 1'b1;
		#22 flag_noise = 1'b0;
		#1000 flag_noise = 1'b1;
		#22 flag_noise = 1'b0;
    		#50000 $stop;
  	end



endmodule;
