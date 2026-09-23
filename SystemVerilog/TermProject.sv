module TermProject
(
	input logic [3:0] row,
	input logic clock, clearAll, clearEntry,
	output logic [3:0] col,
	output logic [0:27] HEX,
	output [7:0] out,
	output logic LEDR9, LEDR8,
	output logic Reset, LoadX, LoadY, AddSub, LoadR, IUAU
);
	logic [7:0] TC; //two-complerment from IU
	logic [7:0] R; //R from AU
	logic [7:0] MUX; //the multiplexer
	logic trig; //the trig
	logic [3:0] value;
	logic [3:0] Ccout;
	assign out = TC;
	
	CU CU_inst 
	(
		.trig(trig),
		.clock(clock),
		.value(value),
		.clearAll(clearAll),
		.clearEntry(clearEntry),
		.Reset(Reset), .LoadX(LoadX), .LoadY(LoadY), .LoadR(LoadR),
		.IUAU(IUAU)
	);
	
	IU IU_inst
	(
		.clk(clock),
		.reset(Reset),
		.row(row),
		.col(col),
		.out(TC),
		.value(value),
		.trig(trig)
	);
	
	AU8 AU8_inst
	(
		.X(TC),
		.InA(LoadX),
		.InB(LoadY),
		.Out(LoadR),
		.Clear(clearAll),
		.Add_Subtract(AddSub),
		.Rout(R),
		.Ccout(Ccout), 
		.HEX2(), .HEX1(), .HEX0() //nothing to do
	);
	
	always_comb
		begin
			if (IUAU == 1'b0) MUX = TC;
		else 
			MUX = R;
	end
	
	OU OU_inst
	(
		.IN(MUX),
		.OUT(HEX)
	);
	
	assign LEDR9 = Ccout[3];
	assign LEDR8 = Ccout[0];
endmodule
	
	