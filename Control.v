module control_single( RegDst, ALUOP, ALUSrc, Branch, MemRead, MemWrite, Regwrite, MemToReg, Jump, opcode, Sign ) ;
    input [5:0]opcode ;
    output reg RegDst, ALUSrc, Branch, MemRead, MemWrite, Regwrite, MemToReg, Jump, Sign ;
	output reg [1:0]ALUOP ;

    parameter R_FORMAT = 6'd0 ;
    parameter LW = 6'd35 ;
    parameter SW = 6'd43 ;
    parameter BEQ = 6'd4 ;
	parameter J = 6'd2 ;
	parameter ANDI = 6'd12;
	
    always @( opcode ) begin
        case ( opcode )
          R_FORMAT : 
          begin
              RegDst = 1'b1 ; ALUOP = 2'b10 ; ALUSrc = 1'b0; Branch = 1'b0 ; Sign = 1'b1;
              MemRead = 1'b0 ; MemWrite = 1'b0 ; Regwrite = 1'b1 ; MemToReg = 1'b0 ; Jump = 1'b0 ;
          end
          LW :
          begin
              RegDst = 1'b0 ; ALUOP = 2'b00 ; ALUSrc = 1'b1 ; Branch = 1'b0 ; Sign = 1'b1;
              MemRead = 1'b1 ; MemWrite = 1'b0 ; Regwrite = 1'b1 ; MemToReg = 1'b1 ; Jump = 1'b0 ;
          end
          SW :
          begin
              RegDst = 1'bx ; ALUOP = 2'b00 ; ALUSrc = 1'b1 ; Branch = 1'b0 ; Sign = 1'b1;
              MemRead = 1'b0 ; MemWrite = 1'b1 ; Regwrite = 1'b0 ; MemToReg = 1'bx ; Jump = 1'b0 ;
          end
          BEQ :
          begin
              RegDst = 1'bx ; ALUOP = 2'b01 ; ALUSrc = 1'b0 ; Branch = 1'b1 ; Sign = 1'b1;
              MemRead = 1'b0 ; MemWrite = 1'b0 ; Regwrite = 1'b0 ; MemToReg = 1'bx ; Jump = 1'b0 ;
          end
          J :
          begin
              RegDst = 1'bx ; ALUOP = 2'b0x ; ALUSrc = 1'b0 ; Branch = 1'b0 ; Sign = 1'b1;
              MemRead = 1'bx ; MemWrite = 1'bx ; Regwrite = 1'bx ; MemToReg = 1'bx ; Jump = 1'b1 ;
          end
          ANDI :
          begin
              RegDst = 1'b0 ; ALUOP = 2'b11 ; ALUSrc = 1'b1 ; Branch = 1'b0 ; Sign = 1'b0;
              MemRead = 1'b0 ; MemWrite = 1'b0 ; Regwrite = 1'b1 ; MemToReg = 1'b0 ; Jump = 1'b0 ;
          end
          default
          begin
              $display("control_single unimplemented opcode %d", opcode);
              RegDst = 1'bx ; ALUOP = 2'bxx ; ALUSrc = 1'bx ; Branch = 1'bx ; Sign = 1'bx;
              MemRead = 1'bx ; MemWrite = 1'bx ; Regwrite = 1'bx ; MemToReg = 1'bx ; Jump = 1'bx ;
          end

        endcase
    end
endmodule