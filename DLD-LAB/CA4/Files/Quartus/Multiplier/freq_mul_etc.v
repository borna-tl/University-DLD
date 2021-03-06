`timescale 1ps/1ps

module freq_controller (input clk, rst, kc, adjust, output reg valid, ld_cnt, cnt_en, k_count);

    reg [2:0] ps, ns;
    parameter [2:0] idle = 0, ready = 1, cal_k = 2, ld = 3, cal_f = 4;

    always @(adjust, kc) begin
        ns = idle;
        {valid, ld_cnt, cnt_en, k_count} = 4'b0000;
        case (ps)
            idle: ns = (adjust)? ready : idle;
            ready: ns = (adjust)? ready : cal_k;
            cal_k: begin k_count = 1'b1; ns = (kc) ? ld : cal_k; end
            ld: begin valid = 1'b1; ld_cnt = 1'b1; ns = cal_f; end
            cal_f: begin valid = 1'b1; cnt_en = 1'b1; ns = (adjust) ? ready : cal_f; end
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= idle;
        else
            ps <= ns;
    end

endmodule


module freq_datapath(input clk, rst, infreq, ld_cnt, cnt_en, kcount, input [2:0]n, output reg kc, outfreq, output reg [7:0]k);

    reg[7:0] duration, count;
    reg prev;

    always @(posedge clk, posedge rst) begin
        if(rst)
            count <= 8'd1;
        else begin
            if(kcount == 1'b0) //don't count
                count <= count;
            else begin
            case ({prev, infreq})
                2'b00: count <= count;
                2'b01: count <= count;
                2'b10: count <= count;
                2'b11: count <= count + 8'd1;
            endcase
            end
        end
    end

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            prev <= 1'b0;
            outfreq <= 1'b0;
        end
        else begin
            prev <= infreq;
			end
    end

    always @(posedge clk, posedge rst) begin
        if({prev, infreq} == 2'b10)begin //done counting
            kc <= 1'b1;
        end
        else if ({prev, infreq}==2'b01) begin //can count
            kc <= 1'b0;
        end
    end

    reg [7:0] T;
    T = (count << 1);
    k = T >> n;
    reg cout;
    cout = &{duration};
    always @(posedge cout) begin
       outfreq <= ~outfreq; 
    end

    always @(posedge clk, posedge rst) begin
        if(ld_cnt)            
            duration <= 8'b11111111 - (count >> n);
        else begin
            if(cout)
                duration <= 8'b11111111 - (count >> n);
            else begin
            if(cnt_en)
                duration <= duration + 8'b00000001;
            else 
                duration <= duration; 
            end
        end
        
    end

endmodule
