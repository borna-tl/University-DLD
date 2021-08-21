module DDS(input clk, rst, ld, input[7:0] phaseCntrl, output reg [7:0] out);
   	wire[7:0] pIn;

    	always @(posedge clk, posedge rst) begin
        	if(rst) out <= 8'd0;
        	else if(ld) out <= pIn%256;
    	end

	assign pIn = out + phaseCntrl;
endmodule
