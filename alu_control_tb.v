`include "alu_control.v"

module alu_control_tb();
  reg [3:0] instruction;
  reg [1:0] aluop;
  wire [3:0] alucmd;

  alu_control ac (
    .instruction(instruction),
    .aluop(aluop),
    .alucmd(alucmd)
  );

  initial
  begin : stimulus
    #0 aluop = 0; instruction = 0;
    #2 aluop = 1; instruction = 6;
    #2 aluop = 2; instruction = 0;
    #2 aluop = 2; instruction = 8;
    #2 aluop = 2; instruction = 7;
    #2 aluop = 2; instruction = 6;
  end

  initial
  begin
    $display("TIME	ALUOP	INSTR	ALUCMD");
    $monitor("%2d	%b	%b	%b", $time, aluop, instruction, alucmd);
  end

  initial #20 $finish;

endmodule
