;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000
	JSR	main_start

ERROR_CHECK
	LD	R7,checkb
	ADD	R0,R0,R7
	BRz	LOOP
	LD	R0,NEWLINE2
	OUT
	LEA	R0,error
	PUTS
	LD	R0,NEWLINE2
	OUT
	BRnzp	main_start
NOT_ZERO
	ADD	R6,R6,#-1
	ADD	R5,R0,R6
	BRz	CONTINUE
NOT_ONE
	LD	R6,ASCII
	ADD	R5,R0,R6
	BRz	CONTINUE
INVALID
	LD	R0,NEWLINE2
	OUT
	LEA	R0,wrong_num
	PUTS
SPACE_ENTERED
	ADD	R1,R1,#1
	BRnzp	LOOP

;-----------------isns-main---------------
main_start
	LD	R1,max
	AND	R4,R4,#0
LOOP
	GETC
	OUT	
	ADD	R1,R1,#-1
	ADD	R2,R1,#-16
	ADD	R2,R2,#0
	BRz	ERROR_CHECK

	LD	R7,space_char2
	ADD	R6,R0,R7
	BRz	SPACE_ENTERED

	LD	R6,ASCII
	ADD	R5,R0,R6
	BRnp	NOT_ZERO
	
	ADD	R6,R6,#-1
	ADD	R5,R0,R6
	BRnp	NOT_ONE
CONTINUE
	ADD	R5,R0,R6
	ADD	R3,R1,#0
	LD	R2,ASCII
	ADD	R0,R0,R2
LOOP2	
	ADD	R3,R3,#0
	BRz	post_compute
	ADD	R0,R0,R0
	ADD	R3,R3,#-1
	BRp	LOOP2
post_compute
	ADD	R4,R4,R0
	ADD	R1,R1,#0
	BRp	LOOP

	ADD	R2,R4,#0	;move the final value to R2
	ADD 	R1,R2,#0
	LD	R5,toASCII
	LD	R3,SUB_ADDR
	LD	R0,NEWLINE2
	OUT
	JSRR	R3

	HALT
;---------DATA-main-----------------
	max	.FILL	#17
	ASCII	.FILL	#-48
	toASCII	.FILL	#48
	SUB_ADDR	.FILL	x5000
	NEWLINE2	.FILL	#10
	checkb	.FILL	#-98
	error	.stringz	"first char not b\n"
	wrong_num	.stringz	"need 0 1 or space\n"
	space_char2	.FILL	#-32
.orig x5000
;---------------
; subroutine Instructions
;--------------
SUBROUTINE
BACKUP_INIT
	ST	R7,backup_R7

	LD 	R6,char16

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
	BRnzp	END_SUBROUTINE
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

END_SUBROUTINE
	LD	R7,backup_R7

	RET

;----------------
;subroutine data
;----------------
	char16		.FILL	#16
	space1		.FILL	#-12	;counter for printing first space
	space2		.FILL	#-8	;counter for printing second space
	space3		.FILL	#-4	;counter for printing third space
	NEWLINE		.FILL	#10	;value for newline
	space_char	.FILL	#32	;value for space	
	backup_R7	.FILL	x0


.end
