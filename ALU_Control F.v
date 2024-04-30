`timescale 1ns / 1ps

module ALU_Control(ALUOp, Funct, Operation);

input [1:0] ALUOp;
input [3:0] Funct;
output reg [3:0] Operation;

always@ (*)
begin
    case (ALUOp)
        2'b00:
        begin
            Operation = 4'b0010;
        end
        2'b01:
        begin
            case(Funct[2:0])
            3'b000:
                Operation = 4'b0110; //beq
            3'b100:
                Operation = 4'b1000; //blt
            endcase        
            
        end
        2'b10:
        begin
            case (Funct)
                4'b0000:
                    Operation = 4'b0010;
                4'b1000:
                    Operation = 4'b0110;
                4'b0111:
                    Operation = 4'b0000;
                4'b0110:
                    Operation = 4'b0001;
             endcase
        end
    endcase
end

endmodule