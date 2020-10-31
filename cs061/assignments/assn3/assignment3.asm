;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 025
; TA: Robert Colvin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, BIN_COUNT
LD R3, SPACECOUNT

	PRINT_LOOP
		ADD R1,R1,#0
		BRzp PRINTING_ZERO
		ADD R1,R1,#0
		BRn  PRINTING_ONE
	
	PRINTING_ZERO
		LD R0,ZERO
		OUT            			;prints 0
		ADD R1,R1,R1  			;left shifting
		ADD R2,R2,#-1  			;decrements newline counter
		BRz PRINTING_NEWLINE    ;only executes if newline counter hits 0
		ADD R3,R3,#-1			;decrements space counter
		BRz PRINTING_SPACE      ;only executes if space counter hits 0
		BRp PRINT_LOOP          ;moves onto next number
	
	PRINTING_ONE
		LD R0,ONE
		OUT					  ;prints 1
		ADD R1,R1,R1		  ;left shifting
		ADD R2,R2,#-1         ;decrements newline counter
		BRz PRINTING_NEWLINE  ;only executes if newline counter hits 0
		ADD R3,R3,#-1         ;decrements space counter
		BRz PRINTING_SPACE    ;only executes if space counter hits 0
		BRp PRINT_LOOP		  ;moves onto next number 
		
	PRINTING_SPACE
		LEA R0,SPACE
		PUTS
		LD R3,SPACECOUNT
		ADD R1,R1,#0
		ADD R4,R2,#0 		 ;checks if everything got printed
		BRp PRINT_LOOP
		
	PRINTING_NEWLINE
		LEA R0,NEWLINE
		PUTS
	
	

HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xAB00	; The address where value to be displayed is stored
NEWLINE     .STRINGZ "\n"
SPACECOUNT  .FILL    #4
SPACE       .STRINGZ  " "
BIN_COUNT   .FILL    #16
ZERO        .FILL    #48
ONE         .FILL    #49

.ORIG xAB00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
