`timescale 1ns / 1ps

module NPC(
    input wire [31:0] pc,
    input wire [31:0] aluc,
    input wire [31:0] offset,//offset bits
    input wire br,//aluf
    input wire [1:0] op,//npc_op
    input wire jr_sel,//npc_jrsel
    output reg [31:0] npc,
    output reg [31:0] pc4
);

    always @(*) 
    begin
        if(op==2'b00)//pc4
        begin
            npc=pc+32'h4;
        end
        else if(op==2'b01)//b
        begin
            if(br==1'b0)
            begin
                npc=pc+32'h4;
            end
            else
            begin
                npc=pc+offset;        
            end
        end
        else if(op==2'b10)//j
        begin
            npc=pc+offset;
        end
        else if(op==2'b11)//jr
        begin
            npc=aluc;
        end
        else
        begin
            npc=32'b0;
        end
    end

    always @(*) 
    begin   
        pc4=pc+32'h4;
    end
    
endmodule
