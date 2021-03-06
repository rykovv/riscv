`include "memory_unit.v"
`define ADDRSIZE    16
`define WORDSIZE    4

module memory_unit_tb();
  wire [`WORDSIZE-1:0] q;
  reg clk, wren, rden;
  reg [`ADDRSIZE-1:0] addr;
  reg [`WORDSIZE-1:0] din;

  reg [`ADDRSIZE:0] i;

  memory_unit #(
    .ADDRSIZE(`ADDRSIZE),
    .WORDSIZE(`WORDSIZE)
  ) mu (
    .clk(clk),
    .wren(wren),
    .rden(rden),
    .addr(addr),
    .d(din),
    .q(q)
  );

  initial
  begin
    clk = 0;
    forever #1 clk = ~clk;
  end

  initial
  begin : stimulus
    wren = 1; rden = 0;
    #2;
    $display("writing into the memory");
    for (i = 0; i < `ADDRSIZE; i=i+1)
    begin
      addr = i; din = `ADDRSIZE-i-1;
      #2;
    end
    $display("reading from the memory");
    #2 wren = 0; rden = 1;
    for (i = 0; i < `ADDRSIZE; i=i+1)
    begin
      addr = `ADDRSIZE-i-1;
      #2;
    end
    #2 rden = 0; addr = 5;
  end

  initial
  begin : monitoring
    $display("TIME  	WREN  	RDEN  	ADDR  	D 	Q");
    $monitor("%2d 	%b  	%b  	%d  	%d  	%d", $time, wren, rden, addr, din, q);
    $vcdpluson;
  end
 
  initial #(`ADDRSIZE*4 + 4 + 10) $finish;

endmodule
