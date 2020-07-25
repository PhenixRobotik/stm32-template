#ifndef GPIO_H
#define GPIO_H

// GPIO mapping
#define LED_GPIO_PORT   GPIOB
#define LED_GPIO_PIN    GPIO3

void gpio_setup();
void led_toggle_status();

#endif
