`timescale 1ns/1ps

module tb;
    // Testbench signals
    reg clk;
    reg rst_n;
    reg [7:0] ui_in;
    reg ena;
    wire [7:0] uo_out;  // Combined 7-segment output

    // Instantiate the DUT (Device Under Test)
    tt_um_bcd_7seg dut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_out(),
        .uio_oe(),
        .uio_in(8'b0),
        .ena(ena)
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
        #10 ui_in = 8'b00001001; // Input value for 9 (BCD)
        #50; // Wait to observe output

        // Display the 7-segment output
        $display("7-segment display for input 9: %b", uo_out[6:0]);  // Output should match 7-segment encoding for 9

        // Finish simulation
        $stop;
    end
endmodule
