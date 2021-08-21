`timescale 1ns/1ns
module cmp8(input [0:7]a, b, input eq, gt, output EQ, GT);
	wire [0:8] gt_wires, eq_wires;
	assign gt_wires[8] = gt;
	assign eq_wires[8] = eq;
	genvar i;
	generate
		for(i = 7; i >= 0; i = i - 1) begin:BCS_GATES
			BCS mybcs(.a(a[i]), .b(b[i]), .eq(eq_wires[i+1]), .gt(gt_wires[i+1]),
				 .EQ(eq_wires[i]), .GT(gt_wires[i]));
		end
	endgenerate
	assign EQ = eq_wires[0];
	assign GT = gt_wires[0];
endmodule

