# Toolchain path
BINPATH ?= /usr/bin
PREFIX   = arm-none-eabi

# Toolchain
CC		:= $(PREFIX)-gcc
CXX		:= $(PREFIX)-g++
LD		:= $(PREFIX)-gcc
AR		:= $(PREFIX)-ar
AS		:= $(PREFIX)-as
OBJCOPY		:= $(PREFIX)-objcopy
OBJDUMP		:= $(PREFIX)-objdump
GDB		:= $(PREFIX)-gdb
SIZE		:= $(PREFIX)-size

# CCache
ifeq (,$(shell which ccache))
else
	CC := ccache $(CC)
	CXX:= ccache $(CXX)
endif
