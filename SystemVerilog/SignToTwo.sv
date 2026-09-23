// Signed Magnitude to Two's Complement
module SignToTwo #(parameter N = 8)
(
    input [N-1:0] A,
    output [N-1:0] B
);
    wire [N-1:0] ha; 

    assign B[N-1] = A[N-1];

    assign ha[0] = A[N-1];

    genvar i;
    generate
        for (i=0; i<N-1; i=i+1)
            begin: signFor
                halfADDER halfADDER_inst1
                (
                    .s(B[i]),
                    .cout(ha[i+1]),
                    .a(A[i] ^ A[N-1]), 
                    .b(ha[i])         
                );
            end
    endgenerate
endmodule