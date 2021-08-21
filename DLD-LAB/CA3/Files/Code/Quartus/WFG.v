module WFG(input [2:0] func, input clk, rst, output [7:0] wave);
    reg [7:0] count, rhomboid, rhomboidline, square, reciprocal, triangle, full_wave, half_wave, modulated;
    reg signed [15:0] sin, cos;
    always @(posedge clk, posedge rst) begin
        if(rst) count <= 8'd0;
        else count <= count + 1;
    end

    always@(count) begin //calculating continuous rhomboid
        rhomboidline = 8'd0;
        if(count <= 127) rhomboidline = count;
        else rhomboidline = 255 - count;
    end

    always @(count, rhomboidline) begin
        rhomboid = 8'd0;
        if(count[0] == 1'b0) rhomboid = rhomboidline + 127;
        else rhomboid = -rhomboidline + 127;
    end

    always @(count) begin
        square = 8'd0;
        if(count <= 127) square = 8'd255;
    end

    always @(count) begin
        reciprocal = 256/(256 - count) - 1;
    end

    always @(count) begin
        if(count <= 127) triangle = count << 1;
        else triangle = (255 - count) << 1; 
    end

    always@(posedge clk, posedge rst) begin
        if(rst) begin
            sin <= 16'd0;
            cos <= 16'd30000;
        end
        else begin
		sin <= sin + (cos >>> 6);
            	cos <= cos - (sin >>> 6);
        end
    end

    always @(sin) begin
        if(sin >= 0)
		full_wave = (sin[15:8]) + 8'd127;
        else 
		full_wave = -(sin[15:8]) + 8'd127; 
	half_wave = (sin >= 0) ? full_wave : 8'd127;
    end

    /*always @(sin) begin
        half_wave = 8'd127;
        if(sin >= 0) half_wave = (sin[15:8]) + 127;     
    end*/

    always @(sin) begin
        modulated = 8'd0;
        if(count[3] == 0) modulated = sin[15:8] + 127;
        else modulated = -(sin[15:8]) + 127;
    end
    
    assign wave = (func == 0) ? rhomboid :
                  (func == 1) ? square :
                  (func == 2) ? reciprocal :
                  (func == 3) ? triangle :
                  (func == 4) ? full_wave :
                  (func == 5) ? half_wave :
                  (func == 6) ? modulated :
                  8'bz;
endmodule
