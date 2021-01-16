#include <at89x51.h>
#include "hd44780.h"

__sfr __at 0x80  _LCD_IR_DR_BUS;    // P0

//////////////////////////////////////////////////////////
// High order bits when using a 4bit data/instruction BUS.
__sbit __at 0x84  _LCD_IR_DR_BUS_4; // P0_4
__sbit __at 0x85  _LCD_IR_DR_BUS_5; // P0_5
__sbit __at 0x86  _LCD_IR_DR_BUS_6; // P0_6
__sbit __at 0x87  _BUSY_FLAG;       // P0_7
//////////////////////////////////////////////////////////

__sbit __at 0xA0  _LCD_EN;          // P2_0
__sbit __at 0xA1  _LCD_RW;          // P2_1
__sbit __at 0xA2  _LCD_RS;          // P2_2

static int _DELAY = 500;

void lcd_set_pulse_and_busyflag_delay(const int delay)
{ _DELAY = delay; }

// Adds a 'delay' while waiting for a LCD controller response.
// See 'LCD_set_busyflag_check_delay' and 'wait_until_not_busy' functions.
void delay()
{
    int i;
    for(i=0; i < _DELAY; i++);
}

// 'Pulse Enable' tells the LCD controller that there is data to be read/writen from/to the IR/DR BUS.
void pulse_enable()
{
    _LCD_EN=1;
    delay();
    _LCD_EN=0;
}

// Start BUSY_FLAG read operation or add counter operation.
void instruction_register_read_busyflag_or_add_counter()
{
    _LCD_RS=0;
    _LCD_RW=1;
}

// Set the LCD controller to 'write instruction register'.
void instruction_register_write_internal_operation()
{
    _LCD_RS=0;
    _LCD_RW=0;
}

// Set the LCD controller to 'write data register'.
void data_register_write_internal_operation()
{
    _LCD_RS=1;
    _LCD_RW=0;
}

/*
 1) Start BUSY_FLAG read operation
 2) Set ENABLE to HIGH to signal the LCD controller we are about to read the BUSY_FLAG checks (see #1)
 3) Keep checking BUSY_FLAG until it's LOW (no pending internal LCD operation)
 4) Set ENABLE back to LOW to signal the LCD controller we are ending the BUSY_FLAG checks

 The function callee only controls how long this library waits until checking again the BUSY_FLAG. 
 The whole implementation is based on checking the BUSY_FLAG rather than using complex
 calculations based on different LCD controller and MCU crystal oscillator speeds.
*/
void wait_until_not_busy()
{
    instruction_register_read_busyflag_or_add_counter();

    _LCD_EN=1;

    while (_BUSY_FLAG) {
        delay();
    };
    
    _LCD_EN=0;
}

void lcd_irwrite(const unsigned char ir)
{
    wait_until_not_busy();
    // Place the Instruction Register on the MCU-LCD BUS.
    instruction_register_write_internal_operation();
    _LCD_IR_DR_BUS=ir;
    pulse_enable();
}

//******************************************************************************
// 8-BIT BUS FUNCTIONS

void lcd_drwrite(const unsigned char dr)
{
    wait_until_not_busy();
    // Place the Data Register on the MCU-LCD BUS.
    data_register_write_internal_operation();
    _LCD_IR_DR_BUS=dr;
    pulse_enable();
}

void lcd_stringwrite(const unsigned char* pstr)
{
    unsigned char i;
    for(i=0; pstr[i] != 0; i++)
        lcd_drwrite(pstr[i]);
}

// 8-BIT BUS FUNCTIONS
//******************************************************************************

//******************************************************************************
// 4-BIT BUS FUNCTIONS

void lcd_irwrite_4bits_bus(const unsigned char highorderbits)
{
    wait_until_not_busy();
    // Place the Instruction Register on the MCU-LCD BUS.
    instruction_register_write_internal_operation();
    _LCD_IR_DR_BUS_4 = (highorderbits & (1<<4));
    _LCD_IR_DR_BUS_5 = (highorderbits & (1<<5));
    _LCD_IR_DR_BUS_6 = (highorderbits & (1<<6));
    _BUSY_FLAG       = (highorderbits & (1<<7));
    pulse_enable();
}

void lcd_drwrite_4bits_bus(const unsigned char highorderbits)
{
    wait_until_not_busy();
    // Place the Data Register on the MCU-LCD BUS.
    data_register_write_internal_operation();
    _LCD_IR_DR_BUS_4 = (highorderbits & (1<<4));
    _LCD_IR_DR_BUS_5 = (highorderbits & (1<<5));
    _LCD_IR_DR_BUS_6 = (highorderbits & (1<<6));
    _BUSY_FLAG       = (highorderbits & (1<<7));
    pulse_enable();
}

void lcd_irwrite_4bits(const unsigned char ir)
{
    lcd_irwrite_4bits_bus(ir);      // Send first the upper 4 bits.
    lcd_irwrite_4bits_bus(ir << 4); // and then the lower 4 bits.
}

void lcd_stringwrite_4bits(const unsigned char* pstr)
{
    unsigned char i;
    for(i=0; pstr[i] != 0; i++)
    {
        lcd_drwrite_4bits_bus(pstr[i]);       // Send first the upper 4 bits.
        lcd_drwrite_4bits_bus(pstr[i] << 4);  // and then the lower 4 bits.
    }
}

// 4-BIT BUS FUNCTIONS
//******************************************************************************
