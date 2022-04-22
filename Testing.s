;;;------------------------------------------------------------------------------;;;
;;;---------------------------Move & Merge Testing-------------------------------;;;
;;;------------------------------------------------------------------------------;;;


;;;------------------------------------------------------------------------------;;;
;;		Simple move_left test, showing the merging of block2 in columns 1&2 -> column 1
;;	[2 2 _ _]		[4 _ _ _]
;;	[2 2 _ _]	to 	[4 _ _ _]
;;	[2 2 _ _]		[4 _ _ _]
;;	[2 2 _ _]		[4 _ _ _]

	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	;; Print Time score Prompt
	LDR R0, ptr_to_timescore_prompt
	BL output_string

	;; display starting screen
	LDR R0, ptr_to_game_board
	BL output_string

	;-------Move Left------;
	; Merge the block2 in Column 1 with the block2 in Column 2

	;---ROW 1---;
	LDR R0, ptr_to_SQ0 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ1 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 2---;
	LDR R0, ptr_to_SQ4 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ5 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 3---;
	LDR R0, ptr_to_SQ8 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ9 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 4---;
	LDR R0, ptr_to_SQ12 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ13 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	BL render_game_board

	BL move_left

	BL render_game_board

;;;------------------------------------------------------------------------------;;;
;;		Repeated call move_left calling
;;	[2 _ _ 2]	[2 _ 2 _]	[2 2 _ _]	[4 _ _ _]
;;	[2 _ _ 2]	[2 _ 2 _]	[2 2 _ _]	[4 _ _ _]
;;	[2 _ _ 2]	[2 _ 2 _]	[2 2 _ _]	[4 _ _ _]
;;	[2 _ _ 2]	[2 _ 2 _]	[2 2 _ _]	[4 _ _ _]

	;; clear SQ ptrs
	BL clear_board_ptrs

	;; clear merge ptrs
	BL clear_merge_ptrs

	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	;; Print Time score Prompt
	LDR R0, ptr_to_timescore_prompt
	BL output_string

	;; display starting screen
	LDR R0, ptr_to_game_board
	BL output_string

	;---ROW 1---;
	LDR R0, ptr_to_SQ0 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ3 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 2---;
	LDR R0, ptr_to_SQ4 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ7 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 3---;
	LDR R0, ptr_to_SQ8 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ11 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 4---;
	LDR R0, ptr_to_SQ12 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ15 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---Call & Render---;
	BL render_game_board

	BL move_left

	BL render_game_board

	BL move_left

	BL render_game_board

	BL move_left

	BL render_game_board

;;;------------------------------------------------------------------------------;;;
;;		Capped Merge Example 1 (held in the @)
;;		[4 2 _ 2]	[4 2 2 _]	[4 4 _ _]	[4 4 _ _](Extra third call for the test)
;;		[4 2 _ 2]	[4 2 2 _]	[4 4 _ _]	[4 4 _ _]
;;		[4 2 _ 2]	[4 2 2 _]	[4 4 _ _]	[4 4 _ _]
;;		[4 2 _ 2]	[4 2 2 _]	[4 4 _ _]	[4 4 _ _]

	;; clear SQ ptrs
	BL clear_board_ptrs

	;; clear merge ptrs
	BL clear_merge_ptrs

	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	;; Print Time score Prompt
	LDR R0, ptr_to_timescore_prompt
	BL output_string

	;; display starting screen
	LDR R0, ptr_to_game_board
	BL output_string

	;---ROW 1---;
	LDR R0, ptr_to_SQ0 ;First block4
	MOV R1, #0x4
	STR R1, [R0]

	LDR R0, ptr_to_SQ1 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ3 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 2---;
	LDR R0, ptr_to_SQ4 ;First block4
	MOV R1, #0x4
	STR R1, [R0]

	LDR R0, ptr_to_SQ5 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ7 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 3---;
	LDR R0, ptr_to_SQ8 ;First block4
	MOV R1, #0x4
	STR R1, [R0]

	LDR R0, ptr_to_SQ9 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ11 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 4---;
	LDR R0, ptr_to_SQ12 ;First block4
	MOV R1, #0x4
	STR R1, [R0]

	LDR R0, ptr_to_SQ13 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ15 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	;---Call & Render---;
	BL render_game_board

	BL move_left

	BL render_game_board

	BL move_left

	BL render_game_board

	BL move_left

	BL render_game_board

;;;------------------------------------------------------------------------------;;;
;;		Capped Merge Example 1 (held in the @)
;;		[2 2 2 2]	[4 _ 4 _]	[4 4 _ _]	[4 4 _ _](Extra third call for the test)
;;		[2 2 2 2]	[4 _ 4 _]	[4 4 _ _]	[4 4 _ _]
;;		[2 2 2 2]	[4 _ 4 _]	[4 4 _ _]	[4 4 _ _]
;;		[2 2 2 2]	[4 _ 4 _]	[4 4 _ _]	[4 4 _ _]

	;; clear SQ ptrs
	BL clear_board_ptrs

	;; clear merge ptrs
	BL clear_merge_ptrs

	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	;; Print Time score Prompt
	LDR R0, ptr_to_timescore_prompt
	BL output_string

	;; display starting screen
	LDR R0, ptr_to_game_board
	BL output_string

	;---ROW 1---;
	LDR R0, ptr_to_SQ0 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ1 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ2 ;Third block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ3 ;Fourth block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 2---;
	LDR R0, ptr_to_SQ4 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ5 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ6 ;Third block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ7 ;Fourth block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 3---;
	LDR R0, ptr_to_SQ8 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ9 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ10 ;Third block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ11 ;Fourth block2
	MOV R1, #0x2
	STR R1, [R0]

	;---ROW 4---;
	LDR R0, ptr_to_SQ12 ;First block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ13 ;Second block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ14 ;Third block2
	MOV R1, #0x2
	STR R1, [R0]

	LDR R0, ptr_to_SQ15 ;Fourth block2
	MOV R1, #0x2
	STR R1, [R0]

	;---Call & Render---;
	BL render_game_board

	BL move_left

	BL render_game_board

	BL move_left

	BL render_game_board

	BL move_left

	BL render_game_board


;;;------------------------------------------------------------------------------;;;
;;		Simple move_right test, showing the merging of block2 in columns 3&4 -> column 4
;;	[_ _ 2 2]		[_ _ _ 4]
;;	[_ _ 2 2]	to	[_ _ _ 4]
;;	[_ _ 2 2]		[_ _ _ 4]
;;	[_ _ 2 2]		[_ _ _ 4]

	;; clear terminal display
	LDR R0, ptr_to_clear_screen
	BL output_string

	;; Print Time score Prompt
	LDR R0, ptr_to_timescore_prompt
	BL output_string

	;; display starting screen
	LDR R0, ptr_to_game_board
	BL output_string




;;;------------------------End of Move & Merge Testing---------------------------;;;
;;;------------------------------------------------------------------------------;;;
