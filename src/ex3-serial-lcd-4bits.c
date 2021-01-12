#include "../lib/hd44780.h"
#include <at89x51.h>

static const int            DATA_BUS_PULSE_INTERVAL = 100;
static const unsigned char  FIRST_LINE_BUFF[]       = {"MESSAGE:"};

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
    SCON = 0x50;    // Serial Mode 1, 8-Data Bit, REN Enabled
    TH1  = 0xFD;    // Load Baud Rate 9600 To Timer Register
    TR1  = 1;       // Start Timer
}

int main()
{    
    // Trial and error: 
    // minimum value to enable the LCD to effectively read/write from/to the BUS AND check the BUSY_FLAG.
    lcd_set_pulse_and_busyflag_delay(&DATA_BUS_PULSE_INTERVAL);
    
    // Initialization of the LCD by instructions (see HITACHI manual).
    lcd_irwrite_4bits(HD44780_IR_ENABLE_4BIT_IRDR);
    lcd_irwrite_4bits(HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES);
    lcd_irwrite_4bits(HD44780_IR_DISPLAY_ON_CURSOR_ON);
    
    lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
    lcd_stringwrite_4bits(FIRST_LINE_BUFF);
    lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);

    initialize_serial();

    while(1);
}