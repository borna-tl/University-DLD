`timescale 1ns/1ns

module clock_monitor(input clk, rst, ro_external, input[7:0] FRO_MIN, PSI_MIN, PSI_MAX, PSI_SET, output [7:0] SET_PERIOD, output reg FAIL);
	assign SET_PERIOD = (PSI_SET < PSI_MAX) ? PSI_MAX : (PSI_SET > PSI_MIN) ? PSI_MIN : PSI_SET; 
	reg [15:0] data_flag;
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			data_flag <= 15'd0;
		end
		else
			data_flag <= data_flag + 1;
	end

	always @(posedge ro_external) begin
		data_flag <= 15'd0;
		if (data_flag > FRO_MIN * 6)
			FAIL <= 1'b1;
		else
			FAIL <= 1'b0;
	end
	
endmodule
