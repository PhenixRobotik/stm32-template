set(CC_PREFIX ${CROSS_PREFIX})

# Use ccache if present
find_program(CCACHE_PROG ccache)

if(CCACHE_PROG)
message("Using ccache")
set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ${CCACHE_PROG})
endif()

set(CMAKE_C_COMPILER "${CC_PREFIX}gcc")
set(CMAKE_CXX_COMPILER "${CC_PREFIX}g++")
message("${CMAKE_C_COMPILER}")

set(CMAKE_C_FLAGS "\
    -std=c99 \
    -g \
    -Os \
    -fdiagnostics-color=always \
    -Wall \
    -Wextra")

set(CMAKE_CXX_FLAGS "-fno-exceptions")

# Don't use target programs
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Use target files only (not host) for libraries, includes and packages
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
