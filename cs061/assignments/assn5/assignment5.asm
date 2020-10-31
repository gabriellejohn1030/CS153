;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Assignment name: Assignment 5
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

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
MENU_LOOP			
    LD R0,MENU_3200	 ;JUMP TO MENU SUBROUTINE
    JSRR R0
				
    ADD R3,R1,#0		;
    ADD R3,R3,#-1
 	
    ADD R3,R1,#0		
    ADD R3,R3,#-2
  
    
    ADD R3,R1,#0
    ADD R3,R3,#-3
 
    
    ADD R3,R1,#0
    ADD R3,R3,#-4
 
    
    ADD R3,R1,#0
    ADD R3,R3,#-5
  
    ADD R3,R1,#0
    ADD R3,R3,#-6
    
    ADD R3,R1,#0
    ADD R3,R3,#-7
    BRz GOODBYE
    
    BRnzp MENU_LOOP		;any other number will put it back to menu loop


GOODBYE
    LEA R0,Goodbye
    PUTS


HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU_3200 .FILL x3200
ALL_MACHINES_BUSY_3400 .FILL x3400
ALL_MACHINES_FREE_3600 .FILL x3600
NUM_BUSY_MACHINES_3800 .FILL x3800
NUM_FREE_MACHINES_4000 .FILL x4000
MACHINE_STATUS_4200 .FILL x4200
FIRST_FREE_4400 .FILL x4400
GET_INPUT_4600 .FILL x4600
PRINT_NUM_4800 .FILL x4800


;Other data 
STATUS .FILL #0

;Strings for options
NEWLINE .FILL '\n'
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"
FIRSTFREE1 .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.orig x3200
;HINT back up 
ST R7,R7_BACKUP_3200

INTRO
    LD R0,Menu_string_addr
    PUTS

    GETC				;GET USER INPUT
    OUT			
    ADD R1,R0,#0		;LOAD CHAR INTO R1
    AND R0,R0,#0		;RESET R0 FOR NEWLINE
    ADD R0,R0,#10		;LOAD ASCII OF NEWLINE
    OUT
    ADD R0,R1,#0
    BR INPUT_CONVERSION		
   
ERROR
    LEA R0,Error_msg_1
    PUTS
    BRnzp INTRO
    
INPUT_CONVERSION
    LD R2,ASCII_TO_DEC_3200	
    ADD R1,R1,R2				;CONVERT
    ADD R1,R1,#-1				
    BRn ERROR					;ERROR IF LESS THAN 0
    ADD R1,R0,#0				;RELOAD CHAR INTO R1
    LD R2,ASCII_SEVEN			;LOAD WITH NEG ASCII VAL OF 7
    ADD R1,R1,R2		
    BRp ERROR					;ERROR IF GREATER THAN 7
    ADD R1,R0,#0				;IF BETWEEN 1-7, THEN RELOAD CHAR INTO R1
    LD R2,ASCII_TO_DEC_3200
    ADD R1,R1,R2		
    BRnzp END	

END
    AND R0,R0,#0	;CLEAR REGISTERS
    AND R2,R2,#0
    
    ;HINT Restore
    LD R7,R7_BACKUP_3200

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000
R7_BACKUP_3200 .BLKW #1
ASCII_TO_DEC_3200 .FILL #-48
ASCII_SEVEN .FILL #-55



;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3400
;HINT back up 
	ST R7,R7_BACKUP_3400
;HINT Restore
	LD R7,R7_BACKUP_3400
RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xCE00
R7_BACKUP_3400 .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.orig x3600			
;HINT back up 
	ST R7,R7_BACKUP_3600
;HINT Restore
	LD R7,R7_BACKUP_3600
RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xCE00
R7_BACKUP_3600 .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.orig x3800
;HINT back up 
    ST R7,R7_BACKUP_3800
;HINT Restore
    LD R7,R7_BACKUP_3800

RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xCE00
R7_BACKUP_3800 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.orig x4000
;HINT back up
    ST R7,R7_BACKUP_4000
;HINT Restore
	LD R7,R7_BACKUP_4000
	RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xCE00
R7_BACKUP_4000 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.orig x4200
;HINT back up 	
    ST R7,R7_BACKUP_4200
;HINT Restore
    LD R7,R7_BACKUP_4200

RET

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xCE00
R7_BACKUP_4200 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.orig x4400
;HINT back up 
    ST R7,R7_BACKUP_4400
;HINT Restore
    LD R7,R7_BACKUP_4400

RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xCE00
R7_BACKUP_4400 .BLKW #1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4600
	
	ST R7,R7_BACKUP_4600
	
	; Set up flags, counters, accumulators as needed
	AND R1,R1,#0 ;REGISTER TO STORE CHAR
	AND R2,R2,#0 ;REGISTER TO STORE FLAG
	AND R3,R3,#0 ;COUNTER
	AND R4,R4,#0 ;TEMPORARY REGISTER
	AND R5,R5,#0 ;REGISTER TO STORE FINAL RESULT
	AND R6,R6,#0 ;REGISTER TO LOAD LABELS TO AVOID OVERFLOW
	AND R7,R7,#0 ;STORE INITIAL VALUE OF R4 TEMPORARILY

MAIN_START
; output intro prompt
	LEA R0, prompt
	PUTS	
; Get first character, test for '\n', '+', '-', digit/non-digit
LOOP
	GETC ;CHAR IS STORED IN R0
	OUT
	ADD R1,R0,#0 ;LOAD FIRST CHAR INTO R1
	;LD R6,ENTER
	;ADD R1,R1,R6 ;CHECK IF USER ENTERED A NEWLINE MANUALLY
	BRz NEWLINE_LOOP ;IF SO, GO TO ENDING LOOP
	BRnp CHECK_SIGN_LOOP ;IF NOT, CHECK SIGNS
	
	
; is very first character = '\n'? if so, just quit (no message)!

; is it = '+'? if so, ignore it, go get digits
CHECK_SIGN_LOOP
	ADD R1,R0,#0	   ;AGAIN, LOAD R0 TO R1
	ADD R1,R1,#-12 	   ;CHECK IF CHAR INPUTTED WAS '+'
	ADD R1,R1,#-12 
	ADD R1,R1,#-12 
	ADD R1,R1,#-6 
	BRz IGNORE_SIGN_LOOP ;IF SO, IGNORE AND GO STRAIGHT TO GETTING DIGITS
	BRnp CHECK_FOR_NEG_LOOP ;CHECK FOR NEG SIGN SINCE ASCII OF '-' IS GREATER THAN THE POSITIVE VALUE OF '+'
	
IGNORE_SIGN_LOOP
	GETC
	OUT
	ADD R1,R0,#0
	LD R6,ENTER
	ADD R1,R1,R6
	BRz NEWLINE_LOOP
	BR LESS_THAN_ZERO_FOR_PLUS_SIGN

LESS_THAN_ZERO_FOR_PLUS_SIGN
	ADD R1,R0,#0
	LD R6,ZERO
	ADD R1,R1,R6 ;ADD NEG ASCII VAL OF 0 TO CHECK IF ITS LESS THAN 0
	BRn OUTPUT_ERROR_MSG_LESS_THAN_ZERO2 
	BR  GREATER_THAN_NINE_FOR_PLUS_SIGN ;IF IT IS POSITIVE THEN CHECK IF VAL IS GREATER THAN 9
OUTPUT_ERROR_MSG_LESS_THAN_ZERO2
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START ;START WHOLE PROCESS OVER
	
GREATER_THAN_NINE_FOR_PLUS_SIGN
	ADD R1,R0,#0
	LD R6,NINE
	ADD R1,R1,R6 ;SUBTRACT ASCII VALUE OF 9 TO R1
	BRp OUTPUT_ERROR_MSG_GREATER_THAN_NINE2 ;IF POSITIVE (>9) THEN OUTPUT ERROR MESSAGE
	BR  ADD_FIRST_CHAR_WHEN_PLUS_SIGN_ENTERED ;THIS MEANS THAT IT IS WITHIN RANGE AND WE CAN GO GET REMAINING DIGITS
OUTPUT_ERROR_MSG_GREATER_THAN_NINE2
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START ;START OVER
	
ADD_FIRST_CHAR_WHEN_PLUS_SIGN_ENTERED
	ADD R4,R0,#0 ;LOAD FIRST CHAR INTO R4
	LD R3,COUNTER_4600 ;LOAD COUNTER INTO R3
	LD R6,ASCII_TO_DEC
	ADD R4,R4,R6 ;CONVERT ASCII TO DECIMAL
	ADD R5,R4,#0 ;ADD (LOAD) VALUE INTO DESIGNATED REGISTER

	ADD R3,R3,#-1 ;DECREMENT COUNTER
	BR GET_REMAINING_DIGITS
; is it = '-'? if so, set neg flag, go get digits
CHECK_FOR_NEG_LOOP
	ADD R1,R0,#0
	LD R6,NEG_SIGN
	ADD R1,R1,R6
	BRz SET_FLAG ;IF THERE IS A NEGATIVE SIGN, SET FLAG TO -1
	BR LESS_THAN_ZERO_LOOP ;IF NOT, CHECK IF CHAR LESS THAN 0			 
SET_FLAG
	ADD R2,R2,#-1
	BR GET_FIRST_CHAR_FOR_NEG_NUM ;GO IMMEDIATELY TO GETTING THE FIRST CHAR FOR NEG NUM
GET_FIRST_CHAR_FOR_NEG_NUM
	GETC
	OUT
	ADD R1,R0,#0
	LD R6,ENTER
	ADD R1,R1,R6
	BRz CHECK_IF_NEG_SIGN_WAS_ENTERED
	BR LESS_THAN_ZERO_LOOP_FOR_NEG_SIGN
LESS_THAN_ZERO_LOOP_FOR_NEG_SIGN
	ADD R1,R0,#0
	LD R6,ZERO
	ADD R1,R1,R6 ;ADD NEG ASCII VAL OF 0 TO CHECK IF ITS LESS THAN 0
	BRn OUTPUT_ERROR_MSG_LESS_THAN_ZERO_FOR_NEG_SIGN 
	BR  GREATER_THAN_NINE_LOOP_FOR_NEG_SIGN ;IF IT IS POSITIVE THEN CHECK IF VAL IS GREATER THAN 9
OUTPUT_ERROR_MSG_LESS_THAN_ZERO_FOR_NEG_SIGN 
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START ;START WHOLE PROCESS OVER
GREATER_THAN_NINE_LOOP_FOR_NEG_SIGN
	ADD R1,R0,#0
	LD R6,NINE
	ADD R1,R1,R6 ;SUBTRACT ASCII VALUE OF 9 TO R1
	BRp OUTPUT_ERROR_MSG_GREATER_THAN_NINE_FOR_NEG_SIGN ;IF POSITIVE (>9) THEN OUTPUT ERROR MESSAGE
	BR  ADD_FIRST_CHAR_WHEN_NEG_SIGN_ENTERED ;THIS MEANS THAT IT IS WITHIN RANGE AND WE CAN GO TO FIRST CHAR
OUTPUT_ERROR_MSG_GREATER_THAN_NINE_FOR_NEG_SIGN
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START ;START OVER
ADD_FIRST_CHAR_WHEN_NEG_SIGN_ENTERED
	ADD R4,R0,#0 ;LOAD FIRST CHAR INTO R4
	LD R3,COUNTER_4600 ;LOAD COUNTER INTO R3
	LD R6,ASCII_TO_DEC
	ADD R4,R4,R6 ;CONVERT ASCII TO DECIMAL
	ADD R5,R4,#0 ;ADD (LOAD) VALUE INTO DESIGNATED REGISTER

	ADD R3,R3,#-1 ;DECREMENT COUNTER
	BR GET_REMAINING_DIGITS
; is it < '0'? if so, it is not a digit	- o/p error message, start over
LESS_THAN_ZERO_LOOP
	ADD R1,R0,#0
	LD R6,ZERO
	ADD R1,R1,R6 ;ADD NEG ASCII VAL OF 0 TO CHECK IF ITS LESS THAN 0
	BRn OUTPUT_ERROR_MSG_LESS_THAN_ZERO 
	BR  GREATER_THAN_NINE_LOOP ;IF IT IS POSITIVE THEN CHECK IF VAL IS GREATER THAN 9
OUTPUT_ERROR_MSG_LESS_THAN_ZERO
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START ;START WHOLE PROCESS OVER
	
; is it > '9'? if so, it is not a digit	- o/p error message, start over
GREATER_THAN_NINE_LOOP
	ADD R1,R0,#0
	LD R6,NINE
	ADD R1,R1,R6 ;SUBTRACT ASCII VALUE OF 9 TO R1
	BRp OUTPUT_ERROR_MSG_GREATER_THAN_NINE ;IF POSITIVE (>9) THEN OUTPUT ERROR MESSAGE
	BR  GET_FIRST_CHAR ;THIS MEANS THAT IT IS WITHIN RANGE AND WE CAN GO TO FIRST CHAR
OUTPUT_ERROR_MSG_GREATER_THAN_NINE
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START ;START OVER
	
; if none of the above, first character is first numeric digit - deal with it!
GET_FIRST_CHAR
	ADD R4,R0,#0 ;LOAD FIRST CHAR INTO R4
	LD R3,COUNTER_4600 ;LOAD COUNTER INTO R3
	LD R6,ASCII_TO_DEC
	ADD R4,R4,R6 ;CONVERT ASCII TO DECIMAL
	ADD R5,R4,#0 ;ADD (LOAD) VALUE INTO DESIGNATED REGISTER

	ADD R3,R3,#-1 ;DECREMENT COUNTER
	BR GET_REMAINING_DIGITS
	
; Now get (remaining) digits (max 5) from user and build up number in accumulator
GET_REMAINING_DIGITS
	GETC
	OUT
	ADD R1,R0,#0
	LD R6,ENTER
	ADD R1,R1,R6 ;CHECK FOR NEWLINE
	BRz CHECK_IF_NEG_SIGN_WAS_ENTERED ;CHECK IF THERE WAS A NEG SIGN ENTERED
	BR LESS_THAN_ZERO_LOOP2 ;ALWAYS CHECK IF IT IS A VALID CHAR

LESS_THAN_ZERO_LOOP2
	ADD R1,R0,#0
	LD R6,ZERO
	ADD R1,R1,R6 ;ADD NEG ASCII VAL OF 0 TO CHECK IF ITS LESS THAN 0
	BRn OUTPUT_ERROR_MSG_LESS_THAN_ZERO3 
	BR  GREATER_THAN_NINE_LOOP2 ;IF IT IS POSITIVE THEN CHECK IF VAL IS GREATER THAN 9
OUTPUT_ERROR_MSG_LESS_THAN_ZERO3
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START
	
GREATER_THAN_NINE_LOOP2
	ADD R1,R0,#0
	LD R6,NINE
	ADD R1,R1,R6
	BRp OUTPUT_ERROR_MSG_GREATER_THAN_NINE3
	BR  ADD_ADDITIONAL_DIGITS
OUTPUT_ERROR_MSG_GREATER_THAN_NINE3
	LD R0,NEWLINE_4600
	OUT
	LD R0,Error_msg_2
	PUTS
	BR MAIN_START

ADD_ADDITIONAL_DIGITS
	ADD R4,R5,#0 ;LOAD R5 INTO TEMPORARY REGISTER
	ADD R7,R4,#0
	
	ADD R7,R7,R4 ;"MULTIPLY" BY 10 (ADD 10 TO THE REGISTER 9 TIMES)
	ADD R7,R7,R4
	ADD R7,R7,R4
	ADD R7,R7,R4
	ADD R7,R7,R4
	ADD R7,R7,R4
	ADD R7,R7,R4
	ADD R7,R7,R4
	ADD R7,R7,R4
	
	LD R6,ASCII_TO_DEC
	ADD R0,R0,R6 ;CONVERT NEWLY INPUTTED VALUE TO DECIMAL
	
	ADD R7,R7,R0 ;ADD NUMBER STORED IN R0 TO THE NUMBER THAT WAS JUST MULTIPLIED BY 10
	
	ADD R5,R7,#0 ;LOAD VALUE INTO R5
	
	ADD R3,R3,#-1 ;DECREMENT COUNTER
	BRp GET_REMAINING_DIGITS ;IF NOT THE END, THEN REPEAT PROCESS
	
	ADD R2,R2,#0 ;WHEN ZERO, IT WILL CHECK THE FLAG STORED IN R2
	BRn TWOS_COMP ;IF NEG, DO TWOS COMP
	BRzp NEWLINE_LOOP ;IF ZERO OR POSITIVE THEN GO TO NEWLINE_LOOP
	
TWOS_COMP
	NOT R5,R5
	ADD R5,R5,#1
	BR NEWLINE_LOOP
	
CHECK_IF_NEG_SIGN_WAS_ENTERED
	ADD R2,R2,#0
	BRn TWOS_COMP
	BRzp NEWLINE_LOOP
; remember to end with a newline!
NEWLINE_LOOP
	LD R0,NEWLINE_4600
	OUT		
STORE_IN_R1_LOOP
	ADD R1,R5,#0
	ADD R1,R1,#0
	BRn OUTPUT_ERROR_MSG_LESS_THAN_ZERO
	ADD R3,R1,#-15
	BRp OUTPUT_ERROR_MSG_LESS_THAN_ZERO
	ADD R1,R5,#0
	
    LD R7,R7_BACKUP_4600
	
	RET  
;--------------------------------
;Data for subroutine Get input
;--------------------------------
R7_BACKUP_4600 .BLKW #1
ENTER 				.FILL  #-10
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
NEWLINE_4600 .FILL '\n'
POS_SIGN			.FILL  #-43
NEG_SIGN 			.FILL  #-45
ZERO				.FILL  #-48
NINE				.FILL  #-57
ASCII_TO_DEC		.FILL  #-48
COUNTER_4600 .FILL #6
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine has printed the number that is in R1, as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
; Note: that number is guaranteed to be in the range {#0, #15}, 
; i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4800
    ST R7, R7_BACKUP_4800

	LD R7,R7_BACKUP_4800

RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
R7_BACKUP_4800 .BLKW #1

.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xCE00			; Remote data
BUSYNESS .FILL xABCD		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
