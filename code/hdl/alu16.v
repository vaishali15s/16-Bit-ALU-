// 16-bit ALU (module only)
module alu_16bit (
    input  [15:0] A,
    input  [15:0] B,
    input  [3:0]  sel,
    output reg [15:0] Result,
    output reg Carry,
    output reg Zero,
    output reg Overflow
);

    always @(*) begin
        Carry = 0;
        Overflow = 0;

        case (sel)
            4'b0000: {Carry, Result} = A + B;              // Addition
            4'b0001: {Carry, Result} = A - B;              // Subtraction
            4'b0010: Result = A & B;                       // Bitwise AND
            4'b0011: Result = A | B;                       // Bitwise OR
            4'b0100: Result = A ^ B;                       // Bitwise XOR
            4'b0101: Result = ~A;                          // Bitwise NOT
            4'b0110: Result = A << 1;                      // Logical Left Shift
            4'b0111: Result = A >> 1;                      // Logical Right Shift
            4'b1000: Result = A * B;                       // Multiplication
            4'b1001: Result = (A == B) ? 16'h0001 : 16'h0000; // Equality check
            4'b1010: Result = (A > B) ? 16'h0001 : 16'h0000;  // Greater than check
            4'b1011: Result = (A < B) ? 16'h0001 : 16'h0000;  // Less than check
            default: Result = 16'h0000;
        endcase

        Zero = (Result == 16'h0000);

        if (sel == 4'b0000 || sel == 4'b0001) begin
            Overflow = (A[15] == B[15]) && (Result[15] != A[15]);
        end
    end

endmodule
