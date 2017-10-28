module idex(RegWriteO, MemtoRegO, MemReadO, MemWriteO, BranchO, ALUOpO, RegDstO, ALUSrcO, PCO, RD1O, RD2O, EXTNDEDImmO, rtO, rdO, functO, shamtO,
	    RegWriteI, MemtoRegI, MemReadI, MemWriteI, BranchI, ALUOpI, RegDstI, ALUSrcI, PCI, RD1I, RD2I, EXTNDEDImmI, rtI, rdI, functI, shamtI, clk);
		
	output reg RegWriteO, MemtoRegO, MemReadO, MemWriteO, BranchO, RegDstO, ALUSrcO;
	input RegWriteI, MemtoRegI, MemReadI, MemWriteI, BranchI, RegDstI, ALUSrcI, clk;
	output reg [1:0] ALUOpO;
	input [1:0] ALUOpI;
	output reg [31:0] PCO, RD1O, RD2O, EXTNDEDImmO;
	input [31:0] PCI, RD1I, RD2I, EXTNDEDImmI;
	output reg [4:0] rtO, rdO;
	input [4:0] rtI, rdI;
	output reg [5:0]functO;
	input [5:0]functI;
	output reg [4:0]shamtO;
	input [4:0]shamtI;

	always@(posedge clk) begin
		RegWriteO <= RegWriteI;
		MemtoRegO <= MemtoRegI;
		MemReadO <= MemReadI;
		MemWriteO <= MemWriteI;
		BranchO <= BranchI;
		RegDstO <= RegDstI;
		ALUSrcO <= ALUSrcI;
		ALUOpO <= ALUOpI;
		PCO <= PCI;
		RD1O <= RD1I;
		RD2O <= RD2I;
		EXTNDEDImmO <= EXTNDEDImmI;
		rtO <= rtI;
		rdO <= rdI;
		functO <= functI;
		shamtO <= shamtI;
	end
endmodule
