;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================

; test harness
	.orig x3000

	LD	R0,SUB_PRINT_OPCODES
	JSRR	R0	
	
	LD R0,SUB_FIND_OPCODE
	JSRR R0	
		 
	halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
	SUB_PRINT_OPCODES	.FILL	x3200
	SUB_FIND_OPCODE		.FILL   x3600

;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 		 and corresponding opcode in the following format:
;		 		 ADD = 0001
;		  		 AND = 0101
;		  		 BR = 0000
;		  		 …
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3200
	ST R0,R0_BACKUP_3200
	ST R1,R1_BACKUP_3200
	ST R2,R2_BACKUP_3200
	ST R3,R3_BACKUP_3200
	ST R4,R4_BACKUP_3200
	ST R7,R7_BACKUP_3200

	LD R2,opcodes_po
	LD R3,instructions_po

FOR_EACH_OP_3200
  ;output name of OP
  FOR_EACH_CHAR_3200
    LDR R0,R3,#0
    BRz END_3200
    BRn END_FULL_3200
    OUT
    ADD R3,R3,#1
    BR FOR_EACH_CHAR_3200
  
END_3200
  ;incr past null term
  ADD R3,R3,#1

  ;output ' = '
  LEA R0,EQUALS
  PUTS


  ;output the opcode in binary
  LD R4,SUB_PRINT_OPCODE
  LDR R1,R2,#0
  JSRR R4
  ADD R2,R2,#1

  ;newline
  LD R0,NEWLINE
  OUT
  BR FOR_EACH_OP_3200

END_FULL_3200

	LD R0,R0_BACKUP_3200
	LD R1,R1_BACKUP_3200
	LD R2,R2_BACKUP_3200
	LD R3,R3_BACKUP_3200
	LD R4,R4_BACKUP_3200
	LD R7,R7_BACKUP_3200

	RET
 
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODES local data
opcodes_po		.fill x4000
instructions_po	.fill x4100

R0_BACKUP_3200 .BLKW #1
R1_BACKUP_3200 .BLKW #1
R2_BACKUP_3200 .BLKW #1
R3_BACKUP_3200 .BLKW #1
R4_BACKUP_3200 .BLKW #1
R7_BACKUP_3200 .BLKW #1
NEWLINE .FILL '\n'
EQUALS .stringz " = "
SUB_PRINT_OPCODE	.FILL		x3400


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3400
	ST R0,R0_BACKUP_3400
	ST R1,R1_BACKUP_3400
	ST R2,R2_BACKUP_3400
	ST R3,R3_BACKUP_3400
	ST R7,R7_BACKUP_3400


	LD R2,FRONT_BIT_3400
	LD R3,ASCII_OFFSET_3400

	;and input with ...1000
	;output the result converted to ascii
	AND R0,R1,R2
	BRnp FOUND_BIT_1
	LD R0,ZERO_3400
	OUT
	BR ZERO_BIT_1

FOUND_BIT_1
	LD R0,ONE_3400
	OUT

ZERO_BIT_1
	;double each itr and repeat
	ADD R1,R1,R1
	AND R0,R1,R2
	BRnp FOUND_BIT_2
	LD R0,ZERO_3400
	OUT
	BR ZERO_BIT_2
	
FOUND_BIT_2
	LD R0,ONE_3400
	OUT

ZERO_BIT_2
	ADD R1,R1,R1
	AND R0,R1,R2
	BRnp FOUND_BIT_3
	LD R0,ZERO_3400
	OUT
	BR ZERO_BIT_3
	
FOUND_BIT_3
	LD R0,ONE_3400
	OUT

ZERO_BIT_3
	ADD R1,R1,R1
	AND R0,R1,R2
	BRnp FOUND_BIT_4
	LD R0,ZERO_3400
	OUT
	BR ZERO_BIT_4
	
FOUND_BIT_4
	LD R0,ONE_3400
	OUT

ZERO_BIT_4
	LD R0,R0_BACKUP_3400
	LD R1,R1_BACKUP_3400
	LD R2,R2_BACKUP_3400
	LD R3,R3_BACKUP_3400
	LD R7,R7_BACKUP_3400
	RET
				 
				 
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
ASCII_OFFSET_3400 .FILL x30
ZERO_3400 .FILL '0'
ONE_3400 .FILL '1'
FRONT_BIT_3400 .FILL #8

R0_BACKUP_3400 .BLKW #1
R1_BACKUP_3400 .BLKW #1
R2_BACKUP_3400 .BLKW #1
R3_BACKUP_3400 .BLKW #1
R4_BACKUP_3400 .BLKW #1
R7_BACKUP_3400 .BLKW #1



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3600
				 
				 
				 
				 
				 
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo			.fill x4000
instructions_fo		.fill x4100



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
				 
				 
				 
				 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
.ORIG x4000								; list opcodes as single numbers, e.g. .fill #12
opcodes
	ADD_NUM .FILL #1
	AND_NUM .FILL #5
	BR_NUM .FILL #0
	JMP_NUM .FILL #12
	JSR_NUM .FILL #4
	JSRR_NUM .FILL #4
	LD_NUM .FILL #2
	LDI_NUM .FILL #10
	LDR_NUM .FILL #6
	LEA_NUM .FILL #14
	NOT_NUM .FILL #9
	RET_NUM .FILL #12
	RTI_NUM .FILL #8
	ST_NUM .FILL #3
	STI_NUM .FILL #11
	STR_NUM .FILL #7
	TRAP_NUM .FILL #15


.ORIG x4100								; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
instructions				 			; - be sure to follow same order in opcode & instruction arrays!
	ADD_OP .stringz "ADD"
	AND_OP .stringz "AND"
	BR_OP .stringz "BR"
	JMP_OP .stringz "JMP"
	JSR_OP .stringz "JSR"
	JSRR_OP .stringz "JSRR"
	LD_OP .stringz "LD"
	LDI_OP .stringz "LDI"
	LDR_OP .stringz "LDR"
	LEA_OP .stringz "LEA"
	NOT_OP .stringz "NOT"
	RET_OP .stringz "RET"
	RTI_OP .stringz "RTI"
	ST_OP .stringz "ST"
	STI_OP .stringz "STI"
	STR_OP .stringz "STR"
	TRAP_OP .stringz "TRAP"
	ENDSTRINGZ_3200 .FILL #-1

;===============================================================================================
