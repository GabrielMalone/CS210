@ ----------------------------------------------
@       Gabriel Malone | Week 8 Lab | CS210
@ ----------------------------------------------        
        .text
        .global _start
@ ----------------------------------------------
_start:     mov R0, #1   @ tell linux write term         
            ldr R1, =intro   @ adr what to write
            mov R2, #20          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS
@ ----------------------------------------------
@  load the value to be convernted
@ ----------------------------------------------
prep:       ldr R9,  =val @ val to conver to hex
            ldr R13, =hex @ address to store hex
            mov R2, #7       @ indexer for array
            mov R0, #0            @ init counter
            mov R3, #0x30     @ mask bits 5 6 on 
            mov R4, #0x40 @ mask turn on 7th bit
            mov R5, #0xF7  @ mask turn off bit 4  
            mov R7, #0xF0       @ HO nibble mask 
            mov R8, #0x0F       @ LO nibble mask
@-----------------------------------------------
@  Loop to convert dec to hex R10 = HO R11 = LO
@-----------------------------------------------
whloop:     cmp R0, #4    @ loop term at 4 bytes
            bge result @ print results when done
            ldrb R6, [R9, R0]  @ get input @ idx
            and R10, R6, R7      @ get HO nibble
            lsr R10, R10, #4 @ shift into LO pos
            and R11, R6, R8      @ get LO nibble 
            cmp R10, #9   @ compare nibbles to 9
            bgt AtoFHO   @ convert to A-F if > 9
            orr R10, R10, R3 @ else to ascii 1-9
cmp2:       cmp R11, #9       @ if LO > 9 branch
            bgt AtoFLO   @ convert to A-F if > 9
            orr R11, R11, R3 @ else to ascii 1-9
reenter:    strb R11, [R13, R2]   @ store result
            sub R2, R2, #1  @ incrememnt arr idx
            strb R10, [R13, R2] @ LO @ next byte 
            add R0, R0, #1      @ increment cntr
            sub R2, R2, #1  @ incrememnt arr idx
            b whloop
@-----------------------------------------------
@ convert nibbles to 'A-F' have an 8 bit val now
@-----------------------------------------------
AtoFHO:     and R10, R10, R5  @ turn off 4th bit
            orr R10, R10, R4     @ turn on bit 7
            sub R10, R10, #1      @ subtract one
            b cmp2           @ reenter loop flow
@-----------------------------------------------
@ convert nibbles to 'A-F' have an 8 bit val now
@-----------------------------------------------
AtoFLO:     and R11, R11, R5  @ turn off 4th bit
            orr R11, R11, R4     @ turn on bit 7
            sub R11, R11, #1      @ subtract one 
            b reenter          @ go back to loop   
@ ---------------------------------------------- 
result:     mov R0, #1   @ tell linux write term         
            ldr R1, =hex     @ adr what to write
            mov R2, #10          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS
@ ----------------------------------------------  
@ print newline at end of program
@ ---------------------------------------------- 
newlineout: mov R0, #1   @ tell linux write term         
            ldr R1, =newline @ adr what to write
            mov R2, #1           @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS
@ ---------------------------------------------- 
exit:	    mov R0, #0		      @ return 0
	    mov R7, #1		      @ 1 = exit
	    svc	0    @ switch to supervisor mode
@ ----------------------------------------------
            .data
@ ----------------------------------------------
intro:      .asciz        "Hex value of R13: 0x"
newline:    .asciz                          "\n"
.align      2
val:        .word                     3731165867
hex:        .space                             7
                 
