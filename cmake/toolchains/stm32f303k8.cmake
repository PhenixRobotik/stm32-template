include(toolchains/stm32)

set(MCU_SERIE "f3")

set(FP_FLAGS "\
    -mfloat-abi=hard \
    -mfpu=fpv4-sp-d16")

string(APPEND CMAKE_C_FLAGS " ${FP_FLAGS}")
string(APPEND CMAKE_CXX_FLAGS " ${FP_FLAGS}")
