//8-bit registered 2-function Arithemtic Unit
module AU8 (
	input [7:0] X,											//data input
	input InA, InB, Out, Clear, Add_Subtract,		//control inputs	
	output logic [7:0] Rout,							//result output
	output logic [3:0] Ccout,							//condition code output 
	output logic [0:6] HEX2, HEX1, HEX0);			//seven-segment outputs
	//declare internal nodes
	logic [7:0] Aout, Bout, R;							//register outputs
	logic Cout, OVR, ZERO, NEG; 						//condition codes
	
	//make internal node assignments
	assign NEG = R[7];
	assign ZERO = ~|R;
	
	//Instantiate registers
	NBitRegister #(4'd8) RegA 
	(
		.D(X),
		.CLK(InA), 
		.CLR(Clear), 
		.Q(Aout)
	);
	
   NBitRegister #(4'd8) RegB 
	(
		.D(X),
		.CLK(InB), 
		.CLR(Clear), 
		.Q(Bout)
	); 
	
   NBitRegister #(4'd8) RegR 
	(
		.D(R), 
		.CLK(Out), 
		.CLR(Clear), 
		.Q(Rout)
	);
	NBitRegister #(3'd4) RegCC 
	(
		.D({OVR, Cout, NEG, ZERO}),
		.CLK(Out), 
		.CLR(Clear), 
		.Q(Ccout)
	);
	
	//Instantiate full adders
	RippleCarryAdderStructural Adder (
        .A(Aout),
        .B(Bout),
        .Cin(Add_Subtract),
        .S(R),
        .Cout(Cout),
		  .OVR(OVR)
    );
	 
	//Instantiate bin2sev decoders
	binary2seven dec0 (
        .BIN(Rout[3:0]),
        .SEV(HEX0)
   );
	
	binary2seven dec1 (
        .BIN(Rout[7:4]),
        .SEV(HEX1)
   );
endmodule