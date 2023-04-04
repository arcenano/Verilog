`timescale 1ns / 1ps

module testbench(

    );
     // Inputs
   logic        clk,reset;
   logic [31:0] bus_A;
   logic [31:0] bus_B;   
   logic [4:0]  instruction;

   // Outputs
   logic [31:0] bus_out; 
   logic        Z;            // Zero
   logic        N;            // Negative
   logic        C;            // Carry
   logic        V;            // Overflow
   
  clk_reset_gen #(
    .CLK_RATE(100_000_000)
  ) clk_gen (
    .clk  (clk),
    .reset(reset)
  );
  
  ALU UUT (
  .clk(clk), 
  .reset(reset), 
  .bus_A(bus_A),
  .bus_B(bus_B),
  .instruction(instruction),
  .out_bus(bus_out),
  .Z(Z),
  .N(N),
  .C(C),
  .V(V)
   );
   
  initial begin
    wait(!reset);
    // ===== LOAD =====
    instruction = 5'h01;
    bus_A = 12345;
    #1;
   
    $display("Loading 12345, Out = %d", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // ===== ADD =====
    instruction = 5'h03;

    // Regular Addition
    bus_B = 54321;
    #1
    $display("Adding 54321 to 12345, Out = %d", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // Carry
    bus_A = 32'b11111111111111111111111111111111;
    bus_B = 1;    
    #1;
    $display("b11111111111111111111111111111111 + 1 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;  
    
    // Overflow
    bus_A = 32'b11111111111111111111111111111111;
    bus_B = 32'b10000000000000000000000000000000;    
    #1;
    $display("b11111111111111111111111111111111 + b10000000000000000000000000000000 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;      
    
    // ===== SUB =====
    instruction = 5'h04;
    // No Overflow
    bus_A = 10000;
    bus_B = 10000;
    #1;
    $display("10000-10000 = %d", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
   
   // Overflow
    bus_A = 32'b10000000000000000000000000000000;
    bus_B = 32'b00000000000000000000000000000001;
    #1;
    $display("b10000000000000000000000000000000 - b00000000000000000000000000000001 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // AND
    instruction = 5'h05;
    bus_A = 32'b10101010101010101010101010101010;
    bus_B = 32'b11111111111111110000000000000000;
    #1;
    $display("10101010101010101010101010101010 & 11111111111111110000000000000000 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // OR
    instruction = 5'h06;
    #1;
    $display("10101010101010101010101010101010 OR 11111111111111110000000000000000 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // XOR
    instruction = 5'h07;
    #1;
    $display("10101010101010101010101010101010 XOR 11111111111111110000000000000000 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // NOT
    instruction = 5'h08;
    #1;
    $display("NOT 10101010101010101010101010101010 = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // SL
    instruction = 5'h09;
    #1;
    $display("10101010101010101010101010101010 Shifted Left = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
    
    // SR
    instruction = 5'h0A;
    #1;
    $display("10101010101010101010101010101010 Shifted Right = %b", bus_out);
    $display("--------------");
    $display("Z | N | C | V");
    $display("%b | %b | %b | %b", Z,N,C,V);
    $display("-------------------------------------");
    #10;
  end
  
//  localparam LD = 4'h0x01;
//  localparam ADD = 4'h0x03;
//  localparam SUB = 4'h0x04;
//  localparam ANDD = 4'h0x05;
//  localparam ORR = 4'h0x06;
//  localparam XORR = 4'h0x07;
//  localparam NOTT = 4'h0x08;
//  localparam SL = 4'h0x09;
//  localparam SR = 4'h0x0A;
  
 
endmodule
