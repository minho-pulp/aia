# Notifier Makefile

CLEAN =

# defaults
SIM ?= verilator
EXTRA_ARGS += --trace --trace-structs
TOPLEVEL_LANG ?= verilog

TEST_FOLDER = $(currdir) 
SRC_FOLDER = $(PWD)/../../rtl/
AXI_FOLDER = $(PWD)/../../axi/
WRAPPER_SRC = $(TEST_FOLDER)./wrap.sv

VERILOG_SOURCES += $(AXI_FOLDER)axi_pkg.sv
VERILOG_SOURCES += $(AXI_FOLDER)axi_intf.sv
VERILOG_SOURCES += $(AXI_FOLDER)ariane_axi_pkg.sv
VERILOG_SOURCES += $(AXI_FOLDER)axi_lite_slave.sv

VERILOG_SOURCES += $(SRC_FOLDER)/axi4_lite_write_master.sv
VERILOG_SOURCES += $(SRC_FOLDER)/axi4_lite_master_wraper.sv
VERILOG_SOURCES += $(WRAPPER_SRC)

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = axi_wrap

# MODULE is the basename of the Python test file
MODULE = axi_tb

ifeq ($(CLEAN),)
# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
else
all:
	rm -rf $(PWD)/__pycache__
	rm -rf $(PWD)/sim_build
	rm $(PWD)/results.xml
	rm $(PWD)/dump.vcd
endif