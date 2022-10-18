#!/usr/bin/env python3
# Copyright 2019 ETH Zurich and University of Bologna.
# SPDX-License-Identifier: Apache-2.0
#
# Edited at: 03/10/2022
# Edited by: F.Marques <fmarques_00@protonmail.com>

import argparse
from enum import Enum
from fileinput import filename
from math import ceil, log
import os.path
import datetime


NORMAL_ENTRY          = 0
REG_MACRO_ENTRY       = 1
REG_BIT_W_MACRO_ENTRY = 2
REG_DEPEND_ENTRY      = 3
SRC_DEPEND_ENTRY      = 4

MAX_DEVICES         = 1023
MAX_SOURCES         = 1023

MMODE               = 0
SMODE               = 1

REGISTER_DEF_SIZE32 = 32
REGISTER_DEF_SIZE64 = 63
SOURCECFG_SIZE      = 11
IDELIVERY_SIZE      = 1
IFORCE_SIZE         = 1
TOPI_SIZE           = 26
CLAIMI_SIZE         = TOPI_SIZE

def clog2(x):
  return ceil(log(x, 2))

class Access(Enum):
  RO    = 1
  RW    = 2
  WAR0  = 3

class AddrMapEntry(object):

  """Represents an Entry in an Address Map"""
  def __init__(self, addr, name, description, access, width, start_bit):
    super(AddrMapEntry, self).__init__()
    self.addr = addr
    self.description = description
    self.access = access
    self.width = width
    self.start_bit = start_bit
    self.name = name

  def __str__(self):
    return '{} | {} | {} | {}'.format(hex(self.addr), self.width, self.access, self.description)

  def get_list_elem(self):
    return [hex(self.addr), self.width, self.access, self.description]

class AddrMap:
  def __init__(self, name, description, access_width=32):
    self.access_width = access_width
    self.name = name
    self.description = description
    self.addrmap = []
    self.ports = []

  def addEntries(self, num, addr, addr_base, name, description, access, width):
    # register port
    self.ports.append((name, num, width, access, 0, 0))
    for i in range(0, num):
      effect_addr = addr(i, addr_base)
      # we need to split the entry into multiple aligned entries as otherwise we would
      # violate the access_width constraints
      if (width / self.access_width) > 1.0:
        for i in range(0, int(ceil(width / self.access_width))):
          if (width - self.access_width * i < self.access_width):
            self.addrmap.append(AddrMapEntry(effect_addr + int(self.access_width/8) * i,  name, description.format(i), access, width - self.access_width * i, 0))
          else:
            self.addrmap.append(AddrMapEntry(effect_addr + int(self.access_width/8) * i,  name, description.format(i), access, self.access_width, 0))
      else:
        self.addrmap.append(AddrMapEntry(effect_addr, name, description.format(i), access, width, 0))

  def addEntry(self, addr, addr_base, name, description, access, width):
    self.addEntries(1, addr, addr_base, name, description, access, width)

  def addEntriesMacro(self, num, macro, macro_type, addr, addr_base, name, description, access, width, start_bit = 0):
    # register port
    self.ports.append((name, macro, width, access, macro_type, start_bit))
    for i in range(0, num):
      effect_addr = addr(i, addr_base)
      # we need to split the entry into multiple aligned entries as otherwise we would
      # violate the access_width constraints
      if (macro_type == 1) | (macro_type == 3) | (macro_type == 4):
        if (width / self.access_width) > 1.0:
          for i in range(0, int(ceil(width / self.access_width))):
            if (width - self.access_width * i < self.access_width):
              self.addrmap.append(AddrMapEntry(effect_addr + int(self.access_width/8) * i,  name, description.format(i), access, width - self.access_width * i, start_bit))
            else:
              self.addrmap.append(AddrMapEntry(effect_addr + int(self.access_width/8) * i,  name, description.format(i), access, self.access_width, start_bit))
        else:
          self.addrmap.append(AddrMapEntry(effect_addr, name, description.format(i), access, width, start_bit))
      elif macro_type == 2:
        self.addrmap.append(AddrMapEntry(effect_addr, name, description.format(i), access, width, start_bit))

  """Dump Verilog for Register Map"""
  def dumpRegmap(self):
    output = "/** \n"
    output += "*   Name: APLIC domain register map (generic)\n"
    output += "*   Date: {}\n".format(str(datetime.datetime.now()))
    output += "*   Author: F.Marques <fmarques_00@protonmail.com>\n"
    output += "* \n"
    output += "*   Description: This module is a generic APLIC domain register map.\n"
    output += "*                For a given domain unused registers should be unconnected.\n"
    output += "*   Disclaimer:  This file was automatically generated. Edit at your own risk.\n"
    output += "*/ \n"
    output += "module {} #(\n".format(regmap_name)
    output += "   parameter int                       DOMAIN_ADDR = 32'h{},\n".format(hex(addr)[2:])
    output += "   parameter int                       NR_SRC      = {},\n".format(nr_src_eff)
    output += "   parameter int                       NR_REG      = {},\n".format(nr_reg_needed_for_interrupt)
    output += "   parameter int                       MIN_PRIO    = {},\n".format(min_prio)
    output += "   parameter int                       IPRIOLEN    = {}, //(MIN_PRIO == 1) ? 1 : $clog2(MIN_PRIO),\n".format(priority_width)
    output += "   parameter int                       NR_IDCs     = {}\n".format(nr_idc)
    output += ") (\n"
    for i in self.ports:
      # self.ports.append((name, num, width, access))
      output += "  // Register: {}\n".format(i[0])
      if i[3] == Access.RO:
        match i[4]:
          case 0: #NORMAL_ENTRY
            output += "  input  logic [{}:0][{}:0]      i_{},\n".format(i[1]-1, i[2]-1, i[0])
            output += "  output logic [{}:0]            o_{}_re,\n".format(i[1]-1, i[0])
          case 1: #REG_MACRO_ENTRY
            output += "  input  logic [{}-1:0][{}:0]    i_{},\n".format(i[1], i[2]-1, i[0])
            output += "  output logic [{}-1:0]          o_{}_re,\n".format(i[1], i[0])
          case 2: #REG_BIT_W_MACRO_ENTRY
            output += "  input  logic [{}-1:0][{}-1:0]  i_{},\n".format(i[1], i[2], i[0])
            output += "  output logic [{}-1:0]          o_{}_re,\n".format(i[1], i[0])
          case 3: #REG_DEPEND_ENTRY
            output += "  input  logic [{}:0][{}:0]      i_{},\n".format(i[1], i[2]-1, i[0])
            output += "  output logic [{}:0]            o_{}_re,\n".format(i[1], i[0])
          case 4: #SRC_DEPEND_ENTRY
            output += "  input  logic [{}-1:{}][{}:0]    i_{},\n".format(i[1], i[5], i[2]-1, i[0])
            output += "  output logic [{}-1:{}]          o_{}_re,\n".format(i[1], i[5], i[0])
      elif (i[3] == Access.RW) | (i[3] == Access.WAR0):
        match i[4]:
          case 0: #NORMAL_ENTRY
            output += "  input  logic [{}:0][{}:0]      i_{},\n".format(i[1]-1, i[2]-1, i[0])
            output += "  output logic [{}:0][{}:0]      o_{},\n".format(i[1]-1, i[2]-1, i[0])
            output += "  output logic [{}:0]            o_{}_we,\n".format(i[1]-1, i[0])
            output += "  output logic [{}:0]            o_{}_re,\n".format(i[1]-1, i[0])
          case 1: #REG_MACRO_ENTRY
            output += "  input  logic [{}-1:0][{}:0]    i_{},\n".format(i[1], i[2]-1, i[0])
            output += "  output logic [{}-1:0][{}:0]    o_{},\n".format(i[1], i[2]-1, i[0])
            output += "  output logic [{}-1:0]          o_{}_we,\n".format(i[1], i[0])
            output += "  output logic [{}-1:0]          o_{}_re,\n".format(i[1], i[0])
          case 2: #REG_BIT_W_MACRO_ENTRY
            output += "  input  logic [{}-1:0][{}-1:0]  i_{},\n".format(i[1], i[2], i[0])
            output += "  output logic [{}-1:0][{}-1:0]  o_{},\n".format(i[1], i[2], i[0])
            output += "  output logic [{}-1:0]          o_{}_we,\n".format(i[1], i[0])
            output += "  output logic [{}-1:0]          o_{}_re,\n".format(i[1], i[0])
          case 3: #REG_DEPEND_ENTRY
            output += "  input  logic [{}:0][{}:0]      i_{},\n".format(i[1], i[2]-1, i[0])
            output += "  output logic [{}:0][{}:0]      o_{},\n".format(i[1], i[2]-1, i[0])
            output += "  output logic [{}:0]            o_{}_we,\n".format(i[1], i[0])
            output += "  output logic [{}:0]            o_{}_re,\n".format(i[1], i[0])
          case 4: #SRC_DEPEND_ENTRY
            output += "  input  logic [{}-1:{}][{}:0]    i_{},\n".format(i[1], i[5], i[2]-1, i[0])
            output += "  output logic [{}-1:{}][{}:0]    o_{},\n".format(i[1], i[5], i[2]-1, i[0])
            output += "  output logic [{}-1:{}]          o_{}_we,\n".format(i[1], i[5], i[0])
            output += "  output logic [{}-1:{}]          o_{}_re,\n".format(i[1], i[5], i[0])

    output += "  // Bus Interface\n"
    output += "  input  reg_intf::reg_intf_req_a32_d32 i_req,\n"
    output += "  output reg_intf::reg_intf_resp_d32    o_resp\n"
    output += ");\n"
    output += "always_comb begin\n"
    output += "  o_resp.ready = 1'b1;\n"
    output += "  o_resp.rdata = '0;\n"
    output += "  o_resp.error = '0;\n"
    for i in self.ports:
      if i[3] != Access.RO:
        output += "  o_{} = '0;\n".format(i[0])
        output += "  o_{}_we = '0;\n".format(i[0])
      output += "  o_{}_re = '0;\n".format(i[0])
    output += "  if (i_req.valid) begin\n"
    output += "    if (i_req.write) begin\n"
    output += "      unique case(i_req.addr)\n"
    j = 0
    last_name = ""
    for i in self.addrmap:
      if i.access != Access.RO:
        if last_name != i.name:
          j = 0
        if (j >= i.start_bit) :
          output += "        DOMAIN_ADDR + {}'h{}: begin\n".format(self.access_width, hex(i.addr - addr)[2:])
          if type(i.width) is str:
            output += "          o_{}[{}][{}-1:0]     = i_req.wdata[{}-1:0];\n".format(i.name, j, i.width, i.width)
          else:  
            output += "          o_{}[{}][{}:0]     = i_req.wdata[{}:0];\n".format(i.name, j, i.width - 1, i.width - 1)
          output += "          o_{}_we[{}]      = 1'b1;\n".format(i.name, j)
          output += "        end\n"
        j += 1
        last_name = i.name
    output += "        default: o_resp.error = 1'b1;\n"
    output += "      endcase\n"
    output += "    end else begin\n"
    output += "      unique case(i_req.addr)\n"
    j = 0
    last_name = ""
    for i in self.addrmap:
      if last_name != i.name:
        j = 0
      if (j >= i.start_bit) :
        output += "        DOMAIN_ADDR + {}'h{}: begin\n".format(self.access_width, hex(i.addr - addr)[2:])
        if type(i.width) is str:
          output += "          o_resp.rdata[{}-1:0]     = i_{}[{}][{}-1:0];\n".format(i.width, i.name, j, i.width)
        else:
          output += "          o_resp.rdata[{}:0]     = i_{}[{}][{}:0];\n".format(i.width - 1, i.name, j, i.width - 1)
        output += "          o_{}_re[{}]      = 1'b1;\n".format(i.name, j)
        output += "        end\n"
      j += 1
      last_name = i.name
    output += "        default: o_resp.error = 1'b1;\n"
    output += "      endcase\n"
    output += "    end\n"
    output += "  end\n"
    output += "end\n"
    output += "endmodule\n"
    return output

  """Dump Interface to APLIC Domain"""
  def dumpAplicDomain(self):
    output = "/** \n"
    output += "*   Name: APLIC domain top module\n"
    output += "*   Date: {}\n".format(str(datetime.datetime.now()))
    output += "*   Author: F.Marques <fmarques_00@protonmail.com>\n"
    output += "* \n"
    output += "*   Description: This module is the APLIC domain.\n"
    output += "*                It is comprised by 3 submodules: gatway, notifier and register map.\n"
    output += "*   Disclaimer:  This file was automatically generated. Edit at your own risk.\n"
    output += "*/ \n"
    output += "module " + file_top_name + " #(\n"
    output += "   parameter int                           DOMAIN_ADDR = 32'h{},\n".format(hex(addr)[2:])
    output += "   parameter int                           NR_SRC    = {},\n".format(nr_src)
    output += "   parameter int                           MIN_PRIO  = {},\n".format(min_prio)
    output += "   parameter int                           IPRIOLEN  = {},\n".format(priority_width)
    output += "   parameter int                           NR_IDCs   = {}\n".format(nr_idc)
    output += ") (\n"
    output += "   input  logic                            i_clk,\n"
    output += "   input  logic                            ni_rst,\n"
    output += "   input  reg_intf::reg_intf_req_a32_d32   i_req,\n"
    output += "   output reg_intf::reg_intf_resp_d32      o_resp,\n"
    output += "   input  logic [NR_SRC-1:0]               i_irq_sources,\n"
    output += "   output logic [NR_SRC-1:0]               o_irq_del_sources,\n"
    if(domain_level == MMODE):
      output += "   output logic [NR_IDCs-1:0]              o_meip_targets\n"
    elif(domain_level == SMODE):
      output += "   output logic [NR_IDCs-1:0]              o_seip_targets\n"
    output += ");\n"

    ######################################
    #      Generate register map reg     #
    ######################################
    for i in self.ports:
      output += "\n// Register {}\n".format(i[0]) 
      if i[3] == Access.RO:
        match i[4]:
          case 0:
            output += "logic [{}:0][{}:0]       {}_qi, {}_di;\n".format(i[1]-1, i[2]-1, i[0], i[0])
            output += "logic [{}:0]             {}_re;\n".format(i[1]-1, i[0])
          case 1:
            output += "logic [{}-1:0][{}:0]     {}_qi, {}_di;\n".format(i[1], i[2]-1, i[0], i[0])
            output += "logic [{}-1:0]           {}_re;\n".format(i[1], i[0])
          case 2:
            output += "logic [{}-1:0][{}-1:0]   {}_qi, {}_di;\n".format(i[1], i[2], i[0], i[0])
            output += "logic [{}-1:0]           {}_re;\n".format(i[1], i[0])
          case 3:
            output += "logic [{}-1:0][{}:0]     {}_qi, {}_di;\n".format(i[1], i[2]-1, i[0], i[0])
            output += "logic [{}-1:0]           {}_re;\n".format(i[1], i[0])
      elif (i[3] == Access.RW) | (i[3] == Access.WAR0):
        match i[4]:
          case 0:
            output += "logic [{}:0][{}:0]       {}_qi, {}_di;\n".format(i[1]-1, i[2]-1, i[0], i[0])
            output += "logic [{}:0][{}:0]       {}_o;\n".format(i[1]-1, i[2]-1, i[0])
            output += "logic [{}:0]             {}_we;\n".format(i[1]-1, i[0])
            output += "logic [{}:0]             {}_re;\n".format(i[1]-1, i[0])
          case 1:
            output += "logic [{}-1:0][{}:0]     {}_qi, {}_di;\n".format(i[1], i[2]-1, i[0], i[0])
            output += "logic [{}-1:0][{}:0]     {}_o;\n".format(i[1], i[2]-1, i[0])
            output += "logic [{}-1:0]           {}_we;\n".format(i[1], i[0])
            output += "logic [{}-1:0]           {}_re;\n".format(i[1], i[0])
          case 2:
            output += "logic [{}-1:0][{}-1:0]   {}_qi, {}_di;\n".format(i[1], i[2], i[0], i[0])
            output += "logic [{}-1:0][{}-1:0]   {}_o;\n".format(i[1], i[2], i[0])
            output += "logic [{}-1:0]           {}_we;\n".format(i[1], i[0])
            output += "logic [{}-1:0]           {}_re;\n".format(i[1], i[0])
          case 3:
            output += "logic [{}-1:0][{}:0]     {}_qi, {}_di;\n".format(i[1], i[2]-1, i[0], i[0])
            output += "logic [{}-1:0][{}:0]     {}_o;\n".format(i[1], i[2]-1, i[0])
            output += "logic [{}-1:0]           {}_we;\n".format(i[1], i[0])
            output += "logic [{}-1:0]           {}_re;\n".format(i[1], i[0])

    ######################################
    #      Instantiate register map      #
    ######################################
    output += "\n"+regmap_name+" #(\n"
    output += "   .DOMAIN_ADDR(DOMAIN_ADDR),\n"
    output += "   .NR_SRC(NR_SRC),\n"
    output += "   .MIN_PRIO(MIN_PRIO),\n"
    output += "   .IPRIOLEN(IPRIOLEN),\n"
    output += "   .NR_IDCs(NR_IDCs)\n"
    output += ") i_"+regmap_name+" (\n"
    for i in self.ports:
      output += "   // Register: {}\n".format(i[0])
      if i[3] == Access.RO:
        output += "   .i_{}({}_qi),\n".format(i[0], i[0])
        output += "   .o_{}_re({}_re),\n".format(i[0], i[0])
      elif i[3] == Access.RW:
        output += "   .i_{}({}_qi),\n".format(i[0], i[0])
        output += "   .o_{}({}_o),\n".format(i[0], i[0])
        output += "   .o_{}_we({}_we),\n".format(i[0], i[0])
        output += "   .o_{}_re({}_re),\n".format(i[0], i[0])
      elif i[3] == Access.WAR0:
        output += "   .i_{}('0),\n".format(i[0], i[0])
        output += "   .o_{}({}_o),\n".format(i[0], i[0])
        output += "   .o_{}_we({}_we),\n".format(i[0], i[0])
        output += "   .o_{}_re(),\n".format(i[0], i[0])
    output += "); // End of Regmap instance\n\n"

    output += "/** Registers sequential logic */\n"
    output += "always_ff @( posedge i_clk or negedge ni_rst ) begin\n"
    output += "   if (!ni_rst) begin\n"
    for i in self.ports:
      output += "     {}_qi <= '0;\n".format(i[0])
    output += "   end else begin\n"
    for i in self.ports:
      output += "     {}_qi <= {}_di;\n".format(i[0], i[0])
    output += "   end\n"
    output += "end\n"
    output += "endmodule\n"
    return output

#
# Generate APLIC address map
#
if __name__ == "__main__":
  # Parse the command line arguments.
  parser = argparse.ArgumentParser()
  parser.add_argument("-d", "--domain_level", metavar="DomainLevel", help="Domain level type: M- M-Level; S- S-Level (default M)", default="M")
  parser.add_argument("-I", "--id", metavar="DomainID", help="Domain ID used to create the file name: aplic_<ID>_regmap.sv (default "")", default="")
  parser.add_argument("-a", "--addr", metavar="AddressDomain", help="Domain base address (default 0xC000000)", default="0xC000000")
  parser.add_argument("-i", "--nr_idc", metavar="NrIDCs", help="number of IDCs. If 0 domain will implement MSI delivery (default 1)", default=1)
  parser.add_argument("-s", "--nr_sources", metavar="NrSources", help="number of sources (default 30)", default=30)
  parser.add_argument("-p", "--min_priority", metavar="MinPriority", help="minimum number of priority (default 7)", default=7)
  parser.add_argument("-y", "--s_domain", metavar="SDomain", help="It will be implemented S-Domain (default y). n if not.", default="y")
  args = parser.parse_args()

  if (args.domain_level == "M"):
    domain_level = 0
  elif(args.domain_level == "S"):
    domain_level = 1
  else:
    domain_level = 2

  if args.id:
    domain_id = args.id + "_"
  else:
    domain_id = ""

  if args.addr:
    addr = int(args.addr, 16)

  if args.nr_idc:
    nr_idc = int(args.nr_idc)

  if args.nr_sources:
    nr_src = int(args.nr_sources)

  if args.min_priority:
    min_prio = int(args.min_priority)

  if (args.s_domain == "y"):
    s_domain = 1
  elif(args.s_domain == "n"):
    s_domain = 0
  else:
    s_domain = 2

  priority_width = clog2(min_prio + 1)

  # interrupt source 0 is reserved, so add another source
  nr_src_eff = nr_src + 1
  source_width = clog2(nr_src_eff)
  nr_reg_needed_for_interrupt = nr_src // REGISTER_DEF_SIZE32

  addrmap = AddrMap("aplic_regs", "APLIC Address Map")

  assert domain_level <= 1, "Only 0 (M-Level) and 1 (S-Level) are supported"
  assert s_domain <= 1, "Only y (yes) and n (not) are supported"
  assert nr_src <= MAX_SOURCES, "Not more than 1023 interrupt sources are supported at the moment"
  assert nr_idc <= MAX_DEVICES, "Maximum allowed targets are {}".format(MAX_DEVICES)

  # ===============================
  # Addresses bases and offsets
  # ===============================
  aplic_idc_base    = 0x4000

  domainOff         = 0x0000
  sourcecfgOff      = 0x0004
  mmsiaddrcfgOff    = 0x1BC0
  mmsiaddrcfghOff   = 0x1BC4
  smsiaddrcfgOff    = 0x1BC8
  smsiaddrcfghOff   = 0x1BCC
  setipOff          = 0x1C00
  setipnumOff       = 0x1CDC
  in_clripOff       = 0x1D00
  clripnumOff       = 0x1DDC
  setieOff          = 0x1E00
  setienumOff       = 0x1EDC
  clrieOff          = 0x1F00
  clrienumOff       = 0x1FDC
  setipnum_leOff    = 0x2000
  setipnum_beOff    = 0x2004
  genmsiOff         = 0x3000
  targetOff         = 0x3004

  ideliveryOff      = 0x00
  iforceOff         = 0x04
  ithresholdOff     = 0x08
  topiOff           = 0x18
  claimiOff         = 0x1C

  def domainAddr(i, addr_base):
    return domainOff + addr_base
  
  def sourcecfgAddr(i, addr_base):
    return sourcecfgOff + addr_base + (i-1) * 4

  def mmsiaddrcfgAddr(i, addr_base):
    return mmsiaddrcfgOff + addr_base

  def mmsiaddrcfghAddr(i, addr_base):
    return mmsiaddrcfghOff + addr_base

  def smsiaddrcfgAddr(i, addr_base):
    return smsiaddrcfgOff + addr_base

  def smsiaddrcfghAddr(i, addr_base):
    return smsiaddrcfghOff + addr_base

  def setipAddr(i, addr_base):
    return setipOff + addr_base + i * 4 

  def setipnumAddr(i, addr_base):
    return setipnumOff + addr_base

  def in_clripAddr(i, addr_base):
    return in_clripOff + addr_base + i * 4

  def clripnumAddr(i, addr_base):
    return clripnumOff + addr_base

  def setieAddr(i, addr_base):
    return setieOff + addr_base + i * 4

  def setienumAddr(i, addr_base):
    return setienumOff + addr_base

  def clrieAddr(i, addr_base):
    return clrieOff + addr_base + i * 4

  def clrienumAddr(i, addr_base):
    return clrienumOff + addr_base

  def setipnum_leAddr(i, addr_base):
    return setipnum_leOff + addr_base
  
  def setipnum_beAddr(i, addr_base):
    return setipnum_beOff + addr_base

  def genmsiAddr(i, addr_base):
    return genmsiOff + addr_base

  def targetAddr(i, addr_base):
    return targetOff + addr_base + (i-1) * 4

  def ideliveryAddr(i, addr_base):
    return ideliveryOff + addr_base + i * 0x20

  def iforceAddr(i, addr_base):
    return iforceOff + addr_base + i * 0x20
  
  def ithresholdAddr(i, addr_base):
    return ithresholdOff + addr_base + i * 0x20

  def topiAddr(i, addr_base):
    return topiOff + addr_base + i * 0x20

  def claimiAddr(i, addr_base):
    return claimiOff + addr_base + i * 0x20

  def addIDC(aplic_idc_base, num_idcs, mode):
    if(num_idcs == 0):
      return 0

    # idelivery register
    #addrmap.addEntries(num_idcs, ideliveryAddr, aplic_idc_base, mode + "idelivery", mode + "idelivery", Access.RW, IDELIVERY_SIZE)
    addrmap.addEntriesMacro(num_idcs, "NR_IDCs", REG_MACRO_ENTRY, ideliveryAddr, aplic_idc_base, mode + "idelivery", mode + "idelivery", Access.RW, IDELIVERY_SIZE)

    # iforce register
    #addrmap.addEntries(num_idcs, iforceAddr, aplic_idc_base, mode + "iforce", mode + "iforce", Access.RW, IFORCE_SIZE)
    addrmap.addEntriesMacro(num_idcs, "NR_IDCs", REG_MACRO_ENTRY, iforceAddr, aplic_idc_base, mode + "iforce", mode + "iforce", Access.RW, IFORCE_SIZE, 0)

    # ithreshold register
    addrmap.addEntriesMacro(num_idcs, "NR_IDCs", REG_BIT_W_MACRO_ENTRY, ithresholdAddr, aplic_idc_base, mode + "ithreshold", mode + "ithreshold", Access.RW, "IPRIOLEN", 0)

    # topi register
    addrmap.addEntriesMacro(num_idcs, "NR_IDCs", REG_MACRO_ENTRY, topiAddr, aplic_idc_base, mode + "topi", mode + "topi", Access.RO, TOPI_SIZE, 0)

    # claimi register
    addrmap.addEntriesMacro(num_idcs, "NR_IDCs", REG_MACRO_ENTRY, claimiAddr, aplic_idc_base, mode + "claimi", mode + "claimi", Access.RO, CLAIMI_SIZE, 0)
    return 0

  def addDomain(domain_mode, exist_s_mode, nr_idc, aplic_base):
    if (domain_mode == MMODE):
      mode = ""#"m_"
    elif (domain_mode == SMODE):
      mode = ""#"s_"

    # domaincfg register
    addrmap.addEntry(domainAddr, aplic_base, mode + "domaincfg", mode + "domaincfg", Access.RW, REGISTER_DEF_SIZE32)

    # sourcecfg registers
    addrmap.addEntriesMacro(nr_src_eff, "NR_SRC", SRC_DEPEND_ENTRY, sourcecfgAddr, aplic_base, mode + "sourcecfg", mode + "sourcecfg", Access.RW, SOURCECFG_SIZE, 1)
    
    # Only implemented at M-Mode
    if(domain_mode == MMODE):
      # mmsiaddrcfg registers
      addrmap.addEntry(mmsiaddrcfgAddr, aplic_base, "mmsiaddrcfg", "mmsiaddrcfg", Access.RW, REGISTER_DEF_SIZE32)

      # mmsiaddrcfgh registers
      addrmap.addEntry(mmsiaddrcfghAddr, aplic_base, "mmsiaddrcfgh", "mmsiaddrcfgh", Access.RW, REGISTER_DEF_SIZE32)
      
      # Only implemented if the domain implements the mmseaddrcfhX
      # AND is implemented at least a S-mode
      if(exist_s_mode):
        # smsiaddrcfg registers
        addrmap.addEntry(smsiaddrcfgAddr, aplic_base, "smsiaddrcfg", "smsiaddrcfg", Access.RW, REGISTER_DEF_SIZE32)

        # smsiaddrcfgh registers
        addrmap.addEntry(smsiaddrcfghAddr, aplic_base, "smsiaddrcfgh", "smsiaddrcfgh", Access.RW, REGISTER_DEF_SIZE32)

    # ==========================================================================================
    # setip registers: only exitent sources are implemented
    # if the number of sources interrupt were less then 31 
    # implement only 1 setip reg with only the existent sources
    nr_setip = nr_reg_needed_for_interrupt
    # if nr_setip == 0:
    #   #addrmap.addEntry(setipAddr, aplic_base, mode + "setip", mode + "setip", Access.RW, nr_src_eff)
    #   addrmap.addEntry(setipAddr, aplic_base, mode + "setip", mode + "setip", Access.RW, REGISTER_DEF_SIZE32)
    # elif nr_setip >= 1:
    #   addrmap.addEntries(nr_setip+1, setipAddr, aplic_base, mode + "setip", mode + "setip", Access.RW, REGISTER_DEF_SIZE32)
    addrmap.addEntriesMacro(nr_setip+1, "NR_REG", REG_DEPEND_ENTRY, setipAddr, aplic_base, mode + "setip", mode + "setip", Access.RW, REGISTER_DEF_SIZE32, 0)

    # setipnum registers
    addrmap.addEntry(setipnumAddr, aplic_base, mode + "setipnum", mode + "setipnum", Access.WAR0, REGISTER_DEF_SIZE32)

    # ==========================================================================================
    # in_clrip registers: only exitent sources are implemented
      # if the number of sources interrupt were less then 31 
      # implement only 1 setip reg with only the existent sources
    nr_in_clrip = nr_reg_needed_for_interrupt
    # if nr_in_clrip == 0:
    #   #addrmap.addEntry(in_clripAddr, aplic_base, mode + "in_clrip", mode + "in_clrip", Access.RW, nr_src_eff)
    #   addrmap.addEntry(in_clripAddr, aplic_base, mode + "in_clrip", mode + "in_clrip", Access.RW, REGISTER_DEF_SIZE32)
    # elif nr_in_clrip >= 1:
    #   addrmap.addEntries(nr_in_clrip+1, in_clripAddr, aplic_base, mode + "in_clrip", mode + "in_clrip", Access.RW, REGISTER_DEF_SIZE32)
    addrmap.addEntriesMacro(nr_in_clrip+1, "NR_REG", REG_DEPEND_ENTRY, in_clripAddr, aplic_base, mode + "in_clrip", mode + "in_clrip", Access.RW, REGISTER_DEF_SIZE32, 0)

    # clripnum registers
    addrmap.addEntry(clripnumAddr, aplic_base, mode + "clripnum", mode + "clripnum", Access.WAR0, REGISTER_DEF_SIZE32)

    # ==========================================================================================
    # setie registers: only exitent sources are implemented
      # if the number of sources interrupt were less then 31 
      # implement only 1 setip reg with only the existent sources
    nr_setie = nr_reg_needed_for_interrupt
    # if nr_setie == 0:
    #   #addrmap.addEntry(setieAddr, aplic_base, mode + "setie", mode + "setie", Access.RW, nr_src_eff)
    #   addrmap.addEntry(setieAddr, aplic_base, mode + "setie", mode + "setie", Access.RW, REGISTER_DEF_SIZE32)
    # elif nr_setie >= 1:
    #   addrmap.addEntries(nr_setie+1, setieAddr, aplic_base, mode + "setie", mode + "setie", Access.RW, REGISTER_DEF_SIZE32)
    addrmap.addEntriesMacro(nr_setie+1, "NR_REG", REG_DEPEND_ENTRY , setieAddr, aplic_base, mode + "setie", mode + "setie", Access.RW, REGISTER_DEF_SIZE32, 0)

    # setienum registers
    addrmap.addEntry(setienumAddr, aplic_base, mode + "setienum", mode + "setienum", Access.WAR0, REGISTER_DEF_SIZE32)

    # ==========================================================================================
    # clrie registers: only exitent sources are implemented
      # if the number of sources interrupt were less then 31 
      # implement only 1 setip reg with only the existent sources
    nr_clrie = nr_reg_needed_for_interrupt
    # if nr_clrie == 0:
    #   #addrmap.addEntry(clrieAddr, aplic_base, mode + "clrie", mode + "clrie", Access.RW, nr_src_eff)
    #   addrmap.addEntry(clrieAddr, aplic_base, mode + "clrie", mode + "clrie", Access.WAR0, REGISTER_DEF_SIZE32)
    # elif nr_clrie >= 1:
    #   addrmap.addEntries(nr_clrie+1, clrieAddr, aplic_base, mode + "clrie", mode + "clrie", Access.WAR0, REGISTER_DEF_SIZE32)
    addrmap.addEntriesMacro(nr_clrie+1, "NR_REG", REG_DEPEND_ENTRY, clrieAddr, aplic_base, mode + "clrie", mode + "clrie", Access.WAR0, REGISTER_DEF_SIZE32, 0)

    # clrienum registers
    addrmap.addEntry(clrienumAddr, aplic_base, mode + "clrienum", mode + "clrienum", Access.WAR0, REGISTER_DEF_SIZE32)

    # ==========================================================================================

    # setipnum_le registers
    addrmap.addEntry(setipnum_leAddr, aplic_base, mode + "setipnum_le", mode + "setipnum_le", Access.RW, REGISTER_DEF_SIZE32)

    # setipnum_be registers
    addrmap.addEntry(setipnum_beAddr, aplic_base, mode + "setipnum_be", mode + "setipnum_be", Access.RW, REGISTER_DEF_SIZE32)

    # genmsi registers
    addrmap.addEntry(genmsiAddr, aplic_base, mode + "genmsi", mode + "genmsi", Access.RW, REGISTER_DEF_SIZE32)

    # target registers
    addrmap.addEntriesMacro(nr_src_eff, "NR_SRC", SRC_DEPEND_ENTRY, targetAddr, aplic_base, mode + "target", mode + "target", Access.RW, REGISTER_DEF_SIZE32, 1)
    
    # IDCs
    addIDC(aplic_base + aplic_idc_base, nr_idc, mode)
    
    return 0

  def print_domain_top(file_top_name):
    proceed = input("Do you want to generate the aplic domain top interface? (y, n)")
    if(proceed == "y"):
      if (os.path.exists(file_top_name+".sv")):
        proceed = input("File already exist. Proceed? (y, n)")
      else:
        proceed = "y"
      if (proceed == "y"):  
        print(addrmap.dumpAplicDomain(), file=open(file_top_name+".sv", 'w'))
    else:
      print("Nothing to do.")

  def print_regmap(regmap_name):
    proceed = input("Do you want to generate the aplic register map? (y, n)")
    if(proceed == "y"):
      if (os.path.exists(regmap_name+".sv")):
        proceed = input("File already exist. Proceed? (y, n)")
      else:
        proceed = "y"      
      if(proceed == "y"):
          print(addrmap.dumpRegmap(), file=open(regmap_name+".sv", 'w'))
    else:
      print("Nothing to do.")

  addDomain(domain_level, s_domain, nr_idc, addr)
  
  regmap_name = "aplic_regmap_unstable"
  if(domain_level == MMODE):
    #regmap_name = "aplic_m_"+ domain_id + "regmap"
    file_top_name = "aplic_m_domain_"+ domain_id + "top"
  elif(domain_level == SMODE):
    #regmap_name = "aplic_s_"+ domain_id + "regmap"
    file_top_name = "aplic_s_domain_"+ domain_id + "top"

  #print_domain_top(file_top_name)
  print_regmap(regmap_name)
