#include <at89x51.h>
#include "hd44780.h"
#include "mcs-51.h"

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

#define LCD_DISPLAYCONTROL 0x08
#define LCD_8BITMODE 0x10
#define LCD_4BITMODE 0x00
#define LCD_2LINE 0x08
#define LCD_5x8DOTS 0x00
#define LCD_FUNCTIONSET 0x20
#define LCD_CLEARDISPLAY 0x01
#define LCD_DISPLAYON 0x04
#define LCD_DISPLAYOFF 0x00
#define LCD_CURSORON 0x02
#define LCD_CURSOROFF 0x00
#define LCD_BLINKON 0x01
#define LCD_BLINKOFF 0x00
#define LCD_ENTRYLEFT 0x02
#define LCD_ENTRYSHIFTDECREMENT 0x00
#define LCD_ENTRYMODESET 0x04

static unsigned char _PULSE_ENABLE_PWEH_HIGH    = 0;
static unsigned char _PULSE_ENABLE_PWEH_LOW     = 0;
static unsigned char _displayfunction     = 0x00;
static unsigned char _displaycontrol = 0x00;
static unsigned char _displaymode = 0x00;

void clear()
{
    lcd_irwrite_4bits(LCD_CLEARDISPLAY);  // clear display, set cursor position to zero
    //2.000.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 1666,666666667 (round to 1667)
    // TIMER COUNTS=65535-START=1667d => START=63868d=F97Ch
    mcs51_timer0_delay(0xF9, 0x7C);
}

// 'Pulse Enable' tells the LCD controller that there is data to be read/writen from/to the IR/DR BUS.
void pulse_enable()
{
    _LCD_EN=0;
    mcs51_timer0_delay(_PULSE_ENABLE_PWEH_HIGH, _PULSE_ENABLE_PWEH_LOW);
    _LCD_EN=1;
    mcs51_timer0_delay(_PULSE_ENABLE_PWEH_HIGH, _PULSE_ENABLE_PWEH_LOW);
    _LCD_EN=0;
    //100.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 83,333333333 (round to 84)
    // TIMER COUNTS=65535-START=84d => START=65451d=FFABh
    mcs51_timer0_delay(0xFF, 0xAB);
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
        //delay();
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
    //wait_until_not_busy();
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
    //wait_until_not_busy();
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

void lcd_drwrite_4bits(const unsigned char dr)
{
    lcd_drwrite_4bits_bus(dr);      // Send first the upper 4 bits.
    lcd_drwrite_4bits_bus(dr << 4); // and then the lower 4 bits.
}

void lcd_stringwrite_4bits(const unsigned char* pstr)
{
    unsigned char i;
    for(i=0; pstr[i] != 0; i++)
        lcd_drwrite_4bits(pstr[i]);
}

// 4-BIT BUS FUNCTIONS
//******************************************************************************

void initialize(const unsigned char pulse_enable_pweh_high, const unsigned char pulse_enable_pweh_low)
{ 
    _PULSE_ENABLE_PWEH_HIGH    = pulse_enable_pweh_high;
    _PULSE_ENABLE_PWEH_LOW     = pulse_enable_pweh_low;
    
    _displayfunction = LCD_4BITMODE | LCD_2LINE | LCD_5x8DOTS;
    //50.000.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 41666,67 (round to 41667)
    // TIMER COUNTS=65535-START=41667d => START=23868d=5D3Ch
    mcs51_timer0_delay(0x5D, 0x3C);
    _LCD_RS=0;
    _LCD_RW=0;
    _LCD_EN=0;

    if (! (_displayfunction & LCD_8BITMODE)) {
        // this is according to the hitachi HD44780 datasheet
        // figure 24, pg 46

        // we start in 8bit mode, try to set 4 bit mode
        lcd_irwrite_4bits_bus(0x03);
        //4.500.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 3750
        // TIMER COUNTS=65535-START=3750d => START=61785d=F159h
        mcs51_timer0_delay(0xF1, 0x59);

        // second try
        lcd_irwrite_4bits_bus(0x03);
        //4.500.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 3750
        // TIMER COUNTS=65535-START=3750d => START=61785d=F159h
        mcs51_timer0_delay(0xF1, 0x59);
        
        // third go!
        lcd_irwrite_4bits_bus(0x03);
        //150.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 125
        // TIMER COUNTS=65535-START=125d => START=65410d=FF82h
        mcs51_timer0_delay(0xFF, 0x82);

        // finally, set to 4-bit interface
        lcd_irwrite_4bits_bus(0x02);
    } else {
        // this is according to the hitachi HD44780 datasheet
        // page 45 figure 23

        // Send function set command sequence
        lcd_irwrite(LCD_FUNCTIONSET | _displayfunction);
        //4.500.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 3750
        // TIMER COUNTS=65535-START=3750d => START=61785d=F159h
        mcs51_timer0_delay(0xF1, 0x59);

        // second try
        lcd_irwrite(LCD_FUNCTIONSET | _displayfunction);
        //150.000 ns = (10^2 ns * 12 * TIMER COUNTS * 1) => TIMER COUNTS = 125
        // TIMER COUNTS=65535-START=125d => START=65410d=FF82h
        mcs51_timer0_delay(0xFF, 0x82);

        // third go
        lcd_irwrite(LCD_FUNCTIONSET | _displayfunction);
    }

    // third go
    lcd_irwrite_4bits(LCD_FUNCTIONSET | _displayfunction);

    _displaycontrol = LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF;  
    _displaycontrol |= LCD_DISPLAYON;
    lcd_irwrite_4bits(LCD_DISPLAYCONTROL | _displaycontrol);

    clear();

    // Initialize to default text direction (for romance languages)
    _displaymode = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
    // set the entry mode
    lcd_irwrite_4bits(LCD_ENTRYMODESET | _displaymode);
}