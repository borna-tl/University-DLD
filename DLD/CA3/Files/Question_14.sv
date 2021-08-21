`timescale 1ns/1ns

module AbsDiffBehavioral (input [7:0]reff, [7:0]data, output logic [7:0]diff);
	always@(reff, data) begin
		if(reff < data)
			diff = data - reff;
		else
			diff = reff - data;
	end
endmodule


module LessDistanceBehavioral (input [7:0]refI, [7:0]dataA, [7:0]dataB, output logic [7:0]diff);
	wire [7:0] diffA, diffB;
	AbsDiffBehavioral A_diff(refI, dataA, diffA);
	AbsDiffBehavioral B_diff(refI, dataB, diffB);
	always@(refI, dataA, dataB, diffA, diffB, diff) begin
		if (diffA > diffB)
			diff = dataB;
		else
			diff = dataA;
	end
endmodule







