#ifndef RCC_H
#define RCC_H

#include <stdint.h>

#define HSI_FREQ (64000000U)
#define SYSTEM_CORE_CLOCK (HSI_FREQ)

void clock_setup();

#endif
