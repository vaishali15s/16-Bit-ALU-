`timescale 1ns/1ps
module alu16_tb;
    reg [15:0] A;
    reg [15:0] B;
    reg [3:0] sel;
    wire [15:0] Result;
    wire Carry, Zero, Overflow;

    alu_16bit uut(.A(A), .B(B), .sel(sel), .Result(Result), .Carry(Carry), .Zero(Zero), .Overflow(Overflow));

    integer failures;

    // helper task to check result
    task check;
        input [15:0] exp;
        input [3:0] op;
        begin
            if (Result !== exp) begin
                $display("FAIL: sel=%b A=%h B=%h => got %h expected %h", op, A, B, Result, exp);
                failures = failures + 1;
            end else begin
                $display("PASS: sel=%b A=%h B=%h => %h", op, A, B, Result);
            end
        end
    endtask

    initial begin
        $dumpfile("simulation_output.vcd");
        $dumpvars(0, alu16_tb);

        failures = 0;

        // test vectors
        A = 16'h000A; B = 16'h0003; // 10,3

        // ADD
        sel = 4'b0000; #5; check(16'h000D, sel); #5;
        // SUB
        sel = 4'b0001; #5; check(16'h0007, sel); #5;
        // AND
        sel = 4'b0010; #5; check(A & B, sel); #5;
        // OR
        sel = 4'b0011; #5; check(A | B, sel); #5;
        // XOR
        sel = 4'b0100; #5; check(A ^ B, sel); #5;
        // NOT
        sel = 4'b0101; #5; check(~A, sel); #5;
        // SLL
        sel = 4'b0110; #5; check(A << 1, sel); #5;
        // SRL
        sel = 4'b0111; #5; check(A >> 1, sel); #5;
        // EQ
        sel = 4'b1001; #5; check( (A == B) ? 16'h0001 : 16'h0000, sel); #5;
        // GT
        sel = 4'b1010; #5; check( (A > B) ? 16'h0001 : 16'h0000, sel); #5;
        // LT
        sel = 4'b1011; #5; check( (A < B) ? 16'h0001 : 16'h0000, sel); #5;

        if (failures == 0) begin
            $display("ALL TESTS PASSED");
        end else begin
            $display("TESTS FAILED: %0d failures", failures);
        end

        $finish;
    end
endmodule
