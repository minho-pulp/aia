from os import setpgid
from readline import set_pre_input_hook
import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
import random

# The test functions need to use the decorator @cocotb.test()
# Usage: await cocotb.start(generate_clock(dut))  # run the clock "in the background"
# if you want to wait a specific time: await Timer(5, units="ns")  # wait a bit

NR_SRC                  = 32
NR_BITS_SRC             = NR_SRC if (NR_SRC > 31) else 32
NR_REG                  = NR_SRC//32
NR_IDC                  = 1

SRC_PER_BIT             = 1
 
# interrupt sources macros
# Just to make the code more readable
class CSources:
    SRC = list(range(0, NR_SRC))

intp = CSources()

class CIDCs:
    ID = list(range(0, NR_IDC))

idc = CIDCs()

class CInputs:
    i_sourcecfg = 0
    i_sugg_setip = 0
    i_domaincfgDM = 0
    i_active = 0
    i_claimed_forwarde = 0
    i_domaincfgIE = 0
    i_setip_q = 0
    i_setie_q = 0
    i_target_q = 0
    i_idelivery = 0
    i_iforce = 0
    i_ithreshold = 0


class CInternals:
    setie_select_i = 0
    setip_select_i = 0
    topi_update_i = 0

class COutputs:
    o_intp_pen = 0
    o_rectified_src = 0
    o_topi_sugg = 0
    o_topi_update = 0

input                   = CInputs()
internal                = CInternals()
outputs                 = COutputs()


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
    # Set pending bit for interrupt 17
    input.i_sugg_setip          = set_or_reg(input.i_sugg_setip, 1, SRC_PER_BIT, intp.SRC[1])
    dut.i_sugg_setip.value      = input.i_sugg_setip

    #...

async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(10):
        dut.i_clk.value = 0
        await Timer(1, units="ns")
        dut.i_clk.value = 1
        await Timer(1, units="ns")

@cocotb.test()
async def regctl_unit_test(dut):
    """Try accessing the design."""

    dut.ni_rst.value = 1
    # run the clock "in the background"
    await cocotb.start(generate_clock(dut))  
    # wait a bit
    await Timer(2, units="ns")  
    # wait for falling edge/"negedge"
    await FallingEdge(dut.i_clk)

    # Reset the dut
    dut.ni_rst.value = 0
    await Timer(1, units="ns")
    dut.ni_rst.value = 1
    await Timer(1, units="ns")

    await cocotb.start(debug_config(dut))

