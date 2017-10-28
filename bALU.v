module bALU( S, Cout, Set, A, B, Cin, Binv, ctrl, less, MSB );
  input A, B, Cin;
  input [2:0]ctrl;
  input Binv, less, MSB;

  output S, Cout, Set;
  wire Set, Cout, S;
  wire B2FA, andAB_output, orAB_output, FA_output;

  and and_AB( andAB_output, A, B );
  or or_AB( orAB_output, A, B ) ;
  
  xor xor_BinvB( B2FA, B, Binv );
  bitFullAdder bFA( FA_output, Cout, A, B2FA, Cin );
  
  and and_MSB( Set, FA_output, MSB );
  
  bMUX4x1 mux4x1( S, ctrl, andAB_output, orAB_output, FA_output, less );

endmodule
