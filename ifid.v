module ifid( PCout, InstructionOut, clk, PCin, InstructionIn );
	output reg [31:0] PCout, InstructionOut;
	input[31:0] PCin, InstructionIn;
	input clk;

	always@(posedge clk) begin
		PCout <= PCin;
		InstructionOut <= InstructionIn;
	end
endmodule
