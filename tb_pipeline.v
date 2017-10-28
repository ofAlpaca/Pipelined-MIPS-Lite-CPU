module tb_pipeline();
	reg clk, rst;
	
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc );
		if ( CPU.ID_opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.WB_rfile_wd );
			if ( CPU.ID_funct == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd42 ) $display( "%d, SLT\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd0 ) $display( "%d, SLL\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd8 ) $display( "%d, JR\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd27 ) $display( "%d, DIVU\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd16 ) $display( "%d, MFHI\n", $time/10-1 );
			else if ( CPU.ID_funct == 6'd18 ) $display( "%d, MFLO\n", $time/10-1 );
		end
		else if ( CPU.ID_opcode == 6'd35 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.ID_opcode == 6'd43 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.ID_opcode == 6'd4 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.ID_opcode == 6'd30 ) $display( "%d, STALL\n", $time/10-1 );
		else if ( CPU.ID_opcode == 6'd2 ) $display( "%d, J\n", $time/10-1 );
		else if ( CPU.ID_opcode == 6'd12 ) $display( "%d, ANDI\n", $time/10-1 );
	end
	
	mips_pipeline CPU( clk, rst );
	
endmodule
