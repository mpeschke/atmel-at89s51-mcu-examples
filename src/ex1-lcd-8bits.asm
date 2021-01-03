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
	.globl _LCD_StringWrite
	.globl _LCD_IRWrite
	.globl _LCD_set_busyflag_check_delay
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
_main_line1_65536_5:
	.ds 17
_main_line2_65536_5:
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
;line1                     Allocated with name '_main_line1_65536_5'
;line2                     Allocated with name '_main_line2_65536_5'
;------------------------------------------------------------
;	ex1-lcd-8bits.c:3: int main()
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
;	ex1-lcd-8bits.c:5: unsigned char line1[]={"THIS IS LINE 01!"}, line2[]={"THIS IS LINE 02!"};
	mov	_main_line1_65536_5,#0x54
	mov	(_main_line1_65536_5 + 0x0001),#0x48
	mov	(_main_line1_65536_5 + 0x0002),#0x49
	mov	(_main_line1_65536_5 + 0x0003),#0x53
	mov	(_main_line1_65536_5 + 0x0004),#0x20
	mov	(_main_line1_65536_5 + 0x0005),#0x49
	mov	(_main_line1_65536_5 + 0x0006),#0x53
	mov	(_main_line1_65536_5 + 0x0007),#0x20
	mov	(_main_line1_65536_5 + 0x0008),#0x4c
	mov	(_main_line1_65536_5 + 0x0009),#0x49
	mov	(_main_line1_65536_5 + 0x000a),#0x4e
	mov	(_main_line1_65536_5 + 0x000b),#0x45
	mov	(_main_line1_65536_5 + 0x000c),#0x20
	mov	(_main_line1_65536_5 + 0x000d),#0x30
	mov	(_main_line1_65536_5 + 0x000e),#0x31
	mov	(_main_line1_65536_5 + 0x000f),#0x21
	mov	(_main_line1_65536_5 + 0x0010),#0x00
	mov	_main_line2_65536_5,#0x54
	mov	(_main_line2_65536_5 + 0x0001),#0x48
	mov	(_main_line2_65536_5 + 0x0002),#0x49
	mov	(_main_line2_65536_5 + 0x0003),#0x53
	mov	(_main_line2_65536_5 + 0x0004),#0x20
	mov	(_main_line2_65536_5 + 0x0005),#0x49
	mov	(_main_line2_65536_5 + 0x0006),#0x53
	mov	(_main_line2_65536_5 + 0x0007),#0x20
	mov	(_main_line2_65536_5 + 0x0008),#0x4c
	mov	(_main_line2_65536_5 + 0x0009),#0x49
	mov	(_main_line2_65536_5 + 0x000a),#0x4e
	mov	(_main_line2_65536_5 + 0x000b),#0x45
	mov	(_main_line2_65536_5 + 0x000c),#0x20
	mov	(_main_line2_65536_5 + 0x000d),#0x30
	mov	(_main_line2_65536_5 + 0x000e),#0x32
	mov	(_main_line2_65536_5 + 0x000f),#0x21
	mov	(_main_line2_65536_5 + 0x0010),#0x00
;	ex1-lcd-8bits.c:7: LCD_set_busyflag_check_delay(1);
	mov	dptr,#0x0001
	lcall	_LCD_set_busyflag_check_delay
;	ex1-lcd-8bits.c:8: LCD_IRWrite(IR_FIVE_EIGHT_TWO_DISPLAY_LINES);
	mov	dptr,#_IR_FIVE_EIGHT_TWO_DISPLAY_LINES
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_LCD_IRWrite
;	ex1-lcd-8bits.c:9: LCD_IRWrite(IR_DISPLAY_ON_CURSOR_ON);
	mov	dptr,#_IR_DISPLAY_ON_CURSOR_ON
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_LCD_IRWrite
;	ex1-lcd-8bits.c:11: while(1){
00102$:
;	ex1-lcd-8bits.c:12: LCD_IRWrite(IR_DISPLAY_CLEAR);
	mov	dptr,#_IR_DISPLAY_CLEAR
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_LCD_IRWrite
;	ex1-lcd-8bits.c:13: LCD_IRWrite(IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
	mov	dptr,#_IR_DISPLAY_CURSOR_HOME_FIRSTLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_LCD_IRWrite
;	ex1-lcd-8bits.c:14: LCD_StringWrite(line1);
	mov	dptr,#_main_line1_65536_5
	mov	b,#0x40
	lcall	_LCD_StringWrite
;	ex1-lcd-8bits.c:16: LCD_IRWrite(IR_DISPLAY_CURSOR_HOME_SECONLINE);
	mov	dptr,#_IR_DISPLAY_CURSOR_HOME_SECONLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_LCD_IRWrite
;	ex1-lcd-8bits.c:17: LCD_StringWrite(line2);
	mov	dptr,#_main_line2_65536_5
	mov	b,#0x40
	lcall	_LCD_StringWrite
;	ex1-lcd-8bits.c:19: }
	sjmp	00102$
	.area CSEG    (CODE)
	.area CONST   (CODE)
_IR_DISPLAY_CLEAR:
	.db #0x01	; 1
_IR_DISPLAY_ON_CURSOR_ON:
	.db #0x0e	; 14
_IR_FIVE_EIGHT_TWO_DISPLAY_LINES:
	.db #0x38	; 56	'8'
_IR_DISPLAY_CURSOR_HOME_FIRSTLINE:
	.db #0x80	; 128
_IR_DISPLAY_CURSOR_HOME_SECONLINE:
	.db #0xc0	; 192
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
