#include <avr/io.h>
#include <util/delay.h>

// Efter att ha testat så är paranteserna runt 'a' och 'b' överflödiga, åtminstone på Linux.
// Dessutom räcker det ja med en unsigned variabel istället för en unsigned long long eftersom
//     de register vi använder är max 8 bitar.
#define BIT_SET(a, b) (a |= (1U << b))
#define BIT_CLEAR(a, b) (a &= ~(1U << b))

void internal_led() {
    while (1) {
        BIT_SET(PORTB, 5);
        _delay_ms(1000);
        BIT_CLEAR(PORTB, 5);
        _delay_ms(1000);
    }
}

int main(void) {
    DDRB |= (1U << 5); // Testade detta också, för att vara extra tydliga bör vi använda en unsigned här med
    internal_led();
    return 0;
}
