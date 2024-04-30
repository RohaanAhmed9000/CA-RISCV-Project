`timescale 1ns / 1ps

module Imm_Gen(instruc,imm_data);

//input
input [31:0] instruc; // 32 bits

//output
output reg [63:0] imm_data; // 64 bits

reg [11:0] ld_imm;
reg [11:0] br_imm;
reg [11:0] sd_imm;
//always statement
always @(instruc) //parameters which trigger reevaluation- their values change
begin 

// conditions
// opcode differs in all three instruction types in 5th and 6th bits
// addi -- opcode 00 ; ld -- opcode 00 -- I type
// sd -- opcode 01 - S type
// beq -- opcode 1x --SB type

if (instruc[5]==0 && instruc[6] == 0) begin // I Format
ld_imm[11:0] <= instruc[31:20]; // since in I type format the immediate field contains a 12 bit immediate in bits in the beginning
imm_data = {{52{instruc[31]}},ld_imm};
end
else if (instruc[5]==1 && instruc[6] == 0 ) // S Format
begin

sd_imm = {instruc [ 31:25] , instruc [11:7]};
imm_data = {{52{instruc[31]}},sd_imm};
end

else // SB Format 
begin
br_imm[11] <= instruc[31];
br_imm <= instruc[7];
br_imm <= instruc[30:25];
br_imm <= instruc[11:8];
imm_data = {{52{instruc[31]}},br_imm};
end
end

always @(*)
begin

//padding other bits based on the 11th bit
if (imm_data[11] == 1)
imm_data[63:12] <= 52'hfffffffffffff; 
else
imm_data[63:12] <= 52'b0;
end
endmodule


