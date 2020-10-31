;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000
;main instructions
	LD	R1,array	  	;load the address to start storing str in r1
	LD	R7,sub_add_3200	;load mem location of subroutine
	JSRR	R7			;jump to subroutine
	
	LD R1,array			;load start address into r1
	LD R7,sub_add_3400  ;load mem location of subroutine
	JSRR R7				;jump to subroutine
	
	
	HALT
;main data
	array	 	  .fill		x4000
	sub_add_3200  .fill		x3200
	sub_add_3400  .fill     x3400


.orig x3200
	ST	R7,R7_backup_3200
;----------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, and has stored it in an array
; that starts at (R1) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;-----------------------------------------------------------------------------
	ADD	R6,R1,#0		;put addr where to store string into R6
	AND	R5,R5,#0		;clear R5 so we can store non-sentinel vals
	LEA	R0,user_prompt	;prompt user to enter a string
	PUTS				
LOOP	
	GETC				;take in a char and out it
	OUT
	ADD	R2,R0,#0		;copy inputted char to R2
	LD	R3,enter		;load -10 into R3
	ADD	R2,R2,R3		;add inputted char in R1 with -10
	BRz	ENTER_PRESSED	;if 0, then inputted char is enter
	STR	R0,R6,#0		;store char in R0 at mem addr in R6
	ADD	R5,R5,#1		;increment # of non-sentinel values
	ADD	R6,R6,#1		;increment data pointer
	BRnzp	LOOP			;jump to next iteration of loop

ENTER_PRESSED	;ENTER was entered; R1 <- input; R1 <- R1 - 10 = 0; R1 = 0.
	AND	R2,R2,#0		;set R2 to 0, which is nullbyte	
	STR	R2,R6,#0		;store nullbyte at mem addr in R6
	
	AND	R0,R0,#0
	AND	R1,R1,#0
	AND	R2,R2,#0
	AND	R3,R3,#0
	AND	R4,R4,#0
	AND	R6,R6,#0
	LD	R7,R7_backup_3200
	RET
;-----------------------------------
;subroutine1 data
	R7_backup_3200	.BLKW #1
	user_prompt	.STRINGZ	"Enter any string followed by ENTER:\n"
	enter	.FILL		#-10
;----------------------------------

.orig x3400
	ST R7,R7_BACKUP_3400
;check if it is a palindrome

	AND R4,R4,#0
	ADD R4,R4,#1

	ADD R6,R1,#0  ;STORE STARTING ADDRESS
	ADD R6,R6,R5  ;NUMBER OF CHARS + 1
	ADD R6,R6,#-1 ;BACK OF THE ARRAY INDEX
	
PALINDROME_LOOP
	NOT R7,R1
	ADD R7,R7,#1
	ADD R7,R6,R7
	BRn END
	
	LDR R2,R1,#0
	LDR R3,R6,#0
	NOT R3,R3  ;CONVERT RIGHT BIN VALUE TO NEG IN ORDER TO SUBTRACT TO GET 0
	ADD R3,R3,#1
	ADD R3,R2,R3
	BRnp NOTPALINDROME ;IF LETTERS ARE NOT THE SAME THEN IT IS NOT A PALINDROME
	
	ADD R1,R1,#1 ;INCREMENT LEFT SIDE OF ARRAY
	ADD R6,R6,#-1 ;DECREMENT RIGHT SIDE
	BRnzp PALINDROME_LOOP ;CONTINUE
	
NOTPALINDROME
	ADD R4,R4,#-1 ;0 IF NOT PALINDROME
	BRnzp END

END
	LD R7,R7_BACKUP_3400
	RET ;DONE
	
	
	
;subroutine data
	R7_BACKUP_3400  .BLKW  #1

.end
