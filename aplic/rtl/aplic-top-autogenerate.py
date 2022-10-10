#!/usr/bin/env python3
# Copyright 2019 ETH Zurich and University of Bologna.
# SPDX-License-Identifier: Apache-2.0
#
# Created at: 04/10/2022
# Created by: F.Marques <fmarques_00@protonmail.com>
# TODO: Create the MSI interface; Make it optional (direct, msi or both)
import argparse
from math import ceil, log

MAX_DEVICES         = 1023
MAX_SOURCES         = 1023
REGISTER_DEF_SIZE32 = 32

def clog2(x):
  return ceil(log(x, 2))

class GenTop:
  def __init__(self, name, description):
    self.name = name
    self.description = description

  """Dump Interface to APLIC top"""
  def dumpInterface(self):
    output = "//\n"
    output += "module aplic_top #(\n"
    output += "   /** Number of external interrupts */\n"
    output += "   parameter int                           N_SOURCE = {},\n" .format(nr_src)
    output += "   /** There is one IDC per hart index connected to the APLIC */\n"
    output += "   parameter int                           N_IDCs = {}\n" .format(nr_idc)
    output += ") (\n"
    output += "   input  logic                            i_clk,\n"
    output += "   input  logic                            ni_rst,\n"
    output += "   input  logic [N_SOURCE:0]               i_sources,\n"
    for i in range(nr_domains):
        output += "   /** APLIC domain interface {}*/\n".format(i+1)
        output += "   input  reg_intf::reg_intf_req_a32_d32   i_req_{},\n".format(i+1)
        output += "   output reg_intf::reg_intf_resp_d32      o_resp_{},\n".format(i+1)
    output += "   /** Interrupt Notification to Targets. One per priv. level. */\n"
    output += "   output logic [(N_IDCs*2)-1:0]           o_Xeip_targets\n"
    output += "); /** End of APLIC top interface */\n\n"
    output += "/** Insert Code Here */\n"
    output += "\n"
    output += "endmodule\n"
    return output

#
# Generate APLIC Top Interface
#
if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("-d", "--nr_domains", metavar="NumDomains", help="Number of domains that will be implemented (default 1)", default=1)
  parser.add_argument("-i", "--nr_idc", metavar="NumIDCs", help="Number of IDCs connected to harts (default 1)", default=1)
  parser.add_argument("-s", "--nr_src", metavar="NrSources", help="number of sources (default 30)", default=30)
  args = parser.parse_args()

  if args.nr_domains:
    nr_domains = int(args.nr_domains)

  if args.nr_idc:
    nr_idc = int(args.nr_idc)

  if args.nr_src:
    nr_src = int(args.nr_src)

  # interrupt source 0 is reserved, so add another source
  nr_src_eff = nr_src + 1
  source_width = clog2(nr_src_eff)
  nr_reg_needed_for_interrupt = nr_src // REGISTER_DEF_SIZE32

  genTop = GenTop("aplic_top", "APLIC Top Interface")

  assert nr_src     <= MAX_SOURCES, "Not more than 1023 interrupt sources are supported at the moment"
  assert nr_idc     <= MAX_DEVICES, "Maximum allowed targets are {}".format(MAX_DEVICES)

  proceed = input("This operation will rewrite the file: aplic_top.sv do you want to proceed? (y, n)")
  if(proceed == "y"):
    print(genTop.dumpInterface(), file=open("aplic_top.sv", 'w'))
  else:
    print("Nothing to do.")

