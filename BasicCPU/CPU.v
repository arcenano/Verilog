// Project 2 CPU module
// Dev: Harper Hill and Mariano Arce

`include "decoder.v"
`include "ALU.v"
`include "microcode.v"

module CPU(input inclk, reset, input [8:0]fib, output [3:0]out);

    // opcode  = instruction[11:8] 4 bit opcode
    // dst = instruction[7:4] 3 bit src
    // src = instruction[3:0] 3 bit src
    // value = instruction[3:0] 4 bit value

    wire [11:0]instruction; // Instruction Code
    reg [3:0]mem[0:15]; // Registers
    wire [3:0]result; // Operation Result
    wire [0:2]s; // Selector Signals
    wire cin, skipif, halt, bsig, ready; // Case Signals
    reg skip = 0; // Skip Signals
    reg clk;  // Clock with halt logic

    // Operands
    reg [3:0]a;
    reg [3:0]b;

    always@(clk or halt or reset)begin
        // Halt / Reset
        if(reset || !halt)begin
            assign clk = inclk;
        end else begin
            assign clk = 1'b1;
        end
    end

    // Wipe registers on reset
    always@(posedge reset)begin
        mem[0] <= 4'b0000;
        mem[1] <= 4'b0000;
        mem[2] <= 4'b0000;
        mem[3] <= 4'b0000;
        mem[4] <= 4'b0000;
        mem[5] <= 4'b0000;
        mem[6] <= 4'b0000;
        mem[7] <= 4'b0000;
        mem[8] <= 4'b0000;
        mem[9] <= 4'b0000;
        mem[10] <= 4'b0000;
        mem[11] <= 4'b0000;
        mem[12] <= 4'b0000;
        mem[13] <= 4'b0000;
        mem[14] <= 4'b0000;
        mem[15] <= 4'b0000;
    end

    always@(reset or halt or skipif or bsig or s or instruction) begin 

        //$display("r10",mem[10]);

        if(s==3'b111) begin // Set case
            // Copy value specified to a
            a <= instruction[3:0];

        end else if(s==3'b000) begin // Copy Case
            // assign a to value src A
            case(instruction[3:0])
                0: begin
                    // Copy value in specified register to a
                    a <= mem[0];
                end
                1: begin
                    a <= mem[1];
                end
                2: begin
                    a <= mem[2];
                end
                3: begin
                    a <= mem[3];
                end
                4: begin
                    a <= mem[4];
                end
                5: begin
                    a <= mem[5];
                end
                6: begin
                    a <= mem[6];
                end
                7: begin
                    a <= mem[7];
                end
                8: begin
                    a <= mem[8];
                end
                9: begin
                    a <= mem[9];
                end
                10: begin
                    a <= mem[10];
                end
                11: begin
                    a <= mem[11];
                end
                12: begin
                    a <= mem[12];
                end
                13: begin
                    a <= mem[13];
                end
                14: begin
                    a <= mem[14];
                end
                15: begin
                    a <= mem[15];
                end
            endcase
        
        end else begin // Regular Behavior
            // assign a to instruction
            case(instruction[7:4])
                0: begin
                    // Copy value in specified register to a
                    a <= mem[0];
                end
                1: begin
                    a <= mem[1];
                end
                2: begin
                    a <= mem[2];
                end
                3: begin
                    a <= mem[3];
                end
                4: begin
                    a <= mem[4];
                end
                5: begin
                    a <= mem[5];
                end
                6: begin
                    a <= mem[6];
                end
                7: begin
                    a <= mem[7];
                end
                8: begin
                    a <= mem[8];
                end
                9: begin
                    a <= mem[9];
                end
                10: begin
                    a <= mem[10];
                end
                11: begin
                    a <= mem[11];
                end
                12: begin
                    a <= mem[12];
                end
                13: begin
                    a <= mem[13];
                end
                14: begin
                    a <= mem[14];
                end
                15: begin
                    a <= mem[15];
                end
            endcase
        end

        if(bsig) begin
            // assign b to instruction
            case(instruction[3:0])
                0: begin
                    // Copy value in specified register to b
                    b <= mem[0];
                end
                1: begin
                    b <= mem[1];
                end
                2: begin
                    b <= mem[2];
                end
                3: begin
                    b <= mem[3];
                end
                4: begin
                    b <= mem[4];
                end
                5: begin
                    b <= mem[5];
                end
                6: begin
                    b <= mem[6];
                end
                7: begin
                    b <= mem[7];
                end
                8: begin
                    b <= mem[8];
                end
                9: begin
                    b <= mem[9];
                end
                10: begin
                    b <= mem[10];
                end
                11: begin
                    b <= mem[11];
                end
                12: begin
                    b <= mem[12];
                end
                13: begin
                    b <= mem[13];
                end
                14: begin
                    b <= mem[14];
                end
                15: begin
                    b <= mem[15];
                end
            endcase
        end else begin
            b <= 0;
        end
    end 

        // Ideal Skipif
    // if(skipif) begin
    //     if(mem[instructions[7:4]]!=0) begin
    //         assign skip = 1;
    //     end
    // end

    // Verilog Skipif     
    always@(posedge skipif) begin 
        if(reset) begin
            assign skip = 0;
        end else begin
            case(instruction[3:0])
            0: begin
                // Copy value specified to dst
                if(mem[0]==0) begin
                    assign skip = 1;
                end          
            end
            1: begin
                if(mem[1]==0) begin
                    assign skip = 1;
                end    
            end
            2: begin
                if(mem[2]==0) begin
                    assign skip = 1;
                end    
            end
            3: begin
                if(mem[3]==0) begin
                    assign skip = 1;
                end    
            end
            4: begin
                if(mem[4]==0) begin
                    assign skip = 1;
                end
            end
            5: begin
                if(mem[5]==0) begin
                    assign skip = 1;
                end    
            end
            6: begin
                if(mem[6]==0) begin
                    assign skip = 1;
                end   
            end
            7: begin
                if(mem[7]==0) begin
                    assign skip = 1;
                end    
            end
            8: begin
                if(mem[8]==0) begin
                    assign skip = 1;
                end    
            end
            9: begin
                if(mem[9]==0) begin
                    assign skip = 1;
                end    
            end
            10: begin
                if(mem[10]==0) begin
                    assign skip = 1;
                end    
            end
            11: begin
                if(mem[11]==0) begin
                    assign skip = 1;
                end    
            end
            12: begin
                if(mem[12]==0) begin
                    assign skip = 1;
                end    
            end
            13: begin
                if(mem[13]==0) begin
                    assign skip = 1;
                end    
            end
            14: begin
                if(mem[14]==0) begin
                    assign skip = 1;
                end    
            end            
            15: begin
                if(mem[15]==0) begin
                    assign skip = 1;
                end    
            end
        endcase
        end
    end

    // Parallel Microcode, Decoder and Adder
    Microcode microcode(fib, inclk, reset, instruction, ready);
    Decoder decoder(instruction[11:8], clk, reset, s, cin, bsig, skipif, halt);
    ALU alu(a, b, s, cin, result);

    // Save result in DST
    //assign mem[instruction[7:4]] = result; // This would be a lot better than cases.
    // https://stackoverflow.com/questions/38177297/verilog-error-a-reference-to-a-wire-or-reg-is-not-allowed-in-a-constant-expres

    always@(negedge clk)begin
        // Save results in register
        if(!skip & !skipif) begin
            case(instruction[7:4])
                0: begin
                    // Copy value specified to dst
                    mem[0] <= result;
                    mem[15] <= result;
                end
                1: begin
                    mem[1] <= result;
                    mem[15] <= result;
                end
                2: begin
                    mem[2] <= result;
                    mem[15] <= result;
                end
                3: begin
                    mem[3] <= result;
                    mem[15] <= result;
                end
                4: begin
                    mem[4] <= result;
                    mem[15] <= result;
                end
                5: begin
                    mem[5] <= result;
                    mem[15] <= result;
                end
                6: begin
                    mem[6] <= result;
                    mem[15] <= result;
                end
                7: begin
                    mem[7] <= result;
                    mem[15] <= result;
                end
                8: begin
                    mem[8] <= result;
                    mem[15] <= result;
                end
                9: begin
                    mem[9] <= result;
                    mem[15] <= result;
                end
                10: begin
                    mem[10] <= result;
                    mem[15] <= result;
                end
                11: begin
                    mem[11] <= result;
                    mem[15] <= result;
                end
                12: begin
                    mem[12] <= result;
                    mem[15] <= result;
                end
                13: begin
                    mem[13] <= result;
                    mem[15] <= result;
                end
                14: begin
                    mem[14] <= result;
                    mem[15] <= result;
                end
                15: begin
                    mem[15] <= result;
                end
            endcase
        end
        // Turn off skip
        if(!skipif)begin
            assign skip = 0; 
        end
    end

    assign out = mem[15];

endmodule