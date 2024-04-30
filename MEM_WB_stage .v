`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 10:02:06 AM
// Design Name: 
// Module Name: MEM_WB_stage
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


module MEM_WB_stage(
    input clk, reset,
    //write back 
    input EM_MemtoReg, EM_RegWrite,
    input [4:0] EM_rd,
    input [63:0] EM_Result,// alu 64 bit result
    input [63:0] ReadData,
    //
    output reg WB_MemtoReg, WB_RegWrite,
    output reg [4:0] WB_RD,
    output reg [63:0] WB_Result,// alu 64 bit result
    output reg [63:0] WB_ReadData
    );
    
always @(posedge clk  or posedge reset) 
begin 
    if(reset ==1'b1)
    begin 
        
        WB_MemtoReg = 0;
        WB_RegWrite = 0;
        WB_RD= 0;
        WB_ReadData = 0;
        WB_Result = 0;
    end 
    else 
    begin
        WB_MemtoReg = EM_MemtoReg;
        WB_RegWrite = EM_RegWrite;
        WB_RD = EM_rd;
        WB_ReadData = ReadData;
        WB_Result = EM_Result;
    end 
end
endmodule
