// register_file.v
// author : vladislav rykov
//
// parameters:
// ADDRSIZE - number of bits to address a register
// WORDSIZE - size of each register

module register_file
#(
  parameter ADDRSIZE = 5,
  WORDSIZE = 64
) (
  input rst, clk,
  input regwr,          		// register write enable
  input [ADDRSIZE-1:0] rs1, rs2,   	// source registers addresses
  input [ADDRSIZE-1:0] rd,		// write register address
  input [WORDSIZE-1:0] rddata,		// write register data
  output [WORDSIZE-1:0] rs1data, rs2data	// source registers data
);
  localparam RFSIZE = 1 << ADDRSIZE;

  reg [WORDSIZE-1:0] file [RFSIZE-1:0];

  /*
  always @(rddata, rs1, rs2, rd) begin
    if (regwr)
      file[rd] = rddata;
    
    rs1data = file[rs1];
    rs2data = file[rs2];
  end
  */

  always @(posedge clk)
  begin
    if (regwr)
      file[rd] <= rddata;
    else
      file[rd] <= file[rd];
  end

  assign rs1data = file[rs1];
  assign rs2data = file[rs2];

  integer i;
  always @(negedge rst)
  begin
    for (i = 0; i < RFSIZE; i=i+1)
      file[i] <= 0;
  end

endmodule
