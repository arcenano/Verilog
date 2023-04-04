`timescale 1ns / 1ps

module register_file #(
  parameter WIDTH       = 32,
  parameter NUM_REGS    = 32
)( 
  input  logic                        clk,
  input  logic                        reset,
  input  logic                        register_load,
  input  logic  [$clog2(WIDTH)-1:0]   address_A,    
  input  logic  [$clog2(WIDTH)-1:0]   address_B, 
  input  logic  [$clog2(WIDTH)-1:0]   address_D, 
  input  logic  [31:0]                bus_D,
  output logic  [31:0]                bus_A,
  output logic  [31:0]                bus_B

);
  logic [NUM_REGS-1:0][WIDTH-1:0] register = 0;
  
  always_comb begin
    bus_A = register[address_A];
    bus_B = register[address_B];
  end
  
  always_ff @(posedge clk) begin
    if(register_load) begin
        register[address_D] <= bus_D;
    end
  end

endmodule
