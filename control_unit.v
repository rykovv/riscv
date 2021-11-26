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
	     IT = 7'b0010011, // ADDI
	     LW = 7'b0000011,
	     SW = 7'b0100011,
	    BEQ = 7'b1100011;
  
  always @(*)
  begin
    case (instruction)
      RT: begin
        { alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop } = 8'b00100010;
      end
      IT: begin
        { alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop } = 8'b10100000;
      end
      LW: begin
        { alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop } = 8'b11110000;
      end
      SW: begin
        { alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop } = 8'b1x001000;
      end
      BEQ: begin
        { alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop } = 8'b0x000101;
      end
    endcase
  end

endmodule
