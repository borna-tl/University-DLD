`timescale 1ns/1ns
module controller(input CLK, RST, UXRX, ABAUD, CO, output reg UXRXIF, LD_EN, CNT_EN, CNT_RST, C3_LD, C3_EN);
	parameter [2:0] idle = 3'b000, init = 3'b001, set = 3'b010, high_edge = 3'b011, low_edge = 3'b100, halt = 3'b101;
	reg [2:0] ps, ns;
	always @(ps, ABAUD, UXRX, CO) begin
		ns = 3'b000;
		{UXRXIF, CNT_RST, C3_LD, CNT_EN, C3_EN, LD_EN} = 6'b000000;
		case(ps)
			idle: begin UXRXIF = 1'b0; ns = ABAUD ? init : idle; end
			init: begin CNT_RST = 1'b1; ns = UXRX ? init : set; end
			set: begin C3_LD = 1'b1; ns = UXRX ? high_edge : set; end
			high_edge: begin CNT_EN = 1'b1; C3_EN = 1'b1; ns = CO ? halt : UXRX ? high_edge : low_edge; end
			low_edge: begin C3_EN = 1'b1; ns = UXRX ? high_edge : low_edge; end
			halt: begin LD_EN = 1'b1; UXRXIF = 1'b1; ns = idle; end //nmd ABAUD 0 SHE YA NA
		endcase 
	end
	always @(posedge CLK, posedge RST) begin
		if (RST)
			ps <= idle;
		else
			ps <= ns;
	end
endmodule

module cnt3b (input clk, en, ld, input [2:0]inp, output reg [2:0]out, output co);
	always @(posedge clk) begin
		if (ld)
			out <= inp;
		else if (en)
			out <= out + 1;
	end
	assign co = &{out, ~ld};
endmodule

module reg8b (input clk, rst, en, input [7:0] inp, output reg [7:0] out);
	always@ (posedge clk, posedge rst) begin
		if (rst) 
			out <= 8'b00000000;
		else if (en)
			out <= inp;
	end
endmodule

module cnt8b (input clk, en, rst, output reg [7:0] out, output co);
	always @(posedge clk, posedge rst) begin
		if (rst)
			out <= 8'b00000000; //aval 7bit
        	else if (en)
			out <= out + 1;
     	end
    	assign co = &{out, ~rst}; //aval rst ndsh
endmodule

module datapath(input clk, ld_en, cnt_en, cnt_rst, c3_ld, c3_en, UXRX, output co3, output [7:0] N);
	wire co8;
	wire [7:0] cnt8;
	wire [2:0] cnt3;
	cnt8b BRG_Counter(clk, cnt_en, cnt_rst, cnt8, co8); 
	reg8b BRG_Reg(clk, 1'b0, ld_en, cnt8, N); 
	cnt3b counter(UXRX, c3_en, c3_ld, 3'b011, cnt3, co3);
endmodule


