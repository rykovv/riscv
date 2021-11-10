module alu #(
  parameter WORDSIZE = 64
) (
  input [WORDSIZE-1:0] A, B,
  input [3:0] CTL,
  output Z,
  output reg [WORDSIZE-1:0] R
);
  localparam
    AND = 4'b0000,
    OR  = 4'b0001,
    ADD = 4'b0010,
    SUB = 4'b0110;
    
  always @(*) 
  begin
    case (CTL):
      AND: R = A & B;
      OR : R = A | B;
      ADD: R = A + B;
      SUB: R = A - B;
    endcase
  end

  assign Z = ~(|R);

endmodule
