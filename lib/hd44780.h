#ifndef __HITACH_LCD_HD44780_H
#define __HITACH_LCD_HD44780_H

// Library to interface an MCU with the HITACHI HD44780 LCD controller.

static const unsigned char IR_DISPLAY_CLEAR =                   0x01;
static const unsigned char IR_DISPLAY_ON_CURSOR_ON =            0x0E;
static const unsigned char IR_FIVE_EIGHT_TWO_DISPLAY_LINES =    0x38;
static const unsigned char IR_FIVE_FOUR_TWO_DISPLAY_LINES =     0x28;
static const unsigned char IR_DISPLAY_CURSOR_HOME_FIRSTLINE =   0x80;
static const unsigned char IR_DISPLAY_CURSOR_HOME_SECONLINE =   0xc0;

// Function to set the delay between BUSY_FLAG checks. Default = 1.
void LCD_set_busyflag_check_delay(int delay);

// Function to send a instruction register to the LCD controller.
void LCD_IRWrite(unsigned char ir);

void LCD_IRWrite_4bits(unsigned char ir);

// Function to send a string to the LCD controller - each character at a time (each character is a 8-bit data register).
void LCD_StringWrite(unsigned char* pstr);

// Function to send a string to the LCD controller - each character at a time (each character is a 8-bit data register).
void LCD_StringWrite_4bits(unsigned char* pstr);

#endif  /* __HITACH_LCD_HD44780_H */