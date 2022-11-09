//Project 1 lookup tables and test benches
//Dev: Harper Hill

`include "main.v"

//Create testbench to try every valid input as well as
//several invalid inputs
module testBench1;

	//create inputs and outputs
	reg [6:0] in;
	wire [7:0] out;
	integer i;
	
	ascii2Braile uut1(in,out);

	//$display(out);
	
	//test all valid symbols and some invalid ones
	initial begin
		in <= 33;
		#5
		in <= 58;
		#5
		in <= 63;
		#5
		for(i = 48; i < 123; i++) begin
			in <= i;
			#5;
		end
	end

	//monitor outputs
	initial begin
		$monitor("t = %3d   in:%d   in:%b   out:%b",$time,in,in,out);
	end

	//export outputs
	initial begin
		$dumpfile("testbench1.vcd");
		$dumpvars(0,testBench1);
	end
endmodule


//Create testbench to convert the phrase "Hello World."
module testBench2;

	//create inputs and outputs
	reg [6:0] in;
	wire [7:0] out;
	integer i;
	
	ascii2Braile uut2(in,out);

	//output "Hello World."
	initial begin
		in = 7'b1001000;
		#5;
		in = 7'b1100101;
		#5;
		in = 7'b1101100;
		#5;
		in = 7'b1101100;
		#5;
		in = 7'b1101111;
		#5;
		in = 7'b0000000;
		#5;
		in = 7'b1010111;
		#5;
		in = 7'b1101111;
		#5;
		in = 7'b1110010;
		#5;
		in = 7'b1101100;
		#5;
		in = 7'b1100100;
		#5;
		in = 7'b0101110;
		#5;
	end

	//monitor outputs
	initial begin
		$monitor("t = %3d   in:%d   in:%b   out:%b",$time,in,in,out);
	end

	//export outputs
	initial begin
		$dumpfile("testbench2.vcd");
		$dumpvars(0,testBench2);
	end
endmodule


//Create testbench to convert the standard communications check of
//"Radio check? Lickin chicken"
module testBench3;

	//create inputs and outputs
	reg [6:0] in;
	wire [7:0] out;
	integer i;
	
	ascii2Braile uut3(in,out);

	initial begin
		in = 7'b1010010;
		#5;
		in = 7'b1100001;
		#5;
		in = 7'b1100100;
		#5;
		in = 7'b1101001;
		#5;
		in = 7'b1101111;
		#5;
		in = 7'b0000000;
		#5;
		in = 7'b1100011;
		#5;
		in = 7'b1101000;
		#5;
		in = 7'b1100101;
		#5;
		in = 7'b1100011;
		#5;
		in = 7'b1101011;
		#5;
		in = 7'b0111111;
		#5;
		in = 7'b0000000;
		#5;
		in = 7'b1001100;
		#5;
		in = 7'b1101001;
		#5;
		in = 7'b1100011;
		#5;
		in = 7'b1101011;
		#5;
		in = 7'b1101001;
		#5;
		in = 7'b1101110;
		#5;
		in = 7'b0000000;
		#5;
		in = 7'b1100011;
		#5;
		in = 7'b1101000;
		#5;
		in = 7'b1101001;
		#5;
		in = 7'b1100011;
		#5;
		in = 7'b1101011;
		#5;
		in = 7'b1100101;
		#5;
		in = 7'b1101110;
		#5;
	end
	
	//monitor outputs
	initial begin
		$monitor("t = %3d   in:%d   in:%b   out:%b",$time,in,in,out);
	end

	//export outputs
	initial begin
		$dumpfile("testbench3.vcd");
		$dumpvars(0,testBench3);
	end
endmodule