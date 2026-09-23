//Hex to 7-segment decoder. Active low output
module bcd2seven (
	input [3:0] BIN, 
	output logic [6:0] SEV);
	always_comb
		begin
			case(BIN)
				4'b0000: SEV = 7'b0000001; //0
				4'b0001: SEV = 7'b1001111; //1
				4'b0010: SEV = 7'b0010010; //2
				4'b0011: SEV = 7'b0000110; //3
				4'b0100: SEV = 7'b1001100; //4
				4'b0101: SEV = 7'b0100100; //5
				4'b0110: SEV = 7'b0100000; //6
				4'b0111: SEV = 7'b0001111; //7
				4'b1000: SEV = 7'b0000000; //8
				4'b1001: SEV = 7'b0001100; //9
				default: SEV = 7'b1111111; //blank
			endcase
		end
endmodule