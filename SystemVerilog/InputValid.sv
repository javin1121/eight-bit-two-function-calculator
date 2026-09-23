module InputValid (
	input [15:0] x,
	output y
);
	logic [3:0] ones;
	logic [3:0] tens;
	logic [3:0] hundreds;
	
	assign hundreds = x[11:8];
	assign tens = x[7:4];
	assign ones = x[4:0];
	
	always_comb
		begin 
		y = 1'b0;
		if (hundreds <= 9 && tens <= 9 && ones <=9)
			begin
				if (hundreds == 1'b0) y = 1'b1;
			end
		else if (hundreds == 1'b1) 
			begin
				if (tens < 2) y = 1'b1;
				else if (tens == 2 && ones <= 7) y = 1'b1;
			end
		end
endmodule