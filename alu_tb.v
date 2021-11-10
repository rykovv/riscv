`include "alu.v"
`define WORDSIZE 4

module alu_tb();
  reg [`WORDSIZE-1:0] a, b;
  reg [3:0] ctl;
  wire [`WORDSIZE-1:0] r;
  wire z;

  alu #(
    .WORDSIZE(`WORDSIZE)
  ) DUT (
    .A(a), .B(b),
    .CTL(ctl),
    .R(r), .Z(z)
  );

  initial
  begin : stimulus
    #0 ctl = 0; a = 7; b = 5;
    #2 ctl = 1; a = 1; b = 4;
    #2 ctl = 2; a = 3; b = 2;
    #2 ctl = 6; a = 5; b = 5; 
    #2 ctl = 0; a = 2; b = 5;
    #2 ctl = 1; a = 3; b = 6;
  end

  initial
  begin
    $display("TIME	A	B	CTL	R	Z");
    $monitor("%2d	%d	%d	%b	%d	%b", $time, a, b, ctl, r, z);
  end

  initial #20 $finish;

endmodule
