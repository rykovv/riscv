`include "register_file.v"
`define ADDRSIZE    2
`define WORDSIZE    4

module register_file_tb();
  reg regwr;
  reg [`ADDRSIZE-1:0] rs1, rs2, rd;
  reg [`WORDSIZE-1:0] rddata;
  wire [`WORDSIZE-1:0] rs1data, rs2data;

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
    #0 regwr = 1; rd = 0; rddata = 10; rs1 = 0; rs2 = 0;
    #2 rd = 1; rddata = 5; rs2 = 1;
    #2 rd = 2; rddata = 7; rs1 = 2;
    #2 rd = 3; rddata = 2; rs2 = 3;
    #2 regwr = 0; rs1 = 0; rs2 = 2;
    #2 rd = 0; rddata = 0; rs1 = 0;
  end

  initial
  begin : monitoring
    $display("TIME  	REGWR  	RS1  	RSD1  	RS2 	RSD2	RD	RDD");
    $monitor("%2d 	%b  	%d  	%d  	%d  	%d	%d	%d", $time, regwr, rs1, rs1data, rs2, rs2data, rd, rddata);
    $vcdpluson;
  end
 
  initial #50 $finish;

endmodule
