/* 8 Bit Adder */
 
module oneBitFull(input a, b, c_in, output f, c_out);

	/* Cout = ACin + BCin + AB*/
	assign c_out = (a & c_in) + (b & c_in) + (a & b);

	/* F = A xor B xor Cin */
	assign f = a ^ b ^ c_in;

endmodule

module eightBitSub(input [6:0]a, input [7:0]s, output [7:0]f);

	wire [7:0]c;
	wire [7:0]si;

	integer i;

	assign si = ~ s;

	oneBitFull b8(a[0], si[0], 1'b1, f[0], c[0]);
	oneBitFull b7(a[1], si[1], c[0], f[1], c[1]);
	oneBitFull b6(a[2], si[2], c[1], f[2], c[2]);
	oneBitFull b5(a[3], si[3], c[2], f[3], c[3]);
	oneBitFull b4(a[4], si[4], c[3], f[4], c[4]);
	oneBitFull b3(a[5], si[5], c[4], f[5], c[5]);
	oneBitFull b2(a[6], si[6], c[5], f[6], c[6]);
	oneBitFull b1(1'b0, si[7], c[6], f[7], c[7]);

endmodule


/* Testbench */
module TB;
	/* Inputs */
	reg [0:6]a;	
	reg [0:7]s;

	/* Outputs */
	wire [0:7]o;

	/* Instantiate inverter module */
	eightBitSub uut(a,s,o);

	/* Stimulus waveform */
	initial begin
		a = 49;
		s = 8'b00110001;
		// #10
		// s = 00100001;
		// #10
		// a = 11111111;
		// #10
		// s = 00000000;
		// #10
		// s = 11111111;
	end
	
	/* Monitor net values over time */
	initial begin
		$monitor("t=%3d a=%b b=%b o=%b", $time, a, s, o);
	end
endmodule
