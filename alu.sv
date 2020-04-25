/*
 * SystemVerilog module for our ALU
 *
 * Eduardo Ortega - eortega@sandiego
 */
module alu
			#(parameter WIDTH=16)
			(input logic [WIDTH-1:0] a,b,
				input logic [2:0] f,
				output logic [WIDTH-1:0] y,
				output logic zero, carry_out, overflow);
	
	//assigns the parameters used for the cases
	parameter s000 = 3'b000;
	parameter s001 = 3'b001;
	parameter s010 = 3'b010;
	parameter s011 = 3'b011;
	parameter s100 = 3'b100;
	parameter s101 = 3'b101;
	parameter s110 = 3'b110;
	parameter s111 = 3'b111;

	//need this to locate the overflow/carry out bit
	logic [WIDTH:0] sum;
	
	// compute computational outputs and the flags
	always_comb
	begin
		case (f)
			//AND - and call
			s000:
				begin
					y = a & b;
					sum = 0;
					carry_out = 0;
					overflow = 0;
				end
			//OR - or call
			s001:
				begin
					y = a | b;
					sum = 0;
					carry_out = 0;
					overflow = 0;
				end
			//SUM - sums both a and b and keeps track of overflow
			s010:
				begin
					sum = a + b;
					y = sum[WIDTH - 1:0];
					carry_out = sum[WIDTH];
					overflow = ((a[WIDTH-1] == b[WIDTH-1]) & (a[WIDTH-1] != y[WIDTH-1]));
				end
			//nothing is used or happens
			s011:
				begin
					y = 0;
					sum = 0;
					carry_out = 0;
					overflow = 0;
				end
			//XOR - exclusive or call
			s100:
				begin
					y = a ^ b;
					sum = 0;
					carry_out = 0;
					overflow = 0;
				end
			//NOR - gets the OR and then ~ 
			s101:
				begin
					y = ~( a | b );
					sum = 0;
					carry_out = 0;
					overflow = 0;
				end
			//SUBTRACT - subtracts the difference of the two inputs
			s110:
				begin
					sum = a - b;
					y = sum[WIDTH - 1:0];
					carry_out = sum[WIDTH];
					overflow = ((a[WIDTH-1] ^ b[WIDTH-1]) & (a[WIDTH-1] ^ y[WIDTH-1]));
				end
			//STL - subtracts to compares the difference
			s111:
				begin
					sum = a - b;
					y = sum[WIDTH-1];
					carry_out = sum[WIDTH];
					overflow = ((a[WIDTH-1] ^ b[WIDTH-1]) & (a[WIDTH-1] ^ sum[WIDTH-1]));
				end
			default:
				begin
					y = 0;
					carry_out = 0;
					overflow= 0;
					sum = 0;
				end
		endcase
	end
	assign zero = (y == 0);
endmodule
