`timescale 1ns / 1ps

module testbench(

    );
   // Inputs
   logic clk,reset;
   logic inbev1 = 1'b0 ,inbev2 = 1'b0 ,inbev3 = 1'b0;
   logic inquarter, indime, innickel;
   
   // Outputs
   logic outbev1, outbev2, outbev3;
   logic outquarter, outdime, outnickel;
    
    
  clk_reset_gen #(
    .CLK_RATE(100_000_000)
  ) clk_gen (
    .clk  (clk),
    .reset(reset)
  );
  
  vending_machine UUT (
  .clk(clk), 
  .reset(reset), 
  .inbev1(inbev1),
  .inbev2(inbev2), 
  .inbev3(inbev3),
  .inquarter(inquarter), 
  .indime(indime), 
  .innickel(innickel), 
  .outbev1(outbev1), 
  .outbev2(outbev2), 
  .outbev3(outbev3), 
  .outquarter(outquarter), 
  .outdime(outdime),
  .outnickel(outnickel) 
   );
   
  initial begin
  wait(!reset);
 
  @(posedge clk);
  inquarter = 1;
  @(posedge clk);
  inquarter = 0;  // 25
  @(posedge clk);
  innickel = 1;
  @(posedge clk);
  innickel = 0;   // 30 Cents
  @(posedge clk);
  inquarter = 1;
  @(posedge clk);
  inquarter = 0;  // 55 Cents
  @(posedge clk);
  indime = 1;
  @(posedge clk);
  indime = 0;     // 65 Cents
  @(posedge clk);
  inquarter = 1;  
  @(posedge clk);
  inquarter = 0;  // 90 Cents'
  @(posedge clk);
  indime = 1;
  @(posedge clk);
  indime = 0;     // 100 Cents
  @(posedge clk);
  inquarter = 1;
  @(posedge clk);
  inquarter = 0;  // 125 Cents
  @(posedge clk);
  innickel = 1;
  @(posedge clk);
  innickel = 0;   // 130 Cents
  inbev2 = 1;
  @(posedge clk);
  inbev2 = 0;     // Selecting bev2
  @(posedge clk);

    //////////////////////////////////////////////////////////////////////
  // AT THIS POINT THE MACHINE IS DISPENSING SODA AND RETURNING CHANGE
  //////////////////////////////////////////////////////////////////////
  
  @(posedge clk);
  inbev2 = 1;
  inquarter = 1;
  @(posedge clk);
  inbev2 = 0;     // Select bev2
  @(posedge clk);
  inquarter = 0;  // On for two cycles (50 cents)
  @(posedge clk);
  innickel = 1;
  @(posedge clk);
  innickel = 0;   // 55 Cents
  @(posedge clk);
  inquarter = 1;
  @(posedge clk);
  inbev1 = 1;
  inquarter = 0;  // 80 Cents
  @(posedge clk);
  inbev1 = 0;     // Change to inbev1
  indime = 1;
  @(posedge clk);
  indime = 0;     // 90 Cents
  @(posedge clk);
  inquarter = 1;  
  @(posedge clk);
  inquarter = 0;  // 115 Cents
  @(posedge clk);

  
  //////////////////////////////////////////////////////////////////////
  // AT THIS POINT THE MACHINE IS DISPENSING SODA AND RETURNING CHANGE
  //////////////////////////////////////////////////////////////////////
  
  @(posedge clk);
  inbev3 = 1;
  inquarter = 1;
  @(posedge clk);
  inbev3 = 0;
  @(posedge clk);
  inquarter = 0;  // On for two cycles (50 cents)
  @(posedge clk);
  innickel = 1;
  @(posedge clk);
  innickel = 0;   // 55 Cents
  @(posedge clk);
  inquarter = 1;
  @(posedge clk);
  inquarter = 0;  // 80 Cents
  @(posedge clk);
  indime = 1;
  @(posedge clk);
  indime = 0;     // 90 Cents
  @(posedge clk);
  inquarter = 1;  
  @(posedge clk);
  inquarter = 0;  // 115 Cents
  //////////////////////////////////////////////////////////////////////
  // AT THIS POINT THE MACHINE IS DISPENSING SODA (NO CHANGE TO RETURN)
  //////////////////////////////////////////////////////////////////////
  #200;
  end
endmodule

