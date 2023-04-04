`timescale 1ns / 1ps

module ROM(
    input  logic         clk,
    input  logic         reset,
    input  logic         enable,
    input  logic   [3:0] addra,
    output logic   [3:0] douta
    );
    
    logic ena;
    
    assign ena = enable && !reset;
   
    blk_mem_gen_0 ROM (
     .clka(clk),    // input wire clka
     .ena(ena),      // input wire ena
     .addra(addra),  // input wire [3 : 0] addra
     .douta(douta)  // output wire [3 : 0] douta
);
endmodule
