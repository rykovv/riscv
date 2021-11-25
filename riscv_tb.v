`include "riscv.v"

`define CLK_C	2
`define CLK_P	(`CLK_C*2)

module riscv_tb();
  reg clk, rst;

  riscv rv (
    .clk(clk),
    .rst(rst)
  );

  initial #(`CLK_P) $readmemb("instruction_data.txt", rv.instruction_memory.mem);
 
  /* 
  integer k;
  initial begin
    #`CLK_P for (k = 0; k < 10; k=k+1) $display("%d : %b", k, rv.instruction_memory.mem[k]);
  end
  */

  initial 
  begin
    clk = 1;
    #(`CLK_P); // wait for $readmemb and rst
    forever #(`CLK_C) clk = ~clk;
  end

  initial $vcdpluson;

  initial 
  begin
    rst = 0;
    #`CLK_P rst = 1;
    #(`CLK_P*9) $finish;
  end

  initial
  begin
    $monitor("%2d %b %b %2d %b%b %2d %b %b %b %b %b %b %b",$time, rst, clk, rv.rf.rddata, rv.aluz, rv.branch, rv.PC, rv.instruction, rv.memread, rv.memtoreg, rv.aluop, rv.memwrite, rv.alusrc, rv.regwrite);
  end

endmodule
