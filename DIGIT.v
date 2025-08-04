`timescale 1ns / 1ps

module DIGIT(
    input wire clk,
    input wire rst,
    input wire [31:0] addr,
    input wire [31:0] wdata,
    input wire we,

    output wire led_a_n,
    output wire led_b_n,
    output wire led_c_n,
    output wire led_d_n,
    output wire led_e_n,
    output wire led_f_n,
    output wire led_g_n,
    output wire led_h_n,
    output reg [7:0] led_en_n

);
    reg [7:0] led_n;
    reg [31:0] fresh_time;
    reg [2:0] loc;
    reg [3:0] num;
    reg [31:0] inner_data;

    assign led_a_n=led_n[0];
    assign led_b_n=led_n[1];
    assign led_c_n=led_n[2];
    assign led_d_n=led_n[3];
    assign led_e_n=led_n[4];
    assign led_f_n=led_n[5];
    assign led_g_n=led_n[6];
    assign led_h_n=led_n[7];


    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1)
        begin
            inner_data<=32'B0;
        end
        else
        begin
            if(we==1'b1)
            begin
                inner_data<=wdata;
            end
            else
            begin
                inner_data<=inner_data;
            end
        end
    end

    always @(posedge clk or posedge rst) //num
    begin
        if(rst==1'b1)
        begin
            num<=3'hf;
        end
        else
        begin
            if(loc==3'b000)
            begin
                num<=inner_data[3:0];
            end
            else if(loc==3'b001)
            begin
                num<=inner_data[7:4];
            end
            else if(loc==3'b010)
            begin
                num<=inner_data[11:8];
            end
            else if(loc==3'b011)
            begin
                num<=inner_data[15:12];
            end
            else if(loc==3'b100)
            begin
                num<=inner_data[19:16];
            end
            else if(loc==3'b101)
            begin
                num<=inner_data[23:20];
            end
            else if(loc==3'b110)
            begin
                num<=inner_data[27:24];
            end
            else if(loc==3'b111)
            begin
                num<=inner_data[31:28];
            end
            else
            begin
                num<=32'b0;
            end
        end
    end


    always @(posedge clk or posedge rst) //en_n
    begin
        if(rst==1'b1) 
        begin
            led_en_n<=8'b11111110;
        end
        else 
        begin
            if(loc==3'b000) 
            begin
                led_en_n<=8'b11111110;
            end
            else if(loc==3'b001)
            begin
                led_en_n<=8'b11111101;
            end
            else if(loc==3'b010)
            begin
                led_en_n<=8'b11111011;
            end
            else if(loc==3'b011)
            begin
                led_en_n<=8'b11110111;
            end
            else if(loc==3'b100)
            begin
                led_en_n<=8'b11101111;
            end
            else if(loc==3'b101) 
            begin
                led_en_n<=8'b11011111;
            end
            else if(loc==3'b110)
            begin
                led_en_n<=8'b10111111;
            end
            else if(loc==3'b111) 
            begin
                led_en_n<=8'b01111111;
            end
            else 
            begin
                led_en_n<=8'b01111111;
            end
        end
    end

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1)
        begin
            fresh_time<=3'b0;
        end
        else
        begin
            if(fresh_time>=32'd20)
            begin
                fresh_time<=32'd0;
            end
            else
            begin
                fresh_time<=fresh_time+32'd1;
            end
        end
    end

    always @(posedge clk or posedge rst)
    begin
        if(rst==1'b1)
        begin
            loc<=3'b000;
        end
        else
        begin
            if(fresh_time==32'd10)
            begin
                if(loc==3'b111)
                begin
                    loc<=3'b000;
                end
                else
                begin
                    loc<=loc+3'b1;
                end
            end
        end
    end

    always @(posedge clk or posedge rst) 
    begin
        if(rst==1'b1)
        begin
            led_n=8'b00111111;
        end
        else 
        begin
            if(num==4'h0)
            begin
                led_n<=8'b11000000;
            end
            else if(num==4'h1)
            begin
                led_n<=8'b11111001;
            end
            else if(num==4'h2)
            begin
                led_n<=8'b10100100;
            end
            else if(num==4'h3)
            begin
                led_n<=8'b10110000;
            end
            else if(num==4'h4)
            begin
                led_n<=8'b10011001;
            end
            else if(num==4'h5)
            begin
                led_n<=8'b10010010;
            end
            else if(num==4'h6)
            begin
                led_n<=8'b10000010;
            end
            else if(num==4'h7)
            begin
                led_n<=8'b11111000;
            end
            else if(num==4'h8)
            begin
                led_n<=8'b10000000;
            end
            else if(num==4'h9)
            begin
                led_n<=8'b10011000;
            end
            else if(num==4'hA)
            begin
                led_n<=8'b10001000;
            end
            else if(num==4'hB)//b
            begin
                led_n<=8'b10000011;
            end
            else if(num==4'hC)//c
            begin
                led_n<=8'b10100111;
            end
            else if(num==4'hD)//d
            begin
                led_n<=8'b10100001;
            end
            else if(num==4'hE)
            begin
                led_n<=8'b10000110;
            end
            else if(num==4'hF)
            begin
                led_n<=8'b10001110;
            end
            else
            begin
                led_n<=8'b01111111;
            end
        end
    end

endmodule