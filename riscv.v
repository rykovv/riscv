`include "memory_unit.v"
`include "control_unit.v"
`include "register_file.v"
`include "immediate_generator.v"
`include "alu.v"
`include "alu_control.v"

`define REGADDRSIZE 5
`define IMEMSIZE    8 // 256
`define DMEMSIZE    8 // 256
`define WORDSIZE    32
`define DWORDSIZE   64

module riscv(input clk);
  // instruction memory
  reg [`DWORDSIZE-1:0] PC;
  wire [`WORDSIZE-1:0] instruction;
  // control unit
  wire branch, memread, memtoreg, alusrc, memwrite, regwrite;
  wire [1:0] aluop;
  // register file
  wire [`DWORDSIZE-1:0] rddata, rs1data, rs2data;
  // immediate generator
  wire [`DWORDSIZE-1:0] immediate;
  // alu
  wire [3:0] alucmd;
  wire [`DWORDSIZE-1:0] alures;
  wire aluz;
  // data memory
  wire [`DWORDSIZE-1:0] readdata;

  memory_unit #(
    .ADDRSIZE(`IMEMSIZE),
    .WORDSIZE(`WORDSIZE)
  ) instruction_memory (
    .wren(1'b0),
    .rden(1'b1),
    .addr(PC[7:0]), // assuming 256B memory
    .d({`WORDSIZE{1'b0}}),
    .q(instruction)
  );

  control_unit cu (
    .instruction(instruction[6:0]), // opcode
    .branch(branch),
    .memread(memread),
    .memwrite(memwrite),
    .memtoreg(memtoreg),
    .alusrc(alusrc),
    .regwrite(regwrite),
    .aluop(aluop)
  );

  register_file #(
    .ADDRSIZE(`REGADDRSIZE),
    .WORDSIZE(`DWORDSIZE)
  ) rf (
    .regwr(regwrite),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .rddata( memtoreg ? readdata : alures ),
    .rs1data(rs1data),
    .rs2data(rs2data)
  );

  immediate_generator #(
    .INSTRSIZE(`WORDSIZE),
    .IMMSIZE(`DWORDSIZE)
  ) ig (
    .instruction(instruction),
    .immediate(immediate)
  );
  
  alu_control ac (
    .instruction( {instruction[30], instruction[14:12]} ),
    .aluop(aluop),
    .alucmd(alucmd)
  );

  alu #(
    .WORDSIZE(`DWORDSIZE)
  ) alu (
    .A(rs1data), .B( alusrc ? immediate : rs2data ),
    .CTL(alucmd),
    .R(alures), .Z(aluz)
  );

  memory_unit #(
    .ADDRSIZE(`DMEMSIZE),
    .WORDSIZE(`DWORDSIZE)
  ) data_memory (
    .wren(memwrite),
    .rden(memread),
    .addr(alures[7:0]), // assuming 256B memory
    .d(rs2data),
    .q(readdata)
  );

  always @(posedge clk)
  begin
    PC <= branch && aluz ? PC + immediate : PC + 4;
  end

endmodule
