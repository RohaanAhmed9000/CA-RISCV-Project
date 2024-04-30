`timescale 1ns / 1ps

module Data_Memory(
input [63:0] Mem_Addr,
input [63:0] WriteData,
input clk,
input MemWrite,
input MemRead,
output reg [63:0] ReadData,
output [63:0] Al_1,
output [63:0] Al_2,
output [63:0] Al_3,
output [63:0] Al_4,
output [63:0] Al_5,
output [63:0] Al_6,
output [63:0] Al_7,
output [63:0] Al_8

);
reg [7:0] Memory [100:0]; 
integer k;
initial
begin
//take loop to assign 0 to all 100 

for (k = 0 ; k < 100 ; k = k + 1)
begin
    Memory[k] = 0; 
end 

Memory[0] = 8'd57;
Memory[8] = 8'd58;
Memory[16] = 8'd59;
Memory[24] = 8'd60;
Memory[32] = 8'd61;
Memory[40] = 8'd62;
Memory[48] = 8'd63;
Memory[56] = 8'd64;

end 
    assign AL_1 = {Memory[7], Memory[6], Memory[5], Memory[4], Memory[3], Memory[2], Memory[1],Memory[0]};
    assign AL_2 = {Memory[15], Memory[14], Memory[13], Memory[12], Memory[11], Memory[10], Memory[9], Memory[8]};
    assign AL_3 = {Memory[23],Memory[22], Memory[21], Memory[20], Memory[19], Memory[18], Memory[17], Memory[16]};
    assign AL_4 = {Memory[31],Memory[30], Memory[29], Memory[28], Memory[27], Memory[26], Memory[25], Memory[24]};
    assign AL_5 = {Memory[39],Memory[38], Memory[37], Memory[36], Memory[35], Memory[34], Memory[33], Memory[32]};
    assign AL_6 = {Memory[47],Memory[46], Memory[45], Memory[44], Memory[43], Memory[42], Memory[41], Memory[40]};
    assign AL_7 = {Memory[55],Memory[54], Memory[53], Memory[52], Memory[51], Memory[50], Memory[49], Memory[48]};
    assign AL_8 = {Memory[63],Memory[62], Memory[61], Memory[60], Memory[59], Memory[58], Memory[57], Memory[56]};
   
   
always@ (*)
 begin
 if (MemRead == 1'b1)
 
 begin
 ReadData[7:0] <= Memory[Mem_Addr+0];
 ReadData[15:8] <= Memory[Mem_Addr+1];
 ReadData[23:16] <= Memory[Mem_Addr+2];
 ReadData[31:24] <= Memory[Mem_Addr+3];
 ReadData[39:32] <= Memory[Mem_Addr+4];
 ReadData[47:40] <= Memory[Mem_Addr+5];
 ReadData[55:48] <= Memory[Mem_Addr+6];
 ReadData[63:56] <= Memory[Mem_Addr+7];

end
end
always@ (posedge clk)
//always@(*)
 begin
 if (MemWrite == 1'b1)
 begin
 Memory[Mem_Addr+7] <= WriteData[63:56];
 Memory[Mem_Addr+6] <= WriteData[55:48];
 Memory[Mem_Addr+5] <= WriteData[47:40];
 Memory[Mem_Addr+4] <= WriteData[39:32];
 Memory[Mem_Addr+3] <= WriteData[31:24];
 Memory[Mem_Addr+2] <= WriteData[23:16];
 Memory[Mem_Addr+1] <= WriteData[15:8];
 Memory[Mem_Addr] <= WriteData[7:0];
 end
 end
endmodule