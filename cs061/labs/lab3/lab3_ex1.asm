;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000


	LD   R5, DATA_PTR
	
	ADD  R6,R5,#1
	
	LDR  R3,R5,#0
	LDR  R4,R6,#0
	
	ADD   R3, R3, #1
	ADD   R4, R4, #1
	
	STR   R3, R5, #0
	STR   R4, R6, #0
	HALT
	
	DATA_PTR .FILL x4000
	  
	
	;; remote data
	.orig x4000
	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41
	

.END
