
.cseg
.org 0x0000 ;happens only power on or reset
jmp setup

.org 0x0028
jmp timer1_ISR
   
.org 0x0072

.DEF column=r20
.DEF position=r21 ;0,1,2=input_n / 3= '*' /4= SPD:

;-================================ Main loop ================================-
main_loop:

	/* move cursor */
	CPI position, 0
	BREQ goto_digit100
	CPI position, 1
	BREQ goto_digit10
	CPI position, 2
	BREQ goto_digit1
	CPI position, 3
	BREQ goto_start_button
	CPI position, 4
	BREQ goto_speed

	;else
	main_continue:
		CALL print_current_input

		CALL check_button

	rjmp main_loop
;-================================ END Main loop =============================-
	goto_speed:
	LDI column, 14
	rjmp main_continue

	goto_start_button:
	LDI column, 6
	rjmp main_continue

	goto_digit1:
	LDI column, 5
	rjmp main_continue

	goto_digit10:
	LDI column, 4
	rjmp main_continue

	goto_digit100:
	LDI column, 3
	rjmp main_continue

;-================================ Function:print_current_input =============================-
print_current_input:
	push r18
	push XL
	push XH
	.def offset=r18
	/*go to input_n 100 digit*/
	LDI r16, 0;row
	LDI r17, 3
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() input_n 100 digit*/
	LDI XL, low(input_n)
	LDI XH, high(input_n)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to input_n 10 digit*/
	LDI r16, 0;row=line1
	LDI r17, 4
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() input_n 10 digit*/
	LDI XL, low(input_n)
	inc XL
	LDI XH, high(input_n)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to input_n 1 digit*/
	LDI r16, 0;row=line1
	LDI r17, 5
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() input_n 1 digit*/
	LDI XL, low(input_n)
	inc XL
	inc XL
	LDI XH, high(input_n)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to start button*/
	LDI r16, 0;row=line1
	LDI r17, 6
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() 1 digit*/
	LDI XL, low(input_n)
	inc XL
	inc XL
	inc XL
	LDI XH, high(input_n)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to Speed button*/
	LDI r16, 0;row=line1
	LDI r17, 14
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() 1 digit*/
	LDI XL, low(input_n)
	inc XL
	inc XL
	inc XL
	inc XL
	LDI XH, high(input_n)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to current collatz digit100000*/
	LDI r16, 1;row
	LDI r17, 10
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() collatz digit100000*/
	LDI XL, low(collatz_6_byte)
	LDI XH, high(collatz_6_byte)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to current collatz digit10000 */
	LDI r16, 1;row
	LDI r17, 11
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() collatz digit10000 */
	LDI XL, low(collatz_6_byte)
	LDI XH, high(collatz_6_byte)
	LDI offset, 1
	ADD XL, offset
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to current collatz digit1000  */
	LDI r16, 1;row
	LDI r17, 12
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() collatz digit1000  */
	LDI XL, low(collatz_6_byte)
	LDI XH, high(collatz_6_byte)
	LDI offset, 2
	ADD XL, offset
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to current collatz digit100  */
	LDI r16, 1;row
	LDI r17, 13
	push r16
	push r17
	rcall lcd_gotoxy
	pop r17
	pop r16

	/*Print() collatz digit100 */  
	LDI XL, low(collatz_6_byte)
	LDI XH, high(collatz_6_byte)
	LDI offset, 3
	ADD XL, offset
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to current collatz digit10  */
	LDI r16, 1;row
	LDI r17, 14
	push r16
	push r17
	rcall lcd_gotoxy
	pop r17
	pop r16

	/*Print() collatz digit10    */
	LDI XL, low(collatz_6_byte)
	LDI XH, high(collatz_6_byte)
	LDI offset, 4
	ADD XL, offset
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to current collatz digit1   */
	LDI r16, 1;row
	LDI r17, 15
	push r16
	push r17
	rcall lcd_gotoxy
	pop r17
	pop r16

	/*Print() collatz digit10    */
	LDI XL, low(collatz_6_byte)
	LDI XH, high(collatz_6_byte)
	LDI offset, 5
	ADD XL, offset
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to collatz counter digit100*/
	LDI r16, 1;row
	LDI r17, 4
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() collatz_counter digit100    */
	LDI XL, low(collatz_counter_string)
	LDI XH, high(collatz_counter_string)
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to collatz counter digit10*/
	LDI r16, 1;row
	LDI r17, 5
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() collatz_counter digit10    */
	LDI XL, low(collatz_counter_string)
	LDI XH, high(collatz_counter_string)
	inc XL
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	/*go to collatz counter digit1*/
	LDI r16, 1;row
	LDI r17, 6
	push r16
	push r17
	rcall lcd_gotoxy;
	pop r17
	pop r16

	/*Print() collatz_counter digit1    */
	LDI XL, low(collatz_counter_string)
	LDI XH, high(collatz_counter_string)
	inc XL
	inc XL
	LD r16, X
	push r16
	rcall lcd_putchar
	pop r16

	;--------------------- ~free up variable ~---------------------------------
	.undef offset
	pop XH
	pop XL
	pop r18


	RET
;-================================ END print_current_input =============================-


setup:
	LDI column, 3
	LDI position, 0
	STS collatz_flag_01, position
	push r16
		LDI r16,1
		STS button_flag, r16;set initial start button flag 1
	pop r16
	/* ----------initialize collatz_address ----*/
	push XL
	push XH
	LDI XL, low(collatz_string)
	LDI XH, high(collatz_string)
	STS collatz_address_l, XL
	STS collatz_address_h, XH

	pop XH
	pop XL

	/* ----------initialize the Analog to Digital converter ----*/
	ldi r16, 0x87 ;1000 0111 ;|
	sts ADCSRA, r16 ;|
	ldi r16, 0x40 ;|
	sts ADMUX, r16 ;|

	.equ RIGHT = 0x032 ; the same for both LCD keypad board ;|
	; board v1.0 ;|
	;.equ UP     = 0x0FA ;|
	;.equ DOWN   = 0x1C2 ;|
	;.equ LEFT   = 0x28A ;|
	;.equ SELECT = 0x352 ;|

	; board v1.1 ;|
	.equ UP    = 0x0C3 ;|
	.equ DOWN = 0x17C ;|
	.equ LEFT = 0x22B ;|
	.equ SELECT = 0x316
	/* ----------initialization END -------------------------*/

	; initialize the stack pointer (we are using functions!)
	ldi r16, high(RAMEND)
	out SPH, r16
	ldi r16, low(RAMEND)
	out SPL, r16

	call timer1_setup

	;*****************  LCD settings *********************
	; initialize the LCD
	call lcd_init

	; clear the screen
	call lcd_clr

	call lcd_init ; call lcd_init to Initialize the LCD (line 689 in lcd.asm)
	;*****************  END LCD settings *********************

	;*****************  Show credit and start screen *********************
	call credit
	call display_credit
	call delay_for_credit
	call lcd_clr

	call set_start_screen
	call display_start_screen

	;*****************  Set " " for blink  *********************
	ldi r16, ' '
	sts char_two, r16
	;*****************  END Blink  *********************

	;*****************  set-up input_n  ******************
	push r16 ;protect
	ldi r16, '0'
	sts input_n, r16
	sts input_n+1, r16
	sts input_n+2, r16 ;input_n ="000"
	ldi r16, '*'
	sts input_n+3, r16 ;input_n ="*"
	ldi r16, '0'
	sts input_n+4, r16
	pop r16
	;*****************  END input_n  *********************

	;*****************  set-up collatz_6_byte  ******************
	push r16 ;protect
	ldi r16, ' '
	sts collatz_6_byte, r16
	sts collatz_6_byte+1, r16
	sts collatz_6_byte+2, r16
	sts collatz_6_byte+3, r16
	sts collatz_6_byte+4, r16
	ldi r16, '0'
	sts collatz_6_byte+5, r16
	pop r16

	;*****************   set-up collatz_counter_int  **************
	push r16 ;protect
	ldi r16, 0
	sts collatz_counter_int, r16
	pop r16
	;*****************  END collatz_counter_int  *********************

	;*****************   set-up collatz_counter_string  **************
	push r16 ;protect
	ldi r16, ' '
	sts collatz_counter_string, r16
	sts collatz_counter_string+1, r16
	ldi r16, '0'
	sts collatz_counter_string+2, r16
	pop r16
	;*****************  END collatz_counter_string  *********************

	ldi r16, 0; debug--------------------------------------------------


	jmp main_loop

;*****************  memo  *********************
; this function is obtained from lab8 
; TCCR1A is used for operation mode: 0 is normal
; TCCR1B is used for pre-scaling mode: control by last 3 digit as shown below.
; TCNT1 is timer count
; TIMSK1 is = Timer/Counter 1 Interrupt Mask Register
;**************************************

;time setting
.equ TIMER1_DELAY = 977
.equ TIMER1_MAX_COUNT = 0xFFFF
.equ TIMER1_COUNTER_INIT=TIMER1_MAX_COUNT - TIMER1_DELAY
.equ TIMER2_DELAY = 1954
.equ TIMER2_MAX_COUNT = 0xFFFF
.equ TIMER2_COUNTER_INIT=TIMER2_MAX_COUNT - TIMER2_DELAY
.equ TIMER3_DELAY = 1954
.equ TIMER3_MAX_COUNT = 0xFFFF
.equ TIMER3_COUNTER_INIT=TIMER3_MAX_COUNT - TIMER3_DELAY
.equ TIMER4_DELAY = 7813
.equ TIMER4_MAX_COUNT = 0xFFFF
.equ TIMER4_COUNTER_INIT=TIMER4_MAX_COUNT - TIMER4_DELAY
.equ TIMER5_DELAY = 15625
.equ TIMER5_MAX_COUNT = 0xFFFF
.equ TIMER5_COUNTER_INIT=TIMER5_MAX_COUNT - TIMER5_DELAY
.equ TIMER6_DELAY = 15625
.equ TIMER6_MAX_COUNT = 0xFFFF
.equ TIMER6_COUNTER_INIT=TIMER6_MAX_COUNT - TIMER6_DELAY
.equ TIMER7_DELAY = 31250
.equ TIMER7_MAX_COUNT = 0xFFFF
.equ TIMER7_COUNTER_INIT=TIMER7_MAX_COUNT - TIMER7_DELAY
.equ TIMER8_DELAY = 39063
.equ TIMER8_MAX_COUNT = 0xFFFF
.equ TIMER8_COUNTER_INIT=TIMER8_MAX_COUNT - TIMER8_DELAY
.equ TIMER9_DELAY = 46875
.equ TIMER9_MAX_COUNT = 0xFFFF
.equ TIMER9_COUNTER_INIT=TIMER9_MAX_COUNT - TIMER9_DELAY
timer1_setup:
; timer mode
ldi r16, 0x00 ; normal operation
    sts TCCR1A, r16     ; TCCR1A=0 is normal status

; prescale
; Our clock is 16 MHz, which is 16,000,000 per second
;
; scale values are the last 3 bits of TCCR1B:
;
; 000 - timer disabled
; 001 - clock (no scaling)
; 010 - clock / 8
; 011 - clock / 64
; 100 - clock / 256
; 101 - clock / 1024
; 110 - external pin Tx falling edge
; 111 - external pin Tx rising edge
ldi r16, (1<<CS12)|(1<<CS10) ; r16=0000 0101.
    ;So prescale effect is 1 clock per 1024 clock cycle
sts TCCR1B, r16

; set timer counter to TIMER1_COUNTER_INIT (defined above)
ldi r16, high(TIMER4_COUNTER_INIT) ;TIMER1_COUNTER_INIT
sts TCNT1H, r16 ; must WRITE high byte first
ldi r16, low(TIMER4_COUNTER_INIT)
sts TCNT1L, r16 ; low byte

; allow timer to interrupt the CPU when it's counter overflows
    ;ldi r16, 1<<TOV1  ;; Interupt vector 1 became '1', then set bit 0 as 1?
ldi r16, 1<<TOIE1
sts TIMSK1, r16 ;when TIMSK1 bit 1 became 1, then enable interupt from function side.

; enable interrupts (the I bit in SREG) from overall program
sei

ret

;===================function int_to_string_collatz ===================
int_to_string_collatz:
push r16
push r17
;push r18
push r23

.def quotient=r16
.def char0=r17
.def counter = r18 ;collatz counter
.def divisor_l =r23

clr quotient
LDI divisor_l, 0x64
LDI char0, 0x30
counter_loop_100:
CP counter, divisor_l
BRLO counter_finish_100
;else
SUBI counter, 0x64
inc quotient
rjmp counter_loop_100

counter_finish_100:
add quotient, char0
st Y+, quotient

clr quotient
LDI divisor_l, 0x0A

counter_loop_10:
CP counter, divisor_l
BRLO counter_finish_10
;else
SUBI counter, 0x0A
inc quotient
rjmp counter_loop_10

counter_finish_10:
add quotient, char0
st Y+, quotient

clr quotient
add counter, char0
st Y+, counter

doneint_to_string_collatz:
.undef quotient
.undef char0
.undef counter ;collatz counter
.undef divisor_l

pop r23
; pop r18
pop r17
pop r16


RET
; timer interrupt flag is automatically
; cleared when this ISR is executed
; per page 168 ATmega datasheet
; this function is obtained from lab8
;*************************  Interuption is called!!! ***********************************
timer1_ISR:
	push r16
	push r17
	push r18
	lds r16, SREG
	push r16
	push r19
	;*these are for collatza char ascii*
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push ZH
	push ZL
	push YH
	push YL
	;push XH 
	;push XL

	/*check the speed value*/
	;Y points to input_n SPEED
	push YL
	push YH
	push r16

	LDI YL, low(input_n)
	inc YL
	inc YL
	inc YL
	inc YL
	LDI YH, high(input_n)
	;get speed char
	LD r16, Y

	;compare by case
	CPI r16, 0x30
	BREQ speed_0
	CPI r16, 0x31
	BREQ speed_1
	CPI r16, 0x32
	BREQ speed_2
	CPI r16, 0x33
	BREQ speed_3
	CPI r16, 0x34
	BREQ speed_4
	CPI r16, 0x35
	BREQ speed_5
	CPI r16, 0x36
	BREQ speed_6
	CPI r16, 0x37
	BREQ speed_7
	CPI r16, 0x38
	BREQ speed_8
	CPI r16, 0x39
	BREQ speed_9

	speed_0:
	pop r16
	pop YH
	pop YL
	rjmp do_nothing
	speed_1:
	ldi r16, high(TIMER1_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER1_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_2:
	ldi r16, high(TIMER2_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER2_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_3:
	ldi r16, high(TIMER3_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER3_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_4:
	ldi r16, high(TIMER4_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER4_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_5:
	ldi r16, high(TIMER5_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER5_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_6:
	ldi r16, high(TIMER6_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER6_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_7:
	ldi r16, high(TIMER7_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER7_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_8:
	ldi r16, high(TIMER8_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER8_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check
	speed_9:
	ldi r16, high(TIMER9_COUNTER_INIT)
	sts TCNT1H, r16
	ldi r16, low(TIMER9_COUNTER_INIT)
	sts TCNT1L, r16
	rjmp done_speed_check

	done_speed_check:
		;free up registers
		pop r16
		pop YH
		pop YL

	.def digit100000=r25
	.def digit10000 =r24
	.def digit1000  =r23
	.def digit100   =r22
	.def digit10    =r21
	.def digit1     =r20
	.def counter    =r18
	LDI counter, 0
   
	;check if start_flag is on =============================================================================
		LDS r16, collatz_flag_01
		CPI r16, 1
		BRNE bridge_do_nothing
	;============================================================================


	
	

	;Y points collatz_counter_int
	LDI YL, low(collatz_counter_int)
	LDI YH, high(collatz_counter_int)

	;get value from collatz_counter_int
	LD counter, Y
	;increment counter and store into collatz_counter_int
	inc counter
	ST Y, counter
	;now, set Y as collatz_counter_string
	LDI YL, low(collatz_counter_string)
	LDI YH, high(collatz_counter_string)

	;convert counter into 3 bytes AND STORE INTO collatz_counter_string
	call int_to_string_collatz

	;else, Z points to stand-by address of collatz 6 byte
	LDI ZL, low(collatz_6_byte)
	LDI ZH, high(collatz_6_byte)

	;get the address ;===========debug=============================
	LDS XL, collatz_address_l
	LDS XH, collatz_address_h ;now, X points to the collatz address

	/* get collatz_string */
	LD digit100000, X+
	LD digit10000,  X+
	LD digit1000,   X+
	LD digit100,    X+
	LD digit10,     X+
	LD digit1,      X+

	/* store collatz address of X into collatz address*/  
	STS collatz_address_l, XL
	STS collatz_address_h, XH
	
	/* check if sequence is done */
		CPI digit100000, 0x30
		breq check_digit10000
		;else
		rjmp store_stand_by_6_byte

		check_digit10000:
			CPI digit10000, 0x30
			breq check_digit1000
			rjmp store_stand_by_6_byte
		check_digit1000:
			CPI digit1000, 0x30
			breq check_digit100
			rjmp store_stand_by_6_byte
		check_digit100:
			CPI digit100, 0x30
			breq check_digit10
			rjmp store_stand_by_6_byte
		check_digit10:
			CPI digit10, 0x30
			breq check_digit1
			rjmp store_stand_by_6_byte
		check_digit1:
			CPI digit1, 0x31 
			BREQ end_collatz_interuption
			CPI digit1, 0x31 
			breq end_collatz_interuption


	/* store collatz address of X into collatz address*/  
	STS collatz_address_l, XL
	STS collatz_address_h, XH

	store_stand_by_6_byte:
	/* else, store the sequence into stand-by 6 byte*/
	ST Z+, digit100000
	ST Z+, digit10000
	ST Z+, digit1000
	ST Z+, digit100
	ST Z+, digit10
	ST Z+, digit1
	rjmp do_nothing

	bridge_do_nothing:
		jmp do_nothing

	end_collatz_interuption:
		LDI r30, 0
		STS collatz_flag_01, r30
		
		LDI ZL, low(collatz_6_byte)
		LDI ZH, high(collatz_6_byte)
		
		ST Z+, digit100000
		ST Z+, digit10000
		ST Z+, digit1000
		ST Z+, digit100
		ST Z+, digit10
		ST Z+, digit1

	do_nothing:
	.undef digit100000
	.undef digit10000
	.undef digit1000  
	.undef digit100  
	.undef digit10    
	.undef digit1    

	pop YL
	pop YH
	pop ZL
	pop ZH
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19

;======================= END: update counter ===========================

pop r16
sts SREG, r16
pop r18
pop r17
pop r16
reti
;*************************  Intruption END ***********************************

; Function that delays for a period of time using busy-loop
; this is obtained from lab 4
delay:
		push r20
		push r21
		push r22
		; Nested delay loop ;originally 0x29
		ldi r20, 0x0A ;0x29
		x1:
		ldi r21, 0xFF
		x2:
		ldi r22, 0xFF
		x3:
		dec r22
		brne x3
		dec r21
		brne x2
		dec r20
		brne x1

		pop r22
		pop r21
		pop r20
	ret

; this is obtained from lab 4
delay_for_credit:
		push r20
		push r21
		push r22
		; Nested delay loop ;originally 0x29
		ldi r20, 0x50 ; originally 0x29
		y1:
		ldi r21, 0xFF
		y2:
		ldi r22, 0xFF
		y3:
		dec r22
		brne y3
		dec r21
		brne y2
		dec r20
		brne y1

		pop r22
		pop r21
		pop r20
	ret
;*************************  Function init_strings ***********************************
credit:
	push r16
		; copy strings from program memory to data memory
		ldi r16, high(credit1_dest) ; address of the destination string in data memory
		push r16
		ldi r16, low(credit1_dest)
		push r16
		ldi r16, high(credit1_source << 1) ; address the source string in program memory
		push r16
		ldi r16, low(credit1_source << 1)
		push r16
		call str_init ; copy from program to data
		pop r16 ; remove the parameters from the stack
		pop r16
		pop r16
		pop r16

		ldi r16, high(credit2_dest) ; address of the destination string in data memory
		push r16
		ldi r16, low(credit2_dest)
		push r16
		ldi r16, high(credit2_source << 1) ; address the source string in program memory
		push r16
		ldi r16, low(credit2_source << 1)
		push r16
		call str_init ; copy from program to data
		pop r16 ; remove the parameters from the stack
		pop r16
		pop r16
		pop r16

	pop r16
ret
;*************************  END: init_strings ***************************

;*************************  Function display strings ***************************

display_credit:

; This subroutine sets the position the next
; character will be on the lcd
;
; The first parameter pushed on the stack is the Y (row) position
;
; The second parameter pushed on the stack is the X (column) position
;
; This call moves the cursor to the top left corner (ie. 0,0)
; subroutines used are defined in lcd.asm in the following lines:
; The string to be displayed must be stored in the data memory
; - lcd_clr at line 661
; - lcd_gotoxy at line 589
; - lcd_puts at line 538
	push r16

		call lcd_clr

		ldi r16, 0x00;row
		push r16
		ldi r16, 0x00;column
		push r16
		call lcd_gotoxy
		pop r16
		pop r16

		; Now display credit1 on the first line
		ldi r16, high(credit1_dest) ;get data memory destination address
		push r16
		ldi r16, low(credit1_dest)
		push r16
		call lcd_puts
		pop r16
		pop r16

		;go to line2
		ldi r16, 0x01;row
		push r16
		ldi r16, 0x00;column
		push r16
		call lcd_gotoxy
		pop r16
		pop r16
		; Now display credit2 on the first line
		ldi r16, high(credit2_dest) ;get data memory destination address
		push r16
		ldi r16, low(credit2_dest)
		push r16
		call lcd_puts
		pop r16
		pop r16

	pop r16
ret
;*************************  END: display strings ***************************

;*************************  Function init_strings ***********************************
set_start_screen:
	push r16
		; copy strings from program memory to data memory
		ldi r16, high(Line1_dest) ; address of the destination string in data memory
		push r16
		ldi r16, low(Line1_dest)
		push r16
		ldi r16, high(Line1_source << 1) ; address the source string in program memory
		push r16
		ldi r16, low(Line1_source << 1)
		push r16
		call str_init ; copy from program to data
		pop r16 ; remove the parameters from the stack
		pop r16
		pop r16
		pop r16

		ldi r16, high(Line2_dest) ; address of the destination string in data memory
		push r16
		ldi r16, low(Line2_dest)
		push r16
		ldi r16, high(Line2_source << 1) ; address the source string in program memory
		push r16
		ldi r16, low(Line2_source << 1)
		push r16
		call str_init ; copy from program to data
		pop r16 ; remove the parameters from the stack
		pop r16
		pop r16
		pop r16

	pop r16
ret
;*************************  END: init_strings ***************************


;*************************  Function display strings ********************
display_start_screen:
	push r16

	call lcd_clr

	ldi r16, 0x00;row
	push r16
	ldi r16, 0x00;column
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	; Now display credit1 on the first line
	ldi r16, high(Line1_dest) ;get data memory destination address
	push r16
	ldi r16, low(Line1_dest)
	push r16
	call lcd_puts
	pop r16
	pop r16

	;go to line2
	ldi r16, 0x01;row
	push r16
	ldi r16, 0x00;column
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
	; Now display credit2 on the first line
	ldi r16, high(Line2_dest) ;get data memory destination address
	push r16
	ldi r16, low(Line2_dest)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
ret
;*************************  END: display strings ***************************

;A function blink takes parameter, column from stack and uses for lcd_gotoxy
blink:
/*;;;;;;;;;;blink;;;;;;;;;;;blink;;;;;;;;;; blink;;;;;;;;blink;;;;;;;;*/
	push r16; protect
	push r17

	;debug 11/12
	IN YL, SPL
	IN YH, SPH
	;get column of LCD display
	LDD r17 ,Y+6 ;r17=column

	;again, go to (0, column)
	LDI r16, 0;row=line1
	push r16
	push r17
	rcall lcd_gotoxy;blink line1, col3
	pop r17
	pop r16

	;again, print " "
	LDS r16, char_two
	push r16
	rcall lcd_putchar
	pop r16

	;-----------------------
	pop r17
	pop r16

RET
/*;;;;;;;;;;blink;;;;;;;;;;;blink;;;;;;;;;; blink;;;;;;;;blink;;;;;;;;*/

;************  Function: check_button(obtained from my assignment2 code) *********
check_button:
	push r20
	push r22
	push r23
	push r24
	push r25
	
	.def button_low = r22
	.def button_high = r23
	.def ADC_low = r24
	.def ADC_high = r25

	; else start a2d conversion
	lds r25, ADCSRA  ; get the current value of SDRA
	ori r25, 0x40     ; set the ADSC bit to 1 to initiate conversion
	sts ADCSRA, r25
	/*CALL delay */
	CALL delay 

wait:
	push YL ;protect Y
	push YH
	push column ;column is the passing parameter

	call blink

	pop column
	pop YH
	pop YL

continue_wait:
	lds r25, ADCSRA
	andi r25, 0x40     ; see if conversion is over by checking ADSC bit
	brne wait          ; ADSC will be reset to 0 is finished

	/*CALL delay*/
	CALL delay 

	; read the value available as 10 bits in ADCH:ADCL
	LDI r25, 0 ;reset r25
	lds ADC_low, ADCL
	lds ADC_high, ADCH

	/* check -right*/
	ldi button_low, low(RIGHT)
	ldi button_high, high(RIGHT)
	CP ADC_low, button_low ;check if RIGHT is pressed
	CPC ADC_high, button_high
	BRLO right_handler

	/* check -UP*/
	ldi button_low, low(UP)
	ldi button_high, high(UP)
	CP ADC_low, button_low ;check if UP is pressed
	CPC ADC_high, button_high
	BRLO up_handler

	/* check -DOWN*/
	ldi button_low, low(DOWN)
	ldi button_high, high(DOWN)
	CP ADC_low, button_low ;check if DOWN is pressed
	CPC ADC_high, button_high
	BRLO bridge_down_handler

	/* check -LEFT*/
	ldi button_low, low(LEFT)
	ldi button_high, high(LEFT)
	CP ADC_low, button_low ;check if LEFT is pressed
	CPC ADC_high, button_high
	BRLO bridge_left_handler

	;clear flag
	push r16
		LDI r16, 0
		STS button_flag, r16
	pop r16
	
	final:
	.undef button_low
	.undef button_high
	.undef ADC_low
	.undef ADC_high
	pop r25
	pop r24
	pop r23
	pop r22
	pop r20

	ret
;****************  END: check_button ***************************

;========================right handler =============================
right_handler:
	;if flag is 1, end right_handler
	push r16
		LDS r16, button_flag
		CPI r16, 1
		BREQ done_right_handler ;...*
		;else, continue
	
	CPI position, 4
	BREQ done_right_handler ;if position =4, go back to final
	;else
	inc position

	;set button_flag, 1
	push r16
		LDI r16, 1
		STS button_flag, r16
	pop r16

done_right_handler:
	pop r16 ;from ...*

	rjmp final

bridge_down_handler:
	jmp down_handler
bridge_left_handler:
	jmp left_handler
	;===================up handler========================
up_handler:
	;if flag is 2, end up_handler
	push r16
		LDS r16, button_flag
		CPI r16, 2
		BREQ done_up_handler ;...*
		;else, continue

	/* check if position is start button*/
	CPI position, 3
	BREQ go_to_start_on_from_up

	;ELSE go to current position
	push r16
	push XL
	push XH
	LDI XL, low(input_n)
	ADD XL, position
	LDI XH, high(input_n)

	;get current value
	LD r16, X
	;if number is 9, adjust to 0
	CPI r16, 0x39
	BRGE adjust_9
	;else, add one
	inc r16


	store_uped_value:
		;store increaded value
		ST X, r16  
		pop XH
		pop XL
		pop r16

	;set button_flag, 2
	push r16
		LDI r16, 2
		STS button_flag, r16
	pop r16

done_up_handler:
	pop r16 ;from ...*

	rjmp final

	adjust_9:
	LDI r16, 0x30 ;0x39 ='0'
	RJMP store_uped_value

	go_to_start_on_from_up:
		pop r16 ;from ...*
		jmp start_on

;=============================down handler==========================================
down_handler:
	;if flag is 3, end down_handler
	push r16
		LDS r16, button_flag
		CPI r16, 3
		BREQ done_down_handler ;...*
		;else, continue

	/* check if position is start button*/
		CPI position, 3
		BREQ go_to_start_on_from_down
		;ELSE go to current position
		push r16
		push XL
		push XH
		LDI XL, low(input_n)
		ADD XL, position
		LDI XH, high(input_n)

		;get current value
		LD r16, X

		CPI r16, 0x30
		BREQ adjust_0
		dec r16 ;else, dec by one

		store_downed_value:
			;store decreased value
			ST X, r16

			pop XH
			pop XL
			pop r16

	;set button_flag, 3
	push r16
		LDI r16, 3
		STS button_flag, r16
	pop r16

done_down_handler:
	pop r16 ;from ...*

	rjmp final

	adjust_0:
	LDI r16, 0x39 ;0x39 ='9'
	RJMP store_downed_value

	go_to_start_on_from_down:
		pop r16 ;from ...*
		jmp start_on
	;==========================left handler ==============================
left_handler:
	;if flag is 4, end down_handler
	push r16
		LDS r16, button_flag
		CPI r16, 4
		BREQ done_left_handler ;...*
		;else, continue

	CPI position, 0
	BREQ done_left_handler
	dec position

	;set button_flag, 3
	push r16
		LDI r16, 4
		STS button_flag, r16
	pop r16

done_left_handler:
	pop r16 ;from ...*

	rjmp final

;+++++++++++++++++++++++++++   ~start_on~ +++++++++++++++++++++++++++++++
start_on:
	
	;prtect r16,r17,r18
	push r18
	push r17
	push r16

	/* if speed is zero, do not start */
	LDI YL, low(input_n)
	LDI YH, high(input_n)
	inc YL
	inc YL
	inc YL
	inc YL
	LD r16, Y
	CPI r16, 0x30
	BREQ bridge_done_start_on

	/* get input value Y points to input_n*/
	LDI YL, low(input_n)
	LDI YH, high(input_n)
	LD  r18, Y+ ;r18=digit100
	LD r17, Y+ ;r17=digit10
	LD r16, Y ;r16=digit1

	/* if input value is '0''0''0', do not start*/
		CPI r18, 0x30
		BREQ check_digit10_start_on
		RJMP continue_start_on

		check_digit10_start_on:
			CPI r17, 0x30
			BREQ check_digit1_start_on
			RJMP continue_start_on
		check_digit1_start_on:
			CPI r16, 0x30
			BREQ done_start_on ;if input is '0'0'0', do nothing
			RJMP continue_start_on

bridge_done_start_on:
	jmp done_start_on
continue_start_on:
	;*****************   set-up collatz_counter_int  **************
	push r16 ;protect
	;ldi r16, 0
	ldi r16, -1 ;intput value start at position 0
	sts collatz_counter_int, r16
	pop r16
	;*****************  END collatz_counter_int  *********************

	;*****************   set-up collatz_counter_string  **************
	push r16 ;protect
	ldi r16, ' '
	sts collatz_counter_string, r16
	sts collatz_counter_string+1, r16
	ldi r16, '0'
	sts collatz_counter_string+2, r16
	pop r16
	;*****************  END collatz_counter_string  *********************

	;*****************   set-up collatz_6_byte  **************
	push r16 ;protect
	ldi r16, ' '
	sts collatz_6_byte, r16
	sts collatz_6_byte+1, r16
	sts collatz_6_byte+2, r16
	sts collatz_6_byte+3, r16
	sts collatz_6_byte+4, r16
	ldi r16, '0'
	sts collatz_6_byte+5, r16
	pop r16
	;*****************  END collatz_counter_string  *********************
	push r16; push input
	push r17
	push r18

	call Collatz 

	pop r18
	pop r17
	pop r16
	/* ----------initialize collatz_address ----*/
	push XL
	push XH

	LDI XL, low(collatz_string)
	LDI XH, high(collatz_string)
	STS collatz_address_l, XL
	STS collatz_address_h, XH

	pop XH
	pop XL

	;start display collatz!!
	LDI r26, 1
	STS collatz_flag_01, r26
	LDI XL, low(collatz_string)
	LDI XH, high(collatz_string)
	
	done_start_on:
		; For prtected r16,r17,r18
		pop r18
		pop r17
		pop r16
rjmp final 
;+++++++++++++++++++++++++++   ~start_on~ +++++++++++++++++++++++++++++++


;==============================Function: Collatz======================================
Collatz:
	/* protect XL, XH*/
	push XL
	push XH
	push ZL
	push ZH
	;push r16
	;push r17
	;push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	/* convert char input int*/
	SUBI r18, 0x30 ;digit 100
	SUBI r17, 0x30 ;digit 10
	SUBI r16, 0x30 ;digit 1

	/*Declaration of labels*/
	.def count = r17
	.def count_h = r18
	.def temp = r19 ;temp is for deciding current number is even or odd
	.def multiplier = r20
	.def one = r21
	.def bit_mask = r22
	.def ANS1 = r23
	.def ANS2 = r24
	.def ANS3 = r25

	;initialize

	LDI ANS1,0
	LDI ANS2,0
	LDI ANS3,0

	/*==================== get input int=====================*/
	MOV ANS1, r16

	LDI temp, 10

	multiply_by_10:
	CPI r17, 0
	BREQ multiply_by_100
	;else
	ADD ANS1, temp
	DEC r17

	rjmp multiply_by_10

	multiply_by_100:
	LDI temp, 100
	CPI r18, 0
	BREQ continue_collatz
	;else
	ADD ANS1,temp ;ANS1 max is 99=0x63
	BRCS carry_on

	continue_multiply_by_100:
	DEC r18

	rjmp multiply_by_100

	carry_on:
	INC ANS2
	rjmp continue_multiply_by_100

/*==================== DONE get input int=====================*/

continue_collatz:
	;let Z be address of collatz_string

	ldi ZH, high(collatz_string)
	ldi ZL, low(collatz_string)

	/* Store input values*/
	push ANS1
	push ANS2
	push ANS3
	CALL int_to_string
	pop ANS3
	pop ANS2
	pop ANS1

	/* get constant values*/
	ldi one, 1
	ldi multiplier, 3
	ldi bit_mask, 1
	ldi count,0
	ldi count_h,0
	MOV temp, ANS1


/* first store input value in the first sequence*/


while:
	ADD count, one
	BRCS carry

	/* if ANS3=0, ANS2=0, ANS1 =1, then the sequence ends */
	cpi ANS1, 1
	breq check_ANS2
	jmp loop
	check_ANS2:
	cpi ANS2, 0
	breq check_ANS3
	jmp loop
	check_ANS3:
	cpi ANS3, 0
	breq bridge_done_collatz
	jmp loop

carry:
	inc count_h
	CLC ;clear carry

loop: ;check if temp is even or odd
	AND temp, bit_mask
	cpi temp , 0
	breq even
	cpi temp , 1
	breq odd
	jmp loop

	odd: /* n=3*n+1 */
		MUL ANS3, multiplier
		MOV ANS3,r0

		MUL ANS2, multiplier
		ADD ANS3, r1
		MOV ANS2, r0

		MUL ANS1, multiplier
		MOV ANS1, r0
		ADD ANS2, r1
		BRCS carry_ANS3;added
		;else
	continue_odd:;added
		inc ANS1
		mov temp, ANS1
		jmp store_collatz
	carry_ANS3:;added
		inc ANS3 ;added
		rjmp continue_odd ;added
		;================end of odd=====================

	even: /*n = n/2 */
		LSR ANS3
		ROR ANS2
		ROR ANS1
		CLC ;clear carry flag after division
		MOV temp, ANS1

		jmp store_collatz

store_collatz:
;==============convert into character=====================
push ANS3
push ANS2
push ANS1

;Z points to first character of num in SRAM
CALL int_to_string

pop ANS1
pop ANS2
pop ANS3

jmp while

bridge_done_collatz:
jmp done_collatz
;=================================================================
 int_to_string:
push r16
push r17
push r18
push r19
push r20

.def quotient=r16
.def char0=r17
.def divisor_h =r18
.def divisor_m =r19
.def divisor_l =r20


LDI quotient,0
LDI char0, 0x30

LDI divisor_h, 0x01
LDI divisor_m, 0x86
LDI divisor_l, 0xA0

 loop_100000:
CP ANS1,divisor_l
CPC ANS2, divisor_m
CPC ANS3, divisor_h
BRLO finish_100000
;else
SUBI ANS1, 0xA0
SBCI ANS2, 0x86
SBCI ANS3, 0x01

inc quotient

rjmp loop_100000

finish_100000:
add quotient, char0
st Z+, quotient

clr quotient
LDI divisor_l, 0x10
LDI divisor_m, 0x27

 loop_10000:
CP ANS1,divisor_l
CPC ANS2, divisor_m
BRLO adjust_ANS3
;else
continue_loop_10000:
SUBI ANS1, 0x10
SBCI ANS2, 0x27
inc quotient

rjmp loop_10000

adjust_ANS3:
CPI ANS3, 0
BREQ finish_10000
;else
dec ANS3
;inc quotient
rjmp continue_loop_10000

finish_10000:
CPI quotient, 0x0A
BRGE adjust_quotient
;else
add quotient, char0
st Z+, quotient

clr quotient
LDI divisor_l, 0xE8
LDI divisor_m, 0x03
jmp loop_1000

adjust_quotient:
LDI quotient, 0
add quotient, char0
st Z+, quotient
clr quotient

LDI divisor_l, 0xE8
LDI divisor_m, 0x03

 loop_1000:
CP ANS1,divisor_l
CPC ANS2, divisor_m
BRLO finish_1000
;else
SUBI ANS1, 0xE8
SBCI ANS2, 0x03
inc quotient

rjmp loop_1000

finish_1000:
add quotient, char0
st Z+, quotient

clr quotient
LDI divisor_l, 0x64
LDI divisor_m, 0x00

loop_100:
CP ANS1,divisor_l
CPC ANS2, divisor_m
BRLO finish_100
;else
SUBI ANS1, 0x64
SBCI ANS2, 0x00
inc quotient
rjmp loop_100

finish_100:
add quotient, char0
st Z+, quotient

clr quotient

LDI divisor_l, 0x0A
LDI divisor_m, 0x00
loop_10:
CP ANS1,divisor_l
CPC ANS2, divisor_m
BRLO finish_10
;else
SUBI ANS1, 0x0A
inc quotient
rjmp loop_10

finish_10:
add quotient, char0
st Z+, quotient
clr quotient

add ANS1, char0
st Z+, ANS1
;----------------------------------------------
pop r20
pop r19
pop r18
pop r17
pop r16
.undef quotient
.undef char0


.undef divisor_h
.undef divisor_m
.undef divisor_l

RET

;============================= END int_to_string =========================================





done_collatz:
.undef count
.undef count_h
.undef temp
.undef multiplier
.undef one
.undef bit_mask
.undef ANS1
.undef ANS2
.undef ANS3

;================= ~ free up XL, XH ~ =====================
pop r25
pop r24
pop r23
pop r22
pop r21
pop r20
pop r19
;pop r18
;pop r17
;pop r16
pop ZH
pop ZL
pop XH
pop XL


RET
;========================END of Collatz Function=============================



;************************Do not change below code**********************************
credit1_source: .db "Kenichi Obata", 0
credit2_source: .db "CSC230-Fall2019", 0; each can display up to 16 characters

Line1_source: .db " n=000*   SPD:0 ", 0
Line2_source: .db "cnt:  0 v:     0", 0

.dseg

credit1_dest: .byte 17
credit2_dest: .byte 17

button_flag: .byte 1
char_two: .byte 1

Line1_dest: .byte 17
Line2_dest: .byte 17

input_n: .byte 5
collatz_6_byte: .byte 6
to_avoid_garbage: .byte 6 ;to avoid one bug display garbage data
collatz_counter_string: .byte 3
collatz_counter_int: .byte 1

collatz_flag_01: .byte 1
collatz_address_l: .byte 1
collatz_address_h: .byte 1
collatz_string: .byte 0x0440; 1068 originally 0x430

;
; Include the HD44780 LCD Driver for ATmega2560
#define LCD_LIBONLY
.include "lcd.asm"

