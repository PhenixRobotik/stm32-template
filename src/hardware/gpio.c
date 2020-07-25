#include "gpio.h"

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

void gpio_setup() 
{
	rcc_periph_clock_enable(RCC_GPIOA);

	// status led
	gpio_mode_setup(GPIOA, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO8);
}

void led_toggle_status()
{
	gpio_toggle(GPIOA, GPIO8);
}
