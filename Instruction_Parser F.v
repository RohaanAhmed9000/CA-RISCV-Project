`timescale 1ns / 1ps

module Instruction_Parser(instruc, opcode, RD, func3, RS1, RS2, func7);

//inputs:
input [31:0] instruc; // 32 bits

//outputs
output reg [6:0] opcode;  // 7 bits
output reg [4:0] RD;     // 5 bits
output reg [2:0] func3; // 3 bits
output reg [4:0] RS1;  // 5 bits
output reg [4:0] RS2; // 5 bits
output reg [6:0] func7; // 7 bits

//always statement
always @(instruc) //parameters which trigger reevaluation- their values change
begin

//splitting 32 bit instruction into its respective fields
opcode <= instruc [6:0];
RD <= instruc [11:7];
func3 <= instruc [14:12];
RS1 <= instruc [19:15];
RS2 <= instruc [24:20];
func7 <= instruc [31:25];

end
endmodule

