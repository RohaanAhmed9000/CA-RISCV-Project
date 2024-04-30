`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 08:46:10 AM
// Design Name: 
// Module Name: Hazard_Control_stage
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


module Hazard_Control_stage(
input [4:0]RS1,
input[4:0]RS2,
input [4:0]P_RD,
input P_MemRead,
output reg stall);

always @(*) 
begin 
    if (P_MemRead && ( P_RD == RS1 || P_RD ==RS2)) // check if register needs rd in WB
        begin 
            stall = 1'b1; ///
        end 
    else 
        begin 
            stall = 1'b0;
        end
end 

endmodule
