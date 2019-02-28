# Target
FP_FLAGS   ?=             \
	-mfloat-abi=hard  \
	-mfpu=fpv4-sp-d16
ARCH_FLAGS :=           \
	-mthumb         \
	-mcpu=cortex-m4 \
	$(FP_FLAGS)

# CFLAGS
CFLAGS += \
	-std=c99 \
	-g \
	-Os \
	-fdiagnostics-color=always \
	-Wall \
	-Wextra \
	-ffunction-sections \
	-fdata-sections \
	-fno-common \
	--static

CXXFLAGS = \
	-fno-exceptions

ifneq ($(PROJECT_VERBOSITY),1)
Q := @
# Do not print "Entering directory ...".
MAKEFLAGS += --no-print-directory
endif

%.bin: %.elf
	@printf "  OBJCOPY $@\n"
	$(Q)$(OBJCOPY) -Obinary $< $@

%.hex: %.elf
	@printf "  OBJCOPY $@\n"
	$(Q)$(OBJCOPY) -Oihex $< $@

%.srec: %.elf
	@printf "  OBJCOPY $@\n"
	$(Q)$(OBJCOPY) -Osrec $< $@

%.list: %.elf
	@printf "  OBJDUMP $@\n"
	$(Q)$(OBJDUMP) -S $< > $@

%.elf: $(OBJS) $(LDSCRIPT) $(LIBDEPS)
	@printf "  LD      $(*).elf\n"
	$(Q)$(LD) $(OBJS) $(LDLIBS) $(LDFLAGS) -T$(LDSCRIPT) $(ARCH_FLAGS)  -o $@

%.o: %.c
	@printf "  CC      $<\n"
	$(Q)$(CC) $(CFLAGS) $(ARCH_FLAGS) -o $@ -c $<

%.o: %.cpp
	@printf "  CXX     $(*).cpp\n"
	$(Q)$(CXX) $(CXXFLAGS) $(ARCH_FLAGS) -o $@ -c $<
