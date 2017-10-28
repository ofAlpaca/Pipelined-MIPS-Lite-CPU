module	bitFullAdder( Sum, Cout, A, B, Cin );
input A, B, Cin;
output Sum, Cout;
wire Sum, Cout, w1, w2, w3;

xor xor_ABCin( Sum, A, B, Cin );

or or_AB( w1, A, B );
and and_w1Cin( w2, w1, Cin );
and and_AB( w3, A, B );
or or_w2w3( Cout, w2, w3 );

endmodule