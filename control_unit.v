module control_unit (
  input [6:0] instruction, // opcode
  output reg branch,
  output reg memread,
  output reg memwrite,
  output reg memtoreg,
  output reg alusrc,
  output reg regwrite,
  output reg [1:0] aluop
);
  localparam RT = 7'b0110011,
	     LW = 7'b0000011,
	     SW = 7'b0100011,
	    BEQ = 7'b1100011;
  
  always @(*)
  begin
    case (instruction)
      RT: begin
        
      end
      LW: begin

      end
      SW: begin

      end
      BEQ: begin

      end
  end

endmodule
