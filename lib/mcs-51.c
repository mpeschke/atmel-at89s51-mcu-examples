#include <at89x51.h>
#include "mcs-51.h"

void mcs51_timer0_delay(const unsigned char th0, const unsigned char tl0)
{
    TMOD = M0_0;  // Timer 0 is in use. 16-bit Timer Mode is selected.  
    TL0 = tl0;    // Load value for TL0 register
    TH0 = th0;    // Load value for TH0 register
    TR0 = 1;      // Run Timer-0
    
    while(!TF0);  // Poll TF0  
    
    TR0 = 0;      // If TF0=1 stop the timer by making TR0=0
    TF0 = 0;      // If TF0=1 stop the timer by making TR0=0
}

void mcs51_mult_max_timer0_delay(const unsigned int mult, const unsigned char th0, const unsigned char tl0)
{
    unsigned int cpmult = mult;
    while(cpmult > 0)
    {
        mcs51_timer0_delay(th0, tl0);
        cpmult--;
    }
}

void mcs51_timer1_delay(const unsigned char th1, const unsigned char tl1)
{
    TMOD = M1_0;  // Timer 1 is in use. 16-bit Timer Mode is selected.  
    TL1 = tl1;    // Load value for TL1 register
    TH1 = th1;    // Load value for TH1 register
    TR1 = 1;      // Run Timer-1
    
    while(!TF1);  // Poll TF1  
    
    TR1 = 0;      // If TF1=1 stop the timer by making TR1=0
    TF1 = 0;      // If TF1=1 stop the timer by making TR1=0
}

void mcs51_mult_max_timer1_delay(const unsigned int mult, const unsigned char th1, const unsigned char tl1)
{
    unsigned int cpmult = mult;
    while(cpmult > 0)
    {
        mcs51_timer1_delay(th1, tl1);
        cpmult--;
    }
}