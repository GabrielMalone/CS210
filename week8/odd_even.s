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
            ldr R0, =num    @ each int of arrary
            ldr R1, =array @ load array from mem
            ldr R1, [R1, R10, lsl #2]@ next word
            bl printf
            add R10, #1      @ increment counter
            b printloop         
@ ----------------------------------------------
@           setup for odd even count loop
@ ----------------------------------------------  
setup:      ldr R0, =brackt 
            bl  printf   @ finish printing array
            mov R0, #0            @ even counter
            mov R1, #0             @ odd counter
            ldr R2, =array @ load array from mem
            mov R3, #0       @ counter for loops
@ ----------------------------------------------
@           loop to find number of even and odds
@ ----------------------------------------------
oeloop:     cmp R3, #10           @ loop counter
            bge printres             @ exit loop 
            ldr R7, [R2, R3, lsl #2] @ next word
            tst R7, #0x80000000@ neg mask w flag
            bne twoscompmin @ if neg check 2comp
            tst R7, #1     @ else look at lo bit 
            addeq R0, #1 @ +1 even if 0 flag set
            addne R1, #1 @ + 1 odd if 1 flag set
reenter:    add R3, #1       @ increment counter
            b oeloop
@ ----------------------------------------------
@           perform 2s complement on neg vals
@ ----------------------------------------------
twoscompmin:mvn R8, R7 @ if odd logical not bits
            add R8, #1                   @ add 1 
            tst R8, #1            @ check lo bit
            addeq R0, #1            @ if 0, even
            addne R1, #1             @ if 1, odd
            b reenter          @ go back to loop
@ ----------------------------------------------
@           print results
@ ----------------------------------------------
printres:   mov R2, R0     @ mov the evens to R2 
            ldr R0, =results
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
results:    .asciz   "# odds: %d, # evens: %d\n"
array:      .word 10245,2,-3,4,5,-6,7,8,-9000,10
negmask:    .word 0x80000000  @check if 1 is set
                 
