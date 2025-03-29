@ ----------------------------------------------
@       Gabriel Malone | Week 8 Lab | CS210
@ ----------------------------------------------        
        .text
        .global main@main instead of start for C
main:   stmfd sp!, {lr} @ link register on stack
@ ----------------------------------------------
@           intro print statement
@ ----------------------------------------------
            ldr R0, =intro        
            bl printf
@ ----------------------------------------------
@           print array
@ ----------------------------------------------  
            mov R10, #0           @ init counter
printloop:  cmp R10, #10          @ loop counter
            bge setup
            ldr R0, =num
            ldr R1, =array @ load array from mem
            ldr R1, [R1, R10, lsl #2]@ next word
            bl printf
            add R10, #1      @ increment counter
            b printloop         
@ ----------------------------------------------
@           setup for min max loops
@ ----------------------------------------------  
setup:      ldr R0, =brackt
            bl  printf   @ finish printing array
            ldr R1, =array @ load array from mem
            mov R6, #0x80000000   @ HO bit check
            mov R2, #0       @ counter for loops
            mov R3, #0x0         @ min val track
            mvn R3, R3   @ set val high to start
            mov R4, #0           @ max val track
            mov R7, #0  @ reg for result of mask
            mov R8, #0 @ reg for two comp result
@ ----------------------------------------------
@           loop to find min val
@ ----------------------------------------------
minloop:    cmp R2, #10           @ loop counter
            bge maxsetup
            ldr R5, [R1, R2, lsl #2] @ next word
            and R7, R5, R6 @apply neg mask check
            cmp R7, #0 @ if 1 present branch 2sc
            bne twoscompmin
            mov R7, #0                   @ reset
retmin:     add R2, #1       @ increment counter
            b minloop
@ ----------------------------------------------
@           perform 2s complement on neg vals
@ ----------------------------------------------
twoscompmin:mvn R8, R5   @ else logical not bits
            add R8, #1                   @ add 1 
            cmp R3, R8    @ compare value to min
            movhi R3, R5  @ if old < new mov new
            b retmin
@ ----------------------------------------------
@           setup for max loop
@ ----------------------------------------------  
maxsetup:   mov R2, #0           @ reset counter
@ ----------------------------------------------
@           loop to find max val
@ ----------------------------------------------         
maxloop:    cmp R2, #10     
            bge printvals
            ldr R5, [R1, R2, lsl #2] @ next word
            and R7, R5, R6 @apply neg mask check
            cmp R7, #0 @ if 1 present (neg) skip
            bne retmax
posonly:    cmp R4, R5   @ check for new max val
            movlo R4, R5 @ if old < new, mov new  
retmax:     add R2, #1       @ increment counter
            b maxloop           
@ ----------------------------------------------
printvals:  ldr R0, =output       
            mov R1, R3               @ print min
            mov R2, R4               @ print max
            bl printf
printrange: ldr R0, =range
            add R1, R4, R8  @2scomp of neg + max
            bl printf
@ ----------------------------------------------
exit:       mov     r0, #0            @ return 0
            ldmfd   sp!, {lr}    @ pop lnk rgstr
            mov     pc, lr    @ link rgstr to pc
@ ----------------------------------------------
            .data
@ ----------------------------------------------
intro:      .asciz        "An array of ints: [ "
num:        .asciz                         "%d "
brackt:     .asciz                         "]\n"
output:     .asciz  "min val: %d, max val: %d\n"
range:      .asciz                 "range: %d\n"
array:      .word 10000,2,-3,4,5,-6,7,8,-9000,10
negmask:    .word 0x80000000  @check if 1 is set
                 
