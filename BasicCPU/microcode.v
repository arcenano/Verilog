module Microcode (input [8:0]n, input clk, reset,  output reg [11:0]opcode, output reg ready);

    integer i;
    reg [11:0]opcodes[0:120];

    
    // Fpr Microcode 1 set to -1
    // For Microcode 2 set to 62
    // For Microcode 3 set to 91
    integer counter = -1; // Set counter to starting point -1
    
    // n breakdown
    // first 4 bits for microcode 1
    // next 3 bits for microcode 2
    // next 2 bits for microcode 3

    always@(negedge clk)begin
        if(reset)begin
            counter = -1; // Set counter to starting point -1
        end else begin
            counter++;
            opcode <= opcodes[counter];
        end
    end

    initial begin

    
        // =============================
        // ======== Microcode 1 ========
        // =============================

        // Set reg 9 to 0
        // To catch if there's a skipif at reset
        opcodes[0] <= 12'b00000010000;

        // Set reg 10 to n
        opcodes[1][11:4] <= 8'b00001010;
        opcodes[1][3:0] <= n[8:5];

        // Decrement reg 10
        opcodes[2] <= 12'b010110100000;
        // Set reg 1 to 0
        opcodes[3] <= 12'b00000010000;

        // Skipif reg 10 = 0
        opcodes[4] <= 12'b100100001010;

        // Set reg 0 to 1
        opcodes[5] <= 12'b000000000001;

        //Skipif reg 10 = 0
        opcodes[6] <= 12'b100100001010;

        // Decrement reg 10
        opcodes[7] <= 12'b010110100000;
        
        // Copy reg 0 to reg 15
        opcodes[8] <= 12'b000111110000;

        // Loop Starts here
        // First Iteration
        
        //Skipif reg 10 = 0
        opcodes[9] <= 12'b100100001010;
        //copy reg 0 to reg 2
        opcodes[10] <= 12'b000100100000;
        //Skipif reg 10 = 0
        opcodes[11] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[12] <= 12'b001000000001;
        //Skipif reg 10 = 0
        opcodes[13] <= 12'b100100001010;
        //copy reg 2 to reg 1
        opcodes[14] <= 12'b000100010010;
        //Skipif reg 10 = 0
        opcodes[15] <= 12'b100100001010;
        //decrement reg 10
        opcodes[16] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[17] <= 12'b000111110000;

        // Second iteration

        //Skipif reg 10 = 0
        opcodes[18] <= 12'b100100001010;
        //copy reg 0 to reg 2
        opcodes[19] <= 12'b000100100000;
        //Skipif reg 10 = 0
        opcodes[20] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[21] <= 12'b001000000001;
        //Skipif reg 10 = 0
        opcodes[22] <= 12'b100100001010;
        //copy reg 2 to reg 1
        opcodes[23] <= 12'b000100010010;
        //Skipif reg 10 = 0
        opcodes[24] <= 12'b100100001010;
        //decrement reg 10
        opcodes[25] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[26] <= 12'b000111110000;

        // Third Iteration
        
        //Skipif reg 10 = 0
        opcodes[27] <= 12'b100100001010;
        //copy reg 0 to reg 2
        opcodes[28] <= 12'b000100100000;
        //Skipif reg 10 = 0
        opcodes[29] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[30] <= 12'b001000000001;
        //Skipif reg 10 = 0
        opcodes[31] <= 12'b100100001010;
        //copy reg 2 to reg 1
        opcodes[32] <= 12'b000100010010;
        //Skipif reg 10 = 0
        opcodes[33] <= 12'b100100001010;
        //decrement reg 10
        opcodes[34] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[35] <= 12'b000111110000;

        // Fourth Iteration
        
        //Skipif reg 10 = 0
        opcodes[36] <= 12'b100100001010;
        //copy reg 0 to reg 2
        opcodes[37] <= 12'b000100100000;
        //Skipif reg 10 = 0
        opcodes[38] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[39] <= 12'b001000000001;
        //Skipif reg 10 = 0
        opcodes[40] <= 12'b100100001010;
        //copy reg 2 to reg 1
        opcodes[41] <= 12'b000100010010;
        //Skipif reg 10 = 0
        opcodes[42] <= 12'b100100001010;
        //decrement reg 10
        opcodes[43] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[44] <= 12'b000111110000;

        // Fifth Iteration

        //Skipif reg 10 = 0
        opcodes[45] <= 12'b100100001010;
        //copy reg 0 to reg 2
        opcodes[46] <= 12'b000100100000;
        //Skipif reg 10 = 0
        opcodes[47] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[48] <= 12'b001000000001;
        //Skipif reg 10 = 0
        opcodes[49] <= 12'b100100001010;
        //copy reg 2 to reg 1
        opcodes[50] <= 12'b000100010010;
        //Skipif reg 10 = 0
        opcodes[51] <= 12'b100100001010;
        //decrement reg 10
        opcodes[52] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[53] <= 12'b000111110000;
        
        // Sixth (Last) Iteration
        
        //Skipif reg 10 = 0
        opcodes[54] <= 12'b100100001010;
        //copy reg 0 to reg 2
        opcodes[55] <= 12'b000100100000;
        //Skipif reg 10 = 0
        opcodes[56] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[57] <= 12'b001000000001;
        //Skipif reg 10 = 0
        opcodes[58] <= 12'b100100001010;
        //copy reg 2 to reg 1
        opcodes[59] <= 12'b000100010010;
        //Skipif reg 10 = 0
        opcodes[60] <= 12'b100100001010;
        //decrement reg 10
        opcodes[61] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[62] <= 12'b000111110000;
        
        // =============================
        // ======== Microcode 2 ========
        // =============================
        

        // To catch if there's a skipif at reset
        opcodes[63] <= 12'b00000010000;
        
        // set r10 to n
        opcodes[64][11:3] <= 9'b000010100;
        opcodes[64][2:0] <= n[4:2];
        // copy r10 to r0
        opcodes[65] <= 12'b000100001010;
        //Skipif reg 10 = 0
        opcodes[66] <= 12'b100100001010;
        
        //First iteration of loop

        //decrement reg 10
        opcodes[67] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[68] <= 12'b000111110000;
        //Skipif reg 10 = 0
        opcodes[69] <= 12'b100100001010;
        // add r10 to r0
        opcodes[70] <= 12'b001000001010;
        //Skipif reg 10 = 0
        opcodes[71] <= 12'b100100001010;

        //Second iteration of loop

        //decrement reg 10
        opcodes[72] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[73] <= 12'b000111110000;
        //Skipif reg 10 = 0
        opcodes[74] <= 12'b100100001010;
        // add r10 to r0
        opcodes[75] <= 12'b001000001010;
        //Skipif reg 10 = 0
        opcodes[76] <= 12'b100100001010;

        //Third iteration of loop

        //decrement reg 10
        opcodes[77] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[78] <= 12'b000111110000;
        //Skipif reg 10 = 0
        opcodes[79] <= 12'b100100001010;
        // add r10 to r0
        opcodes[80] <= 12'b001000001010;
        //Skipif reg 10 = 0
        opcodes[81] <= 12'b100100001010;

        //Fourth iteration of loop

        //decrement reg 10
        opcodes[82] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[83] <= 12'b000111110000;
        //Skipif reg 10 = 0
        opcodes[84] <= 12'b100100001010;
        // add r10 to r0
        opcodes[85] <= 12'b001000001010;
        //Skipif reg 10 = 0
        opcodes[86] <= 12'b100100001010;

        //Fifth iteration of loop

        //decrement reg 10
        opcodes[87] <= 12'b010110100000;
        //copy reg 0 to reg 15
        opcodes[88] <= 12'b000111110000;
        //Skipif reg 10 = 0
        opcodes[89] <= 12'b100100001010;
        // add r10 to r0
        opcodes[90] <= 12'b001000001010;
        //Skipif reg 10 = 0
        opcodes[91] <= 12'b100100001010;
        
        
        // =============================
        // ======== Microcode 3 ========
        // =============================

        // To catch if there's a skipif at reset
        opcodes[92] <= 12'b00000010000;

        // Set reg 10 to n
        opcodes[93][11:2] <= 10'b0000101000;
        opcodes[93][1:0] <= n[1:0];
        // Set reg 1 to n
        opcodes[94][11:2] <= 10'b0000000100;
        opcodes[94][1:0] <= n[1:0];
        // Set reg 0 to n
        opcodes[95][11:2] <= 10'b0000000000;
        opcodes[95][1:0] <= n[1:0];

        //First iteration of loop
        
        //Skipif reg 10 = 0
        opcodes[96] <= 12'b100100001010;
        //decrement reg 10
        opcodes[97] <= 12'b010110100000;
        //Skipif reg 10 = 0
        opcodes[98] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[99] <= 12'b001000000001;
        //copy reg 0 to reg 15
        opcodes[100] <= 12'b000111110000;

        //Second iteration of loop
        
        //Skipif reg 10 = 0
        opcodes[101] <= 12'b100100001010;
        //decrement reg 10
        opcodes[102] <= 12'b010110100000;
        //Skipif reg 10 = 0
        opcodes[103] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[104] <= 12'b001000000001;
        //copy reg 0 to reg 15
        opcodes[105] <= 12'b000111110000;

        //Third iteration of loop
        
        //Skipif reg 10 = 0
        opcodes[106] <= 12'b100100001010;
        //decrement reg 10
        opcodes[107] <= 12'b010110100000;
        //Skipif reg 10 = 0
        opcodes[108] <= 12'b100100001010;
        //add reg 1 to reg 0
        opcodes[109] <= 12'b001000000001;
        //copy reg 0 to reg 15
        opcodes[110] <= 12'b000111110000;
    
    end
endmodule