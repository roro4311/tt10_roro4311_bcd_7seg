module tt_um_bcd_7seg (
    input wire clk,               // Clock signal
    input wire rst_n,             // Active-low reset signal
    input wire [7:0] ui_in,       // Input signal from UI (e.g., button presses)
    output wire [7:0] uo_out,     // Debugging output for Morse code (if needed)
    output wire [7:0] uio_out,    // Decoded ASCII output for external use
    output wire [7:0] uio_oe,     // Output enable for uio_out
    input wire [7:0] uio_in,      // External inputs (not used in this design)
    input wire ena,               // Enable signal
    // Seven-segment display outputs as a single 7-bit vector
    output wire [6:0] seg         // Combined 7-segment display output
);

// Internal signals
reg [6:0] seg_output;  // Stores the output for the 7-segment display

// Assign the 7-segment output directly to the combined wire
assign seg = seg_output;

// Assign unused outputs to default values
assign uo_out = 8'b0;
assign uio_out = 8'b0;
assign uio_oe = 8'b0;

// LUT for BCD to 7-segment decoding
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        seg_output <= 7'b0000000;  // Reset all segments
    end else if (ena) begin
        case (ui_in[3:0])  // Use only the lower 4 bits of ui_in for BCD
            4'b0000: seg_output <= 7'b1111110;  // 0
            4'b0001: seg_output <= 7'b0110000;  // 1
            4'b0010: seg_output <= 7'b1101101;  // 2
            4'b0011: seg_output <= 7'b1111001;  // 3
            4'b0100: seg_output <= 7'b0110011;  // 4
            4'b0101: seg_output <= 7'b1011011;  // 5
            4'b0110: seg_output <= 7'b1011111;  // 6
            4'b0111: seg_output <= 7'b1110000;  // 7
            4'b1000: seg_output <= 7'b1111111;  // 8
            4'b1001: seg_output <= 7'b1111011;  // 9
            default: seg_output <= 7'b0000000;  // Blank display for invalid inputs
        endcase
    end
end

endmodule
