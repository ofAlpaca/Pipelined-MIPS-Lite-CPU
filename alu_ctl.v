module alu_ctl(ALUOp, Funct, ALUOperation, JumpReg, DIVOperation, HILOOperation, clk);
    input [1:0] ALUOp;
    input [5:0] Funct;
	input clk;
    output [2:0] ALUOperation;
	output [1:0] HILOOperation;
	output DIVOperation;
	output JumpReg;
	reg		DIVOperation;
	reg	   [1:0]HILOOperation;
	reg		JumpReg;
    reg    [2:0] ALUOperation;
	reg	   [5:0] counter;

	parameter F_sll = 6'd0;
	parameter F_jr = 6'd8;
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	parameter F_divu = 6'd27;
	parameter F_mfhi = 6'd16;
	parameter F_mflo = 6'd18;

    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
	parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b011;
    parameter ALU_slt = 3'b100;
	parameter ALU_sll = 3'b101;

    always @(ALUOp or Funct)
    begin
        case (ALUOp) 
            2'b00 : ALUOperation = ALU_add;
            2'b01 : ALUOperation = ALU_sub;
			2'b11 : ALUOperation = ALU_and; //  強制AND
            2'b10 : case (Funct) 
                        F_add : ALUOperation = ALU_add;
                        F_sub : ALUOperation = ALU_sub;
                        F_and : ALUOperation = ALU_and;
                        F_or  : ALUOperation = ALU_or;
                        F_slt : ALUOperation = ALU_slt;
						F_sll : ALUOperation = ALU_sll;
						F_jr : ALUOperation = ALU_add;
                        default ALUOperation = 3'bxxx;
                    endcase
            default ALUOperation = 3'bxxx;
        endcase
		
		if(Funct == F_divu) begin
			DIVOperation = 1'b1;
			counter = 6'd0;
		end
			
		if(Funct == F_mfhi)
			HILOOperation = 2'b00;
		else if(Funct == F_mflo)
			HILOOperation = 2'b01;
		else
			HILOOperation = 2'b10;
		
		
		if( Funct == F_jr ) 
			JumpReg = 1'b1;
		else
			JumpReg = 1'b0;
    end
	
	always @( posedge clk )
	begin
		if(DIVOperation)
			counter = counter + 1;
			
		if(counter == 6'd33) begin
			counter = 6'd0;
			DIVOperation = 1'b0;
		end
	end
endmodule

