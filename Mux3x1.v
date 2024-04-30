`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 10:12:37 AM
// Design Name: 
// Module Name: Mux_3x1
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


module Mux_3x1(input [63:0] a, input [63:0] b, input [63:0] c,
input [1:0] sel, output reg [63:0] data_out_mux);

always @(*) //parameters which trigger reevaluation- their values change
begin
    case(sel[1:0])  //2 inputs-  2 possibilities
        2'b00: 
        data_out_mux = a; //if sel = 0 then data is a else b
        2'b01: 
        data_out_mux = b; 
        2'b10: 
        data_out_mux = c; 
        
    endcase

end
endmodule

