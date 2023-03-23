from os import setpgid
from readline import set_pre_input_hook
import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
import random

# The test functions need to use the decorator @cocotb.test()
# Usage: await cocotb.start(generate_clock(dut))  # run the clock "in the background"
# if you want to wait a specific time: await Timer(5, units="ns")  # wait a bit

def set_reg(reg, hexa, reg_width, reg_num):
    reg     = (hexa << reg_width*reg_num)
    return reg

def set_or_reg(reg, hexa, reg_width, reg_num):
    reg     = reg | (hexa << reg_width*reg_num)
    return reg

def read_bit_from_reg(reg, bit_num):
    aux     = int(reg)
    aux     = (aux >> bit_num) & 1
    return aux

async def debug_config(dut):
    # Disable domain interrupts 
    dut.ready_i.value = 0
    dut.addr_i.value  = 0x24000000
    dut.data_i.value  = 0xbebecafe
    await Timer(2, units="ns")
    
    dut.ready_i.value = 1

    await Timer(2, units="ns")
    dut.ready_i.value = 0



async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(10):
        dut.clk_i.value = 0
        await Timer(1, units="ns")
        dut.clk_i.value = 1
        await Timer(1, units="ns")

@cocotb.test()
async def notifier_unit_test(dut):
    """Try accessing the design."""

    dut.rst_ni.value = 1
    # run the clock "in the background"
    await cocotb.start(generate_clock(dut))  
    # wait a bit
    await Timer(2, units="ns")  
    # wait for falling edge/"negedge"
    await FallingEdge(dut.clk_i)

    # Reset the dut
    dut.rst_ni.value = 0
    await Timer(1, units="ns")
    dut.rst_ni.value = 1
    await Timer(1, units="ns")

    await cocotb.start(debug_config(dut))

    await Timer(15, units="ns")