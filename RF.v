`timescale 1ns / 1ps

module RF(//regfile
    input wire clk,
    input wire rst,
    input wire [4:0] rR1,
    input wire [4:0] rR2,
    input wire we,//write_enable
    input wire [4:0] wR,
    input wire [31:0] wD,

    output reg [31:0] rD1,
    output reg [31:0] rD2
);

    reg [31:0] regfile [31:0];
    
    always @(posedge clk or posedge rst)
    begin
        if(rst==1'b1)
        begin
            regfile[0]<=32'h0;
            regfile[1]<=32'h0;
            regfile[2]<=32'h0;
            regfile[3]<=32'h0;
            regfile[4]<=32'h0;
            regfile[5]<=32'h0;
            regfile[6]<=32'h0;
            regfile[7]<=32'h0;
            regfile[8]<=32'h0;
            regfile[9]<=32'h0;
            regfile[10]<=32'h0;
            regfile[11]<=32'h0;
            regfile[12]<=32'h0;
            regfile[13]<=32'h0;
            regfile[14]<=32'h0;
            regfile[15]<=32'h0;
            regfile[16]<=32'h0;
            regfile[17]<=32'h0;
            regfile[18]<=32'h0;
            regfile[19]<=32'h0;
            regfile[20]<=32'h0;
            regfile[21]<=32'h0;
            regfile[22]<=32'h0;
            regfile[23]<=32'h0;
            regfile[24]<=32'h0;
            regfile[25]<=32'h0;
            regfile[26]<=32'h0;
            regfile[27]<=32'h0;
            regfile[28]<=32'h0;
            regfile[29]<=32'h0;
            regfile[30]<=32'h0;
            regfile[31]<=32'h0;
        end
        else
        begin
            if(we==1'b1 && wR!=5'h0)
            begin
                regfile[wR]<=wD;
            end
            else
            begin
            end
        end
    end

    always @(*)
    begin
        rD1=regfile[rR1];
        rD2=regfile[rR2];
    end

endmodule