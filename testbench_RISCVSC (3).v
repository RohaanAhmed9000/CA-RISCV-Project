`timescale 1ns / 1ps

module testbench_RISCVSC();

reg clk, reset;

RISCV_SCProcessor u1(clk, reset);

initial
begin
clk = 1; reset = 1;
#5 reset = 0;
end

always
#20 clk = ~clk;

endmodule