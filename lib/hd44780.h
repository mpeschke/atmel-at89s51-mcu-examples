#ifndef __HITACH_LCD_HD44780_H
#define __HITACH_LCD_HD44780_H

// Library to interface an MCU with the HITACHI HD44780 LCD controller.

static const unsigned char LCD_SETDDRAMADDR_R0_C0   = 0x80;
static const unsigned char LCD_SETDDRAMADDR_R1_C0   = 0xC0;

static const unsigned char LCD_BLINKOFF             = 0x00;
static const unsigned char LCD_CURSOROFF            = 0x00;
static const unsigned char LCD_DISPLAYOFF           = 0x00;

static const unsigned char LCD_BLINKON              = 0x01;
static const unsigned char LCD_CURSORON             = 0x02;
static const unsigned char LCD_DISPLAYON            = 0x04;

static const unsigned char LCD_FUNCSET_4BITMODE     = 0x00;
static const unsigned char LCD_FUNCSET_5x8DOTS      = 0x00;
static const unsigned char LCD_FUNCSET_2LINE        = 0x08;
static const unsigned char LCD_FUNCSET_8BITMODE     = 0x10;

/**
    Function to set the delays according to the original LiquidCrystal Arduino library (v1.0.7).
    These will be used by the AT89S51 internal 16-bit timer.

    The following delays are relevant to the HD44780 controller (in nanoseconds):
    (see HD44780 documentation, page 49 and figure 25)

         1.000 ns = (PWeh - Enable High)
       100.000 ns = (tAH - Enable Low)
       150.000 ns = (when initializing the third attempt)
     2.000.000 ns = (clear display and set cursor to home)
     4.500.000 ns = (when initializing the first and second attempts)
    50.000.000 ns = (50 ms to initialize the module - before sending any instructions)

    @param lcd_display_function_set      8-bits - the LCD display functions
    @param lcd_dlay_pe_pweh             16-bits - PWeh - Pulse Width High Level
    @param lcd_dlay_pe_tah              16-bits - tAH - Enable Low
    @param lcd_dlay_init_3rd            16-bits - when initializing the third attempt
    @param lcd_dlay_clear_display_home  16-bits - clear display
    @param lcd_dlay_init_1st_2nd        16-bits - when initializing the first and second attempts 
    @param lcd_dlay_init                16-bits - to initialize the module - before sending any instructions
*/
void lcd_initialize(
    const unsigned char lcd_display_functions,
    const unsigned int  lcd_dlay_pe_pweh,
    const unsigned int  lcd_dlay_pe_tah,
    const unsigned int  lcd_dlay_init_3rd,
    const unsigned int  lcd_dlay_clear_display_home,
    const unsigned int  lcd_dlay_init_1st_2nd,
    const unsigned int  lcd_dlay_init
);

/**
    Function to clear the display and set the cursor to home.

*/
void lcd_clear();

/**
    Function to send a instruction (command) to the LCD controller.

    @param ir 8-bit instruction register.
*/
void lcd_instruction_register(const unsigned char ir);

/**
    Function to send a data (character) to the LCD controller.

    @param dr 8-bit data register.
*/
void lcd_data_register(const unsigned char dr);

/**
    Function to send a string of data (character string) to the LCD controller.

    @param pstr pointer to a string.
*/
void lcd_print(const unsigned char* pstr);

#endif  /* __HITACH_LCD_HD44780_H */