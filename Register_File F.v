`timescale 1ns / 1ps

module Register_File(
    
    // inputs
    input [63:0] WriteData,
    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] RD,
    input RegWrite,
    input clk,
    input reset,
    // outputs
    output reg [63:0] ReadData1,
    output reg [63:0] ReadData2
    // initializing an array of registers
    );
    reg [63:0] Registers [31:0];
    // putting random values into the registers
    integer k;
    initial
    begin
    for (k = 0 ; k < 31 ; k = k + 1)begin 
        Registers[k] = 0;
    end
        Registers[0] <= 64'd1; 
        Registers[1] <= 64'd2; 
        Registers[2] <= 64'd3; 
        Registers[3] <= 64'd4; 
        Registers[4] <= 64'd4; 
        Registers[5] <= 64'd6; 
        Registers[6] <= 64'd6; 
        Registers[7] <= 64'd7; 
    end 
    
    // reading
    always @(*)
    begin
    if (reset) 
       begin
       ReadData1 = 0; 
       ReadData2 = 0;
       end
       else begin
       // reading the register values and storing
        ReadData1 <= Registers[RS1]; 
        ReadData2 <= Registers[RS2];
        end
      end
    // writing
    always @(negedge clk)
    begin 
       if (RegWrite)
       begin
       Registers[RD] <= WriteData;
       end
    end
endmodule