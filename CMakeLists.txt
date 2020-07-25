cmake_minimum_required(VERSION 3.17)

list(APPEND CMAKE_MODULE_PATH
     "${CMAKE_CURRENT_SOURCE_DIR}"
     "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")

include(config)
include(toolchains/${CONFIG_TARGET})

project(${CONFIG_NAME}
        DESCRIPTION ${CONFIG_DESC}
        VERSION ${CONFIG_VER}
        LANGUAGES C CXX)

# Executable
set(ELF_NAME "${CONFIG_NAME}.elf")
file(GLOB_RECURSE PROG_C src/*.c)
add_executable(${ELF_NAME} ${PROG_C})
target_include_directories(${ELF_NAME} PRIVATE src/)

# Libraries
if(CONFIG_USE_LIBOPENCM3)
        include(libs/libopencm3)
        target_link_libraries(${ELF_NAME} opencm3)
endif()

if(CONFIG_USE_FREERTOS)
        include(libs/freertos)
        # For FreeRTOSConfig.h
        target_include_directories(freertos PRIVATE src/)
        target_link_libraries(${ELF_NAME} freertos)
endif()
