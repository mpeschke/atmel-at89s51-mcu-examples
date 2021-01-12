;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Mac OS X x86_64)
;--------------------------------------------------------
	.module ex3_serial_lcd_4bits
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _initialize_serial
	.globl _ex3_ser_handler
	.globl _lcd_stringwrite_4bits
	.globl _lcd_irwrite_4bits
	.globl _lcd_drwrite_4bits_bus
	.globl _lcd_set_pulse_and_busyflag_delay
	.globl _CY
	.globl _AC
	.globl _F0
	.globl _RS1
	.globl _RS0
	.globl _OV
	.globl _FL
	.globl _P
	.globl _PS
	.globl _PT1
	.globl _PX1
	.globl _PT0
	.globl _PX0
	.globl _RD
	.globl _WR
	.globl _T1
	.globl _T0
	.globl _INT1
	.globl _INT0
	.globl _TXD
	.globl _RXD
	.globl _P3_7
	.globl _P3_6
	.globl _P3_5
	.globl _P3_4
	.globl _P3_3
	.globl _P3_2
	.globl _P3_1
	.globl _P3_0
	.globl _EA
	.globl _ES
	.globl _ET1
	.globl _EX1
	.globl _ET0
	.globl _EX0
	.globl _P2_7
	.globl _P2_6
	.globl _P2_5
	.globl _P2_4
	.globl _P2_3
	.globl _P2_2
	.globl _P2_1
	.globl _P2_0
	.globl _SM0
	.globl _SM1
	.globl _SM2
	.globl _REN
	.globl _TB8
	.globl _RB8
	.globl _TI
	.globl _RI
	.globl _P1_7
	.globl _P1_6
	.globl _P1_5
	.globl _P1_4
	.globl _P1_3
	.globl _P1_2
	.globl _P1_1
	.globl _P1_0
	.globl _TF1
	.globl _TR1
	.globl _TF0
	.globl _TR0
	.globl _IE1
	.globl _IT1
	.globl _IE0
	.globl _IT0
	.globl _P0_7
	.globl _P0_6
	.globl _P0_5
	.globl _P0_4
	.globl _P0_3
	.globl _P0_2
	.globl _P0_1
	.globl _P0_0
	.globl _B
	.globl _A
	.globl _ACC
	.globl _PSW
	.globl _IP
	.globl _P3
	.globl _IE
	.globl _P2
	.globl _SBUF
	.globl _SCON
	.globl _P1
	.globl _TH1
	.globl _TH0
	.globl _TL1
	.globl _TL0
	.globl _TMOD
	.globl _TCON
	.globl _PCON
	.globl _DPH
	.globl _DPL
	.globl _SP
	.globl _P0
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_PSW	=	0x00d0
_ACC	=	0x00e0
_A	=	0x00e0
_B	=	0x00f0
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES	=	0x00ac
_EA	=	0x00af
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS	=	0x00bc
_P	=	0x00d0
_FL	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; overlayable bit register bank
;--------------------------------------------------------
	.area BIT_BANK	(REL,OVR,DATA)
bits:
	.ds 1
	b0 = bits[0]
	b1 = bits[1]
	b2 = bits[2]
	b3 = bits[3]
	b4 = bits[4]
	b5 = bits[5]
	b6 = bits[6]
	b7 = bits[7]
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
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	ljmp	_ex3_ser_handler
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
;Allocation info for local variables in function 'ex3_ser_handler'
;------------------------------------------------------------
;chr                       Allocated to registers r7 
;------------------------------------------------------------
;	ex3-serial-lcd-4bits.c:8: void ex3_ser_handler (void) __interrupt 4
;	-----------------------------------------
;	 function ex3_ser_handler
;	-----------------------------------------
_ex3_ser_handler:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+7)
	push	(0+6)
	push	(0+5)
	push	(0+4)
	push	(0+3)
	push	(0+2)
	push	(0+1)
	push	(0+0)
	push	psw
	mov	psw,#0x00
;	ex3-serial-lcd-4bits.c:10: char chr = 0x00;
	mov	r7,#0x00
;	ex3-serial-lcd-4bits.c:11: if(RI==1) {
	jnb	_RI,00102$
;	ex3-serial-lcd-4bits.c:12: chr = SBUF;
	mov	r7,_SBUF
;	ex3-serial-lcd-4bits.c:13: RI = 0;
;	assignBit
	clr	_RI
00102$:
;	ex3-serial-lcd-4bits.c:16: lcd_drwrite_4bits_bus(chr);
	mov	dpl,r7
	push	ar7
	lcall	_lcd_drwrite_4bits_bus
	pop	ar7
;	ex3-serial-lcd-4bits.c:17: lcd_drwrite_4bits_bus(chr << 4);
	mov	a,r7
	swap	a
	anl	a,#0xf0
	mov	dpl,a
	lcall	_lcd_drwrite_4bits_bus
;	ex3-serial-lcd-4bits.c:18: }
	pop	psw
	pop	(0+0)
	pop	(0+1)
	pop	(0+2)
	pop	(0+3)
	pop	(0+4)
	pop	(0+5)
	pop	(0+6)
	pop	(0+7)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'initialize_serial'
;------------------------------------------------------------
;	ex3-serial-lcd-4bits.c:20: void initialize_serial(void)
;	-----------------------------------------
;	 function initialize_serial
;	-----------------------------------------
_initialize_serial:
;	ex3-serial-lcd-4bits.c:22: TMOD = 0x20;    // Timer 1 In Mode 2 -Auto Reload to Generate Baud Rate
	mov	_TMOD,#0x20
;	ex3-serial-lcd-4bits.c:23: SCON = 0x50;    // Serial Mode 1, 8-Data Bit, REN Enabled
	mov	_SCON,#0x50
;	ex3-serial-lcd-4bits.c:24: TH1  = 0xFD;    // Load Baud Rate 9600 To Timer Register
	mov	_TH1,#0xfd
;	ex3-serial-lcd-4bits.c:25: TR1  = 1;       // Start Timer
;	assignBit
	setb	_TR1
;	ex3-serial-lcd-4bits.c:26: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;	ex3-serial-lcd-4bits.c:28: int main()
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	ex3-serial-lcd-4bits.c:32: lcd_set_pulse_and_busyflag_delay(&DATA_BUS_PULSE_INTERVAL);
	mov	dptr,#_DATA_BUS_PULSE_INTERVAL
	mov	b,#0x80
	lcall	_lcd_set_pulse_and_busyflag_delay
;	ex3-serial-lcd-4bits.c:35: lcd_irwrite_4bits(HD44780_IR_ENABLE_4BIT_IRDR);
	mov	dptr,#_HD44780_IR_ENABLE_4BIT_IRDR
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex3-serial-lcd-4bits.c:36: lcd_irwrite_4bits(HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES);
	mov	dptr,#_HD44780_IR_FIVE_FOUR_TWO_DISPLAY_LINES
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex3-serial-lcd-4bits.c:37: lcd_irwrite_4bits(HD44780_IR_DISPLAY_ON_CURSOR_ON);
	mov	dptr,#_HD44780_IR_DISPLAY_ON_CURSOR_ON
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex3-serial-lcd-4bits.c:39: lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_FIRSTLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex3-serial-lcd-4bits.c:40: lcd_stringwrite_4bits(FIRST_LINE_BUFF);
	mov	dptr,#_FIRST_LINE_BUFF
	mov	b,#0x80
	lcall	_lcd_stringwrite_4bits
;	ex3-serial-lcd-4bits.c:41: lcd_irwrite_4bits(HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE);
	mov	dptr,#_HD44780_IR_DISPLAY_CURSOR_HOME_SECONLINE
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_lcd_irwrite_4bits
;	ex3-serial-lcd-4bits.c:43: initialize_serial();
	lcall	_initialize_serial
;	ex3-serial-lcd-4bits.c:45: while(1);
00102$:
;	ex3-serial-lcd-4bits.c:46: }
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
_DATA_BUS_PULSE_INTERVAL:
	.byte #0x64, #0x00	;  100
_FIRST_LINE_BUFF:
	.ascii "MESSAGE:"
	.db 0x00
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
