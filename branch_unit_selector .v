`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 11:03:58 AM
// Design Name: 
// Module Name: branch_unit_selector
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


module branch_unit_selector(
    input [3:0] Funct,
    input [63:0] ReadData1,
    input [63:0] b,
    output reg select_mux
    
    );
initial 
    begin 
        select_mux=1'b0;
    end 
always  @(*)
begin 
    case (Funct [2:0])
        3'b000: 
            begin
                if (ReadData1 == b) 
                    select_mux =1'b0; 
                else 
                    select_mux =1'b0; 
                end 
        3'b100:
             begin
                if (ReadData1 > b) 
                    select_mux =1'b1; 
                else 
                    select_mux =1'b0; 
                end 
        3'b101:
             begin
                if (ReadData1 < b) 
                    select_mux =1'b1; 
                else 
                    select_mux =1'b0; 
                end     
                        
    endcase 
end             
endmodule
