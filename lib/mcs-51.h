#ifndef __MCS_51_H
#define __MCS_51_H

/**
    Run the internal timer0 with full 16-bit counter 'mult' times.

    @param pmult pointer - how many times the counter must run.
    @param pth0 pointer - the HIGHER bits of the 16-bit counter start value.
    @param ptl0 pointer - the LOWER bits of the 16-bit counter start value.
*/
void mcs51_mult_max_timer0_delay(const int* pmult, const unsigned char* pth0, const unsigned char* ptl0);

/**
    Run the internal timer1 with full 16-bit counter 'mult' times.

    @param pmult pointer - how many times the counter must run.
    @param pth0 pointer - the HIGHER bits of the 16-bit counter start value.
    @param ptl0 pointer - the LOWER bits of the 16-bit counter start value.
*/
void mcs51_mult_max_timer1_delay(const int* pmult, const unsigned char* pth0, const unsigned char* ptl0);

#endif  /* __MCS_51_H */