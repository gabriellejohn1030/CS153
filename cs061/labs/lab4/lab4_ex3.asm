;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 4, ex 3
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000

	LD R1, COUNT
	LD R2, ARRAY_PTR
	LD R5, MAXIMUM

	
	LOOP
		STR R1,R2,#0
		ADD R2,R2,#1
		ADD R1,R1,R1
		ADD R3,R1,R5
		BRnp LOOP
	
	LD R4,ARRAY_PTR
	ADD R4,R4,#6
	
	LDR R2,R4,#0
	
	HALT

ARRAY_PTR  .FILL	ARRAY
COUNT      .FILL     x1
MAXIMUM    .FILL    #-1024
;remote data
	.orig x4000
ARRAY  .BLKW	#10



.end
