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
; +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+
; |     | |     | |     | |     | |     | |     | |     | |     | |     | |     | |     |
; |  2  | |  4  | |  8  | | 16  | | 32  | | 64  | | 128 | | 256 | | 512 | |1024 | |2048 |
; |     | |     | |     | |     | |     | |     | |     | |     | |     | |     | |     |
; +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+
	.data

	; screens
	.global pause_menu
	.global start_menu
	.global win_block_menu
	.global clear_screen
	.global LOSE_end
	.global WIN_end

	; game components
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

	; value of each tile in grid
	.global SQ0
	.global SQ1
	.global SQ2
	.global SQ3
	.global SQ4
	.global SQ5
	.global SQ6
	.global SQ7
	.global SQ8
	.global SQ9
	.global SQ10
	.global SQ11
	.global SQ12
	.global SQ13
	.global SQ14
	.global SQ15

	; ansi position of each tile in grid
	.global position_SQ0
	.global position_SQ1
	.global position_SQ2
	.global position_SQ3
	.global position_SQ4
	.global position_SQ5
	.global position_SQ6
	.global position_SQ7
	.global position_SQ8
	.global position_SQ9
	.global position_SQ10
	.global position_SQ11
	.global position_SQ12
	.global position_SQ13
	.global position_SQ14
	.global position_SQ15

	; meta
	.global TIMESCORE_prompt
	.global SCORE
	.global TIME
	.global END_status
	.global PAUSED
	.global WIN_BLOCK
	.global position

; top row show player's time and score
TIMESCORE_prompt:	.string 27,"[1;1f",27,"[37mTIME: ",27,"[1;17f",27,"[37mSCORE: ",0xA,0xD,0x0

; track time and score for current game
SCORE:				.word 0x00000000
TIME:				.word 0x00000000

; flags for checking in progress/ended
END_status:			.byte 0x00
PAUSED:				.byte 0x00

;Winning value block - default 2048
WIN_BLOCK: .half 2048

;Data corresponding to square values
SQ0:	.byte 0x00
SQ1:	.byte 0x00
SQ2:	.byte 0x00
SQ3:	.byte 0x00

SQ4:	.byte 0x00
SQ5:	.byte 0x00
SQ6:	.byte 0x00
SQ7:	.byte 0x00

SQ8:	.byte 0x00
SQ9:	.byte 0x00
SQ10:	.byte 0x00
SQ11:	.byte 0x00

SQ12:	.byte 0x00
SQ13:	.byte 0x00
SQ14:	.byte 0x00
SQ15:	.byte 0x00


;;-----------------------------------------------------------;;
 	.text

 	.global uart_init
 	.global GPIO_init

 	.global uart_interrupt_init
 	.global gpio_interrupt_init
 	.global timer_interrupt_init

 	.global UART0_Handler			; for keystrokes
 	.global Switch_Handler			; for button/switch press
 	.global Timer_Handler			; for timer

 	.global simple_read_character	; get keystroke w,a,s,d
 	.global read_from_push_btns		; read sw2-5
 	.global read_tiva_push_button	; read sw1
 	.global output_character
 	.global output_string
 	.global int2string				; to print current score and time
 	.global illuminate_RGB_LED
	.global modulus					; r0 % r1
	.global random1_16				; RNG
 	.global lab7					; main
 	.global merge					; smallest subroutine of the movement category

ptr_to_pause_menu:			.word pause_menu
ptr_to_start_menu:			.word start_menu
ptr_to_change_win_menu:		.word win_block_menu
ptr_to_clear_screen:		.word clear_screen
ptr_to_game_board:			.word game_board
ptr_to_win:					.word WIN_end
ptr_to_lose:				.word LOSE_end
ptr_to_end_status:			.word END_status
ptr_to_paused:				.word PAUSED
ptr_to_timescore_prompt:	.word TIMESCORE_prompt
ptr_to_score:				.word SCORE
ptr_to_time:				.word TIME

ptr_to_block0:				.word block0
ptr_to_block2:				.word block2
ptr_to_block4:				.word block4
ptr_to_block8:				.word block8
ptr_to_block16:				.word block16
ptr_to_block32:				.word block32
ptr_to_block64:				.word block64
ptr_to_block128:			.word block128
ptr_to_block256:			.word block256
ptr_to_block512:			.word block512
ptr_to_block1024:			.word block1024
ptr_to_block2048:			.word block2048

;ptrs to abstraction layer
ptr_to_SQ0: 				.word SQ0
ptr_to_SQ1: 				.word SQ1
ptr_to_SQ2: 				.word SQ2
ptr_to_SQ3: 				.word SQ3

ptr_to_SQ4: 				.word SQ4
ptr_to_SQ5: 				.word SQ5
ptr_to_SQ6: 				.word SQ6
ptr_to_SQ7: 				.word SQ7

ptr_to_SQ8:					.word SQ8
ptr_to_SQ9:					.word SQ9
ptr_to_SQ10: 				.word SQ10
ptr_to_SQ11: 				.word SQ11

ptr_to_SQ12: 				.word SQ12
ptr_to_SQ13: 				.word SQ13
ptr_to_SQ14: 				.word SQ14
ptr_to_SQ15: 				.word SQ15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ptr_to_position_SQ0: 		.word position_SQ0
ptr_to_position_SQ1: 		.word position_SQ1
ptr_to_position_SQ2: 		.word position_SQ2
ptr_to_position_SQ3: 		.word position_SQ3

ptr_to_position_SQ4: 		.word position_SQ4
ptr_to_position_SQ5: 		.word position_SQ5
ptr_to_position_SQ6: 		.word position_SQ6
ptr_to_position_SQ7: 		.word position_SQ7

ptr_to_position_SQ8:		.word position_SQ8
ptr_to_position_SQ9:		.word position_SQ9
ptr_to_position_SQ10: 		.word position_SQ10
ptr_to_position_SQ11: 		.word position_SQ11

ptr_to_position_SQ12: 		.word position_SQ12
ptr_to_position_SQ13: 		.word position_SQ13
ptr_to_position_SQ14: 		.word position_SQ14
ptr_to_position_SQ15: 		.word position_SQ15

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
	;;;;;;;;;;;;;;;;;;;;;;;


	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	LDR R0, ptr_to_timescore_prompt
	BL output_string

	LDR R0, ptr_to_game_board
	BL output_string

	LDR R0, ptr_to_position_SQ0
	BL output_string

	LDR R0, ptr_to_block256
	BL output_string

	LDR R0, ptr_to_start_menu
	BL output_string

	LDR R0, ptr_to_pause_menu
	BL output_string

	LDR R0, ptr_to_change_win_menu
	BL output_string

	LDR R0, ptr_to_win
	BL output_string

	LDR R0, ptr_to_lose
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
	PUSH {r0-r11, lr}

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
	POP {r0-r11, lr}
	BX lr


;;;------------------------------------------------------------------------------;;;
;;;------------------------------------------------------------------------------;;;
Switch_Handler:

	PUSH {r0-r11, lr}

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
	CMP R0, #0x0
	BEQ SW1_pressed

	;check pause status for sw2-5
	;LDR R1, ptr_to_paused
	;LDRB R0, [R1]
	;CMP R0, #0x0	; if playing, button has no effect
	;BEQ switch_end

	;check which menu (std pause, change win val)
	;LDR R1, ptr_to_menu
	;LDRB R0, [R1]
	;CMP R0, #0x0	; if playing, button has no effect
	;BEQ switch_end

	BL read_from_push_btns
	CMP R0, #0x1		;0xE possible that its flipped?
	BEQ SW2_pressed
	CMP R0, #0x2		;0xD
	BEQ SW3_pressed
	CMP R0, #0x4		;0xB
	BEQ SW4_pressed
	CMP R0, #0x8		;0x7
	BEQ SW5_pressed

; Pauses the game, if already paused, this will have no effect
SW1_pressed:

	;pause status
	;LDR R1, ptr_to_paused
	;LDRB R0, [R1]
	;CMP R0, #0x0
	;BNE switch_end
	;MOV R0, #0x1
	;STRB R0, [R1]

	; disable timer

	; display pause menu
	LDR R0, ptr_to_pause_menu
	BL output_string

	MOV R0, #0xC ;Cyan
	BL illuminate_RGB_LED
	;;;; if in change win val menu ;;;;
	;LDR R1, ptr_to_win_block
	;MOV R0, #256
	;STRH R0, [R1]

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
	LDR R0, ptr_to_change_win_menu
	BL output_string

	;;;; if in change win val menu ;;;;
	LDR R1, ptr_to_win_block
	MOV R0, #256
	STRH R0, [R1]

	; redisplay pause menu


switch_end:
	POP {r0-r11, lr}
 	BX lr ; Return










;;;------------------------------------------------------------------------------;;;
Timer_Handler:
	PUSH {r0-r11, lr}

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
	POP {r0-r11, lr}
 	BX lr ; Return

;;;------------------------------------------------------------------------------;;;


;;;------------------------------------------------------------------------------;;;
;;;------------------------------BLOCK MOVEMENTS---------------------------------;;;
;;;------------------------------------------------------------------------------;;;
; Can be called from the UART interrupt handler
; Seperated into 4 subroutines each havine the (direction)_combine subroutine that
; is responsable for the merging of the cells, then the overall subroutine which calls
; the (direction)_combine subroutine 4 times and interacts with the system timer

;----------movement_left-------------;
; shifts enire board left one square
; must be called 4 times for complete left shift
movement_left:


;----------movement_right-------------;
; shifts enire board right one square
; must be called 4 times for complete right shift
movement_right:

;----------movement_upward-------------;
; shifts enire board up one square
; must be called 4 times for complete upwards shift
movement_upward:


;----------movement_downward-------------;
; shifts enire board down one square
; must be called 4 times for complete downwards shift
movement_downward:



;-----------------------;
; merges R4-R7 with the registers R8-R11
;1	R4 <- R8
;2	R5 <- R9
;3	R6 <- R10
;4	R7 <- R11
movement_combine:

	; First Merge
	MOV R0, R4
	MOV R1, R8
	BL merge
	MOV R4, R0
	MOV R8, R1

	; Second Merge
	MOV R0, R5
	MOV R1, R9
	BL merge
	MOV R5, R0
	MOV R9, R1

	; Third Merge
	MOV R0, R6
	MOV R1, R10
	BL merge
	MOV R6, R0
	MOV R10, R1

	; Fourth Merge
	MOV R0, R7
	MOV R1, R11
	BL merge
	MOV R7, R0
	MOV R11, R1

	;Thats all folks
	MOV pc, lr



;;;------------------------------------------------------------------------------;;;
;;;----------------------------RANDON NUMBER GENERATOR---------------------------;;;
;;;------------------------------------------------------------------------------;;;
; Takes in initial arguments in R0
; Returns resulting pseudo-random number mod 16 in R0
; Returns 2 or 4 w prob of 10/16 , 6/16 ~~~ 37.5:62.5
random_generator:
	PUSH{r2-r4, lr}

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

	; if x <= 6, return 4
	; else,		 return 2
	CMP R0, #6
	BLT gen4

	MOV R1, #2
	B rand_end
gen4:
	MOV R1, #4

rand_end:
	POP{r2-r4, lr}
	MOV pc, lr
;;;------------------------------------------------------------------------------;;;





;;;------------------------------------------------------------------------------;;;
;;;----------------------------RENDER GAME BOARD---------------------------------;;;
;;;------------------------------------------------------------------------------;;;
;;;	Takes the SQ0-SQ15 ptrs from memory and renders their associated block values
;;; to putty in the order they are defined

render_game_board:
	PUSH {R0-R11, lr}

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

	MOV R2, #0x0 ;start i

RGB_Loop:
	; R0 ~ location of cursor
	; R1 ~ Value of the SQ
	; R2 ~ counter

	;Loading the value (0-2048) from the last pop into R1
	LDM SP!, {R0}
	LDR R1, [R0]

	;Checking if loop complete
	CMP R2, #0x11
	BEQ RGB_end

	;Assigning position
	CMP R2, #0x0
	BEQ RGB_pos_SQ0

	CMP R2, #0x1
	BEQ RGB_pos_SQ1

	CMP R2, #0x2
	BEQ RGB_pos_SQ2

	CMP R2, #0x3
	BEQ RGB_pos_SQ3

	CMP R2, #0x4
	BEQ RGB_pos_SQ4

	CMP R2, #0x5
	BEQ RGB_pos_SQ5

	CMP R2, #0x6
	BEQ RGB_pos_SQ6

	CMP R2, #0x7
	BEQ RGB_pos_SQ7

	CMP R2, #0x8
	BEQ RGB_pos_SQ8

	CMP R2, #0x9
	BEQ RGB_pos_SQ9

	CMP R2, #0xA
	BEQ RGB_pos_SQ10

	CMP R2, #0xB
	BEQ RGB_pos_SQ11

	CMP R2, #0xC
	BEQ RGB_pos_SQ12

	CMP R2, #0xD
	BEQ RGB_pos_SQ13

	CMP R2, #0xE
	BEQ RGB_pos_SQ14

	CMP R2, #0xF
	BEQ RGB_pos_SQ15

;;;---------------------Set up cursor movement------------------------;;;
;;; Based upon the R2 register (AKA the order of the blocks) the cursor movement
;;; will be mapped to predetermined SQ
RGB_pos_SQ0:
	LDR R0, ptr_to_position_SQ0
	B RGB_Compare

RGB_pos_SQ1:
	LDR R0, ptr_to_position_SQ1
	B RGB_Compare

RGB_pos_SQ2:
	LDR R0, ptr_to_position_SQ2
	B RGB_Compare

RGB_pos_SQ3:
	LDR R0, ptr_to_position_SQ3
	B RGB_Compare

RGB_pos_SQ4:
	LDR R0, ptr_to_position_SQ4
	B RGB_Compare

RGB_pos_SQ5:
	LDR R0, ptr_to_position_SQ5
	B RGB_Compare

RGB_pos_SQ6:
	LDR R0, ptr_to_position_SQ6
	B RGB_Compare

RGB_pos_SQ7:
	LDR R0, ptr_to_position_SQ7
	B RGB_Compare

RGB_pos_SQ8:
	LDR R0, ptr_to_position_SQ8
	B RGB_Compare

RGB_pos_SQ9:
	LDR R0, ptr_to_position_SQ9
	B RGB_Compare

RGB_pos_SQ10:
	LDR R0, ptr_to_position_SQ10
	B RGB_Compare

RGB_pos_SQ11:
	LDR R0, ptr_to_position_SQ11
	B RGB_Compare

RGB_pos_SQ12:
	LDR R0, ptr_to_position_SQ12
	B RGB_Compare

RGB_pos_SQ13:
	LDR R0, ptr_to_position_SQ13
	B RGB_Compare

RGB_pos_SQ14:
	LDR R0, ptr_to_position_SQ14
	B RGB_Compare

RGB_pos_SQ15:
	LDR R0, ptr_to_position_SQ15
	B RGB_Compare


;;;---------------------Determine Number------------------------;;;
;;; Based off the number loaded into R1, generated from the stack pop
;;; determine the block to print corresponding to the R1 value
RGB_Compare:
	CMP R1, #0x2
	BEQ Render2

	CMP R1, #0x4
	BEQ Render4

	CMP R1, #0x8
	BEQ Render8

	CMP R1, #0x10
	BEQ Render16

	CMP R1, #0x20
	BEQ Render32

	CMP R1, #0x40
	BEQ Render64

	CMP R1, #0x80
	BEQ Render128

	CMP R1, #0x100
	BEQ Render256

	CMP R1, #0x200
	BEQ Render512

	CMP R1, #0x400
	BEQ Render1024

	CMP R1, #0x800
	BEQ Render2048

;;;-------Additional functionality-------;;;
	;In case there is a zero
	B Render0

;;;---------------------Rendering phase------------------------;;;
;;; Rendering via string and dox value
;;; R0 is the cursor move, while R1 is the block print
Render0:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block0 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop

Render2:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block2 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop

Render4:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block4;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render8:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block8 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render16:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block16 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render32:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block32 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render64:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block64 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render128:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block128 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render256:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block256 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render512:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block512 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render1024:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block1024 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop
Render2048:
	BL output_string ;Move cursor
	LDR R0, ptr_to_block2048 ;print the current block
	BL output_string
	ADD R2, R2, #0x1 ; Increment the counter
	B RGB_Loop

;;;---------------------End Render------------------------;;;
;;; Only be accessed when R2 = #0x11
RGB_end:
	POP {R0, R11, lr}
	MOV pc, lr



;------------;
ML_end:
	B ML_end

	.end
