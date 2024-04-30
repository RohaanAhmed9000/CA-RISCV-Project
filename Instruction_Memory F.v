`timescale 1ns / 1ps

module Instruction_Memory(
input [63:0] Inst_Address,
output reg [31:0] Instruction
);

reg [7:0] Memory [55:0];

initial
begin

Memory[0] = 8'h00; 
Memory[1] = 8'h73; 
Memory[2] = 8'h02; 
Memory[3] = 8'hb3; 

end

always @(Inst_Address)

begin
Instruction[31:24] <= Memory[Inst_Address + 3];
Instruction[23:16] <= Memory[Inst_Address + 2];
Instruction[15:8] <= Memory[Inst_Address + 1];
Instruction[7:0] <= Memory[Inst_Address];

end
endmodule