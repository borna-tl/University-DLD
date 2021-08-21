`timescale 1 ns/1 ns
module wrapper(input clk, rst, start, input [1:0]ui, input [15:0]vi, output done, wrdata, output[20:0]data);

    wire eng_done, ld, eng_start, ldui, sh_en, cout;
    wire [1:0] sh_x, count;
    wire [15:0]eng_x, fp;
    wire[1:0] intp, shiftnum;
    wire [17:0] input_18bit;

    countercnt cntcl(clk, rst, ldcount, encount , cout, count);

    wcontroller wc(clk, rst, start, eng_done, cout, count, ld, eng_start, ldui, done, wrdata, ldcount , encount, sh_en, sh_x);

    shf_reg sr(clk, rst, ld, sh_en, sh_x, vi, eng_x);

    assign input_18bit = {intp, fp};

    sh_comb scc(input_18bit, shiftnum, data);

    ui_reg ur(clk, rst, ldui, ui, shiftnum);

    exponential exp(clk, rst, eng_start, eng_x, eng_done, intp, fp);


endmodule
