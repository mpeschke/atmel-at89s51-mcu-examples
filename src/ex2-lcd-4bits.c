#include "../lib/hd44780.h"
#include "../lib/mcs-51.h"

/*
For a 10MHz crystal oscillator, the AT89S51 internal clock counter will have a frequency of:

10.000.000 Hz / 12 ~= 833.333 Hz ~= 833,33 KHz
Source: Ayala, Kenneth J., The 8051 Microcontroller, 3rd Edition, page 30.

A 16-bit counter can count from 0 to 65535. So, the maximum delay we can achieve with this oscillator is:

833.333 / 65535 ~= 12,72 cycles per second ~= 0,078642 seconds per cycle ~= 0,08 s

Using the function mcs51_mult_max_timer0_delay to achieve the following delays:

2s => 0,078642 * 25,431703162 => (~ 26) 
5s => 0,078642 * 63,579257903 => (~ 64) 
*/

static int TWO_SECONDS = 26;
static int FIVE_SECONDS = 64;
static int DATA_BUS_PULSE_INTERVAL = 100;

int main()
{
    unsigned char line[]={"FEDCBA9876543210"};
    
    // More than enough time to properly initialize the LCD hardware.
    mcs51_mult_max_timer0_delay(TWO_SECONDS);

    // Trial and error: 
    // minimum value to enable the LCD to effectively read/write from/to the BUS AND check the BUSY_FLAG.
    lcd_set_pulse_and_busyflag_delay(DATA_BUS_PULSE_INTERVAL);
    lcd_irwrite_4bits(HD44780_IR_ENABLE_4BIT_IRDR);
    lcd_irwrite_4bits(HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES);
    lcd_irwrite_4bits(HD44780_IR_DISPLAY_ON_CURSOR_ON);
    
    while(1){
        mcs51_mult_max_timer0_delay(FIVE_SECONDS);

        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CLEAR);
        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
        lcd_stringwrite_4bits(line);

        lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);
        lcd_stringwrite_4bits(line);
    }
}