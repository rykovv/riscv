module alu_control (
  input [3:0] instruction, // instruction bits: 30, 14, 13, 12
  input [1:0] aluop,       // signal from the control unit
  output reg [3:0] alucmd  // singal for alu operation
);
  localparam
    AND = 4'b0000,
    OR  = 4'b0001,
    ADD = 4'b0010,
    SUB = 4'b0110;

  always @(*)
  begin
    if (aluop == 2'b00)     alucmd = ADD;
    else if (aluop == 2'b01) alucmd = SUB;
    else if (aluop[1])
    begin
      if (instruction == 4'b0_000)      alucmd = ADD;
      else if (instruction == 4'b1_000) alucmd = SUB;
      else if (instruction == 4'b0_111) alucmd = AND;
      else if (instruction == 4'b0_110) alucmd = OR;
    end
  end

endmodule
