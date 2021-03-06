`timescale 1ps/1ps
module freq_multiplier(input clk, rst, infreq, adjust, input[2:0]n, output outfreq, valid, output[7:0]k);

    wire kc, ld_cnt, cnt_en, kcount;

    freq_controller my_controller(clk, rst, kc, adjust, valid, ld_cnt, cnt_en, kcount);

    freq_datapath my_datapath(clk, rst, infreq, ld_cnt, cnt_en, kcount, n, kc, outfreq, k);

endmodule
