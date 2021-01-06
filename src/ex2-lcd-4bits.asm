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
	.globl _lcd_stringwrite_4bits
	.globl _lcd_irwrite_4bits
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
_TWO_SECONDS:
	.ds 2
_FIVE_SECONDS:
	.ds 2
_DATA_BUS_PULSE_INTERVAL:
	.ds 2
_main_line_65536_7:
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
;	ex2-lcd-4bits.c:20: static int TWO_SECONDS = 26;
	mov	_TWO_SECONDS,#0x1a
	mov	(_TWO_SECONDS + 1),#0x00
;	ex2-lcd-4bits.c:21: static int FIVE_SECONDS = 64;
	mov	_FIVE_SECONDS,#0x40
	mov	(_FIVE_SECONDS + 1),#0x00
;	ex2-lcd-4bits.c:22: static int DATA_BUS_PULSE_INTERVAL = 100;
	mov	_DATA_BUS_PULSE_INTERVAL,#0x64
	mov	(_DATA_BUS_PULSE_INTERVAL + 1),#0x00
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
;line                      Allocated with name '_main_line_65536_7'
;------------------------------------------------------------
;	ex2-lcd-4bits.c:24: int main()
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
;	ex2-lcd-4bits.c:26: unsigned char line[]={"FEDCBA9876543210"};
	mov	_main_line_65536_7,#0x46
	mov	(_main_line_65536_7 + 0x0001),#0x45
	mov	(_main_line_65536_7 + 0x0002),#0x44
	mov	(_main_line_65536_7 + 0x0003),#0x43
	mov	(_main_line_65536_7 + 0x0004),#0x42
	mov	(_main_line_65536_7 + 0x0005),#0x41
	mov	(_main_line_65536_7 + 0x0006),#0x39
	mov	(_main_line_65536_7 + 0x0007),#0x38
	mov	(_main_line_65536_7 + 0x0008),#0x37
	mov	(_main_line_65536_7 + 0x0009),#0x36
	mov	(_main_line_65536_7 + 0x000a),#0x35
	mov	(_main_line_65536_7 + 0x000b),#0x34
	mov	(_main_line_65536_7 + 0x000c),#0x33
	mov	(_main_line_65536_7 + 0x000d),#0x32
	mov	(_main_line_65536_7 + 0x000e),#0x31
	mov	(_main_line_65536_7 + 0x000f),#0x30
	mov	(_main_line_65536_7 + 0x0010),#0x00
;	ex2-lcd-4bits.c:29: mcs51_mult_max_timer0_delay(TWO_SECONDS);
	mov	dpl,_TWO_SECONDS
	mov	dph,(_TWO_SECONDS + 1)
	lcall	_mcs51_mult_max_timer0_delay
;	ex2-lcd-4bits.c:33: lcd_set_pulse_and_busyflag_delay(DATA_BUS_PULSE_INTERVAL);
	mov	dpl,_DATA_BUS_PULSE_INTERVAL
	mov	dph,(_DATA_BUS_PULSE_INTERVAL + 1)
	lcall	_lcd_set_pulse_and_busyflag_delay
;	ex2-lcd-4bits.c:34: lcd_irwrite_4bits(HD44780_IR_ENABLE_4BIT_IRDR);
	mov	dptr,#_HD44780_IR_ENABLE_4BIT_IRDR
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex2-lcd-4bits.c:35: lcd_irwrite_4bits(HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES);
	mov	dptr,#_HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex2-lcd-4bits.c:36: lcd_irwrite_4bits(HD44780_IR_DISPLAY_ON_CURSOR_ON);
	mov	dptr,#_HD44780_IR_DISPLAY_ON_CURSOR_ON
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex2-lcd-4bits.c:38: while(1){
00102$:
;	ex2-lcd-4bits.c:39: mcs51_mult_max_timer0_delay(FIVE_SECONDS);
	mov	dpl,_FIVE_SECONDS
	mov	dph,(_FIVE_SECONDS + 1)
	lcall	_mcs51_mult_max_timer0_delay
;	ex2-lcd-4bits.c:41: lcd_irwrite_4bits(HD44780_IR_DISPLAY_CLEAR);
	mov	dptr,#_HD44780_IR_DISPLAY_CLEAR
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex2-lcd-4bits.c:42: lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex2-lcd-4bits.c:43: lcd_stringwrite_4bits(line);
	mov	dptr,#_main_line_65536_7
	mov	b,#0x40
	lcall	_lcd_stringwrite_4bits
;	ex2-lcd-4bits.c:45: lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex2-lcd-4bits.c:46: lcd_stringwrite_4bits(line);
	mov	dptr,#_main_line_65536_7
	mov	b,#0x40
	lcall	_lcd_stringwrite_4bits
;	ex2-lcd-4bits.c:48: }
	sjmp	00102$
	.area CSEG    (CODE)
	.area CONST   (CODE)
_HD44780_IR_DISPLAY_CLEAR:
	.db #0x01	; 1
_HD44780_IR_ENABLE_4BIT_IRDR:
	.db #0x02	; 2
_HD44780_IR_DISPLAY_ON_CURSOR_ON:
	.db #0x0e	; 14
_HD44780_IR_FIVE_EIGHT_TWO_DISPLAY_LINES:
	.db #0x38	; 56	'8'
_HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES:
	.db #0x28	; 40
_HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE:
	.db #0x80	; 128
_HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE:
	.db #0xc0	; 192
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
