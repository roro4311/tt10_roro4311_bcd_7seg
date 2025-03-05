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
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

    # Enable the module
    dut.ena.value = 1

    # Test for BCD input 9
    bcd = 9
    expected_segments = 0b1111011  # Segments lit for BCD 9: a, b, c, d, f, g
    dut.ui_in.value = bcd
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)  # Allow some delay for outputs to stabilize

    # Collect 7-segment outputs from uo_out
    uo_out = dut.uo_out.value.binstr[1:8]  # Extract the 7 bits corresponding to the segments

    # Assertion for BCD 9
    assert uo_out == format(expected_segments, '07b'), (
        f"BCD {bcd}: Expected {format(expected_segments, '07b')}, got {uo_out}"
    )

    dut._log.info(f"BCD {bcd} test passed: Output {uo_out} matches expected {format(expected_segments, '07b')}.")
