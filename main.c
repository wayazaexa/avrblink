#include <avr/io.h>
#include <util/delay.h>

#define BIT_SET(a, b) ((a) |= (1ULL << (b)))
#define BIT_CLEAR(a, b) ((a) &= ~(1ULL << (b)))

void internal_led() {
    while (1) {
        BIT_SET(PORTB, 5);
        _delay_ms(1000);
        BIT_CLEAR(PORTB, 5);
        _delay_ms(1000);
    }
}

int main(void) {
    DDRB |= (1 << 5);
    internal_led();
    return 0;
}
