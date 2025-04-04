@ ---------------------------------------------- 
@       Gabriel Malone | Week 9 Lab 
@ ---------------------------------------------- 
            .text
	    .global _start
@ ---------------------------------------------- 
_start:                        @ "main function"
@ ---------------------------------------------- 
@                   Task 1
@ ----------------------------------------------        
        ldr R1, =messag   @ prompt usr for input
        mov R2, #22       @ length of requst msg
        bl write       @ write request for input
        ldr R1, =asciibf  @ buffer for usr input
        mov R2, #10       @ lenghth of usr input
        bl read
        bl write     @ argument vals dont change 
@ ---------------------------------------------- 
@                   Task 2
@ ----------------------------------------------
        @ --------------------------------------
        @ print results header
        @ --------------------------------------
        ldr R1, =regval
        mov R2, #18
        bl write
        @ --------------------------------------
        @ print hex val
        @ --------------------------------------
        ldr R1,=val     @ arg 1 = val to convert
        ldr R3,=hex  @ arg 2 = addr to store hex
        bl print_as_hex 
@ ---------------------------------------------- 
@                   Task 3
@ ----------------------------------------------
        ldr R1,=t2bit   @ arg 1 = value to count
        bl counts  
        @ --------------------------------------
        mov R5, R0 @ tmp str 0's res from counts
        mov R4, R1 @ tmp str 1's res from counts
        @ --------------------------------------
        @ print results header
        @ --------------------------------------
        ldr R1, =zcount
        mov R2, #19
        bl write
        @ --------------------------------------
        @ print 0s results as hex vals
        @ --------------------------------------
        ldr R1, =val
        str R5, [R1]
        bl print_as_hex     
        @ --------------------------------------
        @ print results header
        @ --------------------------------------
        ldr R1, =ocount
        mov R2, #19
        bl write
        @ --------------------------------------
        @ print 1s results as hex vals
        @ --------------------------------------
        ldr R1, =val
        str R4, [R1]
        bl print_as_hex  
@ ---------------------------------------------- 
@                   Task 4
@ ----------------------------------------------
        mov R1, #10 @argument 1 for russian psnt
        mov R2, #123@argument 2 for russian psnt
        bl russian_peasant    @ multiply r1 * r2
        ldr R1, =val @ store result for printing
        str R0, [R1] @ store result for printing
        ldr R1, =russps  @ output msg for result
        mov R2, #19      @ output msg for result
        bl write        
        ldr R1, =val       @ print result as hex
        bl print_as_hex   
@ ----------------------------------------------   
        ldr R1, =newlin  @ print new line at end
        mov R2, #1 
        bl write   
@ ----------------------------------------------  
exit:	
        mov R0, #0		      @ return 0
	mov R7, #1 	              @ 1 = exit
	svc 0        @ switch to supervisor mode
@ ----------------------------------------------
.data
@ ----------------------------------------------
russps:  .asciz           "\nRussian P Mult: 0x"
messag:  .asciz         "Enter 10 char string: "
regval:  .asciz             "register value: 0x"
ocount:  .asciz           "\nones present:   0x"
zcount:  .asciz           "\nzeros present:  0x"
newlin:  .asciz                             "\n"
asciibf: .space     11 @10 byte buffer + newline
hex:     .space     7 @ buffer to hold hex ascii
         .align 4
t2bit:   .word 0b10000000001000000000010000000000
val:     .word      3731165867 @dec val to convrt

