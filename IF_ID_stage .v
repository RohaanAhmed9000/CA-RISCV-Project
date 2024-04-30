`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 09:23:57 AM
// Design Name: 
// Module Name: IF_ID_stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_ID_stage(
input clk,
input reset ,
//input n_stall, //add a stall 
input [31:0] instruction, //going in instruction 
input [63:0] PC_out, //take from pc
output reg [31:0] S_inst,// instruction from if/id
output reg [63:0] S_PC_out// pc_out from if/id
    );
always @(posedge clk or posedge reset) 
    // upon each reset change to zero
    begin 
    if(reset == 1'b1) 
        begin 
        S_inst = 0;
        S_PC_out = 0;
        end 
    else 
        begin
        S_inst = instruction;
        S_PC_out = PC_out;
        end
    end
endmodule

