`timescale 1ns / 1ps

module SW(
    input wire clk,
    input wire rst,
    input wire [23:0] sw,
    input wire [31:0] addr,
    output reg [31:0] rdata
);

    always@(*)
    begin
        if(rst==1'b1)
        begin
            rdata=32'b0;
        end
        else
        begin
            rdata={8'b0,sw};
        end
    end
endmodule