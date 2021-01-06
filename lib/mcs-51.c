#include <at89x51.h>
#include "mcs-51.h"

void Timer0_Delay(unsigned char th0, unsigned char tl0)
{
    TMOD = M0_0;  // Timer 0 is in use. 16-bit Timer Mode is selected.  
    TL0 = tl0;    // Load value for TL0 register
    TH0 = th0;    // Load value for TH0 register
    TR0 = 0xff;   // Run Timer-0
    
    while(!TF0);  // Poll TF0  
    
    TR0 = 0x00;   // If TF0=1 stop the timer by making TR0=0
    TF0 = 0x00;   // If TF0=1 stop the timer by making TR0=0
}

void mcs51_mult_max_timer0_delay(const int mult)
{
    int cpmult = mult;
    while(cpmult > 0)
    {
        Timer0_Delay(0x00, 0x00);
        cpmult--;
    }
}