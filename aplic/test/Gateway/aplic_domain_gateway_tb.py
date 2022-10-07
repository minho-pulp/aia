from os import setpgid
from readline import set_pre_input_hook
import cocotb
from cocotb.triggers import FallingEdge, Timer

# The test functions need to use the decorator @cocotb.test()

# Usage: await cocotb.start(generate_clock(dut))  # run the clock "in the background"
# if you want to wait a specific time: await Timer(5, units="ns")  # wait a bit

NR_SRC = 32
NR_BITS_SRC = NR_SRC if (NR_SRC > 31) else 32
NR_REG = NR_SRC/32 

SOURCECFD_W = 11

INACTIVE             = 0
DETACHED             = 1
EDGE1                = 4
EDGE0                = 5
LEVEL1               = 6
LEVEL0               = 7

INACTIVE_C           = 0
DETACHED_C           = 1
EDGEX_C              = 2
LEVELXDM0_C          = 3
LEVELXDM1_C          = 4

FROM_RECTIFIER       = 0
FROM_EDGE_DETECTOR   = 1

class CInputs:
    source          = 0
    sourcecfg       = 0
    setip           = 0
    active          = 0
    claimed         = 0
    succ_w_clr      = 0
    forwarded       = 0

class CInternals:
    rectified_src   = 0
    new_intp        = 0
    rectified_src   = 0
    new_intp_src    = 0
    intp_pen_src    = 0

class COutputs:
    intp_pen        = 0
    rectified_src   = 0

input       = CInputs()
internal    = CInternals()
outputs     = COutputs()

def set_reg(reg, hexa, reg_width, reg_num):
    reg = reg | (hexa << reg_width*reg_num)
    return reg

async def debug_config(dut):
    # Set Domain config Delivery Mode to 0: meaning Direct 
    dut.i_domaincfgDM.value = 0
    
    # Set the maximum value in reg 4 (index 3) in sourcecfg
    # Wait
    # set registers 3, 2, 1 with easy identifiable numbers 
    input.sourcecfg = set_reg(input.sourcecfg, 0x7FF, SOURCECFD_W, 3)
    dut.i_sourcecfg.value       = input.sourcecfg
    await Timer(1, units="ns")
    input.sourcecfg = set_reg(input.sourcecfg, 0x03, SOURCECFD_W, 2)
    input.sourcecfg = set_reg(input.sourcecfg, 0x02, SOURCECFD_W, 1)
    input.sourcecfg = set_reg(input.sourcecfg, 0x01, SOURCECFD_W, 0)
    dut.i_sourcecfg.value       = input.sourcecfg

    # Set setip, a 2D array, with 0xbebecafe
    await Timer(1, units="ns")
    input.setip = set_reg(input.setip, 0xbebecafe, NR_BITS_SRC, 0) 
    dut.i_setip.value           = input.setip 

    # Set active, a 2D array, with 0xbebecafe
    await Timer(1, units="ns")
    input.active = set_reg(input.active, 0xbebecafe, NR_BITS_SRC, 0) 
    dut.i_active.value          = input.active 

    # Set claimed, a 2D array, with 0xbebecafe
    await Timer(1, units="ns")
    input.claimed = set_reg(input.claimed, 0xbebecafe, NR_BITS_SRC, 0) 
    dut.i_claimed.value         = input.claimed 

    # Set forwarded, a 2D array, with 0xbebecafe
    await Timer(1, units="ns")
    input.forwarded = set_reg(input.forwarded, 0xbebecafe, NR_BITS_SRC, 0) 
    dut.i_forwarded.value       = input.forwarded 

    # Set forwarded, a 2D array, with 0xbebecafe
    await Timer(1, units="ns")
    input.succ_w_clr = set_reg(input.succ_w_clr, 0xbebecafe, NR_BITS_SRC, 0) 
    dut.i_succ_w_clr.value      = input.succ_w_clr

async def test_control_unit(dut):
    # Set Domain config Delivery Mode to 0: meaning Direct 
    dut.i_domaincfgDM.value = 0
    
    # Set the maximum value in reg 4 (index 3) in sourcecfg
    await Timer(1, units="ns")
    # Source 0 will always be INACTIVE. Ensured by Register Control
    input.sourcecfg             = set_reg(input.sourcecfg, INACTIVE, SOURCECFD_W, 0)
    input.sourcecfg             = set_reg(input.sourcecfg, EDGE1, SOURCECFD_W, 1)
    input.sourcecfg             = set_reg(input.sourcecfg, LEVEL0, SOURCECFD_W, 2)
    input.sourcecfg             = set_reg(input.sourcecfg, EDGE0, SOURCECFD_W, 52)
    dut.i_sourcecfg.value       = input.sourcecfg

    await Timer(1, units="ns")
    internal.new_intp_src       = set_reg(internal.new_intp_src, 0x00, 1, 0)
    internal.new_intp_src       = set_reg(internal.new_intp_src, 0x01, 1, 1)
    internal.new_intp_src       = set_reg(internal.new_intp_src, 0x00, 1, 2)
    internal.new_intp_src       = set_reg(internal.new_intp_src, 0x01, 1, 52)

    
async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(10):
        dut.i_clk.value = 0
        await Timer(1, units="ns")
        dut.i_clk.value = 1
        await Timer(1, units="ns")

@cocotb.test()
async def gateway_unit_test(dut):
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

    #await cocotb.start(debug_config(dut))
    await cocotb.start(test_control_unit(dut))

    await Timer(15, units="ns")
    assert dut.i_sourcecfg.value    == input.sourcecfg  , "Oh boy, you fucked it up in sourcecfg!"
    assert dut.aplic_domain_gateway_i.new_intp_src.value == internal.new_intp_src  , "Oh boy, you fucked it up in new_intp_src!"
    # assert dut.i_setip.value        == input.setip      , "Oh boy, you fucked it up in setip!"
    # assert dut.i_active.value       == input.active     , "Oh boy, you fucked it up in active!"
    # assert dut.i_claimed.value      == input.claimed    , "Oh boy, you fucked it up in claimed!"
    # assert dut.i_forwarded.value    == input.forwarded  , "Oh boy, you fucked it up in forwarded!"
    # assert dut.i_succ_w_clr.value   == input.succ_w_clr , "Oh boy, you fucked it up in succ_w_clr!"