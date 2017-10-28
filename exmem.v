module exmem( RegWriteO, MemtoRegO, MemReadO, MemWriteO, BranchO, PCO, zeroO, ALUtoDataMemAddrO, RD2toDataMemWDO, WNO, jrO, 
	      RegWriteI, MemtoRegI, MemReadI, MemWriteI, BranchI, PCI, zeroI, ALUtoDataMemAddrI, RD2toDataMemWDI, WNI, jrI, clk );
		  
	output reg RegWriteO, MemtoRegO, MemReadO, MemWriteO, BranchO, zeroO;
	input RegWriteI, MemtoRegI, MemReadI, MemWriteI, BranchI, zeroI, clk;
	output reg [31:0] PCO, ALUtoDataMemAddrO, RD2toDataMemWDO;
	input [31:0] PCI, ALUtoDataMemAddrI, RD2toDataMemWDI;
	output reg [4:0] WNO;
	input [4:0] WNI;
	output reg jrO;
	input jrI;

	always@( posedge clk ) begin
		RegWriteO <= RegWriteI;
		MemtoRegO <= MemtoRegI;
		MemReadO <= MemReadI;
		MemWriteO <= MemWriteI;
		BranchO <= BranchI;
		zeroO <= zeroI;
		PCO <= PCI;
		ALUtoDataMemAddrO <= ALUtoDataMemAddrI;
		RD2toDataMemWDO <= RD2toDataMemWDI;
		WNO <= WNI;
		jrO <= jrI;
	end
endmodule
