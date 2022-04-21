	.data
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

	; screens
	.global pause_menu
	.global start_menu
	.global win_block_menu
	.global clear_screen
	.global LOSE_end
	.global WIN_end
	.global game_board
	.global TIMESCORE_prompt
	.global SCORE
	.global TIME
	.global END_status
	.global START_status
	.global PAUSED_status
	.global CHANGE_status
	.global WIN_BLOCK
	.global INCR

 	.global clear_game

;;-----------------------------------------------------------;;
 	.text

 	.global UART0_Handler			; for keystrokes
 	.global Switch_Handler			; for button/switch press
 	.global Timer_Handler			; for timer

 	.global simple_read_character	; get keystroke w,a,s,d
 	.global read_from_push_btns		; read sw2-5
 	.global read_tiva_push_button	; read sw1
 	.global output_character
 	.global output_string
 	.global illuminate_RGB_LED
 	.global move_left
 	.global move_right
 	.global move_upward
 	.global move_downward
 	.global render_game_board

 	; Merge Pointers
	.global merge_A
	.global merge_B
	.global merge_C
	.global merge_D
	.global merge_E
	.global merge_F
	.global merge_G
	.global merge_H


ptr_to_pause_menu:			.word pause_menu
ptr_to_start_menu:			.word start_menu
ptr_to_change_win_menu:		.word win_block_menu
ptr_to_clear_screen:		.word clear_screen
ptr_to_game_board:			.word game_board
ptr_to_win:					.word WIN_end
ptr_to_lose:				.word LOSE_end
ptr_to_end_status:			.word END_status
ptr_to_start_status:		.word START_status
ptr_to_paused_status:		.word PAUSED_status
ptr_to_change_status:		.word CHANGE_status
ptr_to_timescore_prompt:	.word TIMESCORE_prompt
ptr_to_score:				.word SCORE
ptr_to_time:				.word TIME
ptr_to_accumulator:			.word INCR

; ptr to winning value block
ptr_to_win_block: 	.word WIN_BLOCK

END_status:			.byte 0x00
PAUSED_status:		.byte 0x00
CHANGE_status:		.byte 0x00
START_status:		.byte 0x00


INCR:				.byte 0x00
TI:					.byte 0x00
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

;ptrs to meta data
ptr_to_merge_A:		.word merge_A
ptr_to_merge_B:		.word merge_B
ptr_to_merge_C:		.word merge_C
ptr_to_merge_D:		.word merge_D
ptr_to_merge_E:		.word merge_E
ptr_to_merge_F:		.word merge_F
ptr_to_merge_G:		.word merge_G
ptr_to_merge_H:		.word merge_H

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

ptr_to_TI:					.word TI
;;;------------------------------------------------------------------------------;;;
;;;----------------------------INTERRUPT HANDLERS--------------------------------;;;
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

	BL read_from_push_btns
	CMP R0, #0x8		;0xE, possible that its 1s comp bc of pullup resistors
	BEQ SW2_pressed
	CMP R0, #0x4		;0xD
	BEQ SW3_pressed
	CMP R0, #0x2		;0xB
	BEQ SW4_pressed
	CMP R0, #0x1		;0x7
	BEQ SW5_pressed


;;-------------------------------------------------------------;;
; If playing game, pause the game
; If already paused, this will have no effect
; if in change win menu, go back to pause menu
SW1_pressed:

	;check if game started
	LDR R1, ptr_to_start_status
	LDRB R1, [R1]

	; if game not started, start it
	CMP R1, #0
	BEQ sw1_start

	;check menu status
	LDR R1, ptr_to_paused_status
	LDRB R1, [R1]

	; if not paused, just pause
	CMP R1, #0
	BEQ sw1_pause

	; already paused, check win
	LDR R1, ptr_to_change_status
	LDRB R1, [R1]

	CMP R1, #1
	BEQ sw1_change_win

	; if paused, and not in change win menu, sw1 does nothing
	B switch_end

sw1_start:

	BL clear_game

	;set started status
	LDR R1, ptr_to_start_status
	MOV R0, #0x1
	STRB R0, [R1]

	; enable timer
	MOV R0, #0x0000
	MOVT R0, #0x4003
	LDR R1, [R0, #0xC]
	ORR R1, #0x1
	STR R1, [R0, #0xC]

	B switch_end

sw1_pause:
	;set pause status
	LDR R1, ptr_to_paused_status
	MOV R0, #0x1
	STRB R0, [R1]

	; disable timer
	MOV R0, #0x0000
	MOVT R0, #0x4003
	LDR R1, [R0, #0xC]
	BIC R1, #0x1
	STR R1, [R0, #0xC]

	; display pause menu
	LDR R0, ptr_to_pause_menu
	BL output_string

	; rgb is off when game is paused
	MOV R0, #0x0
	BL illuminate_RGB_LED
	;;
	B switch_end


sw1_change_win:

	; if in change win val menu, go back to pause menu
	LDR R1, ptr_to_change_status
	MOV R0, #0
	STRB R0, [R1]

	; redisplay pause screen
	B sw1_pause

;;----------------------------------------------------------;;



;;-------------------------------------------------------------;;
; If playing game, do nothing
; If paused, quit/end game
; If change win menu, update win block to 2048
SW2_pressed:

	;check pause status
	LDR R1, ptr_to_paused_status
	LDRB R1, [R1]

	; if not paused, do nothing
	CMP R1, #0
	BEQ switch_end

	; if paused, check win
	LDR R1, ptr_to_change_status
	LDRB R1, [R1]

	; if in change win, update block to 2048
	CMP R1, #1
	BEQ sw2_change_win

	; if paused, and not in change win menu, sw2 quits game
	B sw2_quit


sw2_quit:

	; zero the timer, score, and game board
	BL clear_game

	; display start menu
	; TODO

	B switch_end

sw2_change_win:

	; update win block to 2048
	LDR R1, ptr_to_win_block
	MOV R0, #2048
	STRH R0, [R1]

	; exit change win menu
	LDR R1, ptr_to_change_status
	MOV R0, #0
	STRB R0, [R1]

	; redisplay pause menu
	B sw1_pause

;;-------------------------------------------------------------;;



;;-------------------------------------------------------------;;
; If playing game, do nothing
; If paused, restart game
; If change win menu, update win block to 1024
SW3_pressed:

	;check pause status
	LDR R1, ptr_to_paused_status
	LDRB R1, [R1]

	; if not paused, do nothing
	CMP R1, #0
	BEQ switch_end

	; if paused, check win
	LDR R1, ptr_to_change_status
	LDRB R1, [R1]

	; if in change win, update block to 1024
	CMP R1, #1
	BEQ sw3_change_win

	; if paused, and not in change win menu, sw2 quits game
	B sw3_restart


sw3_restart:

	; zero the timer, score, and game board
	BL clear_game

	; display start menu

	B switch_end

sw3_change_win:

	LDR R1, ptr_to_win_block
	MOV R0, #1024
	STRH R0, [R1]

	; exit change win menu
	LDR R1, ptr_to_change_status
	MOV R0, #0
	STRB R0, [R1]

	; redisplay pause menu
	B sw1_pause

;;-------------------------------------------------------------;;



;;-------------------------------------------------------------;;
; If playing game, do nothing
; If paused, resume game
; If change win menu, update win block to 512
SW4_pressed:

	;check pause status
	LDR R1, ptr_to_paused_status
	LDRB R1, [R1]

	; if not paused, do nothing
	CMP R1, #0
	BEQ switch_end

	; if paused, check win
	LDR R1, ptr_to_change_status
	LDRB R1, [R1]

	; if in change win, update block to 512
	CMP R1, #1
	BEQ sw4_change_win

	; if paused, and not in change win menu, sw2 quits game
	B sw4_resume

sw4_resume:

	; clear pause menu
	LDR R1, ptr_to_clear_screen
	BL output_string

	; rerender current board,time,score
	LDR R1, ptr_to_timescore_prompt
	BL output_string

	LDR R1, ptr_to_game_board
	BL output_string

	; clear paused flag
	LDR R0, ptr_to_paused_status
	MOV R1, #0
	STRB R1, [R0]

	; re-enable timer
	MOV R0, #0x0000
	MOVT R0, #0x4003
	LDR R1, [R0, #0xC]
	ORR R1, #0x1
	STR R1, [R0, #0xC]

	;;
	B switch_end

sw4_change_win:

	; update win block to 512
	LDR R1, ptr_to_win_block
	MOV R0, #512
	STRH R0, [R1]

	; exit change win menu
	LDR R1, ptr_to_change_status
	MOV R0, #0
	STRB R0, [R1]

	; redisplay pause menu
	B sw1_pause
;;-------------------------------------------------------------;;


;;-------------------------------------------------------------;;
; If playing game, do nothing
; If paused, go to change win menu
; If change win menu, update win block to 256
SW5_pressed:

	;check pause status
	LDR R1, ptr_to_paused_status
	LDRB R1, [R1]

	; if not paused, do nothing
	CMP R1, #0
	BEQ switch_end

	; if paused, check win
	LDR R1, ptr_to_change_status
	LDRB R2, [R1]

	; if in change win, update block to 256
	CMP R2, #1
	BEQ sw2_change_win

	; else, go to change win menu
sw5_change_menu:
	MOV R2, #1
	STRB R2, [R1]

	; display change win menu
	LDR R0, ptr_to_change_win_menu
	BL output_string

	B switch_end

sw5_change_win:

	; update win block to 256
	LDR R1, ptr_to_win_block
	MOV R0, #256
	STRH R0, [R1]

	; exit change win menu
	LDR R1, ptr_to_change_status
	MOV R0, #0
	STRB R0, [R1]

	; redisplay pause menu
	B sw1_pause

;;-------------------------------------------------------------;;
;; endpoint for all 5 switches after handling
switch_end:
	POP {r0-r11, lr}
 	BX lr ; Return
;;;------------------------------------------------------------------------------;;;



;;;------------------------------------------------------------------------------;;;
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



complete_movement_poll:

	; check if accum == 4
	LDR R0, ptr_to_accumulator
	LDRB R1, [R0]

	CMP R1, #4
	BEQ clear_merges

	; check TI, if true: render movement, else: clear merges
	LDR R0, ptr_to_TI
	LDRB R1, [R0]

	CMP R1, #1
	BNE clear_merges

render_movement:

	;read keypress
	BL simple_read_character
	CMP R0, #W
	BEQ W_pressed
	CMP R0, #A
	BEQ A_pressed
	CMP R0, #S
	BEQ S_pressed
	CMP R0, #D
	BEQ D_pressed

	B uart_end

W_pressed:
	BL move_upward
	BL render_game_board
	B increment_accumulator

A_pressed:
	BL move_left
	BL render_game_board
	B increment_accumulator

S_pressed:
	BL move_downward
	BL render_game_board
	B increment_accumulator

D_pressed:
	BL move_right
	BL render_game_board
	B increment_accumulator

increment_accumulator:
	LDR R0, ptr_to_accumulator
	LDRB R1, [R0]
	ADD R1, #1
	STRB R1, [R0]

	; reset TI
	MOV R1, #0
	STRB R1, [R0]

	B complete_movement_poll

clear_merges:

	; clear merge pointers
	LDR R0, ptr_to_merge_A
	LDR R1, ptr_to_merge_B
	LDR R2, ptr_to_merge_C
	LDR R3, ptr_to_merge_D
	LDR R4, ptr_to_merge_E
	LDR R5, ptr_to_merge_F
	LDR R6, ptr_to_merge_G
	LDR R7, ptr_to_merge_H

	STMDB SP!, {R0-R7}

	MOV R1, #0
	MOV R2, #1

clear_poll:
	LDMIA SP!, {R0}
	STRB R1, [R0]

	; if iterated all merges
	CMP R2, #8
	IT NE
	ADDNE R2, #1
	BNE clear_poll

	; prep SQs for win check
	LDR R0, ptr_to_SQ0
	LDR R1, ptr_to_SQ1
	LDR R2, ptr_to_SQ2
	LDR R3, ptr_to_SQ3
	STMDB SP!, {R0-R3}

	LDR R0, ptr_to_SQ4
	LDR R1, ptr_to_SQ5
	LDR R2, ptr_to_SQ6
	LDR R3, ptr_to_SQ7
	STMDB SP!, {R0-R3}

	LDR R0, ptr_to_SQ8
	LDR R1, ptr_to_SQ9
	LDR R2, ptr_to_SQ10
	LDR R3, ptr_to_SQ11
	STMDB SP!, {R0-R3}

	LDR R0, ptr_to_SQ12
	LDR R1, ptr_to_SQ13
	LDR R2, ptr_to_SQ14
	LDR R3, ptr_to_SQ15
	STMDB SP!, {R0-R3}

	; incrementer
	MOV R2, #1
	; win block value
	LDR R1, ptr_to_win_block
	LDRH R1, [R1]

check_win_poll:

	; POP value of SQ
	LDMIA SP!, {R0}
	LDR R0, [R0]

	; if current SQ = win block
	CMP R0, R1
	BEQ WIN

	; if iterated all SQs
	CMP R2, #16
	IT NE
	ADDNE R2, #1
	BNE check_win_poll

uart_end:
	POP {r0-r11, lr}
	BX lr

WIN:
	B uart_end


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


	; increment INCs
	LDR R0, ptr_to_accumulator
	LDR R1, [R0]
	ADD R1, #1
	STR R1, [R0]

	; toggle TI
	MOV R1, #1
	LDR R0, ptr_to_TI
	STRB R1, [R0]



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insert Logic here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

timer_end:
	POP {r0-r11, lr}
 	BX lr ; Return

;;;------------------------------------------------------------------------------;;;
.end
