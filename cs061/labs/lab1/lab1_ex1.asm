;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================

.orig x3000

	LD R1, DEC_0
	LD R2, DEC_12
	LD R3, DEC_6
	
	DO_WHILE_LOOP
		ADD R1, R1, R2
		ADD R3, R3, #-1
		BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	HALT
	
	DEC_0 .FILL #0
	DEC_12 .FILL #12
	DEC_6 .FILL #6
	
	
.end
	
