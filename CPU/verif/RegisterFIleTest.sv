`timescale 1ns / 1ps

module testbench(

    );
     // Inputs
   logic        clk,reset;
   logic        register_load = 0;   
   logic [4:0]  address_A, address_B, address_D;
   logic [31:0] bus_D;
   
   // Outputs
   logic [31:0] bus_A, bus_B;

  clk_reset_gen #(
    .CLK_RATE(100_000_000)
  ) clk_gen (
    .clk  (clk),
    .reset(reset)
  );
  
  register_file UUT (
  .clk(clk), 
  .reset(reset), 
  .register_load(register_load),
  .address_A(address_A),
  .address_B(address_B),
  .address_D(address_D),
  .bus_A(bus_A),
  .bus_B(bus_B),
  .bus_D(bus_D)
   );
   
  initial begin
    wait(!reset);
    register_load <= 1;
    for(int i = 0; i<32; i = i+1)begin
      @(posedge clk);
      address_D <= i;
      bus_D <= i; 
    end
    for(int i = 0; i<32; i = i+1)begin
      @(posedge clk);
      address_A <= i;
      address_B <= i; 
    end
  end
 
endmodule
