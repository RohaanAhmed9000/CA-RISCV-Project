module ALU64(
input [63:0] a,
input [63:0] b,
input [3:0] ALUOp,  
output reg [63:0] Result,
output reg zero
);
reg flag = 1'b0;

always @(*)
begin
 case(ALUOp)
 4'b0000: // AND
 begin
 Result = a & b ;
 end

 4'b0001: // OR
 begin
 Result = a | b ;
 end
 4'b0010: // add
 begin
 Result = a + b;
 end

 4'b0110: // subtract
 begin
 Result = a - b;
 end

 4'b1100: // nor
 begin
 Result = ~a & ~b ;
 end
 
 4'b1000:
 begin 
 Result = a - b;
 if (a < b)
    flag = 1'b1;
 else
    flag = 1'b0;
 end
 endcase

 // calculation for zero
 zero = (~(|Result)&& ~(flag)) || flag ; // take bitwise or all values in result and invert it

end
endmodule
