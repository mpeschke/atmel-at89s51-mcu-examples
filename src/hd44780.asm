;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module hd44780
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _lcd_drwrite_4bits
	.globl _lcd_irwrite_4bits_bus
	.globl _lcd_drwrite
	.globl _wait_until_not_busy
	.globl _data_register_write_internal_operation
	.globl _instruction_register_write_internal_operation
	.globl _instruction_register_read_busyflag_or_add_counter
	.globl _pulse_enable
	.globl _mcs51_timer0_delay
	.globl __LCD_RS
	.globl __LCD_RW
	.globl __LCD_EN
	.globl __BUSY_FLAG
	.globl __LCD_IR_DR_BUS_6
	.globl __LCD_IR_DR_BUS_5
	.globl __LCD_IR_DR_BUS_4
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
	.globl _initialize_PARM_2
	.globl _clear
	.globl _lcd_irwrite
	.globl _lcd_stringwrite
	.globl _lcd_drwrite_4bits_bus
	.globl _lcd_irwrite_4bits
	.globl _lcd_stringwrite_4bits
	.globl _initialize
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
__LCD_IR_DR_BUS_4	=	0x0084
__LCD_IR_DR_BUS_5	=	0x0085
__LCD_IR_DR_BUS_6	=	0x0086
__BUSY_FLAG	=	0x0087
__LCD_EN	=	0x00a0
__LCD_RW	=	0x00a1
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
__PULSE_ENABLE_PWEH_HIGH:
	.ds 1
__PULSE_ENABLE_PWEH_LOW:
	.ds 1
__displayfunction:
	.ds 1
__displaycontrol:
	.ds 1
__displaymode:
	.ds 1
_initialize_PARM_2:
	.ds 1
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
;	../lib/hd44780.c:36: static unsigned char _PULSE_ENABLE_PWEH_HIGH    = 0;
	mov	__PULSE_ENABLE_PWEH_HIGH,#0x00
;	../lib/hd44780.c:37: static unsigned char _PULSE_ENABLE_PWEH_LOW     = 0;
	mov	__PULSE_ENABLE_PWEH_LOW,#0x00
;	../lib/hd44780.c:38: static unsigned char _displayfunction     = 0x00;
	mov	__displayfunction,#0x00
;	../lib/hd44780.c:39: static unsigned char _displaycontrol = 0x00;
	mov	__displaycontrol,#0x00
;	../lib/hd44780.c:40: static unsigned char _displaymode = 0x00;
	mov	__displaymode,#0x00
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
;Allocation info for local variables in function 'clear'
;------------------------------------------------------------
;	../lib/hd44780.c:42: void clear()
;	-----------------------------------------
;	 function clear
;	-----------------------------------------
_clear:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
;	../lib/hd44780.c:44: lcd_irwrite_4bits(LCD_CLEARDISPLAY);  // clear display, set cursor position to zero
	mov	dpl,#0x01
	lcall	_lcd_irwrite_4bits
;	../lib/hd44780.c:47: mcs51_timer0_delay(0xF9, 0x7C);
	mov	_mcs51_timer0_delay_PARM_2,#0x7c
	mov	dpl,#0xf9
;	../lib/hd44780.c:48: }
	ljmp	_mcs51_timer0_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'pulse_enable'
;------------------------------------------------------------
;	../lib/hd44780.c:51: void pulse_enable()
;	-----------------------------------------
;	 function pulse_enable
;	-----------------------------------------
_pulse_enable:
;	../lib/hd44780.c:53: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:54: mcs51_timer0_delay(_PULSE_ENABLE_PWEH_HIGH, _PULSE_ENABLE_PWEH_LOW);
	mov	_mcs51_timer0_delay_PARM_2,__PULSE_ENABLE_PWEH_LOW
	mov	dpl,__PULSE_ENABLE_PWEH_HIGH
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:55: _LCD_EN=1;
;	assignBit
	setb	__LCD_EN
;	../lib/hd44780.c:56: mcs51_timer0_delay(_PULSE_ENABLE_PWEH_HIGH, _PULSE_ENABLE_PWEH_LOW);
	mov	_mcs51_timer0_delay_PARM_2,__PULSE_ENABLE_PWEH_LOW
	mov	dpl,__PULSE_ENABLE_PWEH_HIGH
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:57: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:60: mcs51_timer0_delay(0xFF, 0xAB);
	mov	_mcs51_timer0_delay_PARM_2,#0xab
	mov	dpl,#0xff
;	../lib/hd44780.c:61: }
	ljmp	_mcs51_timer0_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'instruction_register_read_busyflag_or_add_counter'
;------------------------------------------------------------
;	../lib/hd44780.c:64: void instruction_register_read_busyflag_or_add_counter()
;	-----------------------------------------
;	 function instruction_register_read_busyflag_or_add_counter
;	-----------------------------------------
_instruction_register_read_busyflag_or_add_counter:
;	../lib/hd44780.c:66: _LCD_RS=0;
;	assignBit
	clr	__LCD_RS
;	../lib/hd44780.c:67: _LCD_RW=1;
;	assignBit
	setb	__LCD_RW
;	../lib/hd44780.c:68: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'instruction_register_write_internal_operation'
;------------------------------------------------------------
;	../lib/hd44780.c:71: void instruction_register_write_internal_operation()
;	-----------------------------------------
;	 function instruction_register_write_internal_operation
;	-----------------------------------------
_instruction_register_write_internal_operation:
;	../lib/hd44780.c:73: _LCD_RS=0;
;	assignBit
	clr	__LCD_RS
;	../lib/hd44780.c:74: _LCD_RW=0;
;	assignBit
	clr	__LCD_RW
;	../lib/hd44780.c:75: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'data_register_write_internal_operation'
;------------------------------------------------------------
;	../lib/hd44780.c:78: void data_register_write_internal_operation()
;	-----------------------------------------
;	 function data_register_write_internal_operation
;	-----------------------------------------
_data_register_write_internal_operation:
;	../lib/hd44780.c:80: _LCD_RS=1;
;	assignBit
	setb	__LCD_RS
;	../lib/hd44780.c:81: _LCD_RW=0;
;	assignBit
	clr	__LCD_RW
;	../lib/hd44780.c:82: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_until_not_busy'
;------------------------------------------------------------
;	../lib/hd44780.c:94: void wait_until_not_busy()
;	-----------------------------------------
;	 function wait_until_not_busy
;	-----------------------------------------
_wait_until_not_busy:
;	../lib/hd44780.c:96: instruction_register_read_busyflag_or_add_counter();
	lcall	_instruction_register_read_busyflag_or_add_counter
;	../lib/hd44780.c:98: _LCD_EN=1;
;	assignBit
	setb	__LCD_EN
;	../lib/hd44780.c:100: while (_BUSY_FLAG) {
00101$:
	jb	__BUSY_FLAG,00101$
;	../lib/hd44780.c:104: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:105: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_irwrite'
;------------------------------------------------------------
;ir                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:107: void lcd_irwrite(const unsigned char ir)
;	-----------------------------------------
;	 function lcd_irwrite
;	-----------------------------------------
_lcd_irwrite:
	mov	r7,dpl
;	../lib/hd44780.c:109: wait_until_not_busy();
	push	ar7
	lcall	_wait_until_not_busy
;	../lib/hd44780.c:111: instruction_register_write_internal_operation();
	lcall	_instruction_register_write_internal_operation
	pop	ar7
;	../lib/hd44780.c:112: _LCD_IR_DR_BUS=ir;
	mov	__LCD_IR_DR_BUS,r7
;	../lib/hd44780.c:113: pulse_enable();
;	../lib/hd44780.c:114: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_drwrite'
;------------------------------------------------------------
;dr                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:119: void lcd_drwrite(const unsigned char dr)
;	-----------------------------------------
;	 function lcd_drwrite
;	-----------------------------------------
_lcd_drwrite:
	mov	r7,dpl
;	../lib/hd44780.c:121: wait_until_not_busy();
	push	ar7
	lcall	_wait_until_not_busy
;	../lib/hd44780.c:123: data_register_write_internal_operation();
	lcall	_data_register_write_internal_operation
	pop	ar7
;	../lib/hd44780.c:124: _LCD_IR_DR_BUS=dr;
	mov	__LCD_IR_DR_BUS,r7
;	../lib/hd44780.c:125: pulse_enable();
;	../lib/hd44780.c:126: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_stringwrite'
;------------------------------------------------------------
;pstr                      Allocated to registers r5 r6 r7 
;i                         Allocated to registers r4 
;------------------------------------------------------------
;	../lib/hd44780.c:128: void lcd_stringwrite(const unsigned char* pstr)
;	-----------------------------------------
;	 function lcd_stringwrite
;	-----------------------------------------
_lcd_stringwrite:
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	../lib/hd44780.c:131: for(i=0; pstr[i] != 0; i++)
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
;	../lib/hd44780.c:132: lcd_drwrite(pstr[i]);
	mov	dpl,r3
	push	ar7
	push	ar6
	push	ar5
	push	ar4
	lcall	_lcd_drwrite
	pop	ar4
	pop	ar5
	pop	ar6
	pop	ar7
;	../lib/hd44780.c:131: for(i=0; pstr[i] != 0; i++)
	inc	r4
	sjmp	00103$
00105$:
;	../lib/hd44780.c:133: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_irwrite_4bits_bus'
;------------------------------------------------------------
;highorderbits             Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:141: void lcd_irwrite_4bits_bus(const unsigned char highorderbits)
;	-----------------------------------------
;	 function lcd_irwrite_4bits_bus
;	-----------------------------------------
_lcd_irwrite_4bits_bus:
	mov	r7,dpl
;	../lib/hd44780.c:145: instruction_register_write_internal_operation();
	push	ar7
	lcall	_instruction_register_write_internal_operation
	pop	ar7
;	../lib/hd44780.c:146: _LCD_IR_DR_BUS_4 = (highorderbits & (1<<4));
	mov	a,r7
	swap	a
	anl	a,#0x01
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_4,c
;	../lib/hd44780.c:147: _LCD_IR_DR_BUS_5 = (highorderbits & (1<<5));
	mov	a,r7
	mov	c,acc[5]
	clr	a
	rlc	a
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_5,c
;	../lib/hd44780.c:148: _LCD_IR_DR_BUS_6 = (highorderbits & (1<<6));
	mov	a,r7
	rl	a
	rl	a
	anl	a,#0x01
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_6,c
;	../lib/hd44780.c:149: _BUSY_FLAG       = (highorderbits & (1<<7));
	mov	a,r7
	rl	a
	anl	a,#0x01
	add	a,#0xff
	mov	__BUSY_FLAG,c
;	../lib/hd44780.c:150: pulse_enable();
;	../lib/hd44780.c:151: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_drwrite_4bits_bus'
;------------------------------------------------------------
;highorderbits             Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:153: void lcd_drwrite_4bits_bus(const unsigned char highorderbits)
;	-----------------------------------------
;	 function lcd_drwrite_4bits_bus
;	-----------------------------------------
_lcd_drwrite_4bits_bus:
	mov	r7,dpl
;	../lib/hd44780.c:157: data_register_write_internal_operation();
	push	ar7
	lcall	_data_register_write_internal_operation
	pop	ar7
;	../lib/hd44780.c:158: _LCD_IR_DR_BUS_4 = (highorderbits & (1<<4));
	mov	a,r7
	swap	a
	anl	a,#0x01
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_4,c
;	../lib/hd44780.c:159: _LCD_IR_DR_BUS_5 = (highorderbits & (1<<5));
	mov	a,r7
	mov	c,acc[5]
	clr	a
	rlc	a
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_5,c
;	../lib/hd44780.c:160: _LCD_IR_DR_BUS_6 = (highorderbits & (1<<6));
	mov	a,r7
	rl	a
	rl	a
	anl	a,#0x01
	add	a,#0xff
	mov	__LCD_IR_DR_BUS_6,c
;	../lib/hd44780.c:161: _BUSY_FLAG       = (highorderbits & (1<<7));
	mov	a,r7
	rl	a
	anl	a,#0x01
	add	a,#0xff
	mov	__BUSY_FLAG,c
;	../lib/hd44780.c:162: pulse_enable();
;	../lib/hd44780.c:163: }
	ljmp	_pulse_enable
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_irwrite_4bits'
;------------------------------------------------------------
;ir                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:165: void lcd_irwrite_4bits(const unsigned char ir)
;	-----------------------------------------
;	 function lcd_irwrite_4bits
;	-----------------------------------------
_lcd_irwrite_4bits:
;	../lib/hd44780.c:167: lcd_irwrite_4bits_bus(ir);      // Send first the upper 4 bits.
	mov  r7,dpl
	push	ar7
	lcall	_lcd_irwrite_4bits_bus
	pop	ar7
;	../lib/hd44780.c:168: lcd_irwrite_4bits_bus(ir << 4); // and then the lower 4 bits.
	mov	a,r7
	swap	a
	anl	a,#0xf0
	mov	dpl,a
;	../lib/hd44780.c:169: }
	ljmp	_lcd_irwrite_4bits_bus
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_drwrite_4bits'
;------------------------------------------------------------
;dr                        Allocated to registers r7 
;------------------------------------------------------------
;	../lib/hd44780.c:171: void lcd_drwrite_4bits(const unsigned char dr)
;	-----------------------------------------
;	 function lcd_drwrite_4bits
;	-----------------------------------------
_lcd_drwrite_4bits:
;	../lib/hd44780.c:173: lcd_drwrite_4bits_bus(dr);      // Send first the upper 4 bits.
	mov  r7,dpl
	push	ar7
	lcall	_lcd_drwrite_4bits_bus
	pop	ar7
;	../lib/hd44780.c:174: lcd_drwrite_4bits_bus(dr << 4); // and then the lower 4 bits.
	mov	a,r7
	swap	a
	anl	a,#0xf0
	mov	dpl,a
;	../lib/hd44780.c:175: }
	ljmp	_lcd_drwrite_4bits_bus
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_stringwrite_4bits'
;------------------------------------------------------------
;pstr                      Allocated to registers r5 r6 r7 
;i                         Allocated to registers r4 
;------------------------------------------------------------
;	../lib/hd44780.c:177: void lcd_stringwrite_4bits(const unsigned char* pstr)
;	-----------------------------------------
;	 function lcd_stringwrite_4bits
;	-----------------------------------------
_lcd_stringwrite_4bits:
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	../lib/hd44780.c:180: for(i=0; pstr[i] != 0; i++)
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
;	../lib/hd44780.c:181: lcd_drwrite_4bits(pstr[i]);
	mov	dpl,r3
	push	ar7
	push	ar6
	push	ar5
	push	ar4
	lcall	_lcd_drwrite_4bits
	pop	ar4
	pop	ar5
	pop	ar6
	pop	ar7
;	../lib/hd44780.c:180: for(i=0; pstr[i] != 0; i++)
	inc	r4
	sjmp	00103$
00105$:
;	../lib/hd44780.c:182: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'initialize'
;------------------------------------------------------------
;pulse_enable_pweh_low     Allocated with name '_initialize_PARM_2'
;pulse_enable_pweh_high    Allocated to registers 
;------------------------------------------------------------
;	../lib/hd44780.c:187: void initialize(const unsigned char pulse_enable_pweh_high, const unsigned char pulse_enable_pweh_low)
;	-----------------------------------------
;	 function initialize
;	-----------------------------------------
_initialize:
	mov	__PULSE_ENABLE_PWEH_HIGH,dpl
;	../lib/hd44780.c:190: _PULSE_ENABLE_PWEH_LOW     = pulse_enable_pweh_low;
	mov	__PULSE_ENABLE_PWEH_LOW,_initialize_PARM_2
;	../lib/hd44780.c:192: _displayfunction = LCD_4BITMODE | LCD_2LINE | LCD_5x8DOTS;
	mov	__displayfunction,#0x08
;	../lib/hd44780.c:195: mcs51_timer0_delay(0x5D, 0x3C);
	mov	_mcs51_timer0_delay_PARM_2,#0x3c
	mov	dpl,#0x5d
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:196: _LCD_RS=0;
;	assignBit
	clr	__LCD_RS
;	../lib/hd44780.c:197: _LCD_RW=0;
;	assignBit
	clr	__LCD_RW
;	../lib/hd44780.c:198: _LCD_EN=0;
;	assignBit
	clr	__LCD_EN
;	../lib/hd44780.c:200: if (! (_displayfunction & LCD_8BITMODE)) {
	mov	a,__displayfunction
	jb	acc.4,00102$
;	../lib/hd44780.c:205: lcd_irwrite_4bits_bus(0x03);
	mov	dpl,#0x03
	lcall	_lcd_irwrite_4bits_bus
;	../lib/hd44780.c:208: mcs51_timer0_delay(0xF1, 0x59);
	mov	_mcs51_timer0_delay_PARM_2,#0x59
	mov	dpl,#0xf1
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:211: lcd_irwrite_4bits_bus(0x03);
	mov	dpl,#0x03
	lcall	_lcd_irwrite_4bits_bus
;	../lib/hd44780.c:214: mcs51_timer0_delay(0xF1, 0x59);
	mov	_mcs51_timer0_delay_PARM_2,#0x59
	mov	dpl,#0xf1
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:217: lcd_irwrite_4bits_bus(0x03);
	mov	dpl,#0x03
	lcall	_lcd_irwrite_4bits_bus
;	../lib/hd44780.c:220: mcs51_timer0_delay(0xFF, 0x82);
	mov	_mcs51_timer0_delay_PARM_2,#0x82
	mov	dpl,#0xff
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:223: lcd_irwrite_4bits_bus(0x02);
	mov	dpl,#0x02
	lcall	_lcd_irwrite_4bits_bus
	sjmp	00103$
00102$:
;	../lib/hd44780.c:229: lcd_irwrite(LCD_FUNCTIONSET | _displayfunction);
	mov	r6,__displayfunction
	orl	ar6,#0x20
	mov	dpl,r6
	lcall	_lcd_irwrite
;	../lib/hd44780.c:232: mcs51_timer0_delay(0xF1, 0x59);
	mov	_mcs51_timer0_delay_PARM_2,#0x59
	mov	dpl,#0xf1
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:235: lcd_irwrite(LCD_FUNCTIONSET | _displayfunction);
	mov	r6,__displayfunction
	orl	ar6,#0x20
	mov	dpl,r6
	lcall	_lcd_irwrite
;	../lib/hd44780.c:238: mcs51_timer0_delay(0xFF, 0x82);
	mov	_mcs51_timer0_delay_PARM_2,#0x82
	mov	dpl,#0xff
	lcall	_mcs51_timer0_delay
;	../lib/hd44780.c:241: lcd_irwrite(LCD_FUNCTIONSET | _displayfunction);
	mov	r6,__displayfunction
	orl	ar6,#0x20
	mov	dpl,r6
	lcall	_lcd_irwrite
00103$:
;	../lib/hd44780.c:245: lcd_irwrite_4bits(LCD_FUNCTIONSET | _displayfunction);
	mov	r6,__displayfunction
	orl	ar6,#0x20
	mov	dpl,r6
	lcall	_lcd_irwrite_4bits
;	../lib/hd44780.c:248: _displaycontrol |= LCD_DISPLAYON;
	mov	__displaycontrol,#0x04
;	../lib/hd44780.c:249: lcd_irwrite_4bits(LCD_DISPLAYCONTROL | _displaycontrol);
	mov	dpl,#0x0c
	lcall	_lcd_irwrite_4bits
;	../lib/hd44780.c:251: clear();
	lcall	_clear
;	../lib/hd44780.c:254: _displaymode = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
	mov	__displaymode,#0x02
;	../lib/hd44780.c:256: lcd_irwrite_4bits(LCD_ENTRYMODESET | _displaymode);
	mov	dpl,#0x06
;	../lib/hd44780.c:257: }
	ljmp	_lcd_irwrite_4bits
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
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
