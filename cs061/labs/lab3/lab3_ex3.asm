;=================================================
; Name: Gabrielle John
; Email: gjohn010
; 
; Lab: lab 3, ex 3
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000
	LEA R0, intro
	PUTS
	
	LD R1,DATAPTR
	LD R2,COUNT
	
	
	DO_WHILE_LOOP
		GETC
		OUT
		STR R0,R1,#0
		ADD R1,R1,#1
		ADD R2,R2,#-1
		BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	LEA R3, ARRAY
	LD R4, DEC_10
	
	LD R0, newline
	OUT
	
	OUT_LOOP
		LDR R0,R3,#0
		OUT
		LD R0, newline
		OUT
		ADD R3,R3,#1
		ADD R4,R4,#-1
		OUT
		BRp OUT_LOOP
	END_OUT_LOOP
	
	
	HALT
	
	DATAPTR .FILL ARRAY
	ARRAY .BLKW  #10
	COUNT .FILL  #10
	DEC_10 .FILL #10

intro .STRINGZ  "Enter exactly 10 characters\n"
newline .FILL '\n'

.end 
