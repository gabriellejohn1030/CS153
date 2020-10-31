;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
	;loading first char
	GETC
	OUT
	ADD R1,R0, #0
	LD R0, newline
	OUT
	
	;loading second char
	GETC
	OUT
	ADD R2,R0, #0
	LD R0, newline
	OUT
	
	;difference
	ADD R0,R1,#0
	OUT
	LEA R0, minus
	PUTS
	ADD R0,R2,#0
	OUT
	LEA R0, equals
	PUTS
	
	;ascii to binary
	ADD R1,R1,#-12
	ADD R1,R1,#-12
	ADD R1,R1,#-12
	ADD R1,R1,#-12
	
	ADD R2,R2,#-12
	ADD R2,R2,#-12
	ADD R2,R2,#-12
	ADD R2,R2,#-12
	
	NOT R2,R2		
	ADD R2,R2,#1		
	ADD R3,R1,R2		
	ADD R3,R3,#0		
	BRn negative 		
	ADD R3,R3,#0		
	BRzp positive		
	
	negative 
			NOT R3,R3	
			ADD R3,R3,#1	
			ADD R3,R3,#12	
			ADD R3,R3,#12
			ADD R3,R3,#12
			ADD R3,R3,#12
			LD R0,neg	
			OUT
			ADD R0,R3,#0	
			OUT
			BRzp ending
	positive 
			ADD R3,R3,#12	
			ADD R3,R3,#12
			ADD R3,R3,#12
			ADD R3,R3,#12
			ADD R0,R3,#0	
			OUT
	ending	
			LD R0,newline 
			OUT		
		
		
		
		
HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
minus   .STRINGZ " - "
equals  .STRINGZ " = "
neg     .STRINGZ "-"


;---------------	
;END of PROGRAM
;---------------	
.END

