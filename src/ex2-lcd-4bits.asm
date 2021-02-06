;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module ex2_lcd_4bits
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _mcs51_mult_max_timer0_delay
	.globl _lcd_print
	.globl _lcd_set_cursor
	.globl _lcd_clear
	.globl _lcd_initialize
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
	.globl __sdcc_gsinit_startup
	.globl __sdcc_program_startup
	.globl __start__stack
	.globl __mcs51_genXINIT
	.globl __mcs51_genXRAMCLEAR
	.globl __mcs51_genRAMCLEAR
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
__sdcc_program_startup:
	ljmp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;line                      Allocated to registers 
;------------------------------------------------------------
;	ex2-lcd-4bits.c:69: int main()
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
;	ex2-lcd-4bits.c:71: const unsigned char* line = "FEDCBA9876543210";
;	ex2-lcd-4bits.c:75: LCD_FUNCSET_4BITMODE | LCD_FUNCSET_2LINE | LCD_FUNCSET_5x8DOTS,
	mov	dptr,#_LCD_FUNCSET_2LINE
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	mov	dptr,#_LCD_FUNCSET_4BITMODE
	clr	a
	movc	a,@a+dptr
	orl	ar7,a
	mov	dptr,#_LCD_FUNCSET_5x8DOTS
	clr	a
	movc	a,@a+dptr
	orl	ar7,a
;	ex2-lcd-4bits.c:76: LCD_DLAY_PE_PWEH,
	mov	dptr,#_LCD_DLAY_PE_PWEH
	clr	a
	movc	a,@a+dptr
	mov	_lcd_initialize_PARM_2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_lcd_initialize_PARM_2 + 1),a
;	ex2-lcd-4bits.c:77: LCD_DLAY_PE_TAH,
	mov	dptr,#_LCD_DLAY_PE_TAH
	clr	a
	movc	a,@a+dptr
	mov	_lcd_initialize_PARM_3,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_lcd_initialize_PARM_3 + 1),a
;	ex2-lcd-4bits.c:78: LCD_DLAY_INIT_3RD,
	mov	dptr,#_LCD_DLAY_INIT_3RD
	clr	a
	movc	a,@a+dptr
	mov	_lcd_initialize_PARM_4,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_lcd_initialize_PARM_4 + 1),a
;	ex2-lcd-4bits.c:79: LCD_DLAY_CLEAR_DISPLAY_HOME,
	mov	dptr,#_LCD_DLAY_CLEAR_DISPLAY_HOME
	clr	a
	movc	a,@a+dptr
	mov	_lcd_initialize_PARM_5,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_lcd_initialize_PARM_5 + 1),a
;	ex2-lcd-4bits.c:80: LCD_DLAY_INIT_1ST_2ND,
	mov	dptr,#_LCD_DLAY_INIT_1ST_2ND
	clr	a
	movc	a,@a+dptr
	mov	_lcd_initialize_PARM_6,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_lcd_initialize_PARM_6 + 1),a
;	ex2-lcd-4bits.c:81: LCD_DLAY_INIT
	mov	dptr,#_LCD_DLAY_INIT
	clr	a
	movc	a,@a+dptr
	mov	_lcd_initialize_PARM_7,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_lcd_initialize_PARM_7 + 1),a
	mov	dpl,r7
	lcall	_lcd_initialize
;	ex2-lcd-4bits.c:85: while(1){
00102$:
;	ex2-lcd-4bits.c:86: lcd_clear();
	lcall	_lcd_clear
;	ex2-lcd-4bits.c:87: lcd_set_cursor(0, 0);
	mov	_lcd_set_cursor_PARM_2,#0x00
	mov	dpl,#0x00
	lcall	_lcd_set_cursor
;	ex2-lcd-4bits.c:88: lcd_print(line);
	mov	dptr,#___str_0
	mov	b,#0x80
	lcall	_lcd_print
;	ex2-lcd-4bits.c:90: lcd_set_cursor(1, 0);
	mov	_lcd_set_cursor_PARM_2,#0x00
	mov	dpl,#0x01
	lcall	_lcd_set_cursor
;	ex2-lcd-4bits.c:91: lcd_print(line);
	mov	dptr,#___str_0
	mov	b,#0x80
	lcall	_lcd_print
;	ex2-lcd-4bits.c:95: mcs51_mult_max_timer0_delay(FIVE_SECONDS_MULT, FIVE_SECONDS_COUNTER);
	mov	dptr,#_FIVE_SECONDS_MULT
	clr	a
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r7,a
	mov	dptr,#_FIVE_SECONDS_COUNTER
	clr	a
	movc	a,@a+dptr
	mov	_mcs51_mult_max_timer0_delay_PARM_2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_mcs51_mult_max_timer0_delay_PARM_2 + 1),a
	mov	dpl,r6
	mov	dph,r7
	lcall	_mcs51_mult_max_timer0_delay
;	ex2-lcd-4bits.c:97: }
	sjmp	00102$
	.area CSEG    (CODE)
	.area CONST   (CODE)
_LCD_FUNCSET_4BITMODE:
	.db #0x00	; 0
_LCD_FUNCSET_5x8DOTS:
	.db #0x00	; 0
_LCD_FUNCSET_1LINE:
	.db #0x00	; 0
_LCD_FUNCSET_5x10DOTS:
	.db #0x04	; 4
_LCD_FUNCSET_2LINE:
	.db #0x08	; 8
_LCD_FUNCSET_8BITMODE:
	.db #0x10	; 16
_FIVE_SECONDS_MULT:
	.byte #0x40,#0x00	; 64
_FIVE_SECONDS_COUNTER:
	.byte #0xaf,#0x01	; 431
_LCD_DLAY_PE_PWEH:
	.byte #0xfe,#0xff	; 65534
_LCD_DLAY_PE_TAH:
	.byte #0xab,#0xff	; 65451
_LCD_DLAY_INIT_3RD:
	.byte #0x82,#0xff	; 65410
_LCD_DLAY_CLEAR_DISPLAY_HOME:
	.byte #0x7c,#0xf9	; 63868
_LCD_DLAY_INIT_1ST_2ND:
	.byte #0x59,#0xf1	; 61785
_LCD_DLAY_INIT:
	.byte #0x3c,#0x5d	; 23868
___str_0:
	.ascii "FEDCBA9876543210"
	.db 0x00
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
