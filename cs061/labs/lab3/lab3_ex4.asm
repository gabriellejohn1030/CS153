;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000
	LEA R0, intro
	PUTS
	
	LD R1,DATAPTR ;loading start of arr into r1

	
	DO_WHILE_LOOP
		GETC
		OUT
		STR R0,R1,#0
		ADD R1,R1,#1
		ADD R0,R0,#-10 
		BRnp DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	LD R1,DATAPTR
	
	;LD R0, newline
	;OUT
	
	OUT_LOOP
		LDR R0,R1,#0
		OUT
		ADD R2,R0,#0
		LD R0, newline
		OUT
		ADD R1,R1,#1
		ADD R2,R2,#-10
		OUT
		BRnp OUT_LOOP
	END_OUT_LOOP
	
	
	HALT
	
	DATAPTR .FILL x4000
	;COUNT   .FILL #0
	

intro .STRINGZ  "Enter any amount of characters\n"
newline .FILL '\n'

.end 
