`timescale 1ns / 1ps

module wallace_tb;

    // Inputs
    reg [31:0] a;
    reg [31:0] b;

    // Outputs
    wire [63:0] out;

    // Instantiate the Unit Under Test (UUT)
    wallace uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        // Test 1: Small values
        a = 32'd15; b = 32'd3;
        #10;
        $display("Test 1: a = %d, b = %d, out = %d", a, b, out);

        // Test 2: Power of two multiplication
        a = 32'd1024; b = 32'd512;
        #10;
        $display("Test 2: a = %d, b = %d, out = %d", a, b, out);

        // Test 3: Max value for a, small value for b
        a = 32'hFFFFFFFF; b = 32'd2;
        #10;
        $display("Test 3: a = %h, b = %d, out = %d", a, b, out);

        // Test 4: Random large values
        a = 32'h12345678; b = 32'h87654321;
        #10;
        $display("Test 4: a = %h, b = %h, out = %d", a, b, out);

        // Test 5: Zero multiplication
        a = 32'd0; b = 32'd99999;
        #10;
        $display("Test 5: a = %d, b = %d, out = %d", a, b, out);

        // Test 6: Large identical numbers
        a = 32'd100000; b = 32'd100000;
        #10;
        $display("Test 6: a = %d, b = %d, out = %d", a, b, out);

        // Test 7: Max values for both a and b
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
        #10;
        $display("Test 7: a = %h, b = %h, out = %d", a, b, out);

        // Test 8: Edge case where one number is small and the other is very large
        a = 32'h1; b = 32'hFFFFFFFF;
        #10;
        $display("Test 8: a = %h, b = %h, out = %d", a, b, out);

        // Test 9: Both inputs are zero
        a = 32'd0; b = 32'd0;
        #10;
        $display("Test 9: a = %d, b = %d, out = %d", a, b, out);

        // Test 10: Multiplication by one
        a = 32'd1; b = 32'hFFFFFFFF;
        #10;
        $display("Test 10: a = %d, b = %h, out = %d", a, b, out);

        // Test 11: Multiplication by negative numbers (2's complement)
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;  // -1 * -1
        #10;
        $display("Test 11: a = %h, b = %h, out = %d", a, b, out);

        // End the simulation
        $stop;
    end

endmodule

