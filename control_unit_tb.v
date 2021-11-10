`include "control_unit.v"

module control_unit_tb();
  reg [6:0] instruction;
  wire branch, memread, memwrite, memtoreg, alusrc, regwrite;
  wire [1:0] aluop;

  localparam RT = 7'b0110011,
	     LW = 7'b0000011,
	     SW = 7'b0100011,
	    BEQ = 7'b1100011;
  
  control_unit cu (
    .instruction(instruction),
    .branch(branch),
    .memread(memread),
    .memwrite(memwrite),
    .memtoreg(memtoreg),
    .alusrc(alusrc),
    .regwrite(regwrite),
    .aluop(aluop)
  );

  initial
  begin : stimulus
    #0 instruction = RT;
    #2 instruction = LW;
    #2 instruction = SW;
    #2 instruction = BEQ;

    #2 instruction = 7'b0101010;
    #2 instruction = LW;
  end

  initial
  begin : monitoring
    $display("TIME	INSTR	BR	MEMREAD	MEMWRITE	MEMTOREG	ALUSRC	REGWRITE	ALUOP");
    $monitor("%2d	%b	%b	%b	%b		%b		%b	%b		%b", $time, instruction, branch, memread, memwrite, memtoreg, alusrc, regwrite, aluop);
  end

  initial #20 $finish;

endmodule
