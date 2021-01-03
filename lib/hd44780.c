#include <at89x51.h>
#include "hd44780.h"

__sfr __at 0x80  _LCD_IR_DR_BUS;  // P0
__bit __at 0x87  _BUSY_FLAG;      // P0_7
__bit __at 0xA0  _LCD_EN;         // P2_0
__bit __at 0xA1  _LCD_RW;         // P2_1
__bit __at 0xA2  _LCD_RS;         // P2_2

static int DELAY = 500;

static const unsigned char HIGH = 0xff;
static const unsigned char LOW  = 0x00;

// Set the 'delay' until the next BUSY_FLAG LCD check.
void LCD_set_busyflag_check_delay(int delay)
{ DELAY = delay; }

// Adds a 'delay' while waiting for a LCD controller response.
// See 'LCD_set_busyflag_check_delay' and 'wait_until_not_busy' functions.
void delay()
{
    int i;
    for(i=0; i < DELAY; i++);
}

// 'Pulse Enable' tells the LCD controller that there is data to be read/writen from/to the IR/DR BUS.
void pulse_enable()
{
    _LCD_EN=HIGH;
    _LCD_EN=LOW;
}

// Start BUSY_FLAG read operation or add counter operation.
void instruction_register_read_busyflag_or_add_counter()
{
    _LCD_RS=LOW;
    _LCD_RW=HIGH;
}

// Set the LCD controller to 'write instruction register'.
void instruction_register_write_internal_operation()
{
    _LCD_RS=LOW;
    _LCD_RW=LOW;
}

// Set the LCD controller to 'write data register'.
void data_register_write_internal_operation()
{
    _LCD_RS=HIGH;
    _LCD_RW=LOW;
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

    _LCD_EN=HIGH;

    do {
        delay();
    } while (_BUSY_FLAG);
    
    _LCD_EN=LOW;
}

void LCD_IRWrite(unsigned char ir)
{
    wait_until_not_busy();
    // Place the Instruction Register on the MCU-LCD BUS.
    _LCD_IR_DR_BUS=ir;
    instruction_register_write_internal_operation();
    pulse_enable();
}

void LCD_DRWrite(unsigned char dr)
{
    wait_until_not_busy();
    // Place the Data Register on the MCU-LCD BUS.
    _LCD_IR_DR_BUS=dr;
    data_register_write_internal_operation();
    pulse_enable();
}

void LCD_StringWrite(unsigned char* pstr)
{
    unsigned char i;
    for(i=0; pstr[i] != 0; i++)
        LCD_DRWrite(pstr[i]);
}