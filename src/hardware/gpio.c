#include "gpio.h"

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

void gpio_setup() 
{
	rcc_periph_clock_enable(RCC_GPIOB);

	// status led
	gpio_mode_setup(LED_GPIO_PORT, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, LED_GPIO_PIN);
}

void led_toggle_status()
{
	gpio_toggle(LED_GPIO_PORT, LED_GPIO_PIN);
}
