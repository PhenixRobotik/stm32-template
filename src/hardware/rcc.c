#include "rcc.h"
#include <libopencm3/stm32/rcc.h>

void clock_setup()
{
	rcc_clock_setup_hsi(&rcc_hsi_configs[RCC_CLOCK_HSI_64MHZ]);
}
