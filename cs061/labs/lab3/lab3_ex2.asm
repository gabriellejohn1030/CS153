;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000

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
	
		
	HALT
	
	DATAPTR .FILL ARRAY
	ARRAY .BLKW  #10
	COUNT .FILL  #10

intro .STRINGZ  "Enter exactly 10 characters\n"

.end 
