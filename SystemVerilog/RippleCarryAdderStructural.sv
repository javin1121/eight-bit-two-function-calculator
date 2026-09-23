//Two's Complement Adder-Subtractor with carry out 8-bit
module RippleCarryAdderStructural (
	input [7:0] A, B,
	input Cin,
	output [7:0] S, 
	output logic [3:0] Flag,
	output logic Cout,
	output logic OVR);
	logic [8:0] C;
	assign C[0] = Cin;
	assign Cout = C[8];
	assign OVR = C[8] ^ C[7];
	
		
	FAbehavSV s0 (.ai(A[0]), .bi(B[0] ^ C[0]), .cini(C[0]), .si(S[0]), .couti(C[1])); //stage 0
	FAbehavSV s1 (.ai(A[1]), .bi(B[1] ^ C[0]), .cini(C[1]), .si(S[1]), .couti(C[2])); //stage 1
	FAbehavSV s2 (.ai(A[2]), .bi(B[2] ^ C[0]), .cini(C[2]), .si(S[2]), .couti(C[3])); //stage 2
	FAbehavSV s3 (.ai(A[3]), .bi(B[3] ^ C[0]), .cini(C[3]), .si(S[3]), .couti(C[4])); //stage 3
	FAbehavSV s4 (.ai(A[4]), .bi(B[4] ^ C[0]), .cini(C[4]), .si(S[4]), .couti(C[5])); //stage 4
   FAbehavSV s5 (.ai(A[5]), .bi(B[5] ^ C[0]), .cini(C[5]), .si(S[5]), .couti(C[6])); //stage 5
   FAbehavSV s6 (.ai(A[6]), .bi(B[6] ^ C[0]), .cini(C[6]), .si(S[6]), .couti(C[7])); //stage 6
   FAbehavSV s7 (.ai(A[7]), .bi(B[7] ^ C[0]), .cini(C[7]), .si(S[7]), .couti(C[8])); //stage 7
endmodule
