`timescale 1ns/1ns

module regulator(input clk, rst, PSI, input[7:0] setPeriod, output reg [7:0] adjustedDiv);
	reg PSI_CURR, flag_fall, flag_rise, flag_done;
	reg [15:0] data;
	always @(posedge clk, posedge rst) begin: do_something
		if(rst)
			PSI_CURR <= 1'b0;
		else begin
			case({PSI_CURR, PSI})
				2'b01: begin data <= 8'b00000000; end
				2'b11: begin data <= data + 1; end
			endcase
			PSI_CURR <= PSI;
		end
	end
	always @(PSI) begin: comparison
		{flag_rise, flag_fall} <= 2'b00;
		if(PSI_CURR && ~PSI) begin: hey
			if (data > setPeriod)
				flag_rise <= 1'b1;
			else if (data < setPeriod)
				flag_fall <= 1'b1;
			else
				flag_done <= 1'b1;
		end
	end
	always @(posedge clk, posedge rst) begin: inc_dec
		if(rst)
			adjustedDiv <= 8'd127;
		else if(PSI_CURR && ~PSI) begin
			if (flag_fall)
				adjustedDiv <= adjustedDiv - 1;
			else if (flag_rise)
				adjustedDiv <= adjustedDiv + 1;
		end
	end


endmodule
