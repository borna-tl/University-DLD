`timescale 1ns/1ns


module TB();
 	logic sin = 0, clk = 0, rst = 1;
	wire[3:0] p_org, p_new;
	wire outvalid_org, outvalid_new, error_org, error_new, CO3BFLAG_org, CO3BFLAG_new;
	wire[1:0] cur_org, cur_new;
	wire[7:0] shift_out_org, shift_out_new;
	wire[8:0] fl_org, fl_new;
	controller_org CUT1(clk, sin, rst, p_org, outvalid_org, error_org, fl_org, cur_org, shift_out_org, CO3BFLAG_old);
	controller CUT2(clk, sin, rst, p_new, outvalid_new, error_new, fl_new, cur_new, shift_out_new, CO3BFLAG_new);

	always #51 clk = ~clk;
	initial begin
    		#100 rst = 0;
    		#160 sin = 1;
		//#800 sin = 0;
    		#260 sin = 0;
		#2300
		#300 //0001100
		#1000 sin = 1;
		#60
		$stop;
 	end

endmodule
