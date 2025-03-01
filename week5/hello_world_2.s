        .data                       @ data section  
str:    .asciz  "Hello World\n"     @ define a string

        .text                       @ switch to code section
        .globl  main                @ expose entry point

main:   stmfd   sp!, {lr}           @ push link register on stack
        ldr     r0, =str            @ load offset of string
        bl      printf              @ branch wth link to printf
        mov     r0, #0              @ return 0
        ldmfd   sp!, {lr}           @ pop stack to link register
        mov     pc, lr              @ move link register to pc