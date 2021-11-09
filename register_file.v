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
  input regwr,          		// register write enable
  input [ADDRSIZE-1:0] rs1, rs2,   	// source registers addresses
  input [ADDRSIZE-1:0] rd,		// write register address
  input [WORDSIZE-1:0] rddata,		// write register data
  output reg [WORDSIZE-1:0] rs1data, rs2data	// source registers data
);

  reg [WORDSIZE-1:0] file [0:ADDRSIZE-1];

  always @(*) begin
    if (regwr)
      file[rd] = rddata;
    
    rs1data = file[rs1];
    rs2data = file[rs2];
  end

endmodule
