`timescale 1ns/1ns


module controller_org (input clk, sin, rst, output logic [3:0]P, output logic Outvalid, output logic Error, output logic[8:0] flag, output logic [1:0] cur_step, output logic [7:0] out_shift, output logic co3bflag);
 	logic [1:0] ns, ps;
	logic co3b, co9b, en3b, en9b, ensh, endemux;
	wire [7:0] shifter_out;
	wire [2:0] cnt3;
	wire [8:0] cnt9;
	wire [8:0] compliment_out;
	logic [8:0] comp_inp;
	logic [7:0] shift_inp;
	parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;  
	always @(ps, co3b, co9b, sin, en3b, en9b, ensh, endemux) begin
		Outvalid = 0;
		en3b = 0;
		en9b = 0;
		ensh = 0;
		endemux = 0;
		Error = 1'b0;
		ns = A;
		case (ps)
			A: begin ns = sin ? A : B; end
			B: begin en3b = 1; ensh = 1; ns = co3b ? C : B; end
			C: begin Outvalid = 1'b1; endemux = 1; en9b = 1; ns = co9b ? D : C; end
			D: begin ns = sin ? A : D; Error = ~sin; end
			default: ns = A;
		endcase
	end
	cnt3b m1(clk, en3b, rst, cnt3, co3b);
	shift_register m2(clk, sin, ensh, rst, shifter_out);
	complementar m3(shift_inp[7:2], compliment_out);
	cnt9b m4(comp_inp, clk, en9b, rst, co3b, cnt9, co9b);
	demux m5(shift_inp[1:0], sin, endemux, P);
	always@ (posedge clk, posedge rst) begin
		if(rst)
			ps <= A;	
		else
			ps <= ns;
	end
	assign cur_step = ps;
	assign comp_inp = compliment_out;
	assign shift_inp = shifter_out;
	//assign out_shift = co3b ? shifter_out : 8'bz;
	assign out_shift = shifter_out;
	assign flag = compliment_out;
	assign co3bflag = co3b;
endmodule

