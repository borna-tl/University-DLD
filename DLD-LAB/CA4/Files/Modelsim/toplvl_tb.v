`timescale 1ps/1ps

module toplvl_tb();

    reg clk, rst, infreq, adjust, rdreq;
    reg start=1'b0;
    reg [2:0] n;
    wire outfreq, valid;
    wire [7:0] k;
    reg [1:0]ui;
    reg[15:0] vi;
    wire done, wrdata, full, empty;
    wire [20:0] data, q;
    wire [1:0] usedw;
	//freq_multiplier cut(ref_clk, rst, inFreq, adjust, n, outFreq, valid, k);
    freq_multiplier fmtbs(clk, rst, infreq, adjust, n, outfreq,valid, k);

    wrapper wp(outfreq, rst, start, ui, vi, done,wrdata, data);
    FIFO_Module toplvl_fifo(full, wrdata, rdreq, outfreq, data, empty, q, usedw);
    
    always #(2500) clk=~clk;

    initial repeat (10000) #(1000000/4) infreq=~infreq;

    initial begin
	infreq=0;
	rdreq=1'b0;
        //n=3'd3;
	//n = 3'd7;
	n = 3'd5;
	ui=2'b01;
        vi=16'b0000001000000000;
        rst=0;
        adjust=0;
        clk=0;
        #200 rst=1'b1;
        #100 rst=1'b0;
        #20 adjust=1'b1;
        #5000 adjust=1'b0;
        rst=0;
        #20000 rst=1;
        #50000 rst=0;
        #20000000 start=1'b1;
        #1000000 start=1'b0;
	#30000000 rdreq=1'b1;
	$stop;
    end

endmodule

