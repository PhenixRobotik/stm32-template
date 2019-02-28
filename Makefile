# Project configuration makefile
default: all

# Project
PROJECT_ROOT_ABS  := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PROJECT_ROOT      := .
PROJECT_NAME      ?= $(notdir $(patsubst %/,%,$(dir $(PROJECT_ROOT_ABS))))
PROJECT_LIBS      := $(PROJECT_ROOT)/lib
PROJECT_MK        := $(PROJECT_ROOT)/mk
PROJECT_SRC       := $(PROJECT_ROOT)/src
PROJECT_BIN       := $(PROJECT_ROOT)/bin
PROJECT_LDSCRIPT  ?= $(PROJECT_ROOT)/stm32f303.ld
PROJECT_VERBOSITY ?= 0

CFLAGS   ?=
INCLUDES ?=
LDFLAGS  ?=
C_SRCS   =

# Libraries
include $(PROJECT_LIBS)/libopencm3.mk
CFLAGS   += $(OPENCM3_CDEFS)
INCLUDES += -I$(OPENCM3_INC)
LDFLAGS  += -L$(OPENCM3_LIB) -l$(OPENCM3_LIBNAME)

# FreeRTOS
include $(PROJECT_MK)/freertos.mk
INCLUDES += $(RTOS_INC)
C_SRCS   += $(RTOS_SRC)

# Project sources
# Add project subdirectories
SRC_DIRS  = $(sort $(dir $(wildcard $(PROJECT_SRC)/*/)))
C_SRCS   += $(wildcard $(addsuffix *.c,$(SRC_DIRS)))
INCLUDES += $(addprefix -I,$(SRC_DIRS))

# Objects and includes
C_OBJS  = $(C_SRCS:.c=.o)
CFLAGS += $(INCLUDES)

# Linker script
LDFLAGS += -T$(PROJECT_LDSCRIPT)

# Toolchain
include $(PROJECT_MK)/toolchain.mk
include $(PROJECT_MK)/rules.mk

all: libs $(C_OBJS)

libs: libopencm3

clean-libs: libopencm3-clean

clean:
	-rm -f $(C_OBJS)
