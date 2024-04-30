`timescale 1ns / 1ps


module RISCV_SCProcessor(
    input clk, 
    input reset
    );
    
    wire [63:0] PC_in, PC_out, ReadData, ReadData1, ReadData2, WriteData, ImmData, Result; 
    wire [63:0] shifted_data, Data_Out, Out1, Out2;
    wire [31:0] Instruction;
    wire [6:0] opcode, func7; 
    wire [2:0] func3;  
    wire [4:0] RS1, RS2, RD;
    wire [3:0] Operation, Funct;
    wire [1:0] ALUOp;
    wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Zero, Branch, PCSrc ; 
    wire stall;
    wire EM_Branch,EM_MemRead,EM_MemtoReg,EM_MemWrite,EM_ALUSrc,EM_RegWrite;
    wire [4:0] EM_rd;
    wire EM_zero;
    wire [63:0] EM_Result;// alu 64 bit result
    wire [63:0] EM_out; //ouput from adder
    wire [63:0] EM_WriteData;
    wire WB_MemtoReg, WB_RegWrite;
    wire [4:0] WB_RD;
    wire [63:0] WB_Result;// alu 64 bit result
    wire [63:0] WB_ReadData;
    wire [63:0] S_PC_out;// pc_out from if/id
    wire [31:0] S_inst;// instruction from if/id
    wire P_Branch,P_MemRead,P_MemtoReg,P_MemWrite,P_ALUSrc,P_RegWrite;
    wire [4:0] P_RS1, P_RS2, P_RD;
    wire [3:0] P_Funct;
    wire [1:0] P_ALUOp;
    wire [63:0] P_PC_out, P_ReadData1, P_ReadData2, P_imm_data;
    wire [1:0] Forward_A, Forward_B; // all outputs from from id/ex stage
    
    // IF 
    Adder FOURADDER(PC_out, 64'd4, Out1);
    Mux_2x1 BRANCH(Out1, EM_out, (Branch & Zero), PC_in);
    Program_Counter PC(clk, reset, PC_in, stall, PC_out);
    Instruction_Memory IM(PC_out, Instruction);
    IF_ID_stage sadw(clk, reset,Instruction, PC_out, S_inst, S_PC_out);
    Hazard_Control_stage tw(rs1,rs2,P_RD,EM_MemRead,stall);//Task 3, implementing hazard detection
    

    // ID    
    Instruction_Parser IP(S_inst, opcode, RD, func3, RS1, RS2, func7);
    Imm_Gen IG(S_inst, ImmData);
    Control_Unit CU(opcode, stall, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
    Register_File RF(WriteData, RS1, RS2, WB_RD, WB_RegWrite, clk, reset, ReadData1, ReadData2);
    

    assign Funct = {S_inst[30], S_inst[14:12]};
    ID_EX_stage jks(clk, reset,Branch, MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, 
    ALUOp,Funct, RS1, RS2, RD, S_PC_out, ReadData1, ReadData2, ImmData,P_Branch, P_MemRead,
    P_MemWrite, P_MemtoReg, P_RegWrite, P_ALUSrc,P_ALUOp, P_Funct, P_RS1, P_RS2, P_RD,P_PC_out,
    P_ReadData1, P_ReadData2, P_imm_data);

    
    // EXE 
    assign shifted_data = ImmData << 1;
    Adder BRANCHADDER(P_PC_out, shifted_data, Out2); 
    Mux_2x1 ALUSRC(P_ReadData2, P_imm_data, P_ALUSrc, Data_Out);
    // forwarding unit stage 
    ALU_Control ALUC(P_ALUOp, P_Funct, Operation);
    ForwardAB_stage apar(P_RS1,P_RS2,WB_RD,EM_rd,WB_MemtoReg, WB_RegWrite, P_RegWrite,Forward_A, Forward_B);
    
    Mux_3x1 a1(P_ReadData1, WriteData, EM_Result, Forward_A,ForwardA_out); //multiplexer 1
    Mux_3x1 a2(P_ReadData2, WriteData, EM_Result, Forward_B,ForwardB_out); //multiplexer 2
    Mux_2x1 EX_MEM(ForwardB_out, P_imm_data, P_ALUSrc, data_out1); // multiplexer 3
    // between ID/EX and EX/MEM Stage 
    ALU64 aad(data_out1,ForwardA_out,ALUOp,Result,zero);  
    
    EX_MEM_stage mso(P_Branch,P_MemRead,P_MemtoReg,P_MemWrite,P_ALUSrc,P_RegWrite,clk, reset,
    P_RD,zero, Result, out,WriteData,EM_Branch,EM_MemRead,EM_MemtoReg,EM_MemWrite,EM_ALUSrc,EM_RegWrite,EM_rd,EM_zero,EM_Result, EM_out, EM_WriteData);
    
    // MEM
    Data_Memory DM(EM_Result, EM_ReadData2, clk, EM_MemWrite, EM_MemRead, ReadData);
    MEM_WB_stage sas(clk, reset, EM_MemtoReg,EM_RegWrite,EM_RDrd,EM_Result, ReadData,WB_MemtoReg, WB_RegWrite,
    WB_rd,WB_Result,WB_ReadData);
    

    // WB
    Mux_2x1 WB(WB_Result, WB_ReadData, WB_MemtoReg, WriteData);
 

endmodule