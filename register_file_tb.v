`include "register_file.v"
`define ADDRSIZE    4
`define WORDSIZE    8

module register_file_tb();
  reg regrw;
  reg [`ADDRSIZE-1:0] rs1, rs2, rd;
  reg [`WORDSIZE-1:0] rs1data, rs2data, rddata;

  register_file #(
    .ADDRSIZE(`ADDRSIZE),
    .WORDSIZE(`WORDSIZE)
  ) rf (
    .regwr(regwr),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .rddata(rddata),
    .rs1data(rs1data),
    .rs2data(rs2data)
  );

  initial
  begin : stimulus
    regwr = 1;
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
