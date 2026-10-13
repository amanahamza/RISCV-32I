SIM =icarus
TOPLEVEL_LANG =verilog

VERILOG_SOURCES = $(PWD)/rf_wb_mux.sv
COCOTB_TOPLEVEL = rf_wb_mux
COCOTB_TEST_MODULES = python_stimulus_rf_wb_mux


COMPILE_ARGS = -g2012
export COCOTB_HDL_TIMEUNIT = 1ns
export COCOTB_HDL_TIMEPRECISION = 1ps

include $(shell cocotb-config --makefiles)/Makefile.sim

