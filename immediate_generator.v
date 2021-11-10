module immediate_generator #(
  parameter INSTRSIZE = 32,
  IMMSIZE = 64
) (
  input [INSTRSIZE-1:0] instruction,
  output reg signed [IMMSIZE-1:0] immediate
);
  localparam RT = 7'b0110011,
	     LW = 7'b0000011,
	     SW = 7'b0100011,
	    BEQ = 7'b1100011;

  always @(*)
  begin
    case (instruction[6:0])
      LW: begin
        immediate = { {52{instruction[31]}}, instruction[31:20] };
      end
      SW: begin
        immediate = { {52{instruction[31]}}, instruction[31:25], instruction[11:7] };
      end
      BEQ: begin
        immediate = { {51{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 };
      end
    endcase
  end

endmodule
