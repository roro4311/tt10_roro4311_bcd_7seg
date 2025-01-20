import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_bcd_to_7seg(dut):
    """Test BCD to 7-segment decoder for BCD input 9."""

    # Generate clock
    clock = Clock(dut.clk, 10, units="ns")  # 10 ns clock period
    cocotb.start_soon(clock.start())

    # Reset
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.ui_in.value = 0
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1

    # Enable the module
    dut.ena.value = 1

    # Test for BCD input 9
    bcd = 9
    expected_segments = 0b1111011  # Segments lit for BCD 9: a, b, c, d, f, g
    dut.ui_in.value = bcd
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)  # Allow some delay for outputs to stabilize

    # Collect segment outputs
    seg_output = (
        (dut.seg_a.value << 6) |
        (dut.seg_b.value << 5) |
        (dut.seg_c.value << 4) |
        (dut.seg_d.value << 3) |
        (dut.seg_e.value << 2) |
        (dut.seg_f.value << 1) |
        (dut.seg_g.value << 0)
    )

    # Assertion for BCD 9
    assert seg_output == expected_segments, (
        f"BCD {bcd}: Expected {bin(expected_segments)}, got {bin(seg_output)}"
    )

    dut._log.info(f"BCD {bcd} test passed: Output {bin(seg_output)} matches expected {bin(expected_segments)}.")
