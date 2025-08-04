`timescale 1ns / 1ps

module TIMER(
    input wire clk,
    input wire rst,
    input wire [31:0] addr,
    input wire we,
    input wire [31:0] wdata,
    output reg [31:0] rdata
);

    reg [31:0] time_cnt;
    reg [31:0] freq_cnt;

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1)
        begin
            rdata<=32'h0;
        end
        else
        begin
            if(time_cnt==32'h0)
            begin
                if(rdata==32'hffffffff)
                begin
                    rdata<=32'h0;
                end
                else
                begin
                    rdata<=rdata+32'h1;
                end
            end
            else
            begin
                rdata<=rdata;
            end
        end
    end

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1)
        begin
            freq_cnt<=32'h5;
        end
        else
        begin
            if(we==1'b1 && addr==32'hfffff024)
            begin
                freq_cnt<=wdata;
            end
            else
            begin
                freq_cnt<=freq_cnt;
            end
        end
    end

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1)
        begin
            time_cnt<=32'h0;
        end
        else
        begin
            if(freq_cnt==32'h0)
            begin
                if(time_cnt==32'h4)
                begin
                    time_cnt<=32'h0;
                end
                else
                begin
                    time_cnt<=time_cnt+32'h1;
                end
            end
            else
            begin
                if(time_cnt==freq_cnt || time_cnt>=32'h2000)
                begin
                    time_cnt<=32'h0;
                end
                else
                begin
                    time_cnt<=time_cnt+32'h1;
                end
            end
        end
    end
    
endmodule