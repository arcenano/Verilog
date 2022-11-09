`include "CPU.v"

module testBench;

    //reg [9:0] opcode; // Instruction Opcode
    reg clk, reset; // Clock and Reset signals
    wire [3:0] out; // Machine Output
    integer i; // Count

    //initialize CPU (need to change inputs)
    CPU cpu1(clk, reset, 9'b010110110, out[3:0]);

    // n breakdown
    // first 4 bits for microcode 1
    // next 3 bits for microcode 2
    // next 2 bits for microcode 3
    
    //start clock signal
	initial begin

        // Turn on Machine
        reset = 1'b1;
        #1
        reset = 1'b0;

        // Run Clock
		clk = 1'b0;
        #2.5;
		for(i = 0; i < 250; i++) begin
			clk = ~clk;
			#5;
		end
	end


	initial begin
		#90;
		reset = 1'b1;
		#10;
		reset = 1'b0;
	end

    //monitor outputs
	initial begin
		$monitor("t = %3d   clk:%dd   out:%b   out:%d",$time, clk, out, out);
	end
	
	//export outputs
	initial begin
		$dumpfile("p2.vcd");
		$dumpvars(0,testBench);
	end
endmodule