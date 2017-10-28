module divider( Divout, Diviend, Divsor, Signal, reset, clk ) ;
input [31:0]Diviend ;
input [31:0]Divsor ;
input Signal ;
input reset ;
input clk ;
reg [31:0]DIVRHI ;
reg [31:0]DIVRLO ;
reg [63:0]REM ;
reg [31:0]QUOT ;
reg [5:0]counter ;
output reg [63:0]Divout ;

parameter DIVU = 1'b1;
parameter OUT = 1'b0;

always@( posedge clk )
 begin
  if ( reset )
  begin
    DIVRHI = 32'b0 ;
    DIVRLO = 32'b0 ;
    REM = 64'b0 ;
    QUOT = 32'b0 ;
    Divout = 64'b0 ;
	counter = 6'b000000 ;
  end
  else
  begin
    case ( Signal )
      DIVU:
      begin
	    if ( { DIVRHI, DIVRLO } == 64'b0 && counter == 6'b000000 ) 
        begin
          DIVRHI = Divsor;
          REM = { 32'b0, Diviend } ;
        end
	    if ( counter != 6'b100001 )
        begin
          REM = REM - { DIVRHI, DIVRLO } ;
          if ( REM[63] == 1'b0 )
          begin
            QUOT = QUOT << 1 ;
            QUOT[0] = 1 ;
          end
          else
          begin
            REM = REM + { DIVRHI, DIVRLO } ;
            QUOT = QUOT << 1 ;
            QUOT[0] = 0 ;
          end

		  counter = counter + 1 ;
          { DIVRHI, DIVRLO } = { DIVRHI, DIVRLO } >> 1 ;
		end
      end
      OUT:
      begin
          Divout = { REM[31:0], QUOT } ;
      end
    endcase
  end
end
endmodule