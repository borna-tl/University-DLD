`timescale 1ns/1ns
module controller(input clk, rst, start, co, gt, output logic done, initr, initt, zc, ldx, s, ldt, enc, ldr, is_neg, output [2:0] ps_flag);
	logic [2:0] ps, ns;
    	parameter [2:0] IDLE = 3'b000, INITIAL = 3'b001, BEGIN = 3'b010, MULT1 = 3'b011, MULT2 = 3'b100, ADD = 3'b101;
	always @(ps, co, start, gt) begin
      		ns = IDLE;
      		{done, initr, initt, zc, ldx, s, ldt, enc, ldr} = 9'b000000000;
      	case(ps)
        	IDLE: begin
          		ns = start ? INITIAL : IDLE;
          		done = 1'b1;
			is_neg = 1'b0;
        	end
        	INITIAL: ns = start ? INITIAL : BEGIN;
        	BEGIN: begin
          		ns = MULT1;
          		{initr, initt, zc, ldx} = 4'b1111;
        	end
        	MULT1: begin
          		ns = MULT2;
          		s = 1'b0;
          		ldt = 1'b1;
        	end
        	MULT2: begin
          		ns = gt ? IDLE : ADD;
          		{s, ldt} = 2'b11;
        	end
        	ADD: begin
          		ns = co ? IDLE : MULT1;
          		{enc, ldr} = 2'b11;
			is_neg = ~is_neg;
        	end
	endcase
    	end
	always@ (posedge clk, posedge rst) begin
		if (rst)
			ps <= IDLE;
		else
			ps <= ns;
	end
	assign ps_flag = ps;
endmodule



module controller_TB();
	logic clk = 0, rst = 0, start = 0, co = 0, gt = 0;
  	wire done, initr, initt, zc, ldx, s, ldt, enc, ldr;
  	wire [2:0] ps;
  	controller CUT (clk, rst, start, co, gt, done, initr, initt, zc, ldx, s, ldt, enc, ldr, ps);
  	always #50 clk = ~clk;
    	initial begin
	#60 start=1;
    	#101 start=0;
    	#1601 gt=1;
    	#60 start=1;
    	#60 start=0;gt=0;
    	#801 co=1;
    	#201 $stop;
     	end
endmodule
