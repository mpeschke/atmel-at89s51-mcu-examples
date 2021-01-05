#include "../lib/hd44780.h"

int main()
{
    unsigned char line1[]={"THIS IS LINE 01!"}, line2[]={"THIS IS LINE 02!"};
    
    LCD_set_busyflag_check_delay(2000);
    LCD_IRWrite_4bits(0x02);
    LCD_IRWrite_4bits(IR_FIVE_FOUR_TWO_DISPLAY_LINES);
    LCD_IRWrite_4bits(IR_DISPLAY_ON_CURSOR_ON);
    
    while(1){
        LCD_IRWrite_4bits(IR_DISPLAY_CLEAR);
        LCD_IRWrite_4bits(IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
        LCD_StringWrite_4bits(line1);

        LCD_IRWrite_4bits(IR_DISPLAY_CURSOR_HOME_SECONLINE);
        LCD_StringWrite_4bits(line2);
    }
}