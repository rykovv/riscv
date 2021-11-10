`include "immediate_generator.v"

`define WORDSIZE	32
`define DOUBLEWORDSIZE	64

module immediate_generator_tb();
  reg [`WORDSIZE-1:0] instruction;
  wire signed [`DOUBLEWORDSIZE-1:0] immediate;
  reg signed [`DOUBLEWORDSIZE-1:0] exp_immediate;  

  immediate_generator #(
    .INSTRSIZE(`WORDSIZE),
    .IMMSIZE(`DOUBLEWORDSIZE)
  ) ig (
    .instruction(instruction),
    .immediate(immediate)
  );

  initial
  begin : stimulus
    // load          / immediate /
    #0 instruction = 111111001110_00001_000_01110_0010011; exp_immediate = -50;
    #2 instruction = 000000001111_00001_000_01110_0010011; exp_immediate = 15;
    // store         / 11-5 /               / 4-0 /
    #2 instruction = 1111110_01110_00010_010_01110_0100011; exp_immediate = -50;
    #2 instruction = 0000000_01110_00010_010_01111_0100011; exp_immediate = 15;
    // branch
    #2 instruction = 1_111100_01010_10011_000_1110_1_1100011; exp_immediate = -50;
    #2 instruction = 0_000000_01010_10011_000_0111_0_1100011; exp_immediate = -50;
  end

  always @(*)
  begin : selfcheck
    if (exp_immediate != immediate)
      $display("[FAIL @ %d2] %3d/%3d (real/expected)", $time, immediate, exp_immediate);
    else
      $display("[PASS @ %2d] %3d/%3d (real/expected)", $time, immediate, exp_immediate);
  end

  initial
  begin : monitoring
    $display("INSTRUCTION						IMMEDIATE");
    $monitor("%b	%d", instruction, immediate);
  end

  initial #20 $finish;

endmodule
