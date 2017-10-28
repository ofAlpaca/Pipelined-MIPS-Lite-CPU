module ALU32( result, zero, dataA, dataB, signal );
	input [31:0]dataA;
	input [31:0]dataB;
	input [2:0]signal;
	output [31:0]result;
	output zero;
	
	wire Binv, tmp, set;
	wire [31:0]cout;
	
	assign Binv = ( signal == 3'b011 )? 1'b1 :( signal == 3'b100 )? 1'b1 : 1'b0;
	assign zero = ( result == 32'd0 )? 1'b1 : 1'b0;
	
	bALU alu0( .S(result[0]), .Cout(cout[0]), .Set(tmp), .A(dataA[0]), .B(dataB[0]), .Cin(Binv), .Binv(Binv), .ctrl(signal), .less(set), .MSB(1'b0));
	bALU alu1( .S(result[1]), .Cout(cout[1]), .Set(tmp), .A(dataA[1]), .B(dataB[1]), .Cin(cout[0]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu2( .S(result[2]), .Cout(cout[2]), .Set(tmp), .A(dataA[2]), .B(dataB[2]), .Cin(cout[1]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu3( .S(result[3]), .Cout(cout[3]), .Set(tmp), .A(dataA[3]), .B(dataB[3]), .Cin(cout[2]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu4( .S(result[4]), .Cout(cout[4]), .Set(tmp), .A(dataA[4]), .B(dataB[4]), .Cin(cout[3]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu5( .S(result[5]), .Cout(cout[5]), .Set(tmp), .A(dataA[5]), .B(dataB[5]), .Cin(cout[4]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu6( .S(result[6]), .Cout(cout[6]), .Set(tmp), .A(dataA[6]), .B(dataB[6]), .Cin(cout[5]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu7( .S(result[7]), .Cout(cout[7]), .Set(tmp), .A(dataA[7]), .B(dataB[7]), .Cin(cout[6]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu8( .S(result[8]), .Cout(cout[8]), .Set(tmp), .A(dataA[8]), .B(dataB[8]), .Cin(cout[7]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu9( .S(result[9]), .Cout(cout[9]), .Set(tmp), .A(dataA[9]), .B(dataB[9]), .Cin(cout[8]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu10( .S(result[10]), .Cout(cout[10]), .Set(tmp), .A(dataA[10]), .B(dataB[10]), .Cin(cout[9]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu11( .S(result[11]), .Cout(cout[11]), .Set(tmp), .A(dataA[11]), .B(dataB[11]), .Cin(cout[10]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu12( .S(result[12]), .Cout(cout[12]), .Set(tmp), .A(dataA[12]), .B(dataB[12]), .Cin(cout[11]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu13( .S(result[13]), .Cout(cout[13]), .Set(tmp), .A(dataA[13]), .B(dataB[13]), .Cin(cout[12]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu14( .S(result[14]), .Cout(cout[14]), .Set(tmp), .A(dataA[14]), .B(dataB[14]), .Cin(cout[13]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu15( .S(result[15]), .Cout(cout[15]), .Set(tmp), .A(dataA[15]), .B(dataB[15]), .Cin(cout[14]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu16( .S(result[16]), .Cout(cout[16]), .Set(tmp), .A(dataA[16]), .B(dataB[16]), .Cin(cout[15]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu17( .S(result[17]), .Cout(cout[17]), .Set(tmp), .A(dataA[17]), .B(dataB[17]), .Cin(cout[16]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu18( .S(result[18]), .Cout(cout[18]), .Set(tmp), .A(dataA[18]), .B(dataB[18]), .Cin(cout[17]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu19( .S(result[19]), .Cout(cout[19]), .Set(tmp), .A(dataA[19]), .B(dataB[19]), .Cin(cout[18]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu20( .S(result[20]), .Cout(cout[20]), .Set(tmp), .A(dataA[20]), .B(dataB[20]), .Cin(cout[19]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu21( .S(result[21]), .Cout(cout[21]), .Set(tmp), .A(dataA[21]), .B(dataB[21]), .Cin(cout[20]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu22( .S(result[22]), .Cout(cout[22]), .Set(tmp), .A(dataA[22]), .B(dataB[22]), .Cin(cout[21]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu23( .S(result[23]), .Cout(cout[23]), .Set(tmp), .A(dataA[23]), .B(dataB[23]), .Cin(cout[22]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu24( .S(result[24]), .Cout(cout[24]), .Set(tmp), .A(dataA[24]), .B(dataB[24]), .Cin(cout[23]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu25( .S(result[25]), .Cout(cout[25]), .Set(tmp), .A(dataA[25]), .B(dataB[25]), .Cin(cout[24]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu26( .S(result[26]), .Cout(cout[26]), .Set(tmp), .A(dataA[26]), .B(dataB[26]), .Cin(cout[25]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu27( .S(result[27]), .Cout(cout[27]), .Set(tmp), .A(dataA[27]), .B(dataB[27]), .Cin(cout[26]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu28( .S(result[28]), .Cout(cout[28]), .Set(tmp), .A(dataA[28]), .B(dataB[28]), .Cin(cout[27]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu29( .S(result[29]), .Cout(cout[29]), .Set(tmp), .A(dataA[29]), .B(dataB[29]), .Cin(cout[28]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu30( .S(result[30]), .Cout(cout[30]), .Set(tmp), .A(dataA[30]), .B(dataB[30]), .Cin(cout[29]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b0));
	bALU alu31( .S(result[31]), .Cout(cout[31]), .Set(set), .A(dataA[31]), .B(dataB[31]), .Cin(cout[30]), .Binv(Binv), .ctrl(signal), .less(1'b0), .MSB(1'b1));
	
endmodule
