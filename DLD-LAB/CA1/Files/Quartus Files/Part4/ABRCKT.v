`timescale 1ns/1ns

module ABRCKT(input clk, rst, UXRX, ABAUD, output[7:0] N, output UXRXIF);
	wire co3, cnt_rst, ld_en, cnt_en, c3_ld, c3_en;
	controller CONTROLLER(clk, rst, UXRX, ABAUD, co3, UXRXIF, ld_en, cnt_en, cnt_rst, c3_ld, c3_en);
	datapath DATAPATH(clk, ld_en, cnt_en, cnt_rst, c3_ld, c3_en, UXRX, co3, N);
endmodule
