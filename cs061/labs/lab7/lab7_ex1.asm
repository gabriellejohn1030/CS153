;=================================================
; Name: Gabrielle John
; Email: gjohn010@ucr.edu
; 
; Lab: lab 7, ex 1
; Lab section: 025
; TA: Robert Colvin
; 
;=================================================
.orig x3000

;--------------
;Instructions
;--------------

  LD R1, Subroutine_1_3200
  JSRR R1

  ADD R5,R5,#1

  LD R1, Subroutine_2_3400
  JSRR R1

HALT
;--------------
;Local Data
;--------------
Subroutine_1_3200 .FILL x3200
Subroutine_2_3400 .FILL x3400

;--------------
;Subroutine 1
;--------------
.orig x3200
ST R7, Backup_R7_3200

LD R5,VALUE

LD R7, Backup_R7_3200

RET
;------------------
;Subroutine 1 Data
;------------------
Backup_R7_3200 .BLKW #1
VALUE      .FILL   #3900

;------------------
;Subroutine 2
;------------------
.orig x3400
ST R5, Backup_R5_3400
ST R7, Backup_R7_3400

LD R3, COUNTER
AND R1,R1,#0
ADD R6,R5,#0

TEN_THOUSANDS
    LD R2, MINUS_10k
    ADD R5,R5,R2
    BRzp COUNT1
    LD R0, ASCII
    ADD R0,R0,R3
    OUT
    ADD R5,R6,#0
    LD R3, COUNTER
    BRnzp THOUSANDS
COUNT1
    ADD R6,R5,#0
    ADD R3,R3,#1
    BRnzp TEN_THOUSANDS

THOUSANDS
    LD R2, MINUS_1k
    ADD R5,R5,R2
    BRzp COUNT2
    LD R0, ASCII
    ADD R0,R0,R3
    OUT
    ADD R5,R6,#0
    LD R3, COUNTER
    BRnzp HUNDREDS
COUNT2
    ADD R6,R5,#0
    ADD R3,R3,#1
    BRnzp THOUSANDS

HUNDREDS
    LD R2, MINUS_100
    ADD R5,R5,R2
    BRzp COUNT3
    LD R0, ASCII
    ADD R0,R0,R3
    OUT
    ADD R5,R6,#0
    LD R3, COUNTER
    BRnzp TENS
COUNT3
    ADD R6,R5,#0
    ADD R3,R3,#1
    BRnzp HUNDREDS

TENS
    LD R2, MINUS_10
    ADD R5,R5,R2
    BRzp COUNT4
    LD R0, ASCII
    ADD R0,R0,R3
    OUT
    ADD R5,R6,#0
    LD R3, COUNTER
    BRnzp ONES
COUNT4
    ADD R6,R5,#0
    ADD R3,R3,#1
    BRnzp TENS

ONES
    LD R0, ASCII
    ADD R0,R0,R5
    OUT
    BRnzp SR2_END

SR2_END
    LD R0, NEWLINE_CHAR2
    OUT

LD R5, Backup_R5_3400
LD R7, Backup_R7_3400

RET
;------------------
;Subroutine 2 Data
;------------------
Backup_R1_3400 .BLKW #1
Backup_R5_3400 .BLKW #1
Backup_R7_3400 .BLKW #1
ASCII .FILL #48
MINUS_10k .FILL #-10000
MINUS_1k .FILL  #-1000
MINUS_100 .FILL #-100
MINUS_10 .FILL #-10
MINUS_CHAR .FILL #45
COUNTER .FILL #0
NEWLINE_CHAR2 .FILL #10

;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"
;---------------
;END of PROGRAM
;---------------
.END
