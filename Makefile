MAKEFLAGS += --no-print-directory
BUILD_DIR ?=build

PARALLEL_MAKE ?=#-j$(shell nproc)

all: build

.PHONY: gen
gen:
	cmake -S . -B "$(BUILD_DIR)"

build/Makefile:
	cmake -S . -B "$(BUILD_DIR)"

.PHONY: build
build: build/Makefile
	cmake --build "$(BUILD_DIR)" $(PARALLEL_MAKE)

.PHONY: clean
clean:
	cmake --build "$(BUILD_DIR)" --target clean

.PHONY: cleanall
cleanall:
	-rm -rf "$(BUILD_DIR)"
