`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 09:38:14 AM
// Design Name: 
// Module Name: ID_EX_stage
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


module ID_EX_stage(

    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] RD,
    input clk,
    input reset,
    input [1:0] ALUOp,
    input [3:0] Funct,
    input Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,

    input [63:0] S_PC_out,// pc_out from if/id
    input [63:0] ReadData1, ReadData2,
    input [63:0] imm_data,
    
    // outputs
    output reg P_Branch,P_MemRead,P_MemtoReg,P_MemWrite,P_ALUSrc,P_RegWrite,
    output reg [4:0] P_RS1, P_RS2, P_RD,
    output reg [3:0] P_Funct,
    output reg [1:0] P_ALUOp,
    output reg [63:0] P_PC_out, P_ReadData1, P_ReadData2, P_imm_data // all outputs from from id/ex stage 
    );
    
always @(posedge clk or posedge reset) 
begin
    if(reset ==1'b1) 
    begin 
        //all to zero 
        P_Branch=0;
        P_MemRead=0;
        P_MemtoReg=0;
        P_MemWrite=0;
        P_ALUSrc=0;
        P_RegWrite = 0;
        P_RS1=0;
        P_RS2=0;
        P_RD=0;
        P_ALUOp=0;
        P_Funct=0;
        P_imm_data=0;
        P_ReadData1=0;
        P_ReadData2=0;
        P_PC_out=0;
    end 
    else 
    begin 
        //all to zero 
        P_Branch= Branch;
        P_MemRead=MemRead;
        P_MemtoReg=MemtoReg;
        P_MemWrite=MemWrite;
        P_ALUSrc=ALUSrc;
        P_RegWrite = RegWrite;
        P_RS1=RS1;
        P_RS2=RS2;
        P_RD=RD;
        P_ALUOp=ALUOp;
        P_Funct=Funct;
        P_imm_data=imm_data;
        P_ReadData1=ReadData1;
        P_ReadData2=ReadData2;
        P_PC_out=S_PC_out;
    end 
end 
endmodule
