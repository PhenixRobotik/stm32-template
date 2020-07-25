# INPUTS :
# Required :
#  - MCU_TYPE : ex. stm32
#  - MCU_SERIE : ex. f3
# Optional :
#  - CONFIG_LIBOPENCM3_VERBOSE : ON/OFF
#  - CONFIG_LIBOPENCM3_SET_TAG : custom tag for git repo
#  - CONFIG_LIBOPENCM3_SET_URL : custom git repo url
#
# OUTPUTS
# library libopencm3
# include directory for libopencm3
# appends on CMAKE_C_FLAGS, CMAKE_CXX_FLAGS
#
include(libs/common)
include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)

# Load configuration
if(NOT MCU_TYPE)
    message(FATAL_ERROR "MCU_TYPE must be defined for libopencm3 !\nExample : stm32")
endif()

if(NOT MCU_SERIE)
    message(FATAL_ERROR "MCU_SERIE must be defined for libopencm3 !\nExample : f3")
endif()

if(CONFIG_LIBOPENCM3_VERBOSE)
    set(OPENCM3_VERBOSITY "1")
endif()

cmake_language(CALL set_git_cfg
    "libopencm3"
    "https://github.com/libopencm3/libopencm3.git"
    "origin/master")

# Find programs
find_program(MAKE_EXE make)

# OPENCM3 variables
# OPENCM3_TARGETS
set(OPENCM3_TARGETS "${MCU_TYPE}/${MCU_SERIE}")
string(TOLOWER ${OPENCM3_TARGETS} OPENCM3_TARGETS)

# OPENCM3_LIBNAME
set(OPENCM3_LIBNAME "opencm3_${MCU_TYPE}${MCU_SERIE}")
string(TOLOWER ${OPENCM3_LIBNAME} OPENCM3_LIBNAME)

# OPENCM3_CDEF
set(OPENCM3_CDEF "-D${MCU_TYPE}${MCU_SERIE}")
string(TOUPPER ${OPENCM3_CDEF} OPENCM3_CDEF)

set(OPENCM3_SRC "${CMAKE_CURRENT_SOURCE_DIR}/lib/libopencm3")
set(OPENCM3_AR "${OPENCM3_SRC}/lib/lib${OPENCM3_LIBNAME}.a")
set(OPENCM3_INC "${OPENCM3_SRC}/include")

# Download and build
ExternalProject_Add(libopencm3_project
    SOURCE_DIR ${OPENCM3_SRC}
    GIT_REPOSITORY ${LIBOPENCM3_URL}
    GIT_TAG ${LIBOPENCM3_TAG}
    GIT_SHALLOW ON
    GIT_PROGRESS ON
    CONFIGURE_COMMAND "" # this is not a CMake project
    BUILD_COMMAND ${MAKE_EXE} "TARGETS=${OPENCM3_TARGETS}" "V=${OPENCM3_VERBOSITY}"
    INSTALL_COMMAND ""
    BUILD_ALWAYS OFF # set to on if source isn't downloaded
    BUILD_IN_SOURCE ON)

# Define library
add_library(opencm3 STATIC IMPORTED)
add_dependencies(opencm3 libopencm3_project)
set_property(TARGET opencm3
             PROPERTY IMPORTED_LOCATION ${OPENCM3_AR})

# Compiler flags
string(APPEND CMAKE_C_FLAGS " ${OPENCM3_CDEF}")
string(APPEND CMAKE_CXX_FLAGS " {OPENCM3_CDEF}")

# Include directories
target_include_directories(opencm3 INTERFACE ${OPENCM3_SRC}/include)
