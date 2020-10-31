;=================================================
; Name: Gabrielle
; Email: John
; 
; Lab: lab 4, ex 2
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000

	LD R1, COUNT
	LD R2, ARRAY_PTR

	
	LOOP
		STR R1,R2,#0
		ADD R2,R2,#1
		ADD R1,R1,#1
		ADD R3,R1,#-10
		BRnp LOOP
	
	LD R4, ARRAY_PTR   ;put populated array back to new reg
	LD R5, ASCII       ;conversion of value into its ascii 
	
	OUTPUT_LOOP
		LDR R0,R4,#0   
		ADD R3,R0,#0
		ADD R0,R0,R5
		OUT
		ADD R4,R4,#1
		ADD R3,R3,#-9
		BRnp OUTPUT_LOOP
		
		
	;LD R4,ARRAY_PTR
	;ADD R4,R4,#6
	
	;LDR R2,R4,#0
	
	HALT

ARRAY_PTR  .FILL	ARRAY
COUNT      .FILL     #0
ASCII      .FILL     #48

;remote data
	.orig x4000
ARRAY  .BLKW	#10



.end
