`timescale 1ns / 1ps
module Program_Counter(clk, reset,PC_In, stall, PC_Out);
// inputs
input clk, reset;
input [63:0] PC_In;
input stall;
// outputs
output reg [63:0] PC_Out;

always @ (posedge clk or posedge reset)
begin
if (reset == 1'b1)
    PC_Out <= 64'b0;
else if(stall == 1'b1) 
    PC_Out <= PC_Out;
else 
    begin
    PC_Out <= PC_In;
    end
end
endmodule