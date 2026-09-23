module CU 
(
	input logic trig, 
	input logic clock,
	input logic [3:0] value,
	input logic clearAll, clearEntry,
	output logic Reset, LoadX, LoadY, AddSub, LoadR, IUAU,
	output logic [3:0] debug
);
	logic [2:0] state = 3'b000;
	logic addsub_reg = 1'b0;
	
	assign debug = value;
	assign AddSub = addsub_reg;
	
	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;
	
	always_ff @ (posedge trig, negedge clearAll, negedge clearEntry)
	begin
		if (clearAll == 0) begin
			state <= S0;
			addsub_reg <= 1'b0;
		end
		else if (clearEntry == 0) begin
			if (state != S0 && state != S6)
				state <= S0;
		end
		else begin
			case (state)
				S0: if (value != 4'hA && value != 4'hB) state <= S1;
				S1: if (value == 4'hA || value == 4'hB) begin
						state <= S2;
						addsub_reg <= (value == 4'hA) ? 1'b0 : 1'b1;
					end
				S2: state <= S3;
				S3: if (value != 4'hF && value != 4'hA && value != 4'hB) state <= S4;
				S4: state <= S5;
				S5: if (value == 4'hF) state <= S6;
				S6: state <= S6;
			endcase
		end
	end
	
	always_comb
	begin
		case (state)
			S0: begin Reset = 0; LoadX = 1; LoadY = 1; IUAU = 0; end
			S1: begin Reset = 1; LoadX = 0; LoadY = 1; IUAU = 0; end
			S2: begin Reset = 0; LoadX = 0; LoadY = 1; IUAU = 0; end
			S3: begin Reset = 1; LoadX = 1; LoadY = 1; IUAU = 0; end
			S4: begin Reset = 1; LoadX = 1; LoadY = 1; IUAU = 0; end
			S5: begin Reset = 1; LoadX = 1; LoadY = 0; IUAU = 0; end
			S6: begin Reset = 1; LoadX = 1; LoadY = 1; IUAU = 1; end
			default: begin Reset = 1; LoadX = 1; LoadY = 1; IUAU = 0; end
		endcase
	end
	
	logic in_S6_d1;
	always_ff @ (posedge clock)
		in_S6_d1 <= (state == S6);
	
	assign LoadR = in_S6_d1;
endmodule