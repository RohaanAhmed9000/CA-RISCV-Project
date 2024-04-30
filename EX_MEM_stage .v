`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 10:03:03 AM
// Design Name: 
// Module Name: EX_MEM_stage
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


module EX_MEM_stage(
    input P_Branch,P_MemRead,P_MemtoReg,P_MemWrite,P_ALUSrc,P_RegWrite,
    input clk, reset,
 
    input [4:0] P_RD,
    input zero,
    input [63:0] Result,// alu 64 bit result

    input [63:0] out, //ouput from adder
    input [63:0] ForwardB_out,
    //
    output reg EM_Branch,EM_MemRead,EM_MemtoReg,EM_MemWrite,EM_ALUSrc,EM_RegWrite,
    output reg [4:0] EM_rd,
    output reg EM_zero,
    output reg [63:0] EM_Result,// alu 64 bit result
    output reg [63:0] EM_out, //ouput from adder
    output reg [63:0] EM_WriteData

    );
    
always @(posedge clk  or posedge reset) 
begin 
    if(reset ==1'b1)
    begin 
        EM_Branch = 0;
        EM_MemRead = 0;
        EM_MemtoReg = 0;
        EM_MemWrite = 0;
        EM_ALUSrc = 0;
        EM_RegWrite = 0; 
        EM_rd = 0;
        EM_zero = 0;
        EM_Result = 0;// alu 64 bit result
        EM_out = 0; //ouput from adder
        EM_WriteData = 0;
    end 
    else 
    begin
        EM_Branch = P_Branch;
        EM_MemRead = P_MemRead;
        EM_MemtoReg = P_MemtoReg;
        EM_MemWrite = P_MemWrite;
        EM_ALUSrc = P_ALUSrc;
        EM_RegWrite = P_RegWrite; 
        EM_rd = P_RD;
        EM_zero = zero;
        EM_Result = Result;// alu 64 bit result
        EM_out = out; //ouput from adder
        EM_WriteData = ForwardB_out;
    end 
end
endmodule
