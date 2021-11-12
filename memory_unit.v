module memory_unit
#(
  parameter ADDRSIZE = 64,
  WORDSIZE = 64
) (
  input rst,
  input wren, rden,           // write and read enables
  input [ADDRSIZE-1:0] addr,   // write/read address
  input [WORDSIZE-1:0] d,     // data in
  output reg [WORDSIZE-1:0] q // data out
);
  localparam MEMSIZE = 1 << ADDRSIZE;

  reg [WORDSIZE-1:0] mem [0:MEMSIZE-1];

  always @(*) begin
    if (wren)
      mem[addr] = d;
    else if (rden)
      q = mem[addr];
    else
      q = {WORDSIZE{1'bx}};
  end

  integer i;
  always @(negedge rst)
  begin
    for (i = 0; i < MEMSIZE; i=i+1)
      mem[i] <= 0;
  end

endmodule
