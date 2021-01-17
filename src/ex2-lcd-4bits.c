#include "../lib/hd44780.h"
#include "../lib/mcs-51.h"

/*
For a 10MHz crystal oscillator, the two AT89S51 internal timers will have a frequency of:

10.000.000 Hz / 12 ~= 833.333 Hz ~= 833,33 KHz
Source: Ayala, Kenneth J., The 8051 Microcontroller, 3rd Edition, page 30.

So, the timer resolution for a 10 MHz crystal oscillator is:

(10^9 ns * 12 / 10^7 Hz) = 1200 ns (nanoseconds) = 1,2 us (microseconds)

The two AT89S51 timers can be configured to use 16-bit counters (HIGH and LOW bytes), from 0 to 65535.
So, for a 10 MHz crystal oscillator, the timer's maximum delay is:

(10^2 * 12 * 65535) =  78642000 ns = 78642 us = 78,642 ms ~= 0,078642 s

Using the 'mcs51_mult_max_timer0_delay' function, that can run the timer 'mult' times,
we can program delays according to the formula:

DELAY (in nanoseconds) = (10^9 ns * 12 * TIMER COUNTS * MULT) / (OSCILLATOR SPEED)

2s = 2000000000 ns ~= 1,9999824s = (10^9 ns * 12 * 64102 * 26) / 10x10^6
5s = 5000000000 ns ~= 4,9999872s = (10^9 ns * 12 * 65104 * 64) / 10x10^6

The following intervals are relevant to the HD44780 controller (in nanoseconds):

40.000.000 ns = (40 ms to initialize the module - before sending any instructions)

     1.000 ns = (LCD documentation says PWEH should be HIGH for at least 1000 ns. However, it requires 1,44 ms = 1200 x 1200 ns = TIMER COUNTS = 1200) 
40.000.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 33333,3 (round to 33334)
*/

// 65535-65104=431d=01AFh
static const unsigned int   FIVE_SECONDS_MULT           = 64;
static const unsigned char  FIVE_SECONDS_HIGHBITS       = 0x01;
static const unsigned char  FIVE_SECONDS_LOWBITS        = 0xAF;

// TIMER COUNTS=65535-START=33334d => START=32201d=7DC9h
static const unsigned char  LCD_40000US_START_HIGHBITS  = 0x7D;
static const unsigned char  LCD_40000US_START_LOWBITS   = 0xC9;

// TIMER COUNTS=65535-START=1200d => START=64335d=FB4Fh
static const unsigned char  LCD_PULSE_ENABLE_PWEH_HIGH  = 0xFB;
static const unsigned char  LCD_PULSE_ENABLE_PWEH_LOW   = 0x4F;

int main()
{
    unsigned char line[]={"FEDCBA9876543210"};
    
    // 40 ms to initialize the LCD controller.
    mcs51_timer0_delay(LCD_40000US_START_HIGHBITS, LCD_40000US_START_LOWBITS);

    // Initialize the LCD.
    initialize(LCD_PULSE_ENABLE_PWEH_HIGH, LCD_PULSE_ENABLE_PWEH_LOW);
    
    // Initialization of the LCD by instructions (see HITACHI manual).
    lcd_irwrite_4bits(HD44780_IR_ENABLE_4BIT_IRDR);
    lcd_irwrite_4bits(HD44780_IR_5X8_4BITS_TWO_DISPLAY_LINES);
    lcd_irwrite_4bits(HD44780_IR_DISPLAY_ON_CURSOR_ON);
    
    while(1){
        mcs51_mult_max_timer0_delay(FIVE_SECONDS_MULT, FIVE_SECONDS_HIGHBITS, FIVE_SECONDS_LOWBITS);

        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CLEAR);
        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
        lcd_stringwrite_4bits(line);

        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);
        lcd_stringwrite_4bits(line);
    }
}