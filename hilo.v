module hilo( HI, LO, Divans, reset, clk ) ;
input [63:0]Divans ;
input reset ;
input clk ;
reg [63:0]HILO ;
output [31:0]HI ;
output [31:0]LO ;

always@( posedge clk )
begin
  if ( reset )
    HILO = 64'b0 ;
  else
    HILO = Divans ;
end

assign HI = HILO[63:32] ;
assign LO = HILO[31:0] ;

endmodule