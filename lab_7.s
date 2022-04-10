;;;----------------------------------------------------------------;;;
;;;------------------COLOR MAP/BLOCK DECLARATION-------------------;;;
;;;----------------------------------------------------------------;;;
; block color
; first line of block and its color
; move cursor
; next line of block and its color
; move cursor
; last line of block and its color
;
;	+-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+
;	|     | |     | |     | |     | |     | |     | |     | |     | |     | |     | |     |
;	|  2  | |  4  | |  8  | | 16  | | 32  | | 64  | | 128 | | 256 | | 512 | |1024 | |2048 |
;	|     | |     | |     | |     | |     | |     | |     | |     | |     | |     | |     |
;	+-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+
	.data
	.global block2
	.global block4
	.global block8
	.global block16
	.global block32
	.global block64
	.global block128
	.global block256
	.global block512
	.global block1024
	.global block2048
	.global game_board
	.global LOSE_end
	.global WIN_end
	.global TIMESCORE_prompt
	.global SCORE
	;.global TIME_prompt
	.global TIME
	.global END_status
	.global PAUSED
	.global WIN_BLOCK
	.global position


block2: 	.string 27,"[46m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m  2  ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block4: 	.string 27,"[45m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m  4  ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block8: 	.string 27,"[44m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m  8  ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block16: 	.string 27,"[43m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m 16  ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block32: 	.string 27,"[42m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m 32  ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block64: 	.string 27,"[45;1m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m 64  ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block128: 	.string 27,"[44;1m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m 128 ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block256: 	.string 27,"[43;1m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m 256 ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block512:	.string 27,"[42;1m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m 512 ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block1024: 	.string 27,"[41;1m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m1024 ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0
block2048: 	.string 27,"[40;1m",27,"[37m     ",27,"[1B",27,"[5D",27,"[37m2048 ",27,"[1B", 27,"[5D",27,"[37m     ",27,"[0m", 0x0

; size of game board is 4x4 blocks, with each block being 3x5
game_board:	.string "+-----+-----+-----+-----+", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "+-----+-----+-----+-----+", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "+-----+-----+-----+-----+", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "+-----+-----+-----+-----+", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "|     |     |     |     |", 0xA, 0xD
			.string "+-----+-----+-----+-----+", 0x0

position:	.string 27, "[3;2f",0
clear_screen: .string 27,"[2J",27,"[1;1f",0

LOSE_end: 	  .string "You Lost, Welcome to Die!",0
WIN_end: 	  .string "You Won, Conglaturmation!",0
TIMESCORE_prompt: .string 27,"[1;1f",27,"[37mTime: ",27,"[1;17f",27,"[37mScore: ",27,"[2;1f",0

SCORE:		.word 0x00000000
TIME:		.word 0x00000000

END_status:	.byte 0x00
PAUSED:		.byte 0x00

;Data corresponding to square values
SQ0: .byte 0x00
SQ1: .byte 0x00
SQ2: .byte 0x00
SQ3: .byte 0x00

SQ4: .byte 0x00
SQ5: .byte 0x00
SQ6: .byte 0x00
SQ7: .byte 0x00

SQ8: .byte 0x00
SQ9: .byte 0x00
SQ10: .byte 0x00
SQ11: .byte 0x00

SQ12: .byte 0x00
SQ13: .byte 0x00
SQ14: .byte 0x00
SQ15: .byte 0x00

;Winning value block - default 2048
WIN_BLOCK: .half 2048


 	.text

 	.global uart_init
 	.global GPIO_init

 	.global uart_interrupt_init
 	.global gpio_interrupt_init
 	.global timer_interrupt_init

 	.global UART0_Handler
 	.global Switch_Handler
 	.global Timer_Handler

 	.global simple_read_character	; get keystroke w,a,s,d
 	.global read_from_push_btns		; read sw2-5
 	.global read_tiva_push_button	; read sw1
 	.global output_character
 	.global output_string
 	.global int2string				; to print current score and time
 	.global illuminate_RGB_LED
	.global modulus
	.global XORSHIFT32

 	.global lab7

ptr_to_clear_screen:	.word clear_screen
ptr_to_position		.word position
ptr_to_game_board:		.word game_board
ptr_to_win:				.word WIN_end
ptr_to_lose:			.word LOSE_end
ptr_to_end_status:		.word END_status
ptr_to_paused:			.word PAUSED
ptr_to_timescore_prompt:	.word TIMESCORE_prompt
ptr_to_score:			.word SCORE
;ptr_to_time_prompt:		.word TIME_prompt
ptr_to_time:			.word TIME

ptr_to_block2:			.word block2
ptr_to_block4:			.word block4
ptr_to_block8:			.word block8
ptr_to_block16:			.word block16
ptr_to_block32:			.word block32
ptr_to_block64:			.word block64
ptr_to_block128:		.word block128
ptr_to_block256:		.word block256
ptr_to_block512:		.word block512
ptr_to_block1024:		.word block1024
ptr_to_block2048:		.word block2048

;ptrs to abstraction layer
ptr_to_SQ0: .word SQ0
ptr_to_SQ1: .word SQ1
ptr_to_SQ2: .word SQ2
ptr_to_SQ3: .word SQ3

ptr_to_SQ4: .word SQ4
ptr_to_SQ5: .word SQ5
ptr_to_SQ6: .word SQ6
ptr_to_SQ7: .word SQ7

ptr_to_SQ8: .word SQ8
ptr_to_SQ9: .word SQ9
ptr_to_SQ10: .word SQ10
ptr_to_SQ11: .word SQ11

ptr_to_SQ12: .word SQ12
ptr_to_SQ13: .word SQ13
ptr_to_SQ14: .word SQ14
ptr_to_SQ15: .word SQ15

; ptr to winning value block
ptr_to_win_block: .word WIN_BLOCK

; Receive Interrupt Mask in UART Interrupt Mask Register
RXIM:		.equ 0x10
; Recieve Interrupt Clear in UART Interrupt Clear Register
RXIC:		.equ 0x10

; Interrupt clear register offsets
GPIOICR: 	.equ 0x41C
GPTMICR:	.equ 0x024
UARTICR:	.equ 0x044

; Tiva push button
SW1:		.equ 0x10
SW2:		.equ 0x1
SW3:		.equ 0x2
SW4:		.equ 0x4
SW5:		.equ 0x8

; Control keys
W:			.equ 0x77
A:			.equ 0x61
S:			.equ 0x73
D:			.equ 0x64

;;;------------------------------------------------------------------------------;;;

lab7:
	PUSH {lr} ; Store lr to stack

	;;; INITIALIZATION ;;;
	bl uart_init
	bl GPIO_init
	bl uart_interrupt_init
	bl gpio_interrupt_init
	bl timer_interrupt_init


	MOV R0, #0x1D62
	MOVT R0, #0x3A5B

	BL random1_16

	MOV pc,lr

	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	LDR R0, ptr_to_timescore_prompt
	BL output_string

	LDR R0, ptr_to_game_board
	BL output_string

	LDR R0, ptr_to_position
	BL output_string

	LDR R0, ptr_to_block2
	BL output_string

	MOV pc, lr


	LDR R0, ptr_to_block4
	BL output_string
	LDR R0, ptr_to_block8
	BL output_string
	LDR R0, ptr_to_block16
	BL output_string
	LDR R0, ptr_to_block32
	BL output_string
	LDR R0, ptr_to_block64
	BL output_string
	LDR R0, ptr_to_block128
	BL output_string
	LDR R0, ptr_to_block256
	BL output_string
	LDR R0, ptr_to_block512
	BL output_string
	LDR R0, ptr_to_block1024
	BL output_string
	LDR R0, ptr_to_block2048
	BL output_string

main_loop:
	B main_loop

	MOV pc, lr



;;;------------------------------------------------------------------------------;;;
;;;----------------------------INTERRUPT HANDLERS--------------------------------;;;
;;;------------------------------------------------------------------------------;;;
UART0_Handler:
	PUSH {r0-r11}

	; UART data register
	MOV R0, #0xC000
	MOVT R0, #0x4000

 	;Set the bit 4 (RXIC) in the UART Interrupt Clear Register (UARTICR)
	LDR R1, [R0, #UARTICR]
	ORR R1, #RXIC
	STR R1, [R0, #UARTICR]


	BL simple_read_character
	CMP R0, #W
	BEQ W_pressed
	CMP R0, #A
	BEQ A_pressed
	CMP R0, #S
	BEQ S_pressed
	CMP R0, #D
	BEQ D_pressed

W_pressed:
	B uart_end

A_pressed:
	B uart_end

S_pressed:
	B uart_end

D_pressed:
	B uart_end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insert Logic here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

uart_end:
	POP {r0-r11}
	BX lr


;;;------------------------------------------------------------------------------;;;
;;;------------------------------------------------------------------------------;;;
Switch_Handler:

	PUSH {r0-r11}

	;;;-------------------------------------------------------------;;;
	; Clear the Interrupt via the GPIO Interrupt Clear Register

	; port F
	MOV R0, #0x5000
	MOVT R0, #0x4002

	LDR R1, [R0, #GPIOICR]
	ORR R1, #SW1
	STR R1, [R0, #GPIOICR]

	; port D
	MOV R0, #0x7000
	MOVT R0, #0x4000

	LDR R1, [R0, #GPIOICR]
	ORR R1, #SW2
	ORR R1, #SW3
	ORR R1, #SW4
	ORR R1, #SW5
	STR R1, [R0, #GPIOICR]
	;;;-------------------------------------------------------------;;;
	; check which switch was pressed

	BL read_tiva_push_button
	CMP R0, #1
	BEQ SW1_pressed

	;check pause status for sw2-5
	LDR R1, ptr_to_paused
	LDRB R0, [R1]
	CMP R0, #0x0	; if playing, button has no effect
	BEQ switch_end

	;check which menu (std pause, change win val)
	;LDR R1, ptr_to_menu
	LDRB R0, [R1]
	CMP R0, #0x0	; if playing, button has no effect
	BEQ switch_end

	BL read_from_push_btns
	CMP R0, #0x1
	BEQ SW2_pressed
	CMP R0, #0x2
	BEQ SW3_pressed
	CMP R0, #0x4
	BEQ SW4_pressed
	CMP R0, #0x8
	BEQ SW5_pressed

; Pauses the game, if already paused, this will have no effect
SW1_pressed:

	;pause status
	LDR R1, ptr_to_paused
	LDRB R0, [R1]
	CMP R0, #0x0
	BNE switch_end
	MOV R0, #0x1
	STRB R0, [R1]

	; disable timer

	; display pause menu


	;;;; if in change win val menu ;;;;
	LDR R1, ptr_to_win_block
	MOV R0, #256
	STRH R0, [R1]

	B switch_end

; if paused, quit game
SW2_pressed:

	;check pause status
;	LDR R1, ptr_to_paused
;	LDRB R0, [R1]
;	CMP R0, #0x0	; if playing, button has no effect
;	BEQ switch_end

	;;;; if in change win val menu ;;;;
	LDR R1, ptr_to_win_block
	MOV R0, #2048
	STRH R0, [R1]
	; redisplay pause menu


	; else, quit/end the game

	; new timer
	; new score
	; display start menu

	B switch_end

; if paused, restart game
SW3_pressed:

	;check pause status
	LDR R1, ptr_to_paused
	LDRB R0, [R1]
	CMP R0, #0x0	; if playing, button has no effect
	BEQ switch_end

	; new board
	; new timer
	; new score
	; keep winning block value

	;;;; if in change win val menu ;;;;
	LDR R1, ptr_to_win_block
	MOV R0, #1024
	STRH R0, [R1]
	; redisplay pause menu

	B switch_end

; if paused, resume game
SW4_pressed:

	;check pause status
	LDR R1, ptr_to_paused
	LDRB R0, [R1]
	CMP R0, #0x0
	BEQ switch_end

	;unpause
	MOV R0, #0x0
	STRB R0, [R1]

	; reenable timer



	;;;; if in change win val menu ;;;;
	LDR R1, ptr_to_win_block
	MOV R0, #512
	STRH R0, [R1]

	; redisplay pause menu

	B switch_end


; if paused, change win number
SW5_pressed:
	B switch_end

	; display new menu with sw2-5 options for win block

	; display pause menu

	;;;; if in change win val menu ;;;;
	LDR R1, ptr_to_win_block
	MOV R0, #256
	STRH R0, [R1]

	; redisplay pause menu


switch_end:
	POP {r0-r11}
 	BX lr ; Return










;;;------------------------------------------------------------------------------;;;
Timer_Handler:
	PUSH {r0-r11}

	MOV R0, #0x0000
	MOVT R0, #0x4003

	; set TATOCINT to clear interrupt
	LDR R1, [R0, #GPTMICR]
	ORR R1, #0x1
	STR R1, [R0, #GPTMICR]


	; increment timer
	LDR R0, ptr_to_time
	LDR R1, [R0]
	ADD R1, #1
	STR R1, [R0]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insert Logic here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

timer_end:
	POP {r0-r11}
 	BX lr ; Return

;;;------------------------------------------------------------------------------;;;











;;;------------------------------------------------------------------------------;;;
;;;----------------------------RANDON NUMBER GENERATOR---------------------------;;;
;;;------------------------------------------------------------------------------;;;
; Takes in initial arguments in R0
; Returns resulting pseudo-random number mod 16 in R0
random1_16:
	PUSH{r1-r4, lr}

	; x ^= x rot> 13
	ROR R1, R0, #13
	EOR R1, R0

	; x ^= x>>17
	LSR R2, R1, #17
	EOR R2, R1

	; x = x%r1
	MOV R0, R2
	MOV R1, #16
	BL modulus

	POP{r1-r4, lr}
	MOV pc, lr
;;;------------------------------------------------------------------------------;;;



;;;------------------------------------------------------------------------------;;;
;;;----------------------------RENDER GAME BOARD---------------------------------;;;
;;;------------------------------------------------------------------------------;;;
;;; Basic idea, push all the pointers to the stack, then pop them one-by-one
;;; when poped they are mapped to the correct position on game board
;;; their value is then used to determine which block to render

render_game_board:
	PUSH {R0-R11}

	; Order of ptrs after the loading phase
	;------Stack-------
	; SQ15
	; SQ14
	; SQ13
	; SQ12
	; SQ11
	; SQ10
	; SQ9
	; SQ8
	; SQ7
	; SQ6
	; SQ5
	; SQ4
	; SQ3
	; SQ2
	; SQ1
	; SQ0

;;;---------------------Loading Phase------------------------;;;
;;; (hint)
	; POP is actually LDM SP! <Register List>
	;PUSH is actually STMDB SP! <Register List>

	;Load Row 4 (12,13,14,15)
	LDR R0, ptr_to_SQ0
	LDR R1, ptr_to_SQ1
	LDR R2, ptr_to_SQ2
	LDR R3, ptr_to_SQ3
	;push to stack
	STMDB SP!, {R0-R3}

	;Load Row 3 (8,9,10,11)
	LDR R0, ptr_to_SQ0
	LDR R1, ptr_to_SQ1
	LDR R2, ptr_to_SQ2
	LDR R3, ptr_to_SQ3
	;push to stack
	STMDB SP!, {R0-R3}

	;Load Row 2 (4,5,6,7)
	LDR R0, ptr_to_SQ0
	LDR R1, ptr_to_SQ1
	LDR R2, ptr_to_SQ2
	LDR R3, ptr_to_SQ3
	;push to stack
	STMDB SP!, {R0-R3}

	;Load Row 1 (0,1,2,3)
	LDR R0, ptr_to_SQ0
	LDR R1, ptr_to_SQ1
	LDR R2, ptr_to_SQ2
	LDR R3, ptr_to_SQ3
	;push to stack
	STMDB SP!, {R0-R3}

	;At this point the pointers are all loaded onto the stack
	;Using R1 for the rows value

	;Using ANSI instead
	;LDR R1, ptr_to_mov_begin
	BL output_string

	MOV R2, #0x1 ;start i

RGB_Loop:
	; R1 ~ location to print
	; R2 ~ counter

	;calculating loop complete
	CMP R2, #0x10
	BEQ RGB_end

	; Calculating need for indent
	PUSH {R0, R1}
	MOV R0, R2	;Loading i onto mod
	MOV R1, #0x4
	BL modulus	; i % 4

	CMP R0, #0x0 ; if i % 4 == 0 then we need to indent
	POP {R0, R1} ;I think this should be fine
	BEQ RGB_new_row


	LDM SP!, {R0}
	LDR R0, [R0]	;Set up R0 to be value of the block
	B RGB_Compare

RGB_new_row:
	;LDR R1, ptr_to_new_row
	BL output_string
	LDM SP!, {R0}
	LDR R0, [R0]	;Set up R0 to be value of the block
	B RGB_Compare


	; Compare the value to optional pow(2) number
RGB_Compare:
	CMP R0, #0x2
	BEQ Render2

	CMP R0, #0x4
	BEQ Render4

	CMP R0, #0x8
	BEQ Render8

	CMP R0, #0x10
	BEQ Render16

	CMP R0, #0x20
	BEQ Render32

	CMP R0, #0x40
	BEQ Render64

	CMP R0, #0x80
	BEQ Render128

	CMP R0, #0x100
	BEQ Render256

	CMP R0, #0x200
	BEQ Render512

	CMP R0, #0x400
	BEQ Render1024

	CMP R0, #0x800
	BEQ Render2048

	;In case there is a zero
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

;;; Rendering via string and dox value
;;; R1 holds the memory address of the top left position of the block
Render2:
	LDR R0, ptr_to_block2 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop
Render4:
	LDR R0, ptr_to_block4 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render8:
	LDR R0, ptr_to_block8 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render16:
	LDR R0, ptr_to_block16 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render32:
	LDR R0, ptr_to_block32 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render64:
	LDR R0, ptr_to_block64 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render128:
	LDR R0, ptr_to_block128 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render256:
	LDR R0, ptr_to_block256 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render512:
	LDR R0, ptr_to_block512 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render1024:
	LDR R0, ptr_to_block1024 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

Render2048:
	LDR R0, ptr_to_block2048 ;print the current block
	BL output_string
	MOV R0, R1 ;Move the cursor
	BL output_string
	B RGB_Loop

RGB_end:
	POP {R0, R11}
	MOV pc, lr


;------------;
ML_end:
	B ML_end

	.end
