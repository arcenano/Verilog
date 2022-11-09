// Project 2 ALU module
// Dev: Harper Hill and Mariano Arce

module ALU(input [3:0]a, input [3:0]b, input[0:2]s, input cin, output [3:0]f);
	// vars are backwards

    wire [3:0]fa; // Adder signal
    wire [3:0]fl; // Logic Signal

    Arithmetic adder(a, b, s[0:1], cin, fa); 
    Logic logics(a, b, s[0],cin, fl);
    mux2 selector2(fa, fl, s[2], f);

endmodule

module Logic(input [3:0]a, input [3:0]b, input s, cin, output [3:0]f);

	/* Operation buses */
	wire [0:1]selector;
    wire [0:3]AND;
	wire [0:3]OR;
    wire [0:3]XOR;
    wire [0:3]SET;

	assign selector[0] = cin;
	assign selector[1] = s;

	/* Each bus corresponds to one logic operation */
    assign AND = a & b;
    assign OR = a + b;
    assign XOR = a ^ b;
    assign SET = a;

	/* 4 way mux */
    mux4 selector4(AND ,OR, XOR, SET, selector, f);

endmodule


module Arithmetic(input [3:0]a, input [3:0]b, input [0:1]s, input cin, output [3:0]f);

    wire [3:0]y; // Addend
	wire [3:0]c; // Carry
	wire [3:0]sel0; // 4 bit Selector
	wire [3:0]sel1; // 4 bit Selector

	// Make Selector 0 multi bit
	assign sel0[0] = s[0];
	assign sel0[1] = s[0];
	assign sel0[2] = s[0];
	assign sel0[3] = s[0];

	// Make Selector 1 multi bit
	assign sel1[0] = s[1];
	assign sel1[1] = s[1];
	assign sel1[2] = s[1];
	assign sel1[3] = s[1];

    assign y = (b & sel0) + (~b & sel1); // Combinatorial to adder

    /* 4 bit parallel adder */
	oneBitFull b0(a[0], y[0], cin, f[0], c[0]);
	oneBitFull b1(a[1], y[1], c[0], f[1], c[1]);
	oneBitFull b2(a[2], y[2], c[1], f[2], c[2]);
	oneBitFull b3(a[3], y[3], c[2], f[3], c[3]);

endmodule

module oneBitFull(input a, b, c_in, output f, c_out);

	/* Cout = ACin + BCin + AB*/
	assign c_out = (a & c_in) + (b & c_in) + (a & b);

	/* F = A xor B xor Cin */
	assign f = a ^ b ^ c_in;

endmodule
 
module mux4(input [0:3]a, input [0:3]b, input [0:3]c, input [0:3]d, input [0:1]sel, output [3:0]f);

    /* First muxes output holders */
	wire [3:0]muxA;
    wire [3:0]muxB;

    /* 4 way mux with 2 way mux reuse */
	mux2 ma(a, b, sel[0], muxA);
	mux2 mb(c, d, sel[0], muxB);
	mux2 mc(muxA, muxB, sel[1], f);
	
endmodule


module mux2(input [3:0]a, input [3:0]b, input sel, output [3:0]f);

	wire [3:0]msel;
	wire [3:0]nsel;
    wire [3:0]o1;
    wire [3:0]o2;

	/* Expanding sel to 4 bits */
	assign msel[0] = sel;
	assign msel[1] = sel;
	assign msel[2] = sel;
	assign msel[3] = sel;

	/* Selector Expansion */
	assign nsel = ~msel;

	/* Mux 1 Logic */
	assign o1 = nsel & a;
	assign o2 = msel & b;
	assign f = o1 + o2;

endmodule
