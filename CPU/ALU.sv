`timescale 1ns / 1ps

module ALU #(
//  parameter WIDTH       = 32,
//  parameter NUM_REGS    = 32
)( 
  // Inputs
  input  logic                        clk,
  input  logic                        reset,
  input  logic  [31:0]                bus_A,    
  input  logic  [31:0]                bus_B, 
  input  logic  [4:0]                 instruction,
  
  // Outputs
  output logic  [31:0]                out_bus,
  output logic                        Z,            // Zero
  output logic                        N,            // Negative
  output logic                        C,            // Carry
  output logic                        V             // Overflow
);
  
  localparam LD = 5'h01;
  localparam ADD = 5'h03;
  localparam SUB = 5'h04;
  localparam ANDD = 5'h05;
  localparam ORR = 5'h06;
  localparam XORR = 5'h07;
  localparam NOTT = 5'h08;
  localparam SL = 5'h09;
  localparam SR = 5'h0A;
  
  always_comb begin
    Z = (out_bus == 0) ? 1 : 0;       // Check if output is zero 
    N = (out_bus[31] == 1) ? 1 : 0;     // Check if output is negative
    
    // When adding if first bit of both buses the same and it changes then overflow ocurred
    // This is because a positive plus a positive will always be positive and a negative plus
    // a negative will always be negative. 
    V = ((instruction == ADD) && (bus_A[31] == bus_B[31]) && (bus_A[31] !== out_bus[31]))
    
    // When subtracting if first bit of both buses are different and the first bit of the output
    // isn't the same as the first bit of the minuend (bus_A) then overflow ocurred
    // This is because a negative minus a positive will never be positive,
    // and a positive minus a negative will never be negative. 
    || ((instruction == SUB) && (bus_A[31] !== bus_B[31]) && (bus_A[31] !== out_bus[31]));
     
    // If instruction is not add or shift left make carry 0
    if(instruction !== ADD && instruction !== SL) begin
        C = 0;
    end
  end
  
  always_ff @(*) begin
    case(instruction)
        4'h01:   out_bus = bus_A;
        ADD:  {C,out_bus} = bus_A + bus_B; // If sum doesn't fit carry over to C bit
        SUB:  out_bus = bus_A - bus_B;
        ANDD: out_bus = bus_A & bus_B;
        ORR:  out_bus = bus_A | bus_B;
        XORR: out_bus = bus_A ^ bus_B;
        NOTT: out_bus = ~bus_A;
        SL:   {C,out_bus} = bus_A << 1; // Save shifted bit in C bit
        SR:   out_bus = bus_A >> 1; 
    endcase
  end

endmodule


