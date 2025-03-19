@ ----------------------------------------------
@       Gabriel Malone | Week 9 Lab | CS210
@ ----------------------------------------------        
        .text
        .global main@main instead of start for C

main:   stmfd sp!, {lr} @ link register on stack
@ ----------------------------------------------
@    Get user input for size of array to fill 
@ ----------------------------------------------
display:    mov R0, #1   @ tell linux write term         
            ldr R1, =msg1    @ adr what to write
            mov R2, #20          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read0:      ldr R0, =input @<-r0 address of "%d"
            ldr R1, =arr_size    @ dest of input
            bl scanf     @ get arr size from usr

prep:       ldr R1, =arr_size    
            ldr R1, [R1]
            add R1, R1, #1        
            ldr R3, =nums_arr   @ array for nums
            mov R4, #0    @ initialize a counter 
@ ----------------------------------------------
@           FILL ARRAY 
@ ----------------------------------------------
loop:       cmp R4, R1            @ loop counter
            bge lbrack       @ when done go here
            str R5, [R3, R4, LSL #2]   @ idx * 4 
            add R5, R4, #1 @ create val for arry
            add R4, R4, #1   @ increment counter
            B loop @branch back to start of loop
@ ----------------------------------------------
@           PRINT FILLED ARRAY 
@ ----------------------------------------------
lbrack:     ldr R0, =lbr    @ left bracket print
            bl printf

prep2:      ldr R5, =arr_size    
            ldr R5, [R5] 
            add R5, R5, #1         
            mov R4, #0    @ initialize a counter 

showloop:   cmp R4, R5            @ loop counter
            bge rbrack        @ conditional exit
            ldr R0, =outmsg     
            ldr R1, =nums_arr
            ldr R1, [R1, R4, LSL #2] 
            bl printf
            add R4, R4, #1   @ increment counter
            b showloop

rbrack:     ldr R0, =rbr   @ right bracket print
            bl printf
@ ----------------------------------------------
@           FIND PRIMES 
@ ----------------------------------------------

rootprep:   ldr R5, =arr_size   @ load arry size
            ldr R5, [R5]             @ deference
            mov R10, R5 @sve for later for print
            add R5, R5, #1      @ size + 1 for 0 
            ldr R9, =arr_size  @ update arr size
            mov R4, #0    @ initialize a counter 

sqrtloop:   cmp R7, R5 @ cmpr cur square to size
            bge onetwozero        @ break if > = 
            add R4, R4, #1 @ increment sqr 1,2,3
            mul R7, R4, R4       @ create square
            str R4, [R9, #0]     @ save new size   
            b sqrtloop 

onetwozero: mov R8, #0   @ mark 0 1 as not prime
            mov R9, #1
            ldr R5, =nums_arr 
            str R8, [R5, R8, LSL #2] 
            str R8, [R5, R9, LSL #2]

findprep:   ldr R5, =arr_size    
            ldr R5, [R5] 
            add R5, R5, #1   
            add R5, #1  @      n + 1 for algo  ?     
            mov R4, #2  @ init cntr for out loop

outloop:    cmp R4, R5            @ loop counter
            bge primmsg       @ conditional exit 
            ldr R1, =nums_arr
            ldr R1, [R1, R4, LSL #2]@nxt arr val
            cmp R1, #0 @ val in arr not 0, prime 
            mov R6, R1 @   init cntr for in loop 
            add R4, R4, #1 @ ++ counter out loop
            bgt inloop  @ in loop if cndtion met
            b outloop

inloop:     add R6, R6, R1  @ prime number jumps
            cmp R6, R10        @ in loop counter
            bge outloop       @ conditional exit
            ldr R7, =nums_arr 
            mov R8, #0
            str R8, [R7, R6, LSL #2] @!prime = 0
            b inloop
@ ----------------------------------------------
@           PRINT PRIMES 
@ ----------------------------------------------

primmsg:    ldr R0, =msg2            @ prime msg
            bl printf

lbrack2:    ldr R0, =lbr    @ left bracket print
            bl printf

prep4:      ldr R5, =arr_size    
            ldr R5, [R5]        
            mov R4, #0    @ initialize a counter 

showloop2:  cmp R4, R10           @ loop counter
            bge rbrack2       @ conditional exit
            ldr R0, =outmsg     
            ldr R1, =nums_arr
            ldr R1, [R1, R4, LSL #2]
            add R4, R4, #1   @ increment counter
            cmp R1, #1     @only print non zeros
            blt showloop2  @only print non zeros
            bl printf
            b showloop2

rbrack2:    ldr R0, =rbr   @ right bracket print
            bl printf

@ ----------------------------------------------
exit:       mov     r0, #0            @ return 0
            ldmfd   sp!, {lr}    @ pop lnk rgstr
            mov     pc, lr    @ link rgstr to pc
@ ----------------------------------------------
            .data
@ ----------------------------------------------
.align      2
arr_size:   .word  0
nums_arr:   .space 40000    @ save space for arr
lbr:        .asciz                          "[ "
rbr:        .asciz                         "]\n" 
msg1:       .asciz       "\nfill array up to: " 
msg2:       .asciz   "\nprimes in this array:\n" 
outmsg:     .asciz            "%d " @ like in C  
input:      .asciz                          "%d"      
