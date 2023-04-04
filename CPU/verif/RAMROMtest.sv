`timescale 1ns / 1ps

module testbench(
);
   
   logic       clk,reset;   
   logic       enable;      // Enable ROM and RAM
   logic       wea;         // Enable RAM Write
   logic [3:0] addra;       // Memory address
   logic [3:0] writebus;    
   logic [3:0] ROMreadbus;      
   logic [3:0] RAMreadbus;      

    
  clk_reset_gen #(
    .CLK_RATE(100_000_000)
  ) clk_gen (
    .clk  (clk),
    .reset(reset)
  );
  
  ROM UUTROM(
  .clk(clk),
  .reset(reset),
  .enable(enable),
  .addra(addra),
  .douta(ROMreadbus)
  );
  
  RAM UUTRAM(
  .clk(clk),
  .reset(reset),
  .enable(enable),
  .wea(wea),
  .addra(addra),
  .dina(writebus),
  .douta(RAMreadbus)
  );  
  
  initial begin
      wait(!reset);
 
      enable = 1;
        
      // Test ROM      
      for(int i=0; i<16; i++) begin
        addra = i;
        #10;
      end
      
      //Test RAM
      wea = 1;
      for(int i=0; i<16; i++) begin
        addra = i;
        writebus = i;
        #10;
      end
  end
  endmodule
