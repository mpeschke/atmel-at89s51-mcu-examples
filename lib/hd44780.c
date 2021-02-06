#include <at89x51.h>
#include "hd44780.h"
#include "mcs-51.h"

//////////////////////////////////////////////////////////
// 8bit data/instruction BUS.
__sfr __at 0x80  _LCD_IR_DR_BUS;    // P0
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// 4bit data/instruction BUS.
__sbit __at 0x84  _LCD_IR_DR_BUS_4; // P0_4
__sbit __at 0x85  _LCD_IR_DR_BUS_5; // P0_5
__sbit __at 0x86  _LCD_IR_DR_BUS_6; // P0_6
__sbit __at 0x87  _BUSY_FLAG;       // P0_7
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// LCD Pulse Enable ports.
__sbit __at 0xA0  _LCD_EN;          // P2_0
__sbit __at 0xA1  _LCD_RW;          // P2_1
__sbit __at 0xA2  _LCD_RS;          // P2_2
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// Private LCD constants.
static const unsigned char LCD_ENTRYSHIFTDECREMENT  = 0x00;
static const unsigned char LCD_CLEARDISPLAY         = 0x01;
static const unsigned char LCD_ENTRYLEFT            = 0x02;
static const unsigned char LCD_ENABLE_4BIT          = 0x02;
static const unsigned char LCD_DISPLAYCONTROL       = 0x08;
static const unsigned char LCD_FUNCTIONSET          = 0x20;
static const unsigned char LCD_ENTRYMODESET         = 0x04;

static const unsigned char LCD_SETDDRAMADDR         = 0x80;

static const unsigned char LCD_BLINKOFF             = 0x00;
static const unsigned char LCD_CURSOROFF            = 0x00;
static const unsigned char LCD_DISPLAYOFF           = 0x00;

static const unsigned char LCD_BLINKON              = 0x01;
static const unsigned char LCD_CURSORON             = 0x02;
static const unsigned char LCD_DISPLAYON            = 0x04;
// Private LCD constants.
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// Display properties (internal) management.
static unsigned char _DISPLAY_FUNC_SET              = 0x00;
static unsigned char _DISPLAY_CONTROL               = 0x00;
static unsigned char _DISPLAY_MODE                  = 0x00;

// Preset delays.
static unsigned int _DLAY_PE_PWEH                   = 0x0000;
static unsigned int _DLAY_PE_TAH                    = 0x0000;
static unsigned int _DLAY_CLEAR_DISPLAY_HOME        = 0x0000;
// Display properties (internal) management.
//////////////////////////////////////////////////////////

//******************************************************************************
// CONTROL PULSE ENABLE AND BUS READ/WRITE MODES

/**
    'Pulse Enable' tells the LCD controller that there is data to be read/writen 
    from/to the IR/DR BUS.

*/
void pulse_enable()
{
    _LCD_EN=0;
    mcs51_timer0_delay_16bit(_DLAY_PE_PWEH);
    _LCD_EN=1;
    mcs51_timer0_delay_16bit(_DLAY_PE_PWEH);
    _LCD_EN=0;
    mcs51_timer0_delay_16bit(_DLAY_PE_TAH);
}

/**
    Set the LCD controller to 'write instruction register'.

*/
void instruction_register_write_internal_operation()
{
    _LCD_RS=0;
    _LCD_RW=0;
}

/**
    Set the LCD controller to 'write data register'.

*/
void data_register_write_internal_operation()
{
    _LCD_RS=1;
    _LCD_RW=0;
}

// CONTROL PULSE ENABLE AND BUS READ/WRITE MODES
//******************************************************************************

//******************************************************************************
// 8-BIT BUS FUNCTIONS

/**
    Sends an instruction register to the LCD controller.

    @param ir the instruction register (command) - see HD44780 documentation.
*/
void lcd_irwrite(const unsigned char ir)
{
    // Place the Instruction Register on the MCU-LCD BUS.
    instruction_register_write_internal_operation();
    _LCD_IR_DR_BUS=ir;
    pulse_enable();
}

/**
    Sends a data register to the LCD controller.

    @param dr the data register (a string character).
*/
void lcd_drwrite(const unsigned char dr)
{
    // Place the Data Register on the MCU-LCD BUS.
    data_register_write_internal_operation();
    _LCD_IR_DR_BUS=dr;
    pulse_enable();
}

/**
    Function to send a string to the LCD controller - each character at a time
    (each character is a 8-bit data register).

    @param pstr pointer to a string.
*/
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

/**
    Sends 4-bits of a instruction register to the LCD controller.

    @param fourbits 4-bits of the instruction register.
*/
void lcd_irwrite_4bits_bus(const unsigned char fourbits)
{
    // Place the Instruction Register on the MCU-LCD BUS.
    instruction_register_write_internal_operation();
    _LCD_IR_DR_BUS_4 = (fourbits & (1<<4));
    _LCD_IR_DR_BUS_5 = (fourbits & (1<<5));
    _LCD_IR_DR_BUS_6 = (fourbits & (1<<6));
    _BUSY_FLAG       = (fourbits & (1<<7));
    pulse_enable();
}

/**
    Sends 4-bits of a data register to the LCD controller.

    @param fourbits 4-bits of the data register.
*/
void lcd_drwrite_4bits_bus(const unsigned char fourbits)
{
    // Place the Data Register on the MCU-LCD BUS.
    data_register_write_internal_operation();
    _LCD_IR_DR_BUS_4 = (fourbits & (1<<4));
    _LCD_IR_DR_BUS_5 = (fourbits & (1<<5));
    _LCD_IR_DR_BUS_6 = (fourbits & (1<<6));
    _BUSY_FLAG       = (fourbits & (1<<7));
    pulse_enable();
}

/**
    Function to send a string to the LCD controller - 4-bits of the character at a time
    (each character is a 8-bit data register).

    @param pstr pointer to a string.
*/
void lcd_stringwrite_4bits(const unsigned char* pstr)
{
    unsigned char i;
    for(i=0; pstr[i] != 0; i++)
    {
        lcd_drwrite_4bits_bus(pstr[i]);      // Send first the upper 4 bits.
        lcd_drwrite_4bits_bus(pstr[i] << 4); // and then the lower 4 bits.
    }
}

// 4-BIT BUS FUNCTIONS
//******************************************************************************

//******************************************************************************
// 4-BIT/8-BIT LCD FUNCTION WRAPPERS

/**
    Sends an instruction (command) to the LCD controller.

    @param ir 8-bit instruction register.
*/
void lcd_instruction_register_write(const unsigned char ir)
{
    if (! (_DISPLAY_FUNC_SET & LCD_FUNCSET_8BITMODE))
    {
        lcd_irwrite_4bits_bus(ir);      // Send first the upper 4 bits.
        lcd_irwrite_4bits_bus(ir << 4); // and then the lower 4 bits.
    }
    else
        lcd_irwrite(ir);
}

/**
    Sends a data (character) to the LCD controller.

    @param dr 8-bit data register (a string character).
*/
void lcd_data_register_write(const unsigned char dr)
{
    if (! (_DISPLAY_FUNC_SET & LCD_FUNCSET_8BITMODE))
    {
        lcd_drwrite_4bits_bus(dr);      // Send first the upper 4 bits.
        lcd_drwrite_4bits_bus(dr << 4); // and then the lower 4 bits.
    }
    else
        lcd_drwrite(dr);
}

void lcd_print(const unsigned char* pstr)
{
    if (! (_DISPLAY_FUNC_SET & LCD_FUNCSET_8BITMODE))
        lcd_stringwrite_4bits(pstr);
    else
        lcd_stringwrite(pstr);
}

void lcd_clear()
{
    lcd_instruction_register_write(LCD_CLEARDISPLAY);  // clear display, set cursor position to zero

    mcs51_timer0_delay_16bit(_DLAY_CLEAR_DISPLAY_HOME);
}

void lcd_set_cursor(const unsigned char row, const unsigned char col)
{
    lcd_instruction_register_write(LCD_SETDDRAMADDR | (col + 0x40 * row));  // Set cursor position.
}

void lcd_display_on()
{
    _DISPLAY_CONTROL |= LCD_DISPLAYON;

    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn display ON
}

void lcd_display_off()
{
    _DISPLAY_CONTROL &= ~LCD_DISPLAYON;

    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn display OFF
}

void lcd_cursor_on()
{
    _DISPLAY_CONTROL |= LCD_CURSORON;

    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor ON
}

void lcd_cursor_off()
{
    _DISPLAY_CONTROL &= ~LCD_CURSORON;

    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor OFF
}

void lcd_blink_on()
{
    _DISPLAY_CONTROL |= LCD_BLINKON;

    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor blinking ON
}

void lcd_blink_off()
{
    _DISPLAY_CONTROL &= ~LCD_BLINKON;

    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor blinking OFF
}

void lcd_initialize(
    const unsigned char lcd_display_function_set,
    const unsigned int  lcd_dlay_pe_pweh,
    const unsigned int  lcd_dlay_pe_tah,
    const unsigned int  lcd_dlay_init_3rd,
    const unsigned int  lcd_dlay_clear_display_home,
    const unsigned int  lcd_dlay_init_1st_2nd,
    const unsigned int  lcd_dlay_init
)
{
    _DLAY_PE_PWEH               = lcd_dlay_pe_pweh;
    _DLAY_PE_TAH                = lcd_dlay_pe_tah;
    _DLAY_CLEAR_DISPLAY_HOME    = lcd_dlay_clear_display_home;
    _DISPLAY_FUNC_SET           = lcd_display_function_set;

    mcs51_timer0_delay_16bit(lcd_dlay_init);

    _LCD_RS=0;
    _LCD_RW=0;
    _LCD_EN=0;

   if (! (_DISPLAY_FUNC_SET & LCD_FUNCSET_8BITMODE)) {
        // we start in 8bit mode, try to set 4 bit mode
        lcd_irwrite_4bits_bus(0x03);
        mcs51_timer0_delay_16bit(lcd_dlay_init_1st_2nd);

        // second try
        lcd_irwrite_4bits_bus(0x03);
        mcs51_timer0_delay_16bit(lcd_dlay_init_1st_2nd);
        
        // third go!
        lcd_irwrite_4bits_bus(0x03);
        mcs51_timer0_delay_16bit(lcd_dlay_init_3rd);

        // finally, set to 4-bit interface
        lcd_irwrite_4bits_bus(LCD_ENABLE_4BIT);
    } else {
        // this is according to the hitachi HD44780 datasheet
        // page 45 figure 23

        // Send function set command sequence
        lcd_instruction_register_write(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
        mcs51_timer0_delay_16bit(lcd_dlay_init_1st_2nd);

        // second try
        lcd_instruction_register_write(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
        mcs51_timer0_delay_16bit(lcd_dlay_init_3rd);

        // third go
        lcd_instruction_register_write(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
    }

    // third go
    lcd_instruction_register_write(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);

    _DISPLAY_CONTROL = LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF;  
    _DISPLAY_CONTROL |= LCD_DISPLAYON;
    lcd_instruction_register_write(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);

    lcd_clear();

    // Initialize to default text direction (for romance languages)
    _DISPLAY_MODE = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
    // set the entry mode
    lcd_instruction_register_write(LCD_ENTRYMODESET | _DISPLAY_MODE);
}

// 4-BIT/8-BIT LCD FUNCTION WRAPPERS
//******************************************************************************
