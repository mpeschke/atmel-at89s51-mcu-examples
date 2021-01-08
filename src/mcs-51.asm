;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module mcs_51
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mcs51_timer1_delay_PARM_2
	.globl _mcs51_timer0_delay_PARM_2
	.globl _mcs51_timer1_delay
	.globl _mcs51_timer0_delay
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
	.globl _mcs51_mult_max_timer1_delay_PARM_3
	.globl _mcs51_mult_max_timer1_delay_PARM_2
	.globl _mcs51_mult_max_timer0_delay_PARM_3
	.globl _mcs51_mult_max_timer0_delay_PARM_2
	.globl _mcs51_mult_max_timer0_delay
	.globl _mcs51_mult_max_timer1_delay
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
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_mcs51_mult_max_timer0_delay_PARM_2:
	.ds 3
_mcs51_mult_max_timer0_delay_PARM_3:
	.ds 3
_mcs51_mult_max_timer1_delay_PARM_2:
	.ds 3
_mcs51_mult_max_timer1_delay_PARM_3:
	.ds 3
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
_mcs51_timer0_delay_PARM_2:
	.ds 3
	.area	OSEG    (OVR,DATA)
_mcs51_timer1_delay_PARM_2:
	.ds 3
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
;Allocation info for local variables in function 'mcs51_timer0_delay'
;------------------------------------------------------------
;ptl0                      Allocated with name '_mcs51_timer0_delay_PARM_2'
;pth0                      Allocated to registers r5 r6 r7 
;------------------------------------------------------------
;	../lib/mcs-51.c:7: void mcs51_timer0_delay(const unsigned char* pth0, const unsigned char* ptl0)
;	-----------------------------------------
;	 function mcs51_timer0_delay
;	-----------------------------------------
_mcs51_timer0_delay:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	../lib/mcs-51.c:9: TMOD = M0_0;  // Timer 0 is in use. 16-bit Timer Mode is selected.  
	mov	_TMOD,#0x01
;	../lib/mcs-51.c:10: TL0 = *ptl0;  // Load value for TL0 register
	mov	r2,_mcs51_timer0_delay_PARM_2
	mov	r3,(_mcs51_timer0_delay_PARM_2 + 1)
	mov	r4,(_mcs51_timer0_delay_PARM_2 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	_TL0,a
;	../lib/mcs-51.c:11: TH0 = *pth0;  // Load value for TH0 register
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	_TH0,a
;	../lib/mcs-51.c:12: TR0 = HIGH;   // Run Timer-0
	mov	dptr,#_HIGH
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	_TR0,c
;	../lib/mcs-51.c:14: while(!TF0);  // Poll TF0  
00101$:
	jnb	_TF0,00101$
;	../lib/mcs-51.c:16: TR0 = LOW;   // If TF0=1 stop the timer by making TR0=0
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
	mov	_TR0,c
;	../lib/mcs-51.c:17: TF0 = LOW;   // If TF0=1 stop the timer by making TR0=0
;	assignBit
	mov	a,r7
	add	a,#0xff
	mov	_TF0,c
;	../lib/mcs-51.c:18: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'mcs51_mult_max_timer0_delay'
;------------------------------------------------------------
;pth0                      Allocated with name '_mcs51_mult_max_timer0_delay_PARM_2'
;ptl0                      Allocated with name '_mcs51_mult_max_timer0_delay_PARM_3'
;pmult                     Allocated to registers r6 r5 r7 
;cpmult                    Allocated to registers 
;------------------------------------------------------------
;	../lib/mcs-51.c:20: void mcs51_mult_max_timer0_delay(const int* pmult, const unsigned char* pth0, const unsigned char* ptl0)
;	-----------------------------------------
;	 function mcs51_mult_max_timer0_delay
;	-----------------------------------------
_mcs51_mult_max_timer0_delay:
;	../lib/mcs-51.c:22: int cpmult = *pmult;
	mov	r5,dph
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	lcall	__gptrget
	mov	r7,a
;	../lib/mcs-51.c:23: while(cpmult > 0)
00101$:
	clr	c
	clr	a
	subb	a,r6
	mov	a,#(0x00 ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jnc	00104$
;	../lib/mcs-51.c:25: mcs51_timer0_delay(pth0, ptl0);
	mov	_mcs51_timer0_delay_PARM_2,_mcs51_mult_max_timer0_delay_PARM_3
	mov	(_mcs51_timer0_delay_PARM_2 + 1),(_mcs51_mult_max_timer0_delay_PARM_3 + 1)
	mov	(_mcs51_timer0_delay_PARM_2 + 2),(_mcs51_mult_max_timer0_delay_PARM_3 + 2)
	mov	dpl,_mcs51_mult_max_timer0_delay_PARM_2
	mov	dph,(_mcs51_mult_max_timer0_delay_PARM_2 + 1)
	mov	b,(_mcs51_mult_max_timer0_delay_PARM_2 + 2)
	push	ar7
	push	ar6
	lcall	_mcs51_timer0_delay
	pop	ar6
	pop	ar7
;	../lib/mcs-51.c:26: cpmult--;
	dec	r6
	cjne	r6,#0xff,00116$
	dec	r7
00116$:
	sjmp	00101$
00104$:
;	../lib/mcs-51.c:28: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'mcs51_timer1_delay'
;------------------------------------------------------------
;ptl1                      Allocated with name '_mcs51_timer1_delay_PARM_2'
;pth1                      Allocated to registers r5 r6 r7 
;------------------------------------------------------------
;	../lib/mcs-51.c:30: void mcs51_timer1_delay(const unsigned char* pth1, const unsigned char* ptl1)
;	-----------------------------------------
;	 function mcs51_timer1_delay
;	-----------------------------------------
_mcs51_timer1_delay:
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	../lib/mcs-51.c:32: TMOD = M1_0;  // Timer 1 is in use. 16-bit Timer Mode is selected.  
	mov	_TMOD,#0x02
;	../lib/mcs-51.c:33: TL1 = *ptl1;  // Load value for TL1 register
	mov	r2,_mcs51_timer1_delay_PARM_2
	mov	r3,(_mcs51_timer1_delay_PARM_2 + 1)
	mov	r4,(_mcs51_timer1_delay_PARM_2 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	_TL1,a
;	../lib/mcs-51.c:34: TH1 = *pth1;  // Load value for TH1 register
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	_TH1,a
;	../lib/mcs-51.c:35: TR1 = HIGH;   // Run Timer-1
	mov	dptr,#_HIGH
	clr	a
	movc	a,@a+dptr
;	assignBit
	add	a,#0xff
	mov	_TR1,c
;	../lib/mcs-51.c:37: while(!TF0);  // Poll TF1  
00101$:
	jnb	_TF0,00101$
;	../lib/mcs-51.c:39: TR1 = LOW;   // If TF1=1 stop the timer by making TR1=0
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
	mov	_TR1,c
;	../lib/mcs-51.c:40: TF1 = LOW;   // If TF1=1 stop the timer by making TR1=0
;	assignBit
	mov	a,r7
	add	a,#0xff
	mov	_TF1,c
;	../lib/mcs-51.c:41: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'mcs51_mult_max_timer1_delay'
;------------------------------------------------------------
;pth1                      Allocated with name '_mcs51_mult_max_timer1_delay_PARM_2'
;ptl1                      Allocated with name '_mcs51_mult_max_timer1_delay_PARM_3'
;pmult                     Allocated to registers r6 r5 r7 
;cpmult                    Allocated to registers 
;------------------------------------------------------------
;	../lib/mcs-51.c:43: void mcs51_mult_max_timer1_delay(const int* pmult, const unsigned char* pth1, const unsigned char* ptl1)
;	-----------------------------------------
;	 function mcs51_mult_max_timer1_delay
;	-----------------------------------------
_mcs51_mult_max_timer1_delay:
;	../lib/mcs-51.c:45: int cpmult = *pmult;
	mov	r5,dph
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	lcall	__gptrget
	mov	r7,a
;	../lib/mcs-51.c:46: while(cpmult > 0)
00101$:
	clr	c
	clr	a
	subb	a,r6
	mov	a,#(0x00 ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jnc	00104$
;	../lib/mcs-51.c:48: mcs51_timer1_delay(pth1, ptl1);
	mov	_mcs51_timer1_delay_PARM_2,_mcs51_mult_max_timer1_delay_PARM_3
	mov	(_mcs51_timer1_delay_PARM_2 + 1),(_mcs51_mult_max_timer1_delay_PARM_3 + 1)
	mov	(_mcs51_timer1_delay_PARM_2 + 2),(_mcs51_mult_max_timer1_delay_PARM_3 + 2)
	mov	dpl,_mcs51_mult_max_timer1_delay_PARM_2
	mov	dph,(_mcs51_mult_max_timer1_delay_PARM_2 + 1)
	mov	b,(_mcs51_mult_max_timer1_delay_PARM_2 + 2)
	push	ar7
	push	ar6
	lcall	_mcs51_timer1_delay
	pop	ar6
	pop	ar7
;	../lib/mcs-51.c:49: cpmult--;
	dec	r6
	cjne	r6,#0xff,00116$
	dec	r7
00116$:
	sjmp	00101$
00104$:
;	../lib/mcs-51.c:51: }
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
_HIGH:
	.db #0xff	; 255
_LOW:
	.db #0x00	; 0
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
