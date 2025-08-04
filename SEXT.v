`timescale 1ns / 1ps

module SEXT(
    input wire [2:0] op,
    input wire [31:7] imm,
    output reg [31:0] ext
);

    always @(*)
    begin
        if(op==3'b000)//u
        begin
            ext={imm[31:12],12'b0};
        end
        else if(op==3'b001)//i
        begin
            if(imm[31]==1'b1)
            begin
                ext={20'hFFFFF,imm[31:20]};
            end
            else
            begin
                ext={20'h0,imm[31:20]};
            end
        end
        else if(op==3'b010)//b
        begin
            if(imm[31]==1'b1)
            begin
                ext={3'b111,16'hFFFF,imm[31],imm[7],imm[30:25],imm[11:8],1'b0};
            end
            else
            begin
                ext={19'h0,imm[31],imm[7],imm[30:25],imm[11:8],1'b0};
            end
        end
        else if(op==3'b100)//jal
        begin
            if(imm[31]==1'b1)
            begin
                ext={11'h7FF,imm[31],imm[19:12],imm[20],imm[30:21],1'b0};
            end
            else
            begin
                ext={11'h0,imm[31],imm[19:12],imm[20],imm[30:21],1'b0};
            end
        end
        else if(op==3'b011)//sw
        begin
            if(imm[31]==1'b1)
            begin
                ext={20'hFFFFF,imm[31:25],imm[11:7]};
            end
            else
            begin
                ext={20'h0,imm[31:25],imm[11:7]};
            end
        end
        else
        begin
            ext=32'b0;
        end
    end
endmodule
