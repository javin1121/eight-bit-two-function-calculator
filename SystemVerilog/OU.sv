//output unit
module OU 
(
	input [7:0] IN,
	output logic [0:27] OUT
);
	wire [7:0] magnitude;
	wire [3:0] ones, tens;
	wire [1:0] hundreds;
	
	//convert 2 comp to signed mag
	TwoSign #(.N(8)) TwoSign_inst (
		.A(IN),
		.B(magnitude)
   );
	//convert mag to bcd
	binary2bcd binary2bcd_inst (
		.A(magnitude),
		.ONES(ones),
		.TENS(tens),
		.HUNDREDS(hundreds)
	);
	//displays
	bcd2seven display_ones (
		.BIN(ones),
		.SEV(OUT[0:6])
	);
	
	bcd2seven display_tens (
		.BIN(tens),
		.SEV(OUT[7:13])
	);
	
	bcd2seven seg_hund (
      .BIN({2'b00, hundreds}),
      .SEV(OUT[14:20])
   );
	//display for sign
	assign OUT[21:27] = IN[7] ? 7'b1111110 : 7'b1111111;
endmodule