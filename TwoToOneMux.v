module TwoToOneMux(out, sel, in1, in0);

output out;
input sel, in1, in0;

assign out = sel ? in1 : in0 ;

endmodule
