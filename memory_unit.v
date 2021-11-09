module memory_unit
#(
  parameter MEMSIZE = 64,
  WORDSIZE = 64
) (
  input wren, rden,           // write and read enables
  input [MEMSIZE-1:0] addr,   // write/read address
  input [WORDSIZE-1:0] d,     // data in
  output reg [WORDSIZE-1:0] q // data out
);

  reg [WORDSIZE-1:0] mem [0:MEMSIZE-1];

  always @(*) begin
    if (wren)
      mem[addr] = d;
    else if (rden)
      q = mem[addr];
    else
      q = {WORDSIZE{1'bx}};
  end

endmodule
