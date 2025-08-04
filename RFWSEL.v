`timescale 1ns / 1ps

module RFWSEL(
    input wire [1:0] op,
    input [31:0] aluc,
    input [31:0] dram,
    input [31:0] pc4,
    input [31:0] ext,
    output reg [31:0] out
);

always @(*) 
begin
    if(op==2'b00)
    begin
        out=aluc;
    end
    else if(op==2'b01)
    begin
        out=dram;
    end
    else if(op==2'b10)
    begin
        out=pc4;
    end
    else if(op==2'b11)
    begin
        out=ext;
    end
    else
    begin
        out=32'b0;
    end
end
endmodule