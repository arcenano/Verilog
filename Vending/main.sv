`timescale 1ns / 1ps

/////////////////////////////////////////////////////////////////////////////////////////
//                                                                                     //
// Project 1: Vending Machine                                                          //
// Author:    Mariano Arce                                                             //
//                                                                                     //
// The project acts exactly as a real vending machine would, once a beverage has been  //
// selected, the machine waits until the right ammount of coins have been inserted     //
// then the item is dispended. If it already has enough coins then it dispenses        //
// immediately. If the machine is dispending, the beverage can't be changed.           //
//                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////

module vending_machine #(
  parameter int  BEV1PRICE            = 100,
  parameter int  BEV2PRICE            = 120,
  parameter int  BEV3PRICE            = 115
)(
input logic clk,
input logic reset,

// Beverages
input logic inbev1,
input logic inbev2,
input logic inbev3,

// Coins
input logic inquarter,
input logic indime,
input logic innickel,

// Beverages
output logic outbev1,
output logic outbev2,
output logic outbev3,

// Coins
output logic outquarter,
output logic outdime,
output logic outnickel
    );
    
    logic         dispensing, input_change, enable_pick;
    logic [32:0]  coin_count, change;
    logic [1:0]   bev_latch;
   
    
    always_ff @(posedge clk) begin
    
        if(reset) begin
            dispensing <= 1'b0;
            outquarter <= 1'b0;
            outdime    <= 1'b0;
            outnickel  <= 1'b0;
            outbev1    <= 1'b0;
            outbev2    <= 1'b0;
            outbev3    <= 1'b0;
            bev_latch  <= 0;
            coin_count <= 0;
            change     <= 0;
        
        end else begin
            // Coin input
            if(inquarter) begin
                coin_count <= coin_count + 25;
            end
            
            if(indime) begin
                coin_count <= coin_count + 10;

            end
            if(innickel) begin 
                coin_count <= coin_count + 5;
            end
            
            if(enable_pick) begin // Don't allow to pick a new bev while dispensing
                // Select Beverage
                if(inbev1) begin
                    bev_latch <= 2'b01;
                end
                if(inbev2) begin
                    bev_latch <= 2'b10;
                end
                    
                if(inbev3) begin
                    bev_latch <= 2'b11;
                end
            end
 
            // Dispensing Logic
            case(bev_latch) 
                2'b01: begin
                    if(coin_count >= BEV1PRICE) begin
                        dispensing <= 1'b1;
                        change     <= change + coin_count - BEV1PRICE;
                        coin_count <= 0;
                    end
                end
                2'b10: begin
                    if(coin_count >= BEV2PRICE) begin
                        dispensing  <= 1'b1;
                         change     <= change + coin_count - BEV1PRICE;
                         coin_count <= 0;

                    end
                end
                2'b11: begin
                    if(coin_count >= BEV3PRICE) begin
                         dispensing <= 1'b1;
                         change     <= change + coin_count - BEV1PRICE;
                         coin_count <= 0;
                    end
                end
            endcase
            
            
            if (dispensing) begin
                // Dispense Beverage
                case(bev_latch)
                    2'b01: begin
                        outbev1 <= 1'b1;
                    end
                    2'b10: begin
                        outbev2 <= 1'b1;
                    end
                    2'b11: begin
                        outbev3 <= 1'b1;
                    end
                endcase
                dispensing <= 1'b0;
                bev_latch  <= 0;
            end else begin
                outbev1    <= 0;
                outbev2    <= 0;
                outbev3    <= 0;
                
            end  
                  
            // Return change
            if(change >= 25) begin
                change     <= change - 25;
               outquarter <= 1'b1;
                outdime    <= 1'b0;
                outnickel  <= 1'b0;
                
            end else if(change >= 10) begin
                change     <= change - 10;
                outquarter <= 1'b0;
                outdime    <= 1'b1;
                outnickel  <= 1'b0;
                    
            end else if(change >= 5) begin
                change     <= change - 5;
                outquarter <= 1'b0;
                outdime    <= 1'b0;
                outnickel  <= 1'b1;
                 
            end else begin // No Change Left
                outquarter <= 1'b0;
                outdime    <= 1'b0;
                outnickel  <= 1'b0;
            end  
        end 
    end
    
    always_comb begin
        enable_pick = (inbev1==1 || inbev2==1 || inbev3==1) ? (1'b0) : (1'b1);
    end
    
    
endmodule
