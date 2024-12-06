#include "stm32c011xx.h"

void delay(unsigned long delay) {
    for (unsigned long i = 0; i < delay * 1000; i++) {
        __asm("nop"); 
    }
}

void gpio_init(void) {
    // Habilitar o clock para o GPIOB
    RCC->IOPENR |= RCC_IOPENR_GPIOBEN;

    // Configurar PB6 como saída
    GPIOB->MODER &= ~(3U << (6 * 2)); // Limpa os bits correspondentes ao pino 6
    GPIOB->MODER |= (1U << (6 * 2));  // Configura PB6 como saída (01)

    // Configurar PB6 como push-pull
    GPIOB->OTYPER &= ~(1U << 6); // 0 = Saída push-pull

    // Configurar PB6 para baixa velocidade
    GPIOB->OSPEEDR &= ~(3U << (6 * 2)); // 00 = Baixa velocidade
}

void gpio_set_high(void) {
    // Configurar PB6 em nível lógico alto usando ODR
    GPIOB->ODR |= (1U << 6);
}

void gpio_set_low(void) {
    // Configurar PB6 em nível lógico baixo usando ODR
    GPIOB->ODR &= ~(1U << 6);
}

int main(void) {
    gpio_init();

    while (1) {
        gpio_set_high(); // PB6 em nível alto
        delay(1000);     // Aguarda 
        gpio_set_low();  // PB6 em nível baixo
        delay(1000);     // Aguarda 
    }

    return 0;
}
