.global counts
.global russian_peasant
@ ======================================
@       count 1's and 0's procedure
@ ======================================
@ Purpose:
@ ======================================
@   count procedure accepts one argument
@	1) address of value to count in {r1}
@ ======================================
@ Initial Condition:
@ ======================================
@          arguments placed in regs {r1}
@ ======================================
@ Final Condition:
@ ======================================
@   0s sum saved to {R0}, 1s sum to {R1}
@ ======================================
@ Registers Used:      {r0,r1,r4,r5,r10}
@ ======================================

counts:
    str lr, [sp, #-4]!            @ --sp
    ldr R10, [R1]              @ get val 
    mov R5, #0            @ loop counter
    mov R0, #0          @ counter for 0s
    mov R1, #0          @ counter for 1s

    cntloop:    
    cmp R5, #32    @ break after 32 bits
    bge returna         
    and R4, R10, #1        @ test LO bit
    cmp R4, #0     @ compare result to 0
    addeq R0, #1    @ LO = 0 ++ zero cnt
    addhi R1, #1     @ LO = 1 ++ one cnt
    mov R10,R10,lsr #1  @ shft val 1 bit
    add R5, #1              @ ++ counter
    b cntloop

returna:
    ldr pc, [sp], #4             @ sp ++
    mov pc, lr	 @ return from procedure

@ ======================================
@           russian_peasant
@ ======================================
@ Purpose:
@ ======================================
@ russian peasant  accepts two arguments
@	1)        address of multiplier {r1}
@   2)      address of multiplicand {r2}
@ ======================================
@ Initial Condition:
@ ======================================
@   arguments placed in regs {r1 and r2}
@ ======================================
@ Final Condition:
@ ======================================
@                  product saved to {R0}
@ ======================================
@ Registers Used:      {r0,r1,r4,r5,r10}
@ ======================================

russian_peasant:
    str lr, [sp, #-4]!            @ --sp
    mov R0, #0   @ register to hold sums
    halfloop:
    cmp R1, #0      @ return when r1 < 1
    ble returnb  
    tst R1, #1     @ lo bit for odd/even
    addne R0, R2 @ if r1 odd then add r2
    mov R2, R2, lsl #1     @ mult r2 * 2
    mov R1, R1, lsr #1  @ halve r1 value
    b halfloop

returnb:
    ldr pc, [sp], #4             @ sp ++
    mov pc, lr	 @ return from procedure
