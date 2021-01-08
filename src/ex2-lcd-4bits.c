#include "../lib/hd44780.h"
#include "../lib/mcs-51.h"

/*
For a 10MHz crystal oscillator, the AT89S51 internal clock counter will have a frequency of:

10.000.000 Hz / 12 ~= 833.333 Hz ~= 833,33 KHz
Source: Ayala, Kenneth J., The 8051 Microcontroller, 3rd Edition, page 30.

The two AT89S51 16-bit timers can count from 0 to 65535. So, the maximum delay we can achieve with this oscillator is:

833.333 / 65535 ~= 12,72 cycles per second ~= 0,078642 seconds per cycle ~= 0,08 s

Using the 'mcs51_mult_max_timer0_delay' function, that can run the timer 'mult' times,
we can program delays according to the formula:

DELAY (in seconds) = (12 * TIMER COUNTS * MULT) / (OSCILLATOR SPEED)

2s ~= 1,9999824s = (12 * 64102 * 26) / 10.000.000
5s ~= 4,9999872s = (12 * 65104 * 64) / 10.000.000
*/

// 65535-64102=1433d=0599h
static const int            TWO_SECONDS_MULT        = 26;
static const unsigned char  TWO_SECONDS_HIGHBITS    = 0x05;
static const unsigned char  TWO_SECONDS_LOWBITS     = 0x99;

// 65535-65104=431d=01AFh
static const int            FIVE_SECONDS_MULT       = 64;
static const unsigned char  FIVE_SECONDS_HIGHBITS   = 0x01;
static const unsigned char  FIVE_SECONDS_LOWBITS    = 0xAF;

static const int            DATA_BUS_PULSE_INTERVAL = 100;

int main()
{
    unsigned char line[]={"FEDCBA9876543210"};
    
    // More than enough time to properly initialize the LCD hardware.
    mcs51_mult_max_timer0_delay(&TWO_SECONDS_MULT, &TWO_SECONDS_HIGHBITS, &TWO_SECONDS_LOWBITS);

    // Trial and error: 
    // minimum value to enable the LCD to effectively read/write from/to the BUS AND check the BUSY_FLAG.
    lcd_set_pulse_and_busyflag_delay(&DATA_BUS_PULSE_INTERVAL);
    
    // Initialization of the LCD by instructions (see HITACHI manual).
    lcd_irwrite_4bits(HD44780_IR_ENABLE_4BIT_IRDR);
    lcd_irwrite_4bits(HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES);
    lcd_irwrite_4bits(HD44780_IR_DISPLAY_ON_CURSOR_ON);
    
    while(1){
        mcs51_mult_max_timer0_delay(&FIVE_SECONDS_MULT, &FIVE_SECONDS_HIGHBITS, &FIVE_SECONDS_LOWBITS);

        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CLEAR);
        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
        lcd_stringwrite_4bits(line);

        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);
        lcd_stringwrite_4bits(line);
    }
}