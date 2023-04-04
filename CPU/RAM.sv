`timescale 1ns / 1ps

module RAM(
    input  logic         clk,
    input  logic         reset,
    input  logic         enable,
    input  logic         wea,
    input  logic   [3:0] addra,
    input  logic   [3:0] dina,
    output logic   [3:0] douta
    );
    
    logic ena;
    
    assign ena = enable && !reset;
       
    blk_mem_gen_1 RAM (
      .clka(clk),    // input wire clka
      .ena(ena),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addra),  // input wire [3 : 0] addra
      .dina(dina),    // input wire [3 : 0] dina
      .douta(douta)  // output wire [3 : 0] douta
    );
endmodule



