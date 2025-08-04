`timescale 1ns / 1ps

module ALUBSEL(
    input wire op,     
    input wire [31:0] rd2,
    input wire [31:0] ext,
    output reg [31:0] out
);
    always @(*)
    begin
        if(op==1'b0)
        begin
            out=rd2;
        end
        else
        begin
            out=ext;
        end
    end
endmodule