#include <at89x51.h>
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

40.000.000 (40 ms to initialize the module - before sending any instructions)

40.000.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 33333,3 (round to 33334)
*/

// TIMER COUNTS=65535-START=33334d => START=32201d=7DC9h
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

static const unsigned char  FIRST_LINE_BUFF[]           = {"MESSAGE:"};

void ex3_ser_handler (void) __interrupt 4
{
    char chr = 0x00;
    if(RI==1) {
        chr = SBUF;
        RI = 0;
    }

    lcd_drwrite_4bits_bus(chr);
    lcd_drwrite_4bits_bus(chr << 4);
}

void initialize_serial(void)
{
    TMOD = 0x20;    // Timer 1 In Mode 2 -Auto Reload to Generate Baud Rate
    SCON = 0x50;    // Serial Mode 1, 8-Bit Data, REN Enabled
    // Load Baud Rate 9600 To Timer Register
    // TH1 = 256 - (( CRYSTAL OSC / 384) / Baud)
    // TH1 = 256 - (( 22.118.400 Hz / 384) / 9600) = 256 - 6 = 250d = 0xFAh
    TH1  = 0xFA;
    TR1  = 1;       // Start Timer
}

int main()
{    
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

    lcd_clear();
    lcd_set_cursor(0, 0);
    lcd_print(FIRST_LINE_BUFF);
    lcd_set_cursor(1, 0);

    initialize_serial();

    while(1);
}