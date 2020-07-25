set(CMAKE_SYSTEM_NAME "Generic")
set(CMAKE_SYSTEM_PROCESSOR "arm")

set(MCU_TYPE "stm32")

set(CROSS_PREFIX "arm-none-eabi-")

include(toolchains/gcc)

set(ARCH_FLAGS "\
    --specs=nosys.specs \
    -mthumb \
    -mcpu=cortex-m4")

string(APPEND CMAKE_C_FLAGS " ${ARCH_FLAGS}")
string(APPEND CMAKE_CXX_FLAGS " ${ARCH_FLAGS}")

