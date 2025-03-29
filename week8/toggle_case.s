@ ----------------------------------------------
@       Gabriel Malone | Week 8 Lab | CS210
@ ----------------------------------------------        
        .text
        .global _start
@ ----------------------------------------------
_start:     mov R0, #1   @ tell linux write term         
            ldr R1, =message @ adr what to write
            mov R2, #21          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS
@ ----------------------------------------------
strmsg:     mov R0, #0      @ read from keyboard
            ldr R1, =asciibf    @ addr of buffer
            mov R2, #11        @ # chars to read 
            mov R7, #3       @ sys call for read
            svc 0       @ hand things over to OS
@ ----------------------------------------------
prep:       mov R0, #0            @ init counter
            mov R3, #0xDF     @ turn off 3rd bit
            ldr R1, =asciibf @load usr inpt addr
@-----------------------------------------------
@  Loop to upper an lowercase alpha chars
@-----------------------------------------------
whloop:     cmp R0, #10        @ loop terminator
            bge print  @ print results when done
            ldrb R2, [R1, R0]  @ get input @ idx
            cmp R2, #97   @ at least lowercase a
            blt add1    @ < 97 skip to increment 
            cmp R2, #122        @ no more than z 
            bgt add1   @ > 122 skip to increment 
            and R2, R2, R3    @ apply 'and' mask
            strb R2, [R1, R0]  @str @ idx offset 
            b add1                     @ ++ cntr
            b whloop                      @ loop
@-----------------------------------------------
@    increment loop when encounter a non alpha
@-----------------------------------------------               
add1:       add R0, #1          @ increment cntr
            b whloop
@ ---------------------------------------------- 
print:      mov R0, #1   @ tell linux write term         
            ldr R1, =asciibf @ adr what to write
            mov R2, #11          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS
@ ----------------------------------------------   
exit:	    mov R0, #0		      @ return 0
	    mov R7, #1		      @ 1 = exit
	    svc	0    @ switch to supervisor mode
@ ----------------------------------------------
            .data
@ ----------------------------------------------
message:    .asciz      "Enter 10 char string\n"
asciibf:    .space  11 @10 byte buffer + newline
