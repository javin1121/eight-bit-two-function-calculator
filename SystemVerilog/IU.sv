module IU (
	input clk, reset,
	input [3:0] row,
	output [3:0] col,
	output [7:0] out,
	output logic trig,
	output logic [3:0] value
);
	logic [15:0] bcd;
	logic [7:0] binsm;
	
	keypad_input #(.DIGITS(4)) keypad_input
	(
		.clk(clk),
		.reset(reset),
		.row(row),
		.col(col),
		.out(bcd),
		.value(value),
		.trig(trig)
	);
	
	BCD2BinarySM #(.N(8)) BCD2BinarySM
	(
		.BCD(bcd),
		.binarySM(binsm)
	);
	
	SignToTwo #(.N(8)) SignToTwo
	(
		.A(binsm),
		.B(out)
	);
endmodule