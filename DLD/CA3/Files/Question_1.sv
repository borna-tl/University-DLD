`timescale 1ns/1ns
module TCS(input [1:0]a, b, input eq, gt, output logic EQ, GT);
	always@(a, b, eq, gt) begin 
		#20
		//EQ = eq&(a[0]~^b[0])&(a[1]~^b[1]);
		//GT = (((a[1]~^b[1])&~b[0]&a[0])|(~b[1]&a[1]))&eq)|gt;
		EQ = ((a[1] ~^ b[1]) & (a[0] ~^ b[0])) & eq;
        	GT = ((a[1] & ~b[1]) | (a[0] & ~b[1] & ~b[0]) | (a[1] & a[0] & ~b[0])) | gt;
	end
endmodule
