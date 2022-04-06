	.data

	.global prompt_end
	.global game_board
	.global HV_state
	.global DIR_state
	.global piece_pos
	.global end_prompt
	.global END_status

prompt_end: .string "you lost, game over!",0

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

END_status:	.byte 0x00		 ; toggled when collision with wall
PAUSED:		.byte 0x00
;HV_state:	.byte 0x00		 ; toggle by pressing ENTER
;DIR_state:	.byte 0x00		 ; toggle by pressing SW1
;piece_pos:	.word 0x200000FA ; track the position of the game piece

 	.text

 	.global uart_interrupt_init
 	.global gpio_interrupt_init
 	.global UART0_Handler
 	.global Switch_Handler
 	.global Timer_Handler
	.global simple_read_character
 	.global output_character
 	.global read_string
 	.global output_string
 	.global uart_init
 	.global GPIO_init
 	.global illuminate_RGB_LED
 	.global lab7
	.global clear_screen
	.global update_pos
	.global det_in_Board

ptr_to_game_board: 	.word game_board
;ptr_to_prompt_end: 	.word prompt_end
;ptr_to_DIR_state:	.word DIR_state
;ptr_to_HV_state:	.word HV_state
;ptr_to_piece_pos:	.word piece_pos
ptr_to_end_status:	.word END_status
ptr_to_paused:		.word PAUSED

; GPIO INTERRUPT CONFIG
GPIOF:		.equ 0x40000000
GPIOIS: 	.equ 0x404
GPIOIBE: 	.equ 0x408
GPIOEV: 	.equ 0x40C
GPIOIM: 	.equ 0x410
GPIOICR: 	.equ 0x41C

; UART INTERRUPT CONFIG
UARTIM:		.equ 0x038
UARTICR:	.equ 0x044
UART0:		.equ 0x20

; TIMER INTERRUPT CONFIG
GPTMCFG:	.equ 0x000
GPTMTAMR:	.equ 0x004
RCGCTIMER:	.equ 0x604
GPTMTAILR:	.equ 0x028
GPTMCTL:	.equ 0x00C
GPTMIMR:	.equ 0x018
GPTMICR:	.equ 0x024

; Interrupt 0-31 Set Enable Register
EN0: 		.equ 0x100

; Receive Interrupt Mask in UART Interrupt Mask Register
RXIM:		.equ 0x10
; Recieve Interrupt Clear in UART Interrupt Clear Register
RXIC:		.equ 0x10

; Tiva push button
SW1:		.equ 0x10
SW2:		.equ 0x20
SW3:		.equ 0x40
SW4:		.equ 0x80
SW5:		.equ 0x100

; keyboard control keys
;lowerQ:		.equ 0x71
ENTER:		.equ 0x0D

; game logic components
;game_piece:	.equ 0x58	; capital X
;VERTICAL:	.equ 0x18	; +/- this value for vertical movement in a 20x20 gameboard
;HORIZONTAL:	.equ 0x01


; color map
;	40's = background color, 30's = text color
; 2:		.string 30,"[47m__2__",0	; white
; 4:		.string 30,"[46m__4__",0	; cyan
; 8:		.string 30,"[45m__8__",0	; magenta
; 16:		.string 30,"[44m_16__",0	; blue
; 32:		.string 30,"[42m_32__",0	; green
; 64:		.string 30,"[43m_64__",0	; yellow
; 128:		.string 30,"[44;1m_128_",0	; bright blue
; 256:		.string 30,"[42;1m_256_",0	; bright green
; 512:		.string 30,"[43;1m_512_",0	; bright yellow
; 1024:		.string 30,"[41;1m_1024",0	; bright red
; 2048:		.string 30,"[40m_2048",0	; black

;;;------------------------------------------------------------------------------;;;
lab7: ; This is your main routine which is called from your C wrapper
	PUSH {lr} ; Store lr to stack

	;;; INITIALIZATION ;;;
	bl uart_init
	bl GPIO_init
	bl uart_interrupt_init
	bl gpio_interrupt_init
	bl timer_interrupt_init

	LDR R0, ptr_to_game_board

	;game starts w rgb led off

main_loop:

	LDR R0, ptr_to_end_status
	LDR R0, [R0]
	CMP R0, #1
	BEQ ML_end

	B main_loop

	MOV pc, lr


;;;------------------------------------------------------------------------------;;;
;;;---------------------------------GAME LOGIC-----------------------------------;;;
;;;------------------------------------------------------------------------------;;;
update_pos:
	PUSH{r0-r11}

	LDR R0, ptr_to_HV_state
	LDR R1, ptr_to_DIR_state
	LDRB R2,[R0]
	LDRB R3,[R1]
	LDR R4, ptr_to_piece_pos
	LDR R5, [R4]
	MOV R6, #game_piece

	;;--;;
	; r0 = ptr to hv
	; r1 = ptr to dir
	; r2 = HV state
	; r3 = DIR state
	; r4 = ptr to piece pos
	; r5 = piece pos
	; r6 = X game piece
	;;--;;

	; store a blank in current spot
	MOV R0, #0x20
	STRB R0, [R5]

	; check if in vertical of horizontal state
	CMP R2, #0
	BEQ horiz

;;----------------------------------------------------------------;;
vert:
	CMP R3, #0
	BEQ move_up
	B	move_down

move_up:
	STRB R6, [R5, #VERTICAL]!	; store the game piece above pos
	STR R5, [R4]				; update the tracked pos in memory
	B update_pos_end

move_down:
	STRB R6, [R5, #-VERTICAL]!	; store the game piece below pos
	STR R5, [R4]				; update the tracked pos in memory
	B update_pos_end

;;----------------------------------------------------------------;;
horiz:
	CMP R3, #0
	BEQ move_left
	B	move_right

move_right:
	STRB R6, [R5, #HORIZONTAL]! ; store the game piece right of pos
	STR R5, [R4]				; update the tracked pos in memory
	B update_pos_end

move_left:
	STRB R6, [R5, #-HORIZONTAL]! ; store the game piece left of pos
	STR R5, [R4]				 ; update the tracked pos in memory
	B update_pos_end


;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;
update_pos_end:
	POP {r0-r11}
	MOV pc, lr
;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;-;



;;;------------------------------------------------------------------------------;;;
;;;---------------------------INTERRUPT INTIALIZATION----------------------------;;;
;;;------------------------------------------------------------------------------;;;
uart_interrupt_init:

	; UART0 base address
	MOV R0, #0xC000
	MOVT R0, #0x4000

	; set RXIM in UARTIM
	LDR R1, [R0, #UARTIM]
	ORR R1, #RXIM
	STR R1, [R0, #UARTIM]

	; allow UART to interrupt processor
	MOV R0, #0xE000
	MOVT R0, #0xE000

	; set bit 5 (uart0) in nvic
	LDR R1, [R0, #EN0]
	ORR R1, #UART0
	STR R1, [R0, #EN0]

	MOV pc, lr

;;;------------------------------------------------------------------------------;;;
gpio_interrupt_init:

	; port F
	MOV R0, #0x5000
	MOVT R0, #0x4002

	; edge< / level sensitive
	LDR R1, [R0, #GPIOIS]
	MVN R2, #SW1
	AND R1, R2
	STR R1, [R0, #GPIOIS]

	; Both / single< edge trigger
	LDR R1, [R0, #GPIOIBE]
	MVN R2, #SW1
	AND R1, R2
	STR R1, [R0, #GPIOIBE]

	; Rising< / Falling edge
	LDR R1, [R0, #GPIOEV]
	ORR R1, #SW1
	STR R1, [R0, #GPIOEV]

	; mask / unmask<
	LDR R1, [R0, #GPIOIM]
	ORR R1, #SW1
	STR R1, [R0, #GPIOIM]

	; allow GPIO port F to interrupt processor
	MOV R0, #0xE000
	MOVT R0, #0xE000

	LDR R1, [R0, #EN0]
	ORR R1, #GPIOF
	STR R1, [R0, #EN0]

	MOV pc, lr

;;;------------------------------------------------------------------------------;;;
timer_interrupt_init:

	PUSH{R0-R2, lr}

	; connect clock to timer
	MOV R0, #0xE000
	MOVT R0, #0x400F

	LDR R1, [R0, #RCGCTIMER]
	ORR R1, #0x1
	STR R1, [R0, #RCGCTIMER]


	; common base address
	MOV R0, #0x0000
	MOVT R0, #0x4003


	; disable timer
	LDR R1, [R0, #GPTMCTL]
	BIC R1, #0x1
	STR R1, [R0, #GPTMCTL]

	; put timer in 32 bit mode
	LDR R1, [R0, #GPTMCFG]
	BIC R1, #0x1
	STR R1, [R0, #GPTMCFG]

	; put timer in periodic mode
	LDR R1, [R0, #GPTMTAMR]
	BIC R1, #0x3			; safety from being in capture mode
	ORR R1, #0x2
	STR R1, [R0, #GPTMTAMR]

	; set interval period
	; 2ticks per clock @ 16MHz = 32MHz
	; 32,000,000 = 0x01E84800
	MOV R1, #0x4800
	MOVT R1, #0x01E8
	STR R1, [R0, #GPTMTAILR]

	; enable timer to interrupt processor
	LDR R1, [R0, #GPTMIMR]
	ORR R1, #0x1
	STR R1, [R0, #GPTMIMR]

	; config processor to allow interruptions from timer
	MOV R0, #0xE000
	MOVT R0, #0xE000

	LDR R1, [R0, #EN0]
	ORR R1, R1, #(1 << 19)  ;set bit 19
	STR R1, [R0, #EN0]

	; re-enable timer
	MOV R0, #0x0000
	MOVT R0, #0x4003

	LDR R1, [R0, #GPTMCTL]
	ORR R1, #0x1
	STR R1, [R0, #GPTMCTL]

	;;;
	POP{R0-R2, lr}
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

	LDRB R1, [R0]

	CMP R1, #ENTER
	BEQ ENTER_pressed

uart_end:
	POP {r0-r11}
	BX lr


ENTER_pressed:
	; if enter pressed, toggle between horizontal motion or vertical motion
	; HV_state = ~HV_state		0 = horizontal, 1 = vertical
	LDR R1, ptr_to_HV_state
	LDRB R0, [R1]
	EOR R0, #0x1
	STRB R0, [R1]

	B uart_end


;;;------------------------------------------------------------------------------;;;
Switch_Handler:

	PUSH {r0-r11}

	; port F
	MOV R0, #0x5000
	MOVT R0, #0x4002

	; Clear the Interrupt for pF4 via the GPIO Interrupt Clear Register
	LDR R1, [R0, #GPIOICR]
	ORR R1, #SW1
	STR R1, [R0, #GPIOICR]


	CMP R1, #SW1
	BEQ PAUSE_MENU

	CMP R1, #SW2
	BEQ QUIT_GAME

	CMP R1, #SW3
	BEQ RESTART_GAME

	CMP R1, #SW4
	BEQ RESUME_GAME

	CMP R1, #SW5
	BEQ SWITCH_WINNING_VAL


	; on switch press, toggle between left/right, or , up/down
	; DIR_state = ~DIR_state		0 for left/up, 1 for right/down
	LDR R1, ptr_to_DIR_state
	LDRB R0, [R1]
	EOR R0, #0x1
	STRB R0, [R1]


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

	PUSH {lr}

	; calulate new position of game piece
	BL update_pos
	BL det_in_Board

	; reprint the game board
	BL clear_screen
	LDR R0, ptr_to_game_board
	BL output_string

	POP {lr}


	POP {r0-r11}
 	BX lr ; Return



;;;------------------------------------------------------------------------------;;;
;;;-----------------------------HELPER SUBROUTINES-------------------------------;;;
;;;------------------------------------------------------------------------------;;;
simple_read_character:
	PUSH {R1-R2, lr} ; Store register lr on stack

	; data register
	MOV R1, #0xC000
	MOVT R1, #0x4000

	; load from data register
	LDRB R2, [R1]
	MOV R0, R2

 	; Restore and return
	POP {R1-R2, lr}
	MOV PC,LR
;;;------------------------------------------------------------------------------;;;

det_in_Board:
	PUSH {R0-R11}

	;define the constants
	LDR R0, ptr_to_game_board
	LDR R1, ptr_to_piece_pos

	LDR R1, [R1]

	;Running Left-Right Mod
	;r1 mod 0x18
	MOV R4, #0x18
	UDIV R3, R1, R4	; divide to get the dividend
	MUL R3, R3, R4	; Multiplying the dividend to get the change value
	SUB R3, R1, R3	; Returning the difference of the change value

	;Determine left collision
	CMP R3, #0x1
	BEQ collision

	;Determine Right collision
	CMP R3, #0x16
	BEQ collision

	;Determine Top Collision
	ADD R3, R0, #0x18	; add first f=row to the gameboard location
	CMP R1, R3 			; comapre if location is bigger than first row
	BLE collision 		; if smaller than first row break

	;Determine Bottom collision
	ADD R3, R0, #504 ; store the first address of the last
	CMP R1, R3 		 ; compare location
	BGT collision	 ; if bigger than last row break

	;no collision detected
	POP {R0-R11}
	MOV pc, lr

collision:
	;exit code here
	LDR R0, ptr_to_prompt_end
	BL output_string

	; set end status after collision
	LDR R5, ptr_to_end_status
	LDRB R4, [R5]
	ORR R4, #1
	STRB R4, [R5]

	POP {R0-R11}
	MOV pc, lr

;;;------------------------------------------------------------------------------;;;
clear_screen:
	PUSH {R0-R11, lr}

	;Clearing the screen
	MOV R0, #0xC
	BL output_character

	POP {R0-R11, lr}
	MOV PC,LR

;;;------------------------------------------------------------------------------;;;
ML_end:

	MOV R0, #0xA ;yellow
	BL illuminate_RGB_LED

	; on game end, disable timer, enter infinite loop
	MOV R0, #0x0000
	MOVT R0, #0x4003

	; disable timer
	LDR R1, [R0, #GPTMCTL]
	BIC R1, #0x1
	STR R1, [R0, #GPTMCTL]

e_l:
	B e_l

	.end
