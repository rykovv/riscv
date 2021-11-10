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

  

endmodule
