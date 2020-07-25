include(libs/common)
include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)

# Load configuration
if(NOT FREERTOS_PORT)
    message(FATAL_ERROR "FREERTOS_PORT must be defined for FreeRTOS !\nExample : GCC/ARM_CM4F")
endif()

if(NOT CONFIG_FREERTOS_HEAP)
    message(WARNING "CONFIG_FREERTOS_HEAP undefined, using default heap 1")
    set(FREERTOS_HEAP "1")
else()
    set(FREERTOS_HEAP ${CONFIG_FREERTOS_HEAP})
endif()

cmake_language(CALL set_git_cfg
    "FreeRTOS"
    "https://github.com/FreeRTOS/FreeRTOS-Kernel.git"
    "origin/master")

set(FREERTOS_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib/FreeRTOS")

# Download (not FetchContent for progress output)
ExternalProject_Add(FreeRTOS_project
    SOURCE_DIR     ${FREERTOS_SRC_DIR}
    GIT_REPOSITORY ${FREERTOS_URL}
    GIT_TAG        ${FREERTOS_TAG}
    GIT_SHALLOW ON
    GIT_PROGRESS ON
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND "")

set(FREERTOS_SRC
    portable/${FREERTOS_PORT}/port.c
    portable/MemMang/heap_${FREERTOS_HEAP}.c
    croutine.c
    event_groups.c
    list.c
    queue.c
    stream_buffer.c
    tasks.c
    timers.c)
list(TRANSFORM FREERTOS_SRC PREPEND ${FREERTOS_SRC_DIR}/)

add_library(freertos STATIC ${FREERTOS_SRC})
add_dependencies(freertos FreeRTOS_project)
target_include_directories(freertos PUBLIC
    ${FREERTOS_SRC_DIR}/include
    ${FREERTOS_SRC_DIR}/portable/${FREERTOS_PORT}/)
