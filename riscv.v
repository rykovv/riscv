`define IMEMSIZE    32
`define DMEMSIZE    32
`define WORDSIZE    32
`define DWORDSIZE   64

module riscv(input clk);

  reg [`WORDSIZE-1:0] PC;


  reg [`WORDSIZE-1:0] instruction_memory [0:`IMEMSIZE-1];
  reg [`DWORDSIZE-1:0] data_memory [0:`DMEMSIZE-1];
  wire [`WORDSIZE-1:0] instruction;
  assign instruction = instruction_memory[PC];

  reg reg_wr;
  reg [4:0] rdaddr_r1, rdaddr_r2, wraddr;
  reg [`DWORDSIZE-1:0] wrdata;
  wire [`DWORDSIZE-1:0] rdata_r1, rdata_r2;

  register_file rf (
    .reg_wr(reg_wr),
    .rdaddr_r1(rdaddr_r1),
    .rdaddr_r2(rdaddr_r2),
    .wraddr(wraddr),
    .rdata_r1(rdata_r1),
    .rdata_r2(rdata_r2)
  );

  always @(posedge clk)
  begin
    PC <= ctl_branch && alu_z ? PC + (jump_base_address << 1) : PC + 4;
    
  end


endmodule

module register_file (
    input reg_wr,
    input [4:0] rdaddr_r1, rdaddr_r2,
    input [4:0] wraddr,
    input [`DWORDSIZE-1:0] wrdata,
    output [`DWORDSIZE-1:0] rdata_r1, rdata_r2 // read data
);

  reg [`DWORDSIZE-1:0] registers [0:31];

  always @(*)
  begin
    if (reg_wr)
      registers[wraddr] = wrdata;
    else begin
      rdata_r1 = registers[rdaddr_r1];
      rdata_r2 = registers[rdaddr_r2];
    end
  end

endmodule

module control (
  input [6:0] instruct,
  output ctl_branch,
  output ctl_memread,
  output ctl_memtoreg,
  output [1:0] ctl_aluop,
  output ctl_memwrite,
  output ctl_alusrc,
  output ctl_regwrite
);

endmodule

module alu_control (
  input [1:0] alu_op,
  input instruct30,
  input [1:0] instruct1412
);

endmodule
