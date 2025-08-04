`timescale 1ns / 1ps

module BUTTON(
    input wire clk,
    input wire rst,
    input wire [31:0] addr,
    input wire [4:0] button,
    output reg [31:0] rdata
);

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1) 
        begin
            rdata<=32'h0;
        end 
        else 
        begin
            rdata<={27'd0,button};
        end
    end
endmodule