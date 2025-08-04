`timescale 1ns / 1ps

module ALU(
    input wire [3:0] op,
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] c,
    output reg f
);

    always @(*)
    begin
        if(op==4'b0000)//+
        begin
            c=a+b;
            f=0;
        end
        else if(op==4'b0001)//-
        begin
            c=$signed(a)-$signed(b);
            f=0;
        end
        else if(op==4'b0010)//eq
        begin
            c=a-b;
            if(a==b)
            begin
                f=1'b1;
            end
            else
            begin
                f=1'b0;
            end
        end
        else if(op==4'b0100)//ne
        begin
            c=a-b;
            if(a!=b)
            begin
                f=1'b1;
            end
            else
            begin
                f=1'b0;
            end
        end
        else if(op==4'b0011)//lt
        begin
            c=a-b;
            if($signed(a)<$signed(b))
            begin
                f=1'b1;
            end
            else
            begin
                f=1'b0;
            end
        end
        else if(op==4'b1111)//and
        begin
            c=a&b;
            f=0;
        end
        else if(op==4'b1110)//or
        begin
            c=a|b;
            f=0;
        end
        else if(op==4'b1101)//xor
        begin
            c=a^b;
            f=0;
        end
        else if(op==4'b1000)//sra
        begin
            c=$signed(a)>>>b[4:0];
            f=0;
        end
        else if(op==4'b1001)//srl
        begin
            c=a>>b[4:0];
            f=0;
        end
        else if(op==4'b1010)//sll
        begin
            c=a<<b[4:0];
            f=0;
        end
        else
        begin
            c=0;
            f=0;
        end
    end
endmodule
