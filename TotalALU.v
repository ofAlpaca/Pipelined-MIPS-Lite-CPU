module TotalALU( Output, dataA, dataB, signal, Zero, shamt );
	input [31:0] dataA ;
	input [31:0] dataB ;
	input [2:0] signal ;
	input [4:0] shamt ;
	output [31:0] Output ;
	output Zero;

	wire [31:0] ALUOut, ShifterOut, Ex_shamt ;

	assign Ex_shamt = { 27'd0, shamt };
	
	ALU32 ALU32( .result(ALUOut), .dataA(dataA), .dataB(dataB), .signal(signal), .zero(Zero) );
	Shifter Shifter( .out(ShifterOut), .B(Ex_shamt), .A(dataB) );
	
	assign Output = ( signal == 3'b101 )? ShifterOut : ALUOut;

endmodule