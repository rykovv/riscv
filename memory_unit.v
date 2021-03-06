module memory_unit
#(
  parameter ADDRSIZE = 64,
  WORDSIZE = 64
) (
  input clk,
  input wren, rden,           // write and read enables
  input [ADDRSIZE-1:0] addr,   // write/read address
  input [WORDSIZE-1:0] d,     // data in
  output [WORDSIZE-1:0] q // data out
);
  localparam MEMSIZE = 1 << ADDRSIZE;

  reg [WORDSIZE-1:0] mem [0:MEMSIZE-1];

  always @(posedge clk)
  begin
    if (wren)
      mem[addr] <= d;
    else
      mem[addr] <= mem[addr];
  end

  assign q = mem[addr];

  integer i;
  initial
  begin
    for (i = 0; i < MEMSIZE; i=i+1)
      mem[i] = 0;
  end

endmodule
