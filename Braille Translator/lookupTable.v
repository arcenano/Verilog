//create module that will take a converted 6 bit input and
//convert it to braille
module lookupTable (input [5:0]in, output reg [5:0]out);
	
	//set it to run whenever there is an input
	always@(in) begin
		
		//create lookup table to assign inputs
		//to appropriate outputs
		case(in)
			6'b000000 : out = 6'b100000;
			6'b000001 : out = 6'b101000;
			6'b000010 : out = 6'b110000;
			6'b000011 : out = 6'b110100;
			6'b000100 : out = 6'b100100;
			6'b000101 : out = 6'b111000;
			6'b000110 : out = 6'b111100;
			6'b000111 : out = 6'b101100;
			6'b001000 : out = 6'b011000;
			6'b001001 : out = 6'b011100;
			6'b001010 : out = 6'b100010;
			6'b001011 : out = 6'b101010;
			6'b001100 : out = 6'b110010;
			6'b001101 : out = 6'b110110;
			6'b001110 : out = 6'b100110;
			6'b001111 : out = 6'b111010;
			6'b010000 : out = 6'b111110;
			6'b010001 : out = 6'b101110;
			6'b010010 : out = 6'b011010;
			6'b010011 : out = 6'b011110;
			6'b010100 : out = 6'b100011;
			6'b010101 : out = 6'b101011;
			6'b010110 : out = 6'b011101;
			6'b010111 : out = 6'b110011;
			6'b011000 : out = 6'b110111;
			6'b011001 : out = 6'b100111;
			default : out = 6'b000000;
		endcase
	end
endmodule


// Module that takeS in a converted 6 bit input and converts the symbols to braille
module symbolLookupTable (input [5:0]in, output reg [5:0]out);
	
	// Run whenever there is an input
	always@(in) begin
		
		// Create lookup table to assign inputs to appropriate outputs
		case(in)
			6'b101110 : out = 6'b001101;
			6'b101100 : out = 6'b001000;
			6'b100001 : out = 6'b001110;
			6'b111111 : out = 6'b001011;
			6'b111011 : out = 6'b001010;
			6'b111010 : out = 6'b001100;
			default : out = 6'b000000;
		endcase
	end
endmodule