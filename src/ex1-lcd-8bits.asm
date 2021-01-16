;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module ex1_lcd_8bits
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _mcs51_mult_max_timer0_delay
	.globl _mcs51_timer0_delay
	.globl _lcd_stringwrite
	.globl _lcd_irwrite
	.globl _lcd_set_pulse_and_busyflag_delay
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
_main_line1_65536_11:
	.ds 17
_main_line2_65536_11:
	.ds 17
_main_refresh_65536_11:
	.ds 17
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
;line1                     Allocated with name '_main_line1_65536_11'
;line2                     Allocated with name '_main_line2_65536_11'
;refresh                   Allocated with name '_main_refresh_65536_11'
;------------------------------------------------------------
;	ex1-lcd-8bits.c:50: int main()
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
;	ex1-lcd-8bits.c:52: unsigned char line1[]={"THIS IS LINE 01!"}, line2[]={"THIS IS LINE 02!"}, refresh[]={"REFRESH IN 5 SEC"};
	mov	_main_line1_65536_11,#0x54
	mov	(_main_line1_65536_11 + 0x0001),#0x48
	mov	(_main_line1_65536_11 + 0x0002),#0x49
	mov	(_main_line1_65536_11 + 0x0003),#0x53
	mov	(_main_line1_65536_11 + 0x0004),#0x20
	mov	(_main_line1_65536_11 + 0x0005),#0x49
	mov	(_main_line1_65536_11 + 0x0006),#0x53
	mov	(_main_line1_65536_11 + 0x0007),#0x20
	mov	(_main_line1_65536_11 + 0x0008),#0x4c
	mov	(_main_line1_65536_11 + 0x0009),#0x49
	mov	(_main_line1_65536_11 + 0x000a),#0x4e
	mov	(_main_line1_65536_11 + 0x000b),#0x45
	mov	(_main_line1_65536_11 + 0x000c),#0x20
	mov	(_main_line1_65536_11 + 0x000d),#0x30
	mov	(_main_line1_65536_11 + 0x000e),#0x31
	mov	(_main_line1_65536_11 + 0x000f),#0x21
	mov	(_main_line1_65536_11 + 0x0010),#0x00
	mov	_main_line2_65536_11,#0x54
	mov	(_main_line2_65536_11 + 0x0001),#0x48
	mov	(_main_line2_65536_11 + 0x0002),#0x49
	mov	(_main_line2_65536_11 + 0x0003),#0x53
	mov	(_main_line2_65536_11 + 0x0004),#0x20
	mov	(_main_line2_65536_11 + 0x0005),#0x49
	mov	(_main_line2_65536_11 + 0x0006),#0x53
	mov	(_main_line2_65536_11 + 0x0007),#0x20
	mov	(_main_line2_65536_11 + 0x0008),#0x4c
	mov	(_main_line2_65536_11 + 0x0009),#0x49
	mov	(_main_line2_65536_11 + 0x000a),#0x4e
	mov	(_main_line2_65536_11 + 0x000b),#0x45
	mov	(_main_line2_65536_11 + 0x000c),#0x20
	mov	(_main_line2_65536_11 + 0x000d),#0x30
	mov	(_main_line2_65536_11 + 0x000e),#0x32
	mov	(_main_line2_65536_11 + 0x000f),#0x21
	mov	(_main_line2_65536_11 + 0x0010),#0x00
	mov	_main_refresh_65536_11,#0x52
	mov	(_main_refresh_65536_11 + 0x0001),#0x45
	mov	(_main_refresh_65536_11 + 0x0002),#0x46
	mov	(_main_refresh_65536_11 + 0x0003),#0x52
	mov	(_main_refresh_65536_11 + 0x0004),#0x45
	mov	(_main_refresh_65536_11 + 0x0005),#0x53
	mov	(_main_refresh_65536_11 + 0x0006),#0x48
	mov	(_main_refresh_65536_11 + 0x0007),#0x20
	mov	(_main_refresh_65536_11 + 0x0008),#0x49
	mov	(_main_refresh_65536_11 + 0x0009),#0x4e
	mov	(_main_refresh_65536_11 + 0x000a),#0x20
	mov	(_main_refresh_65536_11 + 0x000b),#0x35
	mov	(_main_refresh_65536_11 + 0x000c),#0x20
	mov	(_main_refresh_65536_11 + 0x000d),#0x53
	mov	(_main_refresh_65536_11 + 0x000e),#0x45
	mov	(_main_refresh_65536_11 + 0x000f),#0x43
	mov	(_main_refresh_65536_11 + 0x0010),#0x00
;	ex1-lcd-8bits.c:55: mcs51_timer0_delay(LCD_40000US_START_HIGHBITS, LCD_40000US_START_LOWBITS);
	mov	dptr,#_LCD_40000US_START_HIGHBITS
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	mov	dptr,#_LCD_40000US_START_LOWBITS
	clr	a
	movc	a,@a+dptr
	mov	_mcs51_timer0_delay_PARM_2,a
	mov	dpl,r7
	lcall	_mcs51_timer0_delay
;	ex1-lcd-8bits.c:59: lcd_set_pulse_and_busyflag_delay(DATA_BUS_PULSE_INTERVAL);
	mov	dptr,#_DATA_BUS_PULSE_INTERVAL
	clr	a
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r7,a
	mov	dpl,r6
	mov	dph,r7
	lcall	_lcd_set_pulse_and_busyflag_delay
;	ex1-lcd-8bits.c:61: lcd_irwrite(HD44780_IR_5X8_8BITS_TWO_DISPLAY_LINES);
	mov	dptr,#_HD44780_IR_5X8_8BITS_TWO_DISPLAY_LINES
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:62: lcd_irwrite(HD44780_IR_DISPLAY_ON_CURSOR_ON);
	mov	dptr,#_HD44780_IR_DISPLAY_ON_CURSOR_ON
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:64: while(1){
00102$:
;	ex1-lcd-8bits.c:65: lcd_irwrite(HD44780_IR_DISPLAY_CLEAR);
	mov	dptr,#_HD44780_IR_DISPLAY_CLEAR
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:66: lcd_irwrite(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:67: lcd_stringwrite(refresh);
	mov	dptr,#_main_refresh_65536_11
	mov	b,#0x40
	lcall	_lcd_stringwrite
;	ex1-lcd-8bits.c:69: mcs51_mult_max_timer0_delay(FIVE_SECONDS_MULT, FIVE_SECONDS_HIGHBITS, FIVE_SECONDS_LOWBITS);
	mov	dptr,#_FIVE_SECONDS_MULT
	clr	a
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r7,a
	mov	dptr,#_FIVE_SECONDS_HIGHBITS
	clr	a
	movc	a,@a+dptr
	mov	_mcs51_mult_max_timer0_delay_PARM_2,a
	mov	dptr,#_FIVE_SECONDS_LOWBITS
	clr	a
	movc	a,@a+dptr
	mov	_mcs51_mult_max_timer0_delay_PARM_3,a
	mov	dpl,r6
	mov	dph,r7
	lcall	_mcs51_mult_max_timer0_delay
;	ex1-lcd-8bits.c:70: lcd_irwrite(HD44780_IR_DISPLAY_CLEAR);
	mov	dptr,#_HD44780_IR_DISPLAY_CLEAR
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:71: lcd_irwrite(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:73: lcd_stringwrite(line1);
	mov	dptr,#_main_line1_65536_11
	mov	b,#0x40
	lcall	_lcd_stringwrite
;	ex1-lcd-8bits.c:75: lcd_irwrite(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite
;	ex1-lcd-8bits.c:76: lcd_stringwrite(line2);
	mov	dptr,#_main_line2_65536_11
	mov	b,#0x40
	lcall	_lcd_stringwrite
;	ex1-lcd-8bits.c:77: mcs51_mult_max_timer0_delay(TWO_SECONDS_MULT, TWO_SECONDS_HIGHBITS, TWO_SECONDS_LOWBITS);
	mov	dptr,#_TWO_SECONDS_MULT
	clr	a
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r7,a
	mov	dptr,#_TWO_SECONDS_HIGHBITS
	clr	a
	movc	a,@a+dptr
	mov	_mcs51_mult_max_timer0_delay_PARM_2,a
	mov	dptr,#_TWO_SECONDS_LOWBITS
	clr	a
	movc	a,@a+dptr
	mov	_mcs51_mult_max_timer0_delay_PARM_3,a
	mov	dpl,r6
	mov	dph,r7
	lcall	_mcs51_mult_max_timer0_delay
;	ex1-lcd-8bits.c:79: }
	ljmp	00102$
	.area CSEG    (CODE)
	.area CONST   (CODE)
_HD44780_IR_DISPLAY_CLEAR:
	.db #0x01	; 1
_HD44780_IR_ENABLE_4BIT_IRDR:
	.db #0x02	; 2
_HD44780_IR_DISPLAY_ON_CURSOR_ON:
	.db #0x0e	; 14
_HD44780_IR_5X8_8BITS_TWO_DISPLAY_LINES:
	.db #0x38	; 56	'8'
_HD44780_IR_5X8_4BITS_TWO_DISPLAY_LINES:
	.db #0x28	; 40
_HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE:
	.db #0x80	; 128
_HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE:
	.db #0xc0	; 192
_TWO_SECONDS_MULT:
	.byte #0x1a,#0x00	;  26
_TWO_SECONDS_HIGHBITS:
	.db #0x05	; 5
_TWO_SECONDS_LOWBITS:
	.db #0x99	; 153
_FIVE_SECONDS_MULT:
	.byte #0x40,#0x00	;  64
_FIVE_SECONDS_HIGHBITS:
	.db #0x01	; 1
_FIVE_SECONDS_LOWBITS:
	.db #0xaf	; 175
_LCD_40000US_START_HIGHBITS:
	.db #0x7d	; 125
_LCD_40000US_START_LOWBITS:
	.db #0xc9	; 201
_DATA_BUS_PULSE_INTERVAL:
	.byte #0xa0,#0x00	; 160
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
