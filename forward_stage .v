`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 11:20:11 AM
// Design Name: 
// Module Name: forward_stage
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


module ForwardAB_stage(
// forwarding unit stage 
    input [4:0] P_RS1,
    input [4:0] P_RS2,
    input [4:0] WB_RD,
    input [4:0] EM_rd,
    input WB_MemtoReg, WB_RegWrite, P_RegWrite,
    output reg [1:0] Forward_A, Forward_B

    );
    
always @(*) 
    begin  
        if ((EM_rd == P_RS1) && (P_RegWrite != 0 && (P_RS1 !=0))) // WriteRegM // not condition 
            begin 
                Forward_A = 2'b10;
            end 
        else 
            begin 
                // for deadling with mem hazard ,  (not included)
                if(((WB_RD == P_RS1) && (WB_RegWrite != 0 && P_RS1 != 0) && (WB_RD != 0)) && ~((EM_rd == P_RS1) && (P_RegWrite != 0 && (P_RS1 !=0)))) // WriteRegW
                    begin 
                        Forward_A = 2'b01;
                    end 
                else 
                    begin 
                        Forward_A = 2'b00;
                    end 
            end 
            
           
        if (( EM_rd ==P_RS2) && ( P_RegWrite != 0 && (P_RS2 !=0)))
            begin 
                Forward_B = 2'b01;

            end 
        else 
            begin // for mem hazard not condition  
            if ((( WB_RD == P_RS2) && ( WB_RegWrite != 0 && (P_RS2 !=0 ) && (WB_RD !=0))) && ~(( EM_rd ==P_RS2) && ( P_RegWrite != 0 && (P_RS2 !=0))))
                begin                                   
                    Forward_B = 2'b01;
                end 
            else 
                begin 
                    Forward_B = 2'b00;
                end 
           end 
   end 
endmodule
