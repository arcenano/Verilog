// Project 2 Decoder module
// Dev: Harper Hill and Mariano Arce

module Decoder (input [3:0]opCode, input clk, reset, output [0:2]sOut, output cOut, bOut, skipOut,haltOut);

	reg [0:2]s;
	reg c, b, skip, stop;

	parameter set=0,copy=1,add=2,inc=3,sub=4,dec=5,nd=6,r=7,xr=8,skipif=9,halt=10;

	initial begin
		stop <= 0;
	end

	always@(reset)begin
	skip <= 0;
	stop <= 0;
    end

	always@(posedge clk)begin
	
		case(opCode)
		set: begin
			s <= 3'b111;
			skip <= 0;
			stop <= 0;
			b <= 0;
			c <= 0;
		end
		copy: begin
			s[2] <= 0;
			s[1] <= 0;
			s[0] <= 0;
			c <= 0;
			skip <= 0;
			stop <= 0;
			b <= 0;
		end
		add: begin
			s[2] <= 0;
			s[1] <= 0;
			s[0] <= 1;
			c <= 0;
			skip <= 0;
			stop <= 0;
			b <= 1;
		end
		inc: begin
			s[2] <= 0;
			s[1] <= 0;
			s[0] <= 0;
			c <= 1;
			skip <= 0;
			stop <= 0;
			b <= 0;
		end
		sub: begin
			s[2] <= 0;
			s[1] <= 1;
			s[0] <= 0;
			c <= 1;
			skip <= 0;
			stop <= 0;
			b <= 1;
		end
		dec: begin
			s[2] <= 0;
			s[1] <= 1;
			s[0] <= 1;
			c <= 0;
			skip <= 0;
			stop <= 0;
			b <= 0;
		end
		nd: begin
			s[2] <= 1;
			s[1] <= 0;
			s[0] <= 0;
			c <= 0;
			skip <= 0;
			stop <= 0;
			b <= 1;
		end
		r: begin
			s[2] <= 1;
			s[1] <= 0;
			s[0] <= 0;
			c <= 1;
			skip <= 0;
			stop <= 0;
			b <= 1;
		end
		xr: begin
			s[2] <= 1;
			s[1] <= 0;
			s[0] <= 1;
			c <= 0;
			skip <= 0;
			stop <= 0;
			b <= 1;
		end
		skipif: begin
			if(!reset)begin	
				skip <= 1;
			end else begin
				skip <= 0;
			end
			stop <= 0;
		end
		halt: begin
			if(!reset)begin	
				stop <= 1;
			end else begin
				stop <= 0;
			end
			skip <= 0;
		end
		
		default: begin
		
		end
		endcase
	end
	
	assign sOut = s;
	assign cOut = c;
	assign bOut = b;
	assign skipOut = skip;
	assign haltOut = stop;
	
endmodule