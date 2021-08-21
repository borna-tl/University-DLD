`timescale 1ns/1ns

module cnt4bit (input clk, rst, enc, zc, output Co, output reg[3:0] addr);
	always@ (posedge clk, posedge rst) begin
		if (rst)
			addr <= 4'b0;
		else if (zc)
			addr <= 4'b0;
		else if (enc)
			addr <= addr + 1;	
	end
	assign Co = &addr;
endmodule 

module mult (input [9:0] a, b, output [9:0] out);
	reg [19:0] temp;
  	integer i;
  	always@ (a, b) begin
    		temp = 0;
    		for (i = 0; i < 10; i = i + 1) begin
     		if (a[i])
        		temp = temp + (b << i);
      		end
    	end
    	assign out = {temp[17:16], temp[15:8]};

endmodule


module register10bit (input clk, rst, ld, init, input[9:0] parallel_in, output reg[9:0] parallel_out); 
	always@ (posedge clk, posedge rst) begin
		if (rst)
			parallel_out <= 10'b0;
		else if (ld)
			parallel_out <= parallel_in;
		else if (init)
			parallel_out <= 10'b0100000000;
	end
endmodule



module mux10bit (input[9:0] lut_in, x2_in, input s, output [9:0] out);
	assign out = s ? x2_in : lut_in;
endmodule


module adder (input [9:0] temp, res, input is_neg, output [9:0] w);
	assign w = is_neg ? (res + (~temp + 1'b1)): (res + temp);
endmodule

module cmp10bit (input [9:0] a, b, output GT);
	assign GT = a < b ? 1 : 0;
endmodule


module LUT(input [3:0] adr, output reg[7:0] out);
    always@ (adr) begin
        case (adr)
            0: out = 8'b10000000; // 1 / 2
            1: out = 8'b00010101; // 1 / 3 * 1 / 4
            2: out = 8'b00001000; // 1 / 5 * 1 / 6
            3: out = 8'b00000100; // 1 / 7 * 1 / 8
            4: out = 8'b00000010; // 1 / 9 * 1 / 10
            5: out = 8'b00000001; // 1 / 11 * 1 / 12
            6: out = 8'b00000001; // 1 / 13 * 1 / 14
            7: out = 8'b00000001; // 1 / 15 * 1 / 16
            8: out = 8'b00000000; // 1 / 17 * 1 / 18
            //from now on out = 0;
            default: out = 8'b00000000;
        endcase
    end
endmodule

module dp(input clk, rst, initr, initt, zc, ldx, s, ldt, enc, ldr, is_neg, input [9:0]x, input [7:0]y,
          output [9:0] res, output co, gt);
    wire [3:0] adr;
    wire [7:0] data;
    wire [9:0] mux_out, mult_out, temp_in, temp_out, res_in, x2;
    cnt4bit cnt_(clk, rst, enc, zc, co, adr);
    //LUT lut_(adr, data);
    rom_with_ali final_rom_(adr, ~clk, data);
    mux10bit mux_({2'b00, data}, x2, s, mux_out);
    mult mult1_(mux_out, temp_out, temp_in);
    mult mult2_(x, x, mult_out);
    register10bit regx2(clk, rst, ldx, 1'b0, mult_out, x2);
    register10bit rtemp(clk, rst, ldt, initt, temp_in, temp_out);
    register10bit rres(clk, rst, ldr, initr, res_in, res);
    adder add(temp_out, res, is_neg, res_in);
    cmp10bit cmp(temp_in, {2'b00, y}, gt);
endmodule





