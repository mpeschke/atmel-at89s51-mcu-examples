#include "../lib/hd44780.h"
#include "../lib/mcs-51.h"

/*
For a 10MHz crystal oscillator, the two AT89S51 internal timers will have a frequency of:

10.000.000 Hz / 12 ~= 833.333 Hz ~= 833,33 KHz
Source: Ayala, Kenneth J., The 8051 Microcontroller, 3rd Edition, page 30.

So, the timer resolution (or period) for a 10 MHz crystal oscillator is:

(10^9 ns * 12 / 10^7 Hz) = 1200 ns (nanoseconds) = 1,2 us (microseconds)

The two AT89S51 timers can be configured to use 16-bit counters (HIGH and LOW bytes), from 0 to 65535.
So, for a 10 MHz crystal oscillator, the timer's maximum delay is:

(10^2 * 12 * 65535) =  78642000 ns = 78642 us = 78,642 ms ~= 0,078642 s

Using the 'mcs51_mult_max_timer0_delay' function, that can run the timer 'mult' times,
we can program extended delays, according to the formula:

DELAY (in nanoseconds) = (10^9 ns * 12 * TIMER COUNTS * MULT) / (OSCILLATOR SPEED)

5s = 5000000000 ns ~= 4,9999872s = (10^9 ns * 12 * 65104 * 64) / 10x10^6

The following delays are relevant to the HD44780 controller (see hd44780.h):

     1.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 0,83 (round to 1) 
   100.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 83,333333333 (round to 84) 
   150.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 125
 2.000.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 1666,666666667 (round to 1667) 
 4.500.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 3750
50.000.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 41666,67 (round to 41667)

Another example, this time for a 12 MHz crystal oscillator:
12.000.000 Hz / 12 = 1 MHz
(10^9 ns * 12 / 12 * 10^6 Hz) = 1000 ns (nanoseconds) = 1 us (microseconds)

     1.000 ns = (1 us * TIMER COUNTS * 1) => TIMER COUNTS = 1
   100.000 ns = (1 us * TIMER COUNTS * 1) => TIMER COUNTS = 100 
   150.000 ns = (1 us * TIMER COUNTS * 1) => TIMER COUNTS = 150
 2.000.000 ns = (1 us * TIMER COUNTS * 1) => TIMER COUNTS = 2000 
 4.500.000 ns = (1 us * TIMER COUNTS * 1) => TIMER COUNTS = 4500
50.000.000 ns = (1 us * TIMER COUNTS * 1) => TIMER COUNTS = 50000
*/

// 10 MHz TIMER COUNTS=65535-65104=431d => START=431d=01AFh x 64
static const unsigned int  FIVE_SECONDS_MULT            = 64;
static const unsigned int  FIVE_SECONDS_COUNTER         = 0x01AF;

// 10 MHz TIMER COUNTS=65535-START=1d => START=64334d=FFFEh
static const unsigned int  LCD_DLAY_PE_PWEH             = 0xFFFE;
// 10 MHz TIMER COUNTS=65535-START=84d => START=65451d=FFABh
// 12 MHz TIMER COUNTS=65535-START=100d => START=64535d=FC17h
static const unsigned int  LCD_DLAY_PE_TAH              = 0xFFAB;
// 10 MHz TIMER COUNTS=65535-START=125d => START=65410d=FF82h
// 12 MHz TIMER COUNTS=65535-START=150d => START=65385d=FF69h
static const unsigned int  LCD_DLAY_INIT_3RD            = 0xFF82;
// 10 MHz TIMER COUNTS=65535-START=1667d => START=63868d=F97Ch
// 12 MHz TIMER COUNTS=65535-START=2000d => START=63535d=F82Fh
static const unsigned int  LCD_DLAY_CLEAR_DISPLAY_HOME  = 0xF97C;
// 10 MHz TIMER COUNTS=65535-START=3750d => START=61785d=F159h
// 12 MHz TIMER COUNTS=65535-START=4500d => START=61035d=EE6Bh
static const unsigned int  LCD_DLAY_INIT_1ST_2ND        = 0xF159;
// 10 MHz TIMER COUNTS=65535-START=41667d => START=23868d=5D3Ch
// 12 MHz TIMER COUNTS=65535-START=50000d => START=15535d=3CAFh
static const unsigned int  LCD_DLAY_INIT                = 0x5D3C;

int main()
{
    const unsigned char* line = "FEDCBA9876543210";
    
    // Initialize the LCD.
    lcd_initialize(
        LCD_FUNCSET_4BITMODE | LCD_FUNCSET_2LINE | LCD_FUNCSET_5x8DOTS,
        LCD_DLAY_PE_PWEH,
        LCD_DLAY_PE_TAH,
        LCD_DLAY_INIT_3RD,
        LCD_DLAY_CLEAR_DISPLAY_HOME,
        LCD_DLAY_INIT_1ST_2ND,
        LCD_DLAY_INIT
    );
    
    // Every 5s, prints a message on the two rows of the LCD display.
    while(1){
        lcd_clear();
        lcd_set_cursor(0, 0);
        lcd_print(line);

        lcd_set_cursor(1, 0);
        lcd_print(line);
        //lcd_cursor_on();
        //lcd_blink_on();
        //lcd_set_cursor(1, 15);
        mcs51_mult_max_timer0_delay(FIVE_SECONDS_MULT, FIVE_SECONDS_COUNTER);
    }
}