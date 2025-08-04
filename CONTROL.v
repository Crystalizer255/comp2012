`timescale 1ns / 1ps

module CONTROL(
    input wire [6:0] opcode,
    input wire [6:0] fun7,
    input wire [2:0] fun3,

    output reg [1:0] npc_op,//fin
    output reg rf_we,//fin
    output reg [2:0] sext_op,//fin
    output reg [3:0] alu_op,//fin
    output reg [1:0] rf_wsel,//fin
    output reg alu_bsel,//fin
    output reg npc_jrsel,//fin
    output reg ram_we//fin
);
    
    always @(*) 
    begin
        if(fun3==3'b100)
        begin
            if(opcode==7'b0010011 || opcode==7'b0110011)
            begin
                alu_op=4'b1101;//xor
            end
            else if(opcode==7'b1100011)
            begin
                alu_op=4'b0011;//blt
            end
            else
            begin
                alu_op=4'b0000;
            end
        end
        else if(fun3==3'b111)
        begin
            alu_op=4'b1111;//and
        end
        else if(fun3==3'b110)
        begin
            alu_op=4'b1110;//xor
        end
        else if(fun3==3'b010)
        begin
            alu_op=4'b0000;//lw/sw:add
        end
        else if(fun3==3'b001)
        begin
            if(opcode==7'b1100011)
            begin
                alu_op=4'b0100;//bne
            end
            else
            begin
                alu_op=4'b1010;//sll
            end
        end
        else if(fun3==3'b101)
        begin
            if(fun7==7'b0)
            begin
                alu_op=4'b1001;//srl
            end
            else
            begin
                alu_op=4'b1000;//sra
            end
        end
        else if(fun3==3'b000)
        begin
            if(opcode==7'b1100011)
            begin
                alu_op=4'b0010;//beq
            end
            else if(opcode==7'b0110011)
            begin
                if(fun7==7'b0)
                begin
                    alu_op=4'b0000;//add
                end
                else
                begin
                    alu_op=4'b0001;//sub
                end
            end
            else
            begin
                alu_op=4'b0000;//addi/jr
            end
        end
    end

    always @(*) 
    begin
        if(opcode==7'b0010011 || opcode==7'b0000011 || opcode==7'b0100011 || opcode==7'b1100111)
        begin
            alu_bsel=1'b1;
        end
        else
        begin
            alu_bsel=1'b0;
        end
    end

    always @(*) 
    begin
        if(opcode==7'b0100011)
        begin
            ram_we=1'b1;
        end    
        else
        begin
            ram_we=1'b0;
        end
    end

    always @(*) 
    begin
        if(opcode==7'b1100111 && fun3==3'b000)
        begin
            npc_jrsel=1'b1;
        end
        else
        begin
            npc_jrsel=1'b0;
        end
    end

    always @(*) 
    begin
        if(opcode==7'b1100111 && fun3==3'b000)//jr
        begin
            npc_op=2'b11;
        end
        else if(opcode==7'b1101111)//jal
        begin
            npc_op=2'b10;
        end
        else if(opcode==7'b1100011)//b
        begin
            npc_op=2'b01;
        end
        else
        begin
            npc_op=2'b00;
        end
    end

    always @(*)
    begin
        if(opcode==7'b0100011 || opcode==7'b1100011)
        begin
            rf_we=1'b0;
        end    
        else
        begin
            rf_we=1'b1;
        end
    end


    always @(*) 
    begin
        if(opcode==7'b0110111)//lui
        begin
            rf_wsel=2'b11;
        end
        else if(opcode==7'b1100111 || opcode==7'b1101111)//jal/jr
        begin
            rf_wsel=2'b10;
        end
        else if(opcode==7'b0000011)//lw
        begin
            rf_wsel=2'b01;
        end
        else
        begin
            rf_wsel=2'b00;
        end
    end

    always @(*) 
    begin
        if(opcode==7'b1101111)//jal
        begin
            sext_op=3'b100;
        end
        else if(opcode==7'b1100011)//b
        begin
            sext_op=3'b010;
        end
        else if(opcode==7'b0110111)//u
        begin
            sext_op=3'b000;
        end
        else if(opcode==7'b0100011)//sw
        begin
            sext_op=3'b011;
        end
        else
        begin
            sext_op=3'b001;
        end
    end
endmodule