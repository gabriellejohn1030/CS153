;=================================================
; Name: 
; Email: 
; 
; Lab: lab 4, ex 4
; Lab section: 
; TA: 
; 
;=================================================
.orig x3000

LD 	R1,VALUE_TO_ENTER	;loads the counter to store to the R1 Register
	LD	R2,DATA_PTR		;loads mem location of begin array into R2 reg
	LD	R5,max			;stores maximum value for looping ending
LOOP
	STR	R1,R2,#0		; stores the n-1th value into the nth entry
	ADD	R2,R2,#1		; increments the pointer to point to the next
	ADD	R1,R1,R1		; increment the value via bit-shift 
	ADD	R3,R1,R5		; check if the next value store is 2^9=512
	BRnp	LOOP			; if it isnt, do next iteration

	LD	R4,DATA_PTR		; reload the mem location of array into R4
	ADD	R4,R4,#6		; incremen the 7th element (since it originally
						;points to the 1st element
	LDR	R2,R4,#0		; load the 7th element into the R2 register
					;should be 2^6 = 64
begin_exercise_4	
	LD	R3,DATA_PTR		;load beginningof array ptr. only do this once
	LD	R5,ASCII
	LD	R4,outCounter
LOOP_X
	LD	R6,counter		;load the 16 ctr into R6. Do this 10 times
	LDR	R1,R3,#0		;load nth element of arr in R1. 10 times.

PRINT_BRANCH	
	ADD	R1,R1,#0		;make R1 be last used register
	BRzp	PRINT_0			;jump to 0 print
	ADD	R1,R1,#0		; make R1 last used register (again)
	BRn	PRINT_1			;jump to 1 print
NEXT_CHAR
	ADD	R1,R1,R1		;bit shift left
	ADD	R6,R6,#-1		;decrease 16 char printer

	LD	R7,space1
	ADD	R7,R6,R7
	BRz	PRINT_SPACE
	LD	R7,space2
	ADD	R7,R6,R7
	BRz	PRINT_SPACE
	LD	R7,space3
	ADD	R7,R6,R7
	BRz	PRINT_SPACE
POST_SPACE
	ADD	R6,R6,#0	
	BRp	PRINT_BRANCH
	LD	R0,NEWLINE
	OUT
	ADD	R3,R3,#1
	ADD	R4,R4,#-1
	BRp	LOOP_X
	BRnzp	END
PRINT_0
	AND	R0,R0,#0
	ADD	R0,R0,R5
	OUT
	BRnzp	NEXT_CHAR
PRINT_1	
	AND	R0,R0,#0
	ADD	R0,R0,#1
	ADD	R0,R0,R5
	OUT
	BRnzp	NEXT_CHAR
PRINT_SPACE
	LD	R0,space_char
	OUT
	BRnzp	POST_SPACE
	
END
	HALT
;------------
;data
;------------
	VALUE_TO_ENTER	.FILL	x1	;hard code 2^0 = 1 = 0000 0000 0000 0001
	DATA_PTR	.FILL	ARRAY	;label for memory location of array
	max		.FILL	#-1024	;what is 2^10? this. 
	outCounter	.FILL	#10	;counter for printing the 10 array elements
	counter		.FILL	#16	;counter for printing binary characters
	space1		.FILL	#-12	;counter for printing first space
	space2		.FILL	#-8	;counter for printing second space
	space3		.FILL	#-4	;counter for printing third space	
	NEWLINE		.FILL	#10	;value for newline
	ASCII		.FILL	#48
	space_char	.FILL	#32	;value for space
.orig x4000
	ARRAY	.BLKW	#10		;initialize empty array

.end
