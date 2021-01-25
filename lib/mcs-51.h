#ifndef __MCS_51_H
#define __MCS_51_H

// Library to share common AT89S51 functions with all project examples.

/**
    Wrapper for the mcs51_timer0_delay function.

    @param thtl0  the 16-bit counter start value.
*/
void mcs51_timer0_delay_16bit(const unsigned int thtl0);

/**
    Run the internal timer0 with full 16-bit counter.

    @param th0  the HIGHER bits of the 16-bit counter start value.
    @param tl0  the LOWER bits of the 16-bit counter start value.
*/
void mcs51_timer0_delay(const unsigned char th0, const unsigned char tl0);

/**
    Wrapper for the mcs51_timer1_delay function.

    @param thtl1  the 16-bit counter start value.
*/
void mcs51_timer1_delay_16bit(const unsigned int thtl1);

/**
    Run the internal timer1 with full 16-bit counter.

    @param th1  the HIGHER bits of the 16-bit counter start value.
    @param tl1  the LOWER bits of the 16-bit counter start value.
*/
void mcs51_timer1_delay(const unsigned char th1, const unsigned char tl1);

/**
    Run the internal timer0 with full 16-bit counter 'mult' times.

    @param mult  how many times the counter must run.
    @param thtl0  the 16-bit counter start value.
*/
void mcs51_mult_max_timer0_delay(const unsigned int mult, const unsigned int thtl0);

/**
    Run the internal timer1 with full 16-bit counter 'mult' times.

    @param mult  how many times the counter must run.
    @param thtl1  the 16-bit counter start value.
*/
void mcs51_mult_max_timer1_delay(const unsigned int mult, const unsigned int thtl1);

#endif  /* __MCS_51_H */