`timescale 1ns/1ns
module cmp8tbc(input [0:7]a, b, input eq, gt, output EQ, GT);
	wire [0:4] gt_wires, eq_wires;
	assign gt_wires[4] = gt;
	assign eq_wires[4] = eq;
	genvar i;
	generate
		for(i = 7; i > 0; i = i - 2) begin:TBC_GATES
			TCS mytbc(.a1(a[i]), .a0(a[i-1]), .b1(b[i]), .b0(b[i-1]),
			 .eq(eq_wires[(i+1)/2]), .gt(gt_wires[(i+1)/2]),
			 .EQ(eq_wires[(i-1)/2]), .GT(gt_wires[(i-1)/2]));
		end
	endgenerate
	assign EQ = eq_wires[0];
	assign GT = gt_wires[0];
endmodule

