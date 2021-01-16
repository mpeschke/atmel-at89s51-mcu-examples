#ifndef __HITACH_LCD_HD44780_H
#define __HITACH_LCD_HD44780_H

// Library to interface an MCU with the HITACHI HD44780 LCD controller.

static const unsigned char HD44780_IR_DISPLAY_CLEAR                 = 0x01;
static const unsigned char HD44780_IR_ENABLE_4BIT_IRDR              = 0x02;
static const unsigned char HD44780_IR_DISPLAY_ON_CURSOR_ON          = 0x0E;
static const unsigned char HD44780_IR_5X8_8BITS_TWO_DISPLAY_LINES   = 0x38;
static const unsigned char HD44780_IR_5X8_4BITS_TWO_DISPLAY_LINES   = 0x28;
static const unsigned char HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE = 0x80;
static const unsigned char HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE = 0xC0;

/**
    Function to set the delay between BUSY_FLAG checks and EN HIGH/LOW pulses.

    @param delay number of iterations (delay loop)
*/
void lcd_set_pulse_and_busyflag_delay(const int delay);

//******************************************************************************
// 8-BIT BUS FUNCTIONS

/**
    Function to send a instruction register to the LCD controller.

    @param ir the Instruction Register (LCD Command)
*/
void lcd_irwrite(const unsigned char ir);

/**
    Function to send a string to the LCD controller - each character at a time (each character is a 8-bit data register).

    @param pstr pointer to a string
*/
void lcd_stringwrite(const unsigned char* pstr);

// 8-BIT BUS FUNCTIONS
//******************************************************************************

//******************************************************************************
// 4-BIT BUS FUNCTIONS

/**
    Function to send a data register to the LCD controller.

    @param highorderbits the Data Register (only the 4 high bits)
*/
void lcd_drwrite_4bits_bus(const unsigned char highorderbits);

/**
    Function to send a instruction register to the LCD controller.

    @param ir the Instruction Register (LCD Command)
*/
void lcd_irwrite_4bits(const unsigned char ir);

/**
    Function to send a string to the LCD controller - each character at a time (each character is a 8-bit data register).

    @param pstr pointer to a string
*/
void lcd_stringwrite_4bits(const unsigned char* pstr);

// 4-BIT BUS FUNCTIONS
//******************************************************************************

#endif  /* __HITACH_LCD_HD44780_H */