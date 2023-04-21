`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Name: Mariano Arce
// R-Number: R-11662955
// Assignment: Project 5
// 
//////////////////////////////////////////////////////////////////////////////////

module decoder #(
//  parameter WIDTH       = 32,
//  parameter NUM_REGS    = 32
)( 
  // Inputs
  input  logic                        clk,
  input  logic                        reset,
  input  logic  [48:0]                instruction,
  input  logic                        Z, // ALU Z
  
// hello

  // Outputs
  // Direct from instruction code
  output logic [4:0]                  opcode,             // Opcode
  output logic [7:0]                  A_Sel,              // Src A Select
  output logic [31:0]                 B_Sel,              // Src B Select
  output logic [4:0]                  DST,                // Destination
  //output logic [1:0]                mode,               // Mode
  
  // Addressing Mode
  output logic                        MUX_B_ADDR,         // Immediate (Literal) or Register Mode
  output logic                        RAM_READ_MUX,       // Read from RAM or Registers/Literal
  
  // Depend on Operation
  output logic                        STORE_DECODER,      // Store in RAM or Registers
  output logic                        RAM_ENA,            // RAM Enable
  output logic                        RAM_WENA,           // RAM Write Enable
  output logic                        register_load,      // Register Write Enable
  output logic                        branch              // Branch
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


  logic [1:0]   mode; // Addressing mode

  always_ff @(posedge clk) begin
    if(reset==0) begin
        opcode <= instruction[48:44];
        mode <= instruction[43:42];
        A_Sel <= instruction[41:37];
        B_Sel <= instruction[31:0];
        DST <= instruction[36:32];
    end else begin
        opcode <= 0;
        mode <= 0;
        A_Sel <= 0;
        B_Sel <= 0;
        DST <= 0;
    end
  end
  
    always_ff @(*) begin        
        if(reset == 0) begin          
            case(mode) // Addressing Mode
                2'b00: begin       // Immediate
                MUX_B_ADDR = 0;    
                end
                
                2'b01: begin       // Direct
                MUX_B_ADDR = 0; 
                end

                2'b10: begin       // Register
                MUX_B_ADDR = 1; 
                end
            endcase
            
            case(opcode) 
                LD: begin   // Load
                    RAM_WENA = 0;
                    STORE_DECODER  = 0;
                    register_load = 1;
                    if(mode == 2'b01) begin // Direct Mode
                        RAM_ENA  = 1;
                        RAM_READ_MUX  = 1; // Use value from RAM
                    end else begin          // Immediate Mode (Literal)
                        RAM_ENA  = 0;
                        RAM_READ_MUX  = 0;
                    end

                end
                
                ST: begin       // Store
                    RAM_ENA = 1;
                    RAM_WENA = 1;
                    RAM_READ_MUX  = 0;
                    STORE_DECODER  = 1;
                    register_load = 0;
                end
                
                BZ: begin       // Branch if zero
                    case(Z)
                        1: branch = 1;
                        0: branch = 0;
                    endcase
                    RAM_ENA = 0;
                    RAM_WENA = 0;
                    register_load = 0;
                end
                
                BNZ: begin       // Branch if not zero
                    case(Z)
                        1: branch = 0;
                        0: branch = 1;
                    endcase
                    RAM_ENA = 0;
                    RAM_WENA = 0;
                    register_load = 0;
                end
                
                BRA: begin       // Branch
                    RAM_ENA = 0;
                    branch = 1;
                    RAM_WENA = 0;
                    register_load = 0;
                end
                default begin   // All other operations
                    register_load = 1;
                    RAM_ENA = 0;
                    RAM_WENA = 0;
                    RAM_READ_MUX  = 0; // Read from ALU output
                    STORE_DECODER = 0; // Store in Registers
                    branch = 0; 
                end
            
            endcase
        end else begin
                    MUX_B_ADDR    = 0;
                    register_load = 0;
                    RAM_ENA       = 0;
                    RAM_WENA      = 0;
                    RAM_READ_MUX  = 0; 
                    STORE_DECODER = 0; 
                    branch        = 0; 
        end
    end
endmodule