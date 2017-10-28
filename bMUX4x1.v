module bMUX4x1( output_data, sel, And, Or, Fa, Slt );
  input [2:0]sel;
  input And, Or, Fa, Slt;
  output output_data;

  assign output_data = sel[2]?Slt:( sel[1]?Fa:( sel[0]?Or:And ));
endmodule