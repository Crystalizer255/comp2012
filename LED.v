`timescale 1ns / 1ps

module LED(
    input wire clk,
    input wire rst,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] wdata,
    output reg [23:0] led
);

    reg [31:0] inner_data;

    always @(posedge clk or posedge rst)
    begin
        if(rst==1'b1)
        begin
            inner_data<=32'b0;
        end
        else
        begin
            if(we==1'b1 && addr==32'hfffff060)
            begin
                inner_data<=wdata;
            end
            else
            begin
                inner_data<=inner_data;
            end
        end
    end

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1) 
        begin
            led<=24'b0;
        end 
        else
        begin
            led<=inner_data[23:0];
        end
    end
endmodule