module memwb( RegWriteO, MemtoRegO, DataMemRDO, ALUResultO, WNO,
	      RegWriteI, MemtoRegI, DataMemRDI, ALUResultI, WNI, clk );
	output reg RegWriteO, MemtoRegO;
	input RegWriteI, MemtoRegI, clk;
	output reg [31:0] DataMemRDO, ALUResultO;
	input [31:0] DataMemRDI, ALUResultI;
	output reg [4:0] WNO;
	input [4:0] WNI;

	always@(posedge clk) begin
		RegWriteO <= RegWriteI;
		MemtoRegO <= MemtoRegI;
		DataMemRDO <= DataMemRDI;
		ALUResultO <= ALUResultI;
		WNO <= WNI;
	end
endmodule
