;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module hd44780
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wait_until_not_busy
	.globl _data_register_write_internal_operation
	.globl _instruction_register_write_internal_operation
	.globl _instruction_register_read_busyflag_or_add_counter
	.globl _pulse_enable
	.globl _delay
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
	.globl __LCD_IR_DR_BUS
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
	.globl __LCD_RS
	.globl __LCD_RW
	.globl __LCD_EN
	.globl __BUSY_FLAG
	.globl _LCD_set_busyflag_check_delay
	.globl _LCD_IRWrite
	.globl _LCD_DRWrite
	.globl _LCD_StringWrite
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
__LCD_IR_DR_BUS	=	0x0080
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
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_DELAY:
	.ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
	.area	OSEG    (OVR,DATA)
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
__BUSY_FLAG	=	0x0087
__LCD_EN	=	0x00a0
__LCD_RW	=	0x00a1
__LCD_RS	=	0x00a2
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;	../lib/hd44780.c:10: static int DELAY = 500;
	mov	_DELAY,#0xf4
	mov	(_DELAY + 1),#0x01
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_set_busyflag_check_delay'
;------------------------------------------------------------
;delay                     Allocated to registers 
;------------------------------------------------------------
;	../lib/hd44780.c:16: void LCD_set_busyflag_check_delay(int delay)
;	-----------------------------------------
;	 function LCD_set_busyflag_check_delay
;	-----------------------------------------
_LCD_set_busyflag_check_delay:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
	mov	_DELAY,dpl
	mov	(_DELAY + 1),dph
;	../lib/hd44780.c:17: { DELAY = delay; }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'delay'
;------------------------------------------------------------
;i                         Allocated to registers r6 r7 
;------------------------------------------------------------
;	../lib/hd44780.c:21: void delay()
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
;	../lib/hd44780.c:24: for(i=0; i < DELAY; i++);
	mov	r6,#0x00
	mov	r7,#0x00
00103$:
	clr	c
	mov	a,r6
	subb	a,_DELAY
	mov	a,r7
	xrl	a,#0x80
	mov	b,(_DELAY + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	00105$
	inc	r6
	cjne	r6,#0x00,00103$
	inc	r7
	sjmp	00103$
00105$:
;	../lib/hd44780.c:25: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'pulse_enable'
;------------------------------------------------------------
;	../lib/hd44780.c:28: void pulse_enable()
;	-----------------------------------------
;	 function pulse_enable
;	-----------------------------------------
_pulse_enable:
;	../lib/hd44780.c:30: _LCD_EN=HIGH;
	mov	dptr,#_HIGH
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_EN,c
;	../lib/hd44780.c:31: _LCD_EN=LOW;
	mov	dptr,#_LOW
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_EN,c
;	../lib/hd44780.c:32: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'instruction_register_read_busyflag_or_add_counter'
;------------------------------------------------------------
;	../lib/hd44780.c:35: void instruction_register_read_busyflag_or_add_counter()
;	-----------------------------------------
;	 function instruction_register_read_busyflag_or_add_counter
;	-----------------------------------------
_instruction_register_read_busyflag_or_add_counter:
;	../lib/hd44780.c:37: _LCD_RS=LOW;
	mov	dptr,#_LOW
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_RS,c
;	../lib/hd44780.c:38: _LCD_RW=HIGH;
	mov	dptr,#_HIGH
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_RW,c
;	../lib/hd44780.c:39: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'instruction_register_write_internal_operation'
;------------------------------------------------------------
;	../lib/hd44780.c:42: void instruction_register_write_internal_operation()
;	-----------------------------------------
;	 function instruction_register_write_internal_operation
;	-----------------------------------------
_instruction_register_write_internal_operation:
;	../lib/hd44780.c:44: _LCD_RS=LOW;
	mov	dptr,#_LOW
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	clr	a
	rlc	a
;	assignBit
	mov	r7,a
	add	a,#0xff
	mov	__LCD_RS,c
;	../lib/hd44780.c:45: _LCD_RW=LOW;
;	assignBit
	mov	a,r7
	add	a,#0xff
	mov	__LCD_RW,c
;	../lib/hd44780.c:46: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'data_register_write_internal_operation'
;------------------------------------------------------------
;	../lib/hd44780.c:49: void data_register_write_internal_operation()
;	-----------------------------------------
;	 function data_register_write_internal_operation
;	-----------------------------------------
_data_register_write_internal_operation:
;	../lib/hd44780.c:51: _LCD_RS=HIGH;
	mov	dptr,#_HIGH
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_RS,c
;	../lib/hd44780.c:52: _LCD_RW=LOW;
	mov	dptr,#_LOW
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_RW,c
;	../lib/hd44780.c:53: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_until_not_busy'
;------------------------------------------------------------
;	../lib/hd44780.c:65: void wait_until_not_busy()
;	-----------------------------------------
;	 function wait_until_not_busy
;	-----------------------------------------
_wait_until_not_busy:
;	../lib/hd44780.c:67: instruction_register_read_busyflag_or_add_counter();
	lcall	_instruction_register_read_busyflag_or_add_counter
;	../lib/hd44780.c:69: _LCD_EN=HIGH;
	mov	dptr,#_HIGH
	clr	a
	movc	a,@a+dptr
;	assignBit
	mov	r7,a
	add	a,#0xff
	mov	__LCD_EN,c
;	../lib/hd44780.c:71: do {
00101$:
;	../lib/hd44780.c:72: delay();
	lcall	_delay
;	../lib/hd44780.c:73: } while (_BUSY_FLAG);
	jb	__BUSY_FLAG,00101$
;	../lib/hd44780.c:75: _LCD_EN=LOW;
	mov	dptr,#_LOW
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	__LCD_EN,c
;	../lib/hd44780.c:76: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_IRWrite'
;------------------------------------------------------------
;ir                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:78: void LCD_IRWrite(unsigned char ir)
;	-----------------------------------------
;	 function LCD_IRWrite
;	-----------------------------------------
_LCD_IRWrite:
	mov	r7,dpl
;	../lib/hd44780.c:80: wait_until_not_busy();
	push	ar7
	lcall	_wait_until_not_busy
	pop	ar7
;	../lib/hd44780.c:82: _LCD_IR_DR_BUS=ir;
	mov	__LCD_IR_DR_BUS,r7
;	../lib/hd44780.c:83: instruction_register_write_internal_operation();
	lcall	_instruction_register_write_internal_operation
;	../lib/hd44780.c:84: pulse_enable();
;	../lib/hd44780.c:85: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_DRWrite'
;------------------------------------------------------------
;dr                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:87: void LCD_DRWrite(unsigned char dr)
;	-----------------------------------------
;	 function LCD_DRWrite
;	-----------------------------------------
_LCD_DRWrite:
	mov	r7,dpl
;	../lib/hd44780.c:89: wait_until_not_busy();
	push	ar7
	lcall	_wait_until_not_busy
	pop	ar7
;	../lib/hd44780.c:91: _LCD_IR_DR_BUS=dr;
	mov	__LCD_IR_DR_BUS,r7
;	../lib/hd44780.c:92: data_register_write_internal_operation();
	lcall	_data_register_write_internal_operation
;	../lib/hd44780.c:93: pulse_enable();
;	../lib/hd44780.c:94: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_StringWrite'
;------------------------------------------------------------
;pstr                      Allocated to registers r5 r6 r7 
;i                         Allocated to registers r4 
;------------------------------------------------------------
;	../lib/hd44780.c:96: void LCD_StringWrite(unsigned char* pstr)
;	-----------------------------------------
;	 function LCD_StringWrite
;	-----------------------------------------
_LCD_StringWrite:
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	../lib/hd44780.c:99: for(i=0; pstr[i] != 0; i++)
	mov	r4,#0x00
00103$:
	mov	a,r4
	add	a,r5
	mov	r1,a
	clr	a
	addc	a,r6
	mov	r2,a
	mov	ar3,r7
	mov	dpl,r1
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r3,a
	jz	00105$
;	../lib/hd44780.c:100: LCD_DRWrite(pstr[i]);
	mov	dpl,r3
	push	ar7
	push	ar6
	push	ar5
	push	ar4
	lcall	_LCD_DRWrite
	pop	ar4
	pop	ar5
	pop	ar6
	pop	ar7
;	../lib/hd44780.c:99: for(i=0; pstr[i] != 0; i++)
	inc	r4
	sjmp	00103$
00105$:
;	../lib/hd44780.c:101: }
	ret
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
_HIGH:
	.db #0xff	; 255
_LOW:
	.db #0x00	; 0
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
