`timescale 1ns/1ns
module SyncCount_TB();
	wire out[7:0];
  	reg DN = 1'b1, preset = 1'b0;
  	wire CO, CLK, CLK_TFF;
  	ring_oscillator #(1, 5) CLK_CUT(1'b0, CLK);
  	//syncsync sync_cnt(.MSBA(1'b0), .MSBB(1'b0), .MSBC(1'b0), .MSBD(1'b1), .LSBA(1'b0), .LSBB(1'b1), .LSBC(1'b1), .LSBD(1'b1)
        //                , .MSBQA(out[4]), .MSBQB(out[5]), .MSBQC(out[6]), .MSBQD(out[7]), .LSBQA(out[0])
        //               , .LSBQB(out[1]), .LSBQC(out[2]), .LSBQD(out[3]), .MSBCO(CO), .LSBUP(CLK), .LSBDN(DN), .PRESET(preset));
	symsym_tff sync_cnt(.MSBA(1'b0), .MSBB(1'b0), .MSBC(1'b0), .MSBD(1'b1), .LSBA(1'b0), .LSBB(1'b1), .LSBC(1'b1), .LSBD(1'b1)
                        , .MSBQA(out[4]), .MSBQB(out[5]), .MSBQC(out[6]), .MSBQD(out[7])
			, .LSBQA(out[0]), .TFFOUT(CLK_TFF)
                        , .LSBQB(out[1]), .LSBQC(out[2]), .LSBQD(out[3])
			, .MSBCO(CO), .LSBUP(CLK), .LSBDN(DN), .PRESET(preset));
	initial begin
    	#50 preset = 1'b1;
    	#50000 $stop;
  	end
endmodule
