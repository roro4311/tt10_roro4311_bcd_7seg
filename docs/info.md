<!---
This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The BCD to 7-Segment Encoder translates 4-bit binary-coded decimal (BCD) inputs into corresponding signals for a 7-segment display. The primary function is to convert numerical values (0-9) into the correct combination of segment activations to display the digit on the 7-segment display.

The core logic uses a simple combinational circuit based on a truth table for BCD-to-7-segment conversion. Each segment of the display (A through G) is controlled independently, and the logic ensures that only valid BCD inputs produce meaningful outputs. Inputs outside the 0-9 range result in no segment being activated.

### Key Features:
- Efficient conversion logic for minimal resource usage.
- Supports 4-bit BCD input for displaying numbers 0-9.
- Output directly drives a 7-segment display.

## How to test

1. **Initialization**: No initialization is required for this design as it is purely combinational logic. Apply the BCD input signals (`ui[0]` to `ui[3]`) to test the functionality.

2. **Input Testing**:
   - Apply a 4-bit BCD input corresponding to a decimal number (e.g., `0000` for 0, `1001` for 9).
   - Ensure that only valid BCD inputs (0-9) produce the correct 7-segment output. For invalid inputs (10-15), all segment outputs (`uo[0]` to `uo[6]`) should remain low.

3. **Output Observation**:
   - Observe the outputs (`uo[0]` to `uo[6]`) using a logic analyzer, testbench, or simulation environment.
   - Verify that the correct segments are activated for each valid input to display the intended number.

4. **Simulation**:
   - Use a simulation environment (such as ModelSim, Vivado, or Cocotb) to validate the BCD-to-7-segment mapping logic.
   - Apply a range of inputs (0 to 15) and confirm the outputs match the expected behavior.

## External hardware

No external hardware is required for the BCD to 7-Segment Encoder to function. However, for testing and demonstration purposes, you may use the following:

- **7-Segment Display**: Connect the outputs (`uo[0]` to `uo[6]`) to the segments of a 7-segment display to observe the result directly.
- **Logic Analyzer or FPGA Board**: For observing and verifying outputs in real-time.
- **Simulation Tools**: Test the design in a simulation environment to confirm correct behavior before deploying to hardware.

Note: A clock signal is not required for this design as it is a purely combinational circuit.
