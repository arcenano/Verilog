`include "substractor.v"
`include "lookupTable.v"
//'include "symbols.v"

module ascii2Braile(input [6:0]ascii, output [7:0]braile);

    // Variables to store substracted values for all cases
    wire [7:0]lowerLookup;
    wire [7:0]upperLookup;
    wire [7:0]numberLookup;

    // Variables to store lookup table values for all cases
    wire [5:0]convertedLower;
	wire [5:0]convertedUpper;
	wire [5:0]convertedNumber;
	wire [5:0]convertedSymbol;

    // Output
    reg [7:0]out;

	// Run each subtractor and its respective table lookup on every input and store the results separately
    symbolLookupTable symbolTable(ascii[5:0],convertedSymbol);
    eightBitSub number(ascii, 8'b00110001, numberLookup);
	lookupTable numberTable(numberLookup[5:0],convertedNumber);
    eightBitSub lowercase(ascii, 8'b01100001, lowerLookup);
	lookupTable lowerTable(lowerLookup[5:0],convertedLower);
    eightBitSub uppercase(ascii, 8'b01000001, upperLookup);
	lookupTable upperTable(upperLookup[5:0],convertedUpper);

    always @ (convertedSymbol or convertedNumber or convertedLower or convertedUpper) begin
        // Case by case ranges for each category
        if(ascii > 8'b01100000 && ascii < 8'b01111011) begin
            // Assign the lowercase lookup table output to the output
            out[7:2] <= convertedLower;
            $display(out);
            out[1] <= 0;
    		out[0] <= 0;

        end else if(ascii > 8'b01000000 && ascii < 8'b01011011) begin
            // Assign the uppercase lookup table output to the output
            out[7:2] <= convertedUpper;
			out[1] <= 0;
			out[0] <= 1;

        end else if(ascii > 47 && ascii < 58) begin
            // Assign the number lookup table output to the output
            out[7:2] <= convertedNumber;
			out[1] <= 1;
			out[0] <= 0;

            if(ascii == 8'b00110000)
                
                out[7:2] <= 6'b011100;
        end else begin
            // Assign the symbol lookup table output to the output
            out[7:2] <= convertedSymbol;
    		out[1] <= 0;
			out[0] <= 0;
        end
    end
    
    assign braile = out;
    // Search in  the symbols lookup table
    
endmodule