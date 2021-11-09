`include "memory_unit.v"
`define MEMSIZE     16
`define WORDSIZE    4

module memory_unit_tb();
  wire [`WORDSIZE-1:0] q;
  reg wren, rden;
  reg [`MEMSIZE-1:0] addr;
  reg [`WORDSIZE-1:0] din;

  reg [`MEMSIZE:0] i;

  memory_unit #(
    .MEMSIZE(`MEMSIZE),
    .WORDSIZE(`WORDSIZE)
  ) mu (
    .wren(wren),
    .rden(rden),
    .addr(addr),
    .d(din),
    .q(q)
  );

  initial
  begin : stimulus
    wren = 1; rden = 0;
    $display("writing into the memory");
    for (i = 0; i < `MEMSIZE; i=i+1)
    begin
      addr = i; din = `MEMSIZE-i-1;
      #2;
    end
    $display("reading from the memory");
    #2 wren = 0; rden = 1;
    for (i = 0; i < `MEMSIZE; i=i+1)
    begin
      #2 addr = `MEMSIZE-i-1;
    end
    #2 rden = 0; addr = 5;
  end

  initial
  begin : monitoring
    $display("TIME  	WREN  	RDEN  	ADDR  	D 	Q");
    $monitor("%2d 	%b  	%b  	%d  	%d  	%d", $time, wren, rden, addr, din, q);
    $vcdpluson;
  end
 
  initial #(`MEMSIZE*4 + 4 + 10) $finish;

endmodule
