@ ----------------------------------------------
@       Gabriel Malone | Week 6 Lab | CS210
@ ----------------------------------------------        
        .text
        .global main@main instead of start for C

main:   stmfd sp!, {lr} @ link register on stack
@ ----------------------------------------------
display:    mov R0, #1   @ tell linux write term         
            ldr R1, =message @ adr what to write
            mov R2, #59          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS
@ ----------------------------------------------
@ get user input for the four values 
@ ----------------------------------------------
read0:      ldr R0, =input @<-r0 address of "%d"
            ldr R1, =num_1       @ dest of input
            bl scanf

            ldr R0, =input                @ "%d"
            ldr R1, =num_2       @ dest of input
            bl scanf

            ldr R0, =input                @ "%d"
            ldr R1, =num_3       @ dest of input
            bl scanf

            ldr R0, =input                @ "%d"
            ldr R1, =num_4       @ dest of input
            bl scanf

sums:       ldr R0, =num_1   @ -> rgstr num1 val
            ldr R0, [R0]     @ -> derefenced val
            ldr R1, =num_2   @ -> rgstr num2 val
            ldr R1, [R1]     @ -> derefenced val
            ldr R4, =num_3   @ -> rgstr num3 val
            ldr R4, [R4]     @ -> derefenced val
            ldr R5, =num_4   @ -> rgstr num4 val
            ldr R5, [R5]     @ -> derefenced val
            add R2, R0, R1      @ add 1st 2 vals
            add R6, R4, R5      @ add 2nd 2 vals
            add R7, R2, R6       @ add results ^
            ldr R3, =sum  @ -> r3 address of sum
            str R7, [R3]@ val @ r7->mem adr @ r3

echo:       ldr R0, =outmsg  
            ldr R1, =sum 
            ldr R1, [R1]        @ address of msg
            bl printf
      
@ ---------------------------------------------- 
exit:       mov     r0, #0            @ return 0
            ldmfd   sp!, {lr}    @ pop lnk rgstr
            mov     pc, lr    @ link rgstr to pc
@ ----------------------------------------------
            .data
@ ----------------------------------------------
message:    .asciz  "Enter Four(4) Numbers:\n"
outmsg:     .asciz  "your sum: %d\n" @ like in C
input:      .asciz  "%d" 
            .align  2
num_1:      .word   0
num_2:      .word   0    
num_3:      .word   0
num_4:      .word   0
sum:        .word   0
