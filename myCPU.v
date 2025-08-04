`timescale 1ns / 1ps

`include "defines.vh"

module myCPU (
    input  wire         cpu_rst,
    input  wire         cpu_clk,

    // Interface to IROM
`ifdef RUN_TRACE
    output wire [15:0]  inst_addr,
`else
    output wire [13:0]  inst_addr,
`endif
    input  wire [31:0]  inst,

    // Interface to Bridge/dram
    output wire [31:0]  Bus_addr,
    input  wire [31:0]  Bus_rdata,
    output wire         Bus_we,
    output wire [31:0]  Bus_wdata

`ifdef RUN_TRACE
    ,// Debug Interface
    output wire         debug_wb_have_inst,
    output wire [31:0]  debug_wb_pc,
    output              debug_wb_ena,
    output wire [ 4:0]  debug_wb_reg,
    output wire [31:0]  debug_wb_value
`endif
    );

    // TODO:

    wire [31:0] NPC_npc;
    wire [31:0] PC_pc;
    wire [31:0] NPC_PC4;
    wire [31:0] ALU_C;
    wire ALU_F;
    wire [1:0] CTRL_NPC_OP;
    wire [31:0] SEXT_ext;
    wire CTRL_NPC_JRSEL;

    wire [31:0] ALU_A;
    wire [31:0] ALU_B;
    wire [3:0] CTRL_ALU_OP;
    wire CTRL_ALUBSEL;

    wire [31:0] RF_rd2;
    //wire [31:0] RF_rd1;
    wire CTRL_RF_WE;

    //wire [31:0] IROM_inst;
    wire [31:0] RF_wD;
    wire [1:0] CTRL_RFWSEL;
    wire [2:0] CTRL_SEXT_OP;

    assign inst_addr=PC_pc[15:2];
    //assign inst_addr=PC_pc[13:0];
    assign Bus_addr=ALU_C;
    assign Bus_we=CTRL_DRAM_WE;
    assign Bus_wdata=RF_rd2;

    SEXT U_SEXT (
        .ext (SEXT_ext),
        .imm (inst[31:7]),
        .op (CTRL_SEXT_OP)
    );

    NPC U_NPC (
        .offset (SEXT_ext),
        .pc (PC_pc),
        .npc (NPC_npc),
        .pc4 (NPC_PC4),
        .br (ALU_F),
        .aluc (ALU_C),
        .op (CTRL_NPC_OP),
        .jr_sel (CTRL_NPC_JRSEL)
    );

    PC U_PC (
        .rst (cpu_rst),
        .clk (cpu_clk),
        .din (NPC_npc),
        .pc (PC_pc)
    );

    ALU U_ALU (
        .op (CTRL_ALU_OP),
        .a (ALU_A),
        .b (ALU_B),
        .c (ALU_C),
        .f (ALU_F)
    );

    ALUBSEL U_ALUBSEL (
        .op (CTRL_ALUBSEL),
        .ext (SEXT_ext),
        .rd2 (RF_rd2),
        .out (ALU_B)
    );

    RF U_RF (
        .rD1 (ALU_A),
        .rD2 (RF_rd2),
        .clk (cpu_clk),
        .rst (cpu_rst),
        .rR1 (inst[19:15]),
        .rR2 (inst[24:20]),
        .wR (inst[11:7]),
        .we (CTRL_RF_WE),
        .wD (RF_wD)
    );

    RFWSEL U_RFWSEL (
        .op (CTRL_RFWSEL),
        .aluc (ALU_C),
        .dram (Bus_rdata),//dram_rdo
        .pc4 (NPC_PC4),
        .ext (SEXT_ext),
        .out (RF_wD)
    );

    CONTROL U_CTRL (
        .opcode (inst[6:0]),
        .fun7 (inst[31:25]),
        .fun3 (inst[14:12]),
        //output
        .npc_op (CTRL_NPC_OP),
        .rf_we (CTRL_RF_WE),
        .sext_op (CTRL_SEXT_OP),
        .alu_op (CTRL_ALU_OP),
        .rf_wsel (CTRL_RFWSEL),
        .alu_bsel (CTRL_ALUBSEL),
        .npc_jrsel (CTRL_NPC_JRSEL),
        .ram_we (CTRL_DRAM_WE)
    );

`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst = 1'b1;
    assign debug_wb_pc        = PC_pc;
    assign debug_wb_ena       = CTRL_RF_WE;
    assign debug_wb_reg       = inst[11:7];
    assign debug_wb_value     = RF_wD;
`endif

endmodule