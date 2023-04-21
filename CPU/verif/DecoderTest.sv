`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Name: Mariano Arce
// R-Number: R-11662955
// Assignment: Project 5
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench(

    );
     // Inputs
   logic         clk,reset;
   logic [48:0]  instruction;
   logic         Z;

   // Outputs
   // Direct from instruction code
   logic [4:0]                  opcode;             // Opcode
   logic [7:0]                  A_Sel;              // Src A Select
   logic [31:0]                 B_Sel;              // Src B Select
   logic [4:0]                  DST;                // Destination
   //logic [1:0]                mode,               // Mode
   
   // Addressing Mode
   logic                        MUX_B_ADDR;         // Immediate (Literal) or Register Mode
   logic                        RAM_READ_MUX;       // Read from RAM or Registers/Literal
   
   // Depend on Operation
   logic                        STORE_DECODER;      // Store in RAM or Registers
   logic                        RAM_ENA;            // RAM Enable
   logic                        RAM_WENA;           // RAM Write Enable
   logic                        register_load;      // Register Write Enable
   logic                        branch;              // Branch
       
  clk_reset_gen #(
    .CLK_RATE(100_000_000)
  ) clk_gen (
    .clk  (clk),
    .reset(reset)
  );
  
  decoder UUT (
  // Inputs
  .clk(clk), 
  .reset(reset), 
  .instruction(instruction),
  .Z(Z),

  // Outputs

  // Instruction code delayed one cycle
  .opcode(opcode),            
  .A_Sel(A_Sel),            
  .B_Sel(B_Sel),              
  .DST(DST),                

  // Addressing Mode
  .MUX_B_ADDR(MUX_B_ADDR),         
  .RAM_READ_MUX(RAM_READ_MUX),       

   // Depend on Operation
  .STORE_DECODER(STORE_DECODER),
  .RAM_ENA(RAM_ENA),      
  .RAM_WENA(RAM_WENA),     
  .register_load(register_load),
  .branch(branch)       
  );

   
  localparam LD = 5'h01;
  localparam ST = 5'h02;
  localparam ADD = 5'h03;
  localparam SUB = 5'h04;
  localparam ANDD = 5'h05;
  localparam ORR = 5'h06;
  localparam XORR = 5'h07;
  localparam NOTT = 5'h08;
  localparam SL = 5'h09;
  localparam SR = 5'h0A;  
  localparam BZ = 5'h10;
  localparam BNZ = 5'h11;
  localparam BRA = 5'h12;

  initial begin
    wait(!reset);
    Z = 1;
    instruction = 49'h1001ABCDEF12;
    #20;
    instruction = 49'h141D1234DADA;
    #20;
    instruction = 49'h27A000000010;
    #20;
    instruction = 49'h391F0000000A;
    #20;
    instruction = 49'h304100000001;
    #20;
    instruction = 49'h488300000005;
    #20;
    instruction = 49'h40E600000001;
    #20;
    instruction = 49'h894900000000;
    #20;
    instruction = 49'h718BDEADBEEF;
    #20;
    instruction = 49'h79CD0000000F;
    #20;
    instruction = 49'h523000000001;
    #20;
    instruction = 49'h5A7200000014;
    #20;
    instruction = 49'h62D5AAAAAAAA;
    #20;
    instruction = 49'h6B1700000019;
    #20;
    instruction = 49'hA37A00000001;
    #20;
    instruction = 49'h9BBC0000001E;
    #20;
    instruction = 49'h1100000000010;
    #20;
    instruction = 49'h1000000000010;
    #20;
    instruction = 49'h1200000000010;
    #20;
  end 
 endmodule 
  
  
  