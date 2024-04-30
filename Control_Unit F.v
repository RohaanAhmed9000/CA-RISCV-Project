`timescale 1ns / 1ps

module Control_Unit(opcode,stall, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
// inputs
input [6:0] opcode;
// outputs
input stall;
output reg [1:0] ALUOp;
output reg Branch;
output reg MemRead;
output reg MemtoReg;
output reg MemWrite;
output reg ALUSrc;
output reg RegWrite;

always@(*)
begin
case (opcode)
    7'b0110011: // R - type
        begin
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b10;
        end 
    7'b0000011: // I - Type (ld)
        begin
        ALUSrc = 1;
        MemtoReg = 1;
        RegWrite = 1;
        MemRead = 1;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b00;
        end 
    7'b0100011: // S - Type (sd)
        begin
        ALUSrc = 1;
        MemtoReg = 1'bx;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 1;
        Branch = 0;
        ALUOp = 2'b00;
        end 
    7'b1100011: // SB - Type (beq)
        begin
        ALUSrc = 0;
        MemtoReg = 1'bx;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOp = 2'b01;
        end 
    7'b0010011: // I - Type (addi)
        begin
        ALUSrc = 1;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b00; 
        end 
        
    7'b1100011:
        begin
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOp = 2'b01;
        end 
        
       
    default: // initialize the control signals
        begin
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b00;
        end 
    endcase
    
    if(stall == 1'b1) //Task 3, stall flag being used
        begin 
            Branch =1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b00;
            MemWrite =1'b0;
            ALUSrc = 1'b1;
            RegWrite =1'b1;
         end 
            
end
endmodule
