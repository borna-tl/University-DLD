`timescale 1 ns/1 ns

module wcontroller(input clk, rst, start, eng_done, cout, [1:0] count, output reg  ld, eng_start, ldui, is_done, wrdata, ldcount , encount, sh_en, [1:0] sh_x);
    reg [2:0] ps, ns;
    parameter [2:0] idle=0, ready=1, sh_f=2, set=3, cal_exp=4, sh_ui=5, write=6, done=7;

    always @(start, eng_done, ps) begin
        {sh_en, ld, eng_start, ldui, is_done, ldcount, encount, wrdata}=8'b00000000;
        case (ps)
            idle: begin ldcount=1'b1; if(start) ns=ready; else ns=idle; end
            ready: begin ld=1'b1; ldui=1'b1; if(start) ns=ready; else ns=sh_f; end
            sh_f: begin encount=1'b1;sh_en=1'b1; ns=set; end
            set: begin eng_start=1'b1; ns=cal_exp; end
            cal_exp: begin if(eng_done) ns=sh_ui; else ns=cal_exp; end
            sh_ui: begin ns=write; end
            write: begin wrdata=1'b1; if(cout) ns=done; else ns=sh_f;end
            done: begin is_done=1'b1; if(start) ns=idle; else ns=done; end

        endcase
    end

    always @(posedge clk, posedge rst) begin
        if(rst)
            ps <= idle;
        else 
            ps <= ns;
    end
    assign sh_x = count;

endmodule

module countercnt(input clk, rst, ld, en, output reg cout, [1:0]count);

    always @(posedge clk, posedge rst) begin
        if(rst)
            {cout,count} <=3'b000;
        else begin
            if(ld)
                {cout,count}<=3'b000;
            else if(en)
                {cout,count}<= count+1'b1;
        end
    end

endmodule

module shf_reg(input clk, rst, ld, sh_en, [1:0]sh_x, [15:0] in, output reg[15:0] out );

    always @(posedge clk, posedge rst) begin
        if(rst)
            out<=16'd0;
        else
        if(ld)
            out<=in;
        else if(sh_en)
            out<=(in<<sh_x);
    end

endmodule

module sh_comb(input [17:0]x, [1:0] shift_num, output reg[20:0] wrdata);

    always @(shift_num, x) begin
        wrdata<=(x<<shift_num);
    end

endmodule

module ui_reg(input clk, rst, ld, [1:0] ui, output reg[1:0]shift_num);

    always @(posedge clk, posedge rst) begin
        if(rst)
            shift_num<=2'b00;
        else if(ld)
            shift_num<=ui;
    end

endmodule

module wrapper(input clk, rst, start, [1:0]ui, [15:0]vi, output done, wrdata, [20:0]data);

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


module wrapper_tb();

    reg clk = 1'b0, rst = 1'b0, start = 1'b0, rdreq = 1'b0;
    reg [1:0]ui;
    reg[15:0] vi;
    wire done, wrdata, full, empty;
    wire [20:0] data, q;
    wire [1:0] usedw;

    wrapper wp(clk, rst, start, ui, vi, done,wrdata, data);
    FIFO_Module my_fifo(full, wrdata, rdreq, clk, data, empty, q, usedw);

    always #5 clk = ~clk;

    initial begin
        ui=2'b10;
        vi=16'b0000010000000000;
        #20 rst=1;
        #50 rst=0;
        #200 start=1'b1;
        #1000 start=1'b0;
	#4000 rdreq=1;
    	$stop;
    end

endmodule 