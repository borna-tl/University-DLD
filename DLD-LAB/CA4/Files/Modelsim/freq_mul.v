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


module freq_datapath(input clk, rst, infreq, ld_cnt, cnt_en, kcount, [2:0]n, output reg kc, outfreq, [7:0]k);

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
    assign T = (count << 1);
    assign k = T >> n;
    reg cout;
    assign cout = &{duration};
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


module freq_multiplier(input clk, rst, infreq, adjust, [2:0]n, output outfreq, valid, [7:0]k);

    wire kc, ld_cnt, cnt_en, kcount;

    freq_controller my_controller(clk, rst, kc, adjust, valid, ld_cnt, cnt_en, kcount);

    freq_datapath my_datapath(clk, rst, infreq, ld_cnt, cnt_en, kcount, n, kc, outfreq, k);

endmodule



module mul_tb();
	
	reg ref_clk = 1'b0, rst = 1'b0, inFreq = 1'b0, adjust = 1'b0;
    	reg [2:0] n = 3'd3;
    	wire outFreq, valid;
    	wire [7:0] k;
	
    	freq_multiplier cut(ref_clk, rst, inFreq, adjust, n, outFreq, valid, k);
	
    	initial repeat (10000) #(2500) ref_clk = ~ref_clk; //200MHz refrence clock
	
    	initial repeat (10000) #(250000) inFreq = ~inFreq; //50MHz sample frequency
	
    	initial begin	
    	    	#200 rst=1'b1;
    	    	#100 rst=1'b0;
    	    	#20 adjust=1'b1;
   	    	#5000 adjust=1'b0;
   	 end
endmodule





/*module controller (input clk, rst, adjust, inFreq, output reg valid, ld_reg);
	parameter [2:0] idle = 3'b000, ready = 3'b001, set = 3'b010, div_a = 3'b011, div_b = 3'b100, count = 3'b101;
	reg [2:0] ps, ns;
	reg inFreq_prev;
	always @(ps, adjust) begin
		ns = 3'b000;
		{valid, ld_reg} = 2'b00;
		case(ps)
			idle: begin ns = adjust ? ready : idle; end
			ready: begin ld_reg = 1'b1; ns = adjust ? ready : set; end
			set: begin ns = div_a; end
			div_a: begin ns = div_b; end
			div_b: begin ns = count; end
			count: begin valid = 1'b1; ns = adjust ? ready : count; end
		endcase 
	end
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			ps <= idle;
		end
		else begin
			ps <= ns;
		end
	end
endmodule

module shifter (input clk, input[2:0] n, input[7:0] inp, output reg [7:0] out);
	assign out = inp >> n;
endmodule

module register (input clk, rst, ld, inFreq, output[7:0] out);
	reg[7:0] data, data2;
	always@(posedge clk, posedge rst) begin
		if (rst)
			data <= 8'd0;
		else
			data <= data + 1'b1;
	end
	always@ (posedge inFreq) begin
		data <= 8'd0;
	end
	assign data2 = ld ? data : data2;
	assign out = data2;
endmodule

module divider(input clk, rst, inFreq, output [7:0] outFreq); 
	reg [7:0] data = 8'd0;
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			data <= 8'd0;
		end
		else
			data <= data + 1;
	end

	always @(posedge inFreq) begin
		data <= 8'b0;
	end
	assign outFreq = data;

endmodule

module cnt8b (input clk, rst, input[7:0] inp, output reg co);
	reg[7:0] out;
	always @(posedge clk, posedge rst) begin
		if (rst)
			out <= 8'd0;
		else if (out > 8'd254)
			out <= inp;
		else 
			out <= out + 1;
     	end
	assign co = &{out};

endmodule

module datapath(input clk, rst, ld_reg, input[2:0] n, input inFreq, output outFreq);
	wire [7:0] out, shifted_out, reg_out;
	divider my_divider(clk, rst, inFreq, out);
	shifter my_shifter (.clk(clk), .n(n), .inp(out), .out(shifted_out));
	register my_reg(clk, rst, ld_reg, inFreq, reg_out);
	cnt8b my_cnt (clk, rst, reg_out, outFreq);

endmodule

module multiplier(input clk, rst, adjust, input[2:0] n, input inFreq, output valid, output outFreq);
	wire en_cnt, co, ld_reg;
	controller CONTROLLER(clk, rst, adjust, inFreq, valid, ld_reg);
	datapath DATAPATH(clk, rst, ld_reg, n, inFreq, co);
	assign outFreq = co;

endmodule

module mul_tb();

	wire outFreq;
	//reg[2:0] n = 3'd1;
	reg[2:0] n = 3'd2;
	reg inFreq = 1'b0, ref_clk = 1'b1, rst = 1'b1, adjust = 1'b0;
  	wire valid;
	//always #50 inFreq = ~inFreq; //sample frequency = 10MHz
	always #100 inFreq = ~inFreq; //sample frequency = 5MHz
	always #5 ref_clk = ~ref_clk; //refrence clock with frequency = 100MHz

	multiplier my_mul (.clk(ref_clk), .rst(rst), .adjust(adjust), .n(n), .inFreq(inFreq), .valid(valid), .outFreq(outFreq));

	

endmodule
*/