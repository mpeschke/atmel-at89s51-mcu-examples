;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Mac OS X x86_64)
;--------------------------------------------------------
	.module hd44780
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _write
	.globl _command
	.globl _send
	.globl _write4bits
	.globl _write8bits
	.globl _pulse_enable
	.globl _mcs51_timer0_delay_16bit
	.globl __LCD_RS
	.globl __LCD_EN
	.globl __BUSY_FLAG
	.globl __LCD_IR_DR_BUS_6
	.globl __LCD_IR_DR_BUS_5
	.globl __LCD_IR_DR_BUS_4
	.globl __LCD_IR_DR_BUS_3
	.globl __LCD_IR_DR_BUS_2
	.globl __LCD_IR_DR_BUS_1
	.globl __LCD_IR_DR_BUS_0
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
	.globl _lcd_initialize_PARM_7
	.globl _lcd_initialize_PARM_6
	.globl _lcd_initialize_PARM_5
	.globl _lcd_initialize_PARM_4
	.globl _lcd_initialize_PARM_3
	.globl _lcd_initialize_PARM_2
	.globl _lcd_set_cursor_PARM_2
	.globl _send_PARM_2
	.globl _lcd_print
	.globl _lcd_clear
	.globl _lcd_set_cursor
	.globl _lcd_display_on
	.globl _lcd_display_off
	.globl _lcd_cursor_on
	.globl _lcd_cursor_off
	.globl _lcd_blink_on
	.globl _lcd_blink_off
	.globl _lcd_initialize
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
__LCD_IR_DR_BUS_0	=	0x0080
__LCD_IR_DR_BUS_1	=	0x0081
__LCD_IR_DR_BUS_2	=	0x0082
__LCD_IR_DR_BUS_3	=	0x0083
__LCD_IR_DR_BUS_4	=	0x0084
__LCD_IR_DR_BUS_5	=	0x0085
__LCD_IR_DR_BUS_6	=	0x0086
__BUSY_FLAG	=	0x0087
__LCD_EN	=	0x00a0
__LCD_RS	=	0x00a2
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
__DISPLAY_FUNC_SET:
	.ds 1
__DISPLAY_CONTROL:
	.ds 1
__DISPLAY_MODE:
	.ds 1
__DLAY_PE_PWEH:
	.ds 2
__DLAY_PE_TAH:
	.ds 2
__DLAY_CLEAR_DISPLAY_HOME:
	.ds 2
_send_PARM_2:
	.ds 1
_lcd_set_cursor_PARM_2:
	.ds 1
_lcd_initialize_PARM_2:
	.ds 2
_lcd_initialize_PARM_3:
	.ds 2
_lcd_initialize_PARM_4:
	.ds 2
_lcd_initialize_PARM_5:
	.ds 2
_lcd_initialize_PARM_6:
	.ds 2
_lcd_initialize_PARM_7:
	.ds 2
;--------------------------------------------------------
; overlayable items in internal ram
;--------------------------------------------------------
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;	../lib/hd44780.c:53: static unsigned char _DISPLAY_FUNC_SET              = 0x00;
	mov	__DISPLAY_FUNC_SET,#0x00
;	../lib/hd44780.c:54: static unsigned char _DISPLAY_CONTROL               = 0x00;
	mov	__DISPLAY_CONTROL,#0x00
;	../lib/hd44780.c:55: static unsigned char _DISPLAY_MODE                  = 0x00;
	mov	__DISPLAY_MODE,#0x00
;	../lib/hd44780.c:58: static unsigned int _DLAY_PE_PWEH                   = 0x0000;
	clr	a
	mov	__DLAY_PE_PWEH,a
	mov	(__DLAY_PE_PWEH + 1),a
;	../lib/hd44780.c:59: static unsigned int _DLAY_PE_TAH                    = 0x0000;
	mov	__DLAY_PE_TAH,a
	mov	(__DLAY_PE_TAH + 1),a
;	../lib/hd44780.c:60: static unsigned int _DLAY_CLEAR_DISPLAY_HOME        = 0x0000;
	mov	__DLAY_CLEAR_DISPLAY_HOME,a
	mov	(__DLAY_CLEAR_DISPLAY_HOME + 1),a
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
;Allocation info for local variables in function 'pulse_enable'
;------------------------------------------------------------
;	../lib/hd44780.c:72: void pulse_enable()
;	-----------------------------------------
;	 function pulse_enable
;	-----------------------------------------
_pulse_enable:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
;	../lib/hd44780.c:74: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:75: mcs51_timer0_delay_16bit(_DLAY_PE_PWEH);
	mov	dpl,__DLAY_PE_PWEH
	mov	dph,(__DLAY_PE_PWEH + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:76: _LCD_EN=1;
;	assignBit
	setb	__LCD_EN
;	../lib/hd44780.c:77: mcs51_timer0_delay_16bit(_DLAY_PE_PWEH);
	mov	dpl,__DLAY_PE_PWEH
	mov	dph,(__DLAY_PE_PWEH + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:78: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:79: mcs51_timer0_delay_16bit(_DLAY_PE_TAH);
	mov	dpl,__DLAY_PE_TAH
	mov	dph,(__DLAY_PE_TAH + 1)
;	../lib/hd44780.c:80: }
	ljmp	_mcs51_timer0_delay_16bit
;------------------------------------------------------------
;Allocation info for local variables in function 'write8bits'
;------------------------------------------------------------
;dr                        Allocated to registers 
;------------------------------------------------------------
;	../lib/hd44780.c:93: void write8bits(const unsigned char dr)
;	-----------------------------------------
;	 function write8bits
;	-----------------------------------------
_write8bits:
	mov	__LCD_IR_DR_BUS,dpl
;	../lib/hd44780.c:97: pulse_enable();
;	../lib/hd44780.c:98: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'write4bits'
;------------------------------------------------------------
;fourbits                  Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:111: void write4bits(const unsigned char fourbits)
;	-----------------------------------------
;	 function write4bits
;	-----------------------------------------
_write4bits:
;	../lib/hd44780.c:114: _LCD_IR_DR_BUS_4 = (fourbits & (1<<4));
	mov	a,dpl
	mov	r7,a
	swap	a
	anl	a,#0x01
;	assignBit
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_4,c
;	../lib/hd44780.c:115: _LCD_IR_DR_BUS_5 = (fourbits & (1<<5));
	mov	a,r7
	mov	c,acc[5]
	clr	a
	rlc	a
;	assignBit
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_5,c
;	../lib/hd44780.c:116: _LCD_IR_DR_BUS_6 = (fourbits & (1<<6));
	mov	a,r7
	rl	a
	rl	a
	anl	a,#0x01
;	assignBit
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_6,c
;	../lib/hd44780.c:117: _BUSY_FLAG       = (fourbits & (1<<7));
	mov	a,r7
	rl	a
	anl	a,#0x01
;	assignBit
	add	a,#0xff
	mov	__BUSY_FLAG,c
;	../lib/hd44780.c:118: pulse_enable();
;	../lib/hd44780.c:119: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'send'
;------------------------------------------------------------
;mode                      Allocated with name '_send_PARM_2'
;dr                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:133: void send(const unsigned char dr, const unsigned char mode)
;	-----------------------------------------
;	 function send
;	-----------------------------------------
_send:
	mov	r7,dpl
;	../lib/hd44780.c:135: _LCD_RS=mode;
;	assignBit
	mov	a,_send_PARM_2
	add	a,#0xff
	mov	__LCD_RS,c
;	../lib/hd44780.c:137: if (! (_DISPLAY_FUNC_SET & LCD_FUNCSET_8BITMODE))
	mov	dptr,#_LCD_FUNCSET_8BITMODE
	clr	a
	movc	a,@a+dptr
	anl	a,__DISPLAY_FUNC_SET
	jnz	00102$
;	../lib/hd44780.c:139: write4bits(dr);
	mov	dpl,r7
	push	ar7
	lcall	_write4bits
	pop	ar7
;	../lib/hd44780.c:140: write4bits(dr << 4);
	mov	ar6,r7
	mov	a,r6
	swap	a
	anl	a,#0xf0
	mov	dpl,a
	ljmp	_write4bits
00102$:
;	../lib/hd44780.c:144: write8bits(dr);
	mov	dpl,r7
;	../lib/hd44780.c:146: }
	ljmp	_write8bits
;------------------------------------------------------------
;Allocation info for local variables in function 'command'
;------------------------------------------------------------
;dr                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:154: void command(const unsigned char dr)
;	-----------------------------------------
;	 function command
;	-----------------------------------------
_command:
;	../lib/hd44780.c:156: send(dr, 0x00);
	mov	_send_PARM_2,#0x00
;	../lib/hd44780.c:157: }
	ljmp	_send
;------------------------------------------------------------
;Allocation info for local variables in function 'write'
;------------------------------------------------------------
;dr                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:165: void write(const unsigned char dr)
;	-----------------------------------------
;	 function write
;	-----------------------------------------
_write:
;	../lib/hd44780.c:167: send(dr, 0xFF);
	mov	_send_PARM_2,#0xff
;	../lib/hd44780.c:168: }
	ljmp	_send
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_print'
;------------------------------------------------------------
;pstr                      Allocated to registers r5 r6 r7 
;i                         Allocated to registers r4 
;------------------------------------------------------------
;	../lib/hd44780.c:170: void lcd_print(const unsigned char* pstr)
;	-----------------------------------------
;	 function lcd_print
;	-----------------------------------------
_lcd_print:
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	../lib/hd44780.c:173: for(i=0; pstr[i] != 0; i++)
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
;	../lib/hd44780.c:174: write(pstr[i]);
	mov	dpl,r3
	push	ar7
	push	ar6
	push	ar5
	push	ar4
	lcall	_write
	pop	ar4
	pop	ar5
	pop	ar6
	pop	ar7
;	../lib/hd44780.c:173: for(i=0; pstr[i] != 0; i++)
	inc	r4
	sjmp	00103$
00105$:
;	../lib/hd44780.c:175: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_clear'
;------------------------------------------------------------
;	../lib/hd44780.c:177: void lcd_clear()
;	-----------------------------------------
;	 function lcd_clear
;	-----------------------------------------
_lcd_clear:
;	../lib/hd44780.c:179: command(LCD_CLEARDISPLAY);  // clear display, set cursor position to zero
	mov	dptr,#_LCD_CLEARDISPLAY
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_command
;	../lib/hd44780.c:181: mcs51_timer0_delay_16bit(_DLAY_CLEAR_DISPLAY_HOME);
	mov	dpl,__DLAY_CLEAR_DISPLAY_HOME
	mov	dph,(__DLAY_CLEAR_DISPLAY_HOME + 1)
;	../lib/hd44780.c:182: }
	ljmp	_mcs51_timer0_delay_16bit
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_set_cursor'
;------------------------------------------------------------
;col                       Allocated with name '_lcd_set_cursor_PARM_2'
;row                       Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:184: void lcd_set_cursor(const unsigned char row, const unsigned char col)
;	-----------------------------------------
;	 function lcd_set_cursor
;	-----------------------------------------
_lcd_set_cursor:
;	../lib/hd44780.c:186: command(LCD_SETDDRAMADDR | (col + 0x40 * row));  // Set cursor position.
	mov	a,dpl
	rr	a
	rr	a
	anl	a,#0xc0
	mov	r6,_lcd_set_cursor_PARM_2
	add	a,r6
	mov	r7,a
	mov	dptr,#_LCD_SETDDRAMADDR
	clr	a
	movc	a,@a+dptr
	orl	a,r7
	mov	dpl,a
;	../lib/hd44780.c:187: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_display_on'
;------------------------------------------------------------
;	../lib/hd44780.c:189: void lcd_display_on()
;	-----------------------------------------
;	 function lcd_display_on
;	-----------------------------------------
_lcd_display_on:
;	../lib/hd44780.c:191: _DISPLAY_CONTROL |= LCD_DISPLAYON;
	mov	dptr,#_LCD_DISPLAYON
	clr	a
	movc	a,@a+dptr
	orl	__DISPLAY_CONTROL,a
;	../lib/hd44780.c:193: command(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn display ON
	mov	dptr,#_LCD_DISPLAYCONTROL
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_CONTROL
	mov	dpl,a
;	../lib/hd44780.c:194: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_display_off'
;------------------------------------------------------------
;	../lib/hd44780.c:196: void lcd_display_off()
;	-----------------------------------------
;	 function lcd_display_off
;	-----------------------------------------
_lcd_display_off:
;	../lib/hd44780.c:198: _DISPLAY_CONTROL &= ~LCD_DISPLAYON;
	mov	dptr,#_LCD_DISPLAYON
	clr	a
	movc	a,@a+dptr
	cpl	a
	anl	__DISPLAY_CONTROL,a
;	../lib/hd44780.c:200: command(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn display OFF
	mov	dptr,#_LCD_DISPLAYCONTROL
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_CONTROL
	mov	dpl,a
;	../lib/hd44780.c:201: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_cursor_on'
;------------------------------------------------------------
;	../lib/hd44780.c:203: void lcd_cursor_on()
;	-----------------------------------------
;	 function lcd_cursor_on
;	-----------------------------------------
_lcd_cursor_on:
;	../lib/hd44780.c:205: _DISPLAY_CONTROL |= LCD_CURSORON;
	mov	dptr,#_LCD_CURSORON
	clr	a
	movc	a,@a+dptr
	orl	__DISPLAY_CONTROL,a
;	../lib/hd44780.c:207: command(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor ON
	mov	dptr,#_LCD_DISPLAYCONTROL
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_CONTROL
	mov	dpl,a
;	../lib/hd44780.c:208: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_cursor_off'
;------------------------------------------------------------
;	../lib/hd44780.c:210: void lcd_cursor_off()
;	-----------------------------------------
;	 function lcd_cursor_off
;	-----------------------------------------
_lcd_cursor_off:
;	../lib/hd44780.c:212: _DISPLAY_CONTROL &= ~LCD_CURSORON;
	mov	dptr,#_LCD_CURSORON
	clr	a
	movc	a,@a+dptr
	cpl	a
	anl	__DISPLAY_CONTROL,a
;	../lib/hd44780.c:214: command(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor OFF
	mov	dptr,#_LCD_DISPLAYCONTROL
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_CONTROL
	mov	dpl,a
;	../lib/hd44780.c:215: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_blink_on'
;------------------------------------------------------------
;	../lib/hd44780.c:217: void lcd_blink_on()
;	-----------------------------------------
;	 function lcd_blink_on
;	-----------------------------------------
_lcd_blink_on:
;	../lib/hd44780.c:219: _DISPLAY_CONTROL |= LCD_BLINKON;
	mov	dptr,#_LCD_BLINKON
	clr	a
	movc	a,@a+dptr
	orl	__DISPLAY_CONTROL,a
;	../lib/hd44780.c:221: command(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor blinking ON
	mov	dptr,#_LCD_DISPLAYCONTROL
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_CONTROL
	mov	dpl,a
;	../lib/hd44780.c:222: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_blink_off'
;------------------------------------------------------------
;	../lib/hd44780.c:224: void lcd_blink_off()
;	-----------------------------------------
;	 function lcd_blink_off
;	-----------------------------------------
_lcd_blink_off:
;	../lib/hd44780.c:226: _DISPLAY_CONTROL &= ~LCD_BLINKON;
	mov	dptr,#_LCD_BLINKON
	clr	a
	movc	a,@a+dptr
	cpl	a
	anl	__DISPLAY_CONTROL,a
;	../lib/hd44780.c:228: command(LCD_DISPLAYCONTROL | _DISPLAY_CONTROL);  // Turn cursor blinking OFF
	mov	dptr,#_LCD_DISPLAYCONTROL
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_CONTROL
	mov	dpl,a
;	../lib/hd44780.c:229: }
	ljmp	_command
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_initialize'
;------------------------------------------------------------
;lcd_dlay_pe_pweh          Allocated with name '_lcd_initialize_PARM_2'
;lcd_dlay_pe_tah           Allocated with name '_lcd_initialize_PARM_3'
;lcd_dlay_init_3rd         Allocated with name '_lcd_initialize_PARM_4'
;lcd_dlay_clear_display_home Allocated with name '_lcd_initialize_PARM_5'
;lcd_dlay_init_1st_2nd     Allocated with name '_lcd_initialize_PARM_6'
;lcd_dlay_init             Allocated with name '_lcd_initialize_PARM_7'
;lcd_display_function_set  Allocated to registers 
;------------------------------------------------------------
;	../lib/hd44780.c:231: void lcd_initialize(
;	-----------------------------------------
;	 function lcd_initialize
;	-----------------------------------------
_lcd_initialize:
	mov	__DISPLAY_FUNC_SET,dpl
;	../lib/hd44780.c:241: _DLAY_PE_PWEH               = lcd_dlay_pe_pweh;
	mov	__DLAY_PE_PWEH,_lcd_initialize_PARM_2
	mov	(__DLAY_PE_PWEH + 1),(_lcd_initialize_PARM_2 + 1)
;	../lib/hd44780.c:242: _DLAY_PE_TAH                = lcd_dlay_pe_tah;
	mov	__DLAY_PE_TAH,_lcd_initialize_PARM_3
	mov	(__DLAY_PE_TAH + 1),(_lcd_initialize_PARM_3 + 1)
;	../lib/hd44780.c:243: _DLAY_CLEAR_DISPLAY_HOME    = lcd_dlay_clear_display_home;
	mov	__DLAY_CLEAR_DISPLAY_HOME,_lcd_initialize_PARM_5
	mov	(__DLAY_CLEAR_DISPLAY_HOME + 1),(_lcd_initialize_PARM_5 + 1)
;	../lib/hd44780.c:246: mcs51_timer0_delay_16bit(lcd_dlay_init);
	mov	dpl,_lcd_initialize_PARM_7
	mov	dph,(_lcd_initialize_PARM_7 + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:248: _LCD_RS=0;
;	assignBit
	clr	__LCD_RS
;	../lib/hd44780.c:249: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:251: if (! (_DISPLAY_FUNC_SET & LCD_FUNCSET_8BITMODE)) {
	mov	dptr,#_LCD_FUNCSET_8BITMODE
	clr	a
	movc	a,@a+dptr
	anl	a,__DISPLAY_FUNC_SET
	jnz	00102$
;	../lib/hd44780.c:253: write4bits(0x03);
	mov	dpl,#0x03
	lcall	_write4bits
;	../lib/hd44780.c:254: mcs51_timer0_delay_16bit(lcd_dlay_init_1st_2nd);
	mov	dpl,_lcd_initialize_PARM_6
	mov	dph,(_lcd_initialize_PARM_6 + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:257: write4bits(0x03);
	mov	dpl,#0x03
	lcall	_write4bits
;	../lib/hd44780.c:258: mcs51_timer0_delay_16bit(lcd_dlay_init_1st_2nd);
	mov	dpl,_lcd_initialize_PARM_6
	mov	dph,(_lcd_initialize_PARM_6 + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:261: write4bits(0x03);
	mov	dpl,#0x03
	lcall	_write4bits
;	../lib/hd44780.c:262: mcs51_timer0_delay_16bit(lcd_dlay_init_3rd);
	mov	dpl,_lcd_initialize_PARM_4
	mov	dph,(_lcd_initialize_PARM_4 + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:265: write4bits(LCD_ENABLE_4BIT);
	mov	dptr,#_LCD_ENABLE_4BIT
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_write4bits
	sjmp	00103$
00102$:
;	../lib/hd44780.c:271: command(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
	mov	dptr,#_LCD_FUNCTIONSET
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_FUNC_SET
	mov	dpl,a
	lcall	_command
;	../lib/hd44780.c:272: mcs51_timer0_delay_16bit(lcd_dlay_init_1st_2nd);
	mov	dpl,_lcd_initialize_PARM_6
	mov	dph,(_lcd_initialize_PARM_6 + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:275: command(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
	mov	dptr,#_LCD_FUNCTIONSET
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_FUNC_SET
	mov	dpl,a
	lcall	_command
;	../lib/hd44780.c:276: mcs51_timer0_delay_16bit(lcd_dlay_init_3rd);
	mov	dpl,_lcd_initialize_PARM_4
	mov	dph,(_lcd_initialize_PARM_4 + 1)
	lcall	_mcs51_timer0_delay_16bit
;	../lib/hd44780.c:279: command(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
	mov	dptr,#_LCD_FUNCTIONSET
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_FUNC_SET
	mov	dpl,a
	lcall	_command
00103$:
;	../lib/hd44780.c:283: command(LCD_FUNCTIONSET | _DISPLAY_FUNC_SET);
	mov	dptr,#_LCD_FUNCTIONSET
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_FUNC_SET
	mov	dpl,a
	lcall	_command
;	../lib/hd44780.c:285: lcd_display_on();
	lcall	_lcd_display_on
;	../lib/hd44780.c:287: lcd_clear();
	lcall	_lcd_clear
;	../lib/hd44780.c:290: _DISPLAY_MODE = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
	mov	dptr,#_LCD_ENTRYLEFT
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	mov	dptr,#_LCD_ENTRYSHIFTDECREMENT
	clr	a
	movc	a,@a+dptr
	orl	a,r7
	mov	__DISPLAY_MODE,a
;	../lib/hd44780.c:292: command(LCD_ENTRYMODESET | _DISPLAY_MODE);
	mov	dptr,#_LCD_ENTRYMODESET
	clr	a
	movc	a,@a+dptr
	orl	a,__DISPLAY_MODE
	mov	dpl,a
;	../lib/hd44780.c:293: }
	ljmp	_command
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
_LCD_ENTRYSHIFTDECREMENT:
	.db #0x00	; 0
_LCD_CLEARDISPLAY:
	.db #0x01	; 1
_LCD_ENTRYLEFT:
	.db #0x02	; 2
_LCD_ENABLE_4BIT:
	.db #0x02	; 2
_LCD_DISPLAYCONTROL:
	.db #0x08	; 8
_LCD_FUNCTIONSET:
	.db #0x20	; 32
_LCD_ENTRYMODESET:
	.db #0x04	; 4
_LCD_SETDDRAMADDR:
	.db #0x80	; 128
_LCD_BLINKOFF:
	.db #0x00	; 0
_LCD_CURSOROFF:
	.db #0x00	; 0
_LCD_DISPLAYOFF:
	.db #0x00	; 0
_LCD_BLINKON:
	.db #0x01	; 1
_LCD_CURSORON:
	.db #0x02	; 2
_LCD_DISPLAYON:
	.db #0x04	; 4
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
