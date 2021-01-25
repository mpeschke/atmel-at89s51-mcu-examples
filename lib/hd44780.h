#ifndef __HITACH_LCD_HD44780_H
#define __HITACH_LCD_HD44780_H

// Library to interface an MCU with the HITACHI HD44780 LCD controller.

//////////////////////////////////////////////////////////
// Public LCD constants.
static const unsigned char LCD_FUNCSET_4BITMODE     = 0x00;
static const unsigned char LCD_FUNCSET_5x8DOTS      = 0x00;
static const unsigned char LCD_FUNCSET_1LINE        = 0x00;
static const unsigned char LCD_FUNCSET_5x10DOTS     = 0x04;
static const unsigned char LCD_FUNCSET_2LINE        = 0x08;
static const unsigned char LCD_FUNCSET_8BITMODE     = 0x10;
// Public LCD constants.
//////////////////////////////////////////////////////////

/**
    Function to initialize the LCD controller and set the delays according to the original
    LiquidCrystal Arduino library (v1.0.7).
    These delays will be used by the AT89S51 internal 16-bit timer.

    The following delays are relevant to the HD44780 controller (in nanoseconds):
    (see HD44780 documentation, page 49 and figure 25)

         1.000 ns = (PWeh - Enable High)
       100.000 ns = (tAH - Enable Low)
       150.000 ns = (when initializing the third attempt)
     2.000.000 ns = (clear display and set cursor to home)
     4.500.000 ns = (when initializing the first and second attempts)
    50.000.000 ns = (50 ms to initialize the module - before sending any instructions)

    @param lcd_display_function_set      8-bits - the LCD display function set (dots, 4/8 bits mode, lines, etc)
    @param lcd_dlay_pe_pweh             16-bits - PWeh - Pulse Width High Level
    @param lcd_dlay_pe_tah              16-bits - tAH - Enable Low
    @param lcd_dlay_init_3rd            16-bits - when initializing the third attempt
    @param lcd_dlay_clear_display_home  16-bits - clear display and set cursor to home
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
    Clears the display and sets the cursor to home.

*/
void lcd_clear();

/**
    Sets the cursor to a row x col position.

    @param row (0 based) LCD display row.
    @param col (0 based) LCD display column.
*/
void lcd_set_cursor(const unsigned char row, const unsigned char col);

/**
    Turns the display ON.

*/
void lcd_display_on();

/**
    Turns the display OFF.

*/
void lcd_display_off();

/**
    Turns the cursor ON.

*/
void lcd_cursor_on();

/**
    Turns the cursor OFF.

*/
void lcd_cursor_off();

/**
    Turns the cursor blinking ON.

*/
void lcd_blink_on();

/**
    Turns the cursor blinking OFF.

*/
void lcd_blink_off();

/**
    Sends a string of data (character string) to the LCD controller.

    @param pstr pointer to a string.
*/
void lcd_print(const unsigned char* pstr);

#endif  /* __HITACH_LCD_HD44780_H */