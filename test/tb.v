`timescale 1ns/1ps

module tb;
    // Testbench signals
    reg clk;
    reg rst_n;
    reg [7:0] ui_in;
    reg ena;
    wire seg_a;
    wire seg_b;
    wire seg_c;
    wire seg_d;
    wire seg_e;
    wire seg_f;
    wire seg_g;

    // Instantiate the DUT
    tt_um_bcd_7seg dut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(),
        .uio_out(),
        .uio_oe(),
        .uio_in(8'b0),
        .ena(ena),
        .seg_a(seg_a),
        .seg_b(seg_b),
        .seg_c(seg_c),
        .seg_d(seg_d),
        .seg_e(seg_e),
        .seg_f(seg_f),
        .seg_g(seg_g)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns clock period

    // Test procedure
    initial begin
        // Initialize inputs
        rst_n = 0;
        ui_in = 8'b0;
        ena = 0;

        // Apply reset
        #10 rst_n = 1;

        // Test for BCD input 9
        ena = 1;
        #10 ui_in = 8'b0000_1001; // Input value for 9
        #50; // Wait to observe output

        // Finish simulation
        $stop;
    end
endmodule
