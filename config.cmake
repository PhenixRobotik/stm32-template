# This file defines the specific project's configuration. All variables should
# start with "CONFIG_" to avoid conflicts with standard CMake names

# Project description
set(CONFIG_NAME "stm32-template")
set(CONFIG_DESC "Template project for STM32 with libopencm3 and FreeRTOS")
set(CONFIG_VER 1.0)

# Target file (see cmake/toolchains)
set(CONFIG_TARGET "stm32f303k8-freertos")

# Libraries configuration
# Libopencm3
set(CONFIG_USE_LIBOPENCM3 ON)
set(CONFIG_LIBOPENCM3_VERBOSE OFF) # effective if VERBOSITY=1
set(CONFIG_LIBOPENCM3_SET_URL OFF) # OFF to use official repo
set(CONFIG_LIBOPENCM3_SET_TAG "24bef9c49eda109e92e926e065b246a71d454f2d")

# FreeRTOS
set(CONFIG_USE_FREERTOS ON)
set(CONFIG_FREERTOS_VERSION 10.3.1)
set(CONFIG_FREERTOS_SET_URL OFF)
set(CONFIG_FREERTOS_SET_TAG "V${CONFIG_FREERTOS_VERSION}-kernel-only")
set(CONFIG_FREERTOS_HEAP "1")