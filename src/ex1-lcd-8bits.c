#include "../lib/hd44780.h"

int main()
{
    unsigned char line1[]={"THIS IS LINE 01!"}, line2[]={"THIS IS LINE 02!"};
    
    LCD_set_busyflag_check_delay(1);
    LCD_IRWrite(IR_FIVE_EIGHT_TWO_DISPLAY_LINES);
    LCD_IRWrite(IR_DISPLAY_ON_CURSOR_ON);
    
    while(1){
        LCD_IRWrite(IR_DISPLAY_CLEAR);
        LCD_IRWrite(IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
        LCD_StringWrite(line1);

        LCD_IRWrite(IR_DISPLAY_CURSOR_HOME_SECONLINE);
        LCD_StringWrite(line2);
    }
}