module MUX3x1( output_data, signal, alu, hi, lo );
  input [1:0]signal;
  input [31:0]alu, hi, lo;
  output [31:0]output_data;

  assign output_data = ( signal == 2'b00 )?hi:( ( signal == 2'b01 )?lo:alu );
endmodule