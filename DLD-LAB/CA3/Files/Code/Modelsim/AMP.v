module AMP(input [1:0] divisor, input [7:0] inp, output [7:0] out);
    assign out = inp >> divisor;
endmodule
