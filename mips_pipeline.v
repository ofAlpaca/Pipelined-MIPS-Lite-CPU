module mips_pipeline( clk, rst );
	input clk, rst;
	
	wire[31:0] IF_instr, ID_instr;
	
	wire [5:0] ID_opcode, ID_funct, EX_funct;
    wire [4:0] ID_rs, ID_rt, ID_rd, ID_shamt, EX_shamt,  EX_rt, EX_rd;
    wire [15:0] ID_immed;
    wire [31:0] sign_ext_imm, unsign_ext_imm, ID_extend_immed, EX_extend_immed, b_offset;
    wire [25:0] jumpoffset;
	
    wire [4:0] EX_rfile_wn, MEM_rfile_wn, WB_rfile_wn;
    wire [31:0] ID_rfile_rd1, EX_rfile_rd1, ID_rfile_rd2, EX_rfile_rd2, MEM_rfile_rd2, WB_rfile_wd, EX_alu_b, EX_alu_out, MEM_alu_out, WB_alu_out, pc_next,
                pc, MEM_dmem_rdata, WB_dmem_rdata,  jump_addr, branch_addr;
	wire [31:0] IF_pc_incr, jr_pc_incr, ID_pc_incr, EX_pc_incr, EX_b_tgt, MEM_b_tgt;
	wire [31:0] HI_MUX, LO_MUX, ALU_MUX;

    wire ID_RegWrite, EX_RegWrite, MEM_RegWrite, WB_RegWrite, ID_Branch, EX_Branch, MEM_Branch,  PCSrc, ID_RegDst, EX_RegDst, ID_MemtoReg, EX_MemtoReg, MEM_MemtoReg, WB_MemtoReg;
	wire ID_MemRead, EX_MemRead, MEM_MemRead, ID_MemWrite, EX_MemWrite, MEM_MemWrite, ID_ALUSrc, EX_ALUSrc, EX_Zero, MEM_Zero, Jump, ID_sign, EX_jr, MEM_jr;
    wire [1:0] ID_ALUOp, EX_ALUOp;
    wire [2:0] Operation;
	wire DIVOp;
	wire [1:0]HILOOp;
	wire [63:0] DivAns ;
	
    assign ID_opcode = ID_instr[31:26];
    assign ID_rs = ID_instr[25:21];
    assign ID_rt = ID_instr[20:16];
    assign ID_rd = ID_instr[15:11];
    assign ID_shamt = ID_instr[10:6];
    assign ID_funct = ID_instr[5:0];
    assign ID_immed = ID_instr[15:0];
    assign jumpoffset = ID_instr[25:0];
	
    assign b_offset = ( EX_extend_immed + 32'd3 ) << 2;
	
	assign jump_addr = { IF_pc_incr[31:28], jumpoffset << 2 };
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );
	
	ifid IFID( .PCout(ID_pc_incr), .InstructionOut(ID_instr), .clk(clk), .PCin(IF_pc_incr), .InstructionIn(IF_instr) );
	
	idex IDEX( 	.RegWriteO(EX_RegWrite), .MemtoRegO(EX_MemtoReg), .MemReadO(EX_MemRead), .MemWriteO(EX_MemWrite), .BranchO(EX_Branch), .ALUOpO(EX_ALUOp), .RegDstO(EX_RegDst), .ALUSrcO(EX_ALUSrc),
				.PCO(EX_pc_incr), .RD1O(EX_rfile_rd1), .RD2O(EX_rfile_rd2), .EXTNDEDImmO(EX_extend_immed), .rtO(EX_rt), .rdO(EX_rd), .functO(EX_funct), .shamtO(EX_shamt), 
				.RegWriteI(ID_RegWrite), .MemtoRegI(ID_MemtoReg), .MemReadI(ID_MemRead), .MemWriteI(ID_MemWrite), .BranchI(ID_Branch), .ALUOpI(ID_ALUOp), .RegDstI(ID_RegDst), .ALUSrcI(ID_ALUSrc), 
				.PCI(ID_pc_incr), .RD1I(ID_rfile_rd1), .RD2I(ID_rfile_rd2), .EXTNDEDImmI(ID_extend_immed), .rtI(ID_rt), .rdI(ID_rd), .functI(ID_funct), .shamtI(ID_shamt), .clk(clk) );
			
	exmem EXMEM( 	.RegWriteO(MEM_RegWrite), .MemtoRegO(MEM_MemtoReg), .MemReadO(MEM_MemRead), .MemWriteO(MEM_MemWrite), .BranchO(MEM_Branch), .PCO(MEM_b_tgt), .jrO(MEM_jr),  
					.zeroO(MEM_Zero), .ALUtoDataMemAddrO(MEM_alu_out), .RD2toDataMemWDO(MEM_rfile_rd2), .WNO(MEM_rfile_wn), 
					.RegWriteI(EX_RegWrite), .MemtoRegI(EX_MemtoReg), .MemReadI(EX_MemRead), .MemWriteI(EX_MemWrite), .BranchI(EX_Branch), .PCI(EX_b_tgt), .jrI(EX_jr), 
					.zeroI(EX_Zero), .ALUtoDataMemAddrI(EX_alu_out), .RD2toDataMemWDI(EX_rfile_rd2), .WNI(EX_rfile_wn), .clk(clk) );
			
	memwb MEMWB( 	.RegWriteO(WB_RegWrite), .MemtoRegO(WB_MemtoReg), .DataMemRDO(WB_dmem_rdata), .ALUResultO(WB_alu_out), .WNO(WB_rfile_wn),
					.RegWriteI(MEM_RegWrite), .MemtoRegI(MEM_MemtoReg), .DataMemRDI(MEM_dmem_rdata), .ALUResultI(MEM_alu_out), .WNI(MEM_rfile_wn), .clk(clk) );
		  
	sign_extend SignExt( .immed_in(ID_immed), .ext_immed_out(sign_ext_imm) );
	
	unsign_extend UnSignExt( .immed_in(ID_immed), .ext_immed_out(unsign_ext_imm) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(IF_pc_incr) );

    add32 BRADD( .a(EX_pc_incr), .b(b_offset), .result(EX_b_tgt) );

    TotalALU ALU( .signal(Operation), .dataA(EX_rfile_rd1), .dataB(EX_alu_b), .Output(ALU_MUX), .Zero(EX_Zero), .shamt(EX_shamt) ); // changeddddd

    divider DIVIDER( .Divout(DivAns), .Diviend(EX_rfile_rd1), .Divsor(EX_alu_b), .Signal(DIVOp), .reset(rst), .clk(clk) );

    hilo HILO( .HI(HI_MUX), .LO(LO_MUX), .Divans(DivAns), .reset(rst), .clk(clk) );
	
	MUX3x1 ALU_HI_LO_MUX( .output_data(EX_alu_out), .signal(HILOOp), .alu(ALU_MUX), .hi(HI_MUX), .lo(LO_MUX) );

    and BR_AND(PCSrc, MEM_Branch, MEM_Zero);

    mux2 #(5) RFMUX( .sel(EX_RegDst), .a(EX_rt), .b(EX_rd), .y(EX_rfile_wn) );
	
	mux2 #(32) EXTMUX( .sel(ID_sign), .a(unsign_ext_imm), .b(sign_ext_imm), .y(ID_extend_immed) ) ;

    mux2 #(32) PCMUX( .sel(PCSrc), .a(jr_pc_incr), .b(MEM_b_tgt), .y(branch_addr) );
	
	mux2 #(32) JRMUX( .sel(MEM_jr), .a(IF_pc_incr), .b(MEM_alu_out), .y(jr_pc_incr) ); 
	
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );
	
    mux2 #(32) ALUMUX( .sel(EX_ALUSrc), .a(EX_rfile_rd2), .b(EX_extend_immed), .y(EX_alu_b) );

    mux2 #(32) WRMUX( .sel(WB_MemtoReg), .a(WB_alu_out), .b(WB_dmem_rdata), .y(WB_rfile_wd) );

    control_single CTL(.opcode(ID_opcode), .RegDst(ID_RegDst), .ALUSrc(ID_ALUSrc), .MemToReg(ID_MemtoReg), 
                       .Regwrite(ID_RegWrite), .MemRead(ID_MemRead), .MemWrite(ID_MemWrite), .Branch(ID_Branch), 
                       .Jump(Jump), .ALUOP(ID_ALUOp), .Sign(ID_sign));

    alu_ctl ALUCTL( .ALUOp(EX_ALUOp), .Funct(EX_funct), .ALUOperation(Operation), .JumpReg(EX_jr), .DIVOperation(DIVOp), .HILOOperation(HILOOp), .clk(clk) );
	
	reg_file RegFile( .clk(clk), .RegWrite(WB_RegWrite), .RN1(ID_rs), .RN2(ID_rt), .WN(WB_rfile_wn), 
					  .WD(WB_rfile_wd), .RD1(ID_rfile_rd1), .RD2(ID_rfile_rd2) );

	memory #(1) InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(IF_instr) );

	memory #(0) DatMem( .clk(clk), .MemRead(MEM_MemRead), .MemWrite(MEM_MemWrite), .wd(MEM_rfile_rd2), 
				   .addr(MEM_alu_out), .rd(MEM_dmem_rdata) );	   
				   
endmodule
