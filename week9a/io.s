.global write
.global read
.global print_as_hex

@ ======================================
@           write sub procedure
@ ======================================
@ Purpose:
@ ======================================
@  write procedure accepts two arguments
@	         1) address of msg buffer R1
@	              2) length of msg in R2
@ ======================================
@ Initial Condition:
@ ======================================
@     arguments placed in regs {r1 - r2}
@ ======================================
@  Final Condition:
@ ======================================
@                    msg will be printed
@ ======================================
@ Registers Used:              {r0 - r3}
@ ======================================

write: 
    str lr, [sp, #-4]!            @ --sp
    mov R0, #1   @ tell linux write term         
    mov R7, #4     @ tell linux to write
    svc 0       @ hand things over to OS
returna:
    ldr pc, [sp], #4             @ sp ++
    mov pc, lr	 @ return from procedure

@ ======================================
@           read sub procedure
@ ======================================
@ Purpose:
@ ======================================
@   read procedure accepts two arguments
@	         1) address of msg buffer R1
@	              2) length of msg in R2
@ ======================================
@ Initial Condition:
@ ======================================
@    arguments placed in regs {r1 - r2}
@ ======================================
@ Final Condition:
@ ======================================
@          usr input will be saved to R1
@ ======================================
@ Registers Used:             {r0 - r3}
@ ======================================

read:
    str lr, [sp, #-4]!            @ --sp
    mov R0, #0      @ read from keyboard
    mov R7, #3       @ sys call for read
    svc 0       @ hand things over to OS
returnb:
    ldr pc, [sp], #4             @ sp ++
    mov pc, lr	 @ return from procedure

@ ======================================
@         print hex sub procedure
@ ======================================
@ Purpose:
@ ======================================
@     prints the hex value of a register
@	  1) address of val to convert in R1
@    2) address to store ascii hex in R3
@ ======================================
@ Initial Condition:
@ ======================================
@  arguments placed in regs {r1 and R3}
@ ======================================
@ Final Condition:
@ ======================================
@  32 bit dec val converted to ascii hex
@ ======================================
@ Registers Used:  {r0,r1,r2,r3,r10,r11}
@ ======================================

print_as_hex:
    str lr, [sp, #-4]!            @ --sp
    @ ----------------------------------
    @    load the value to be convernted
    @ ----------------------------------
    prep:   
        mov R2, #7   @ indexer for array
        mov R0, #0        @ init counter
    @-----------------------------------
    @   convert dec to hex R10=HO R11=LO
    @-----------------------------------
    whloop:     
        cmp R0, #4    @ loop for 4 bytes
        bge result     @ print when done
        ldrb R6, [R1, R0]   @ byte @ idx
        and R10, R6, #0xF0@get HO nibble
        lsr R10, R10, #4 @-> into LO pos
        and R11, R6, #0x0F@get LO nibble 
        cmp R10, #9@ compare nibble to 9
        bgt AtoFHO@ convert to A-F if >9
        orr R10, R10, #0x30  @ ascii 1-9
    cmp2:   
        cmp R11, #9   @ if LO > 9 branch
        bgt AtoFLO @ cnvrt to A-F if > 9
        orr R11, R11, #0x30  @ ascii 1-9
    reenter:
        strb R11, [R3, R2]  @ str result
        sub R2, R2, #1      @ ++ arr idx
        strb R10, [R3, R2]@  LO @ ++ byt 
        add R0, R0, #1         @ ++ cntr
        sub R2, R2, #1      @ ++ arr idx
        b whloop
    @-----------------------------------
    @           convert nibbles to 'A-F' 
    @-----------------------------------
    AtoFHO:     
        and R10, R10, #0xF7  @ off 4 bit
        orr R10, R10, #0x40   @ on bit 7
        sub R10, R10, #1  @ subtract one
        b cmp2       @ reenter loop flow
    @-----------------------------------
    @           convert nibbles to 'A-F' 
    @-----------------------------------
    AtoFLO:     
        and R11, R11, #0xF7  @ off 4 bit
        orr R11, R11, #0x40   @ on bit 7
        sub R11, R11, #1  @ subtract one 
        b reenter    @ reenter loop flow 
    @-----------------------------------
    @                print resulting hex 
    @-----------------------------------   
    result:        
        mov R1, R3   
        mov R2, #8 @ length is constant
        bl write   
returnc:
    ldr pc, [sp], #4             @ sp ++
    mov pc, lr	 @ return from procedure
