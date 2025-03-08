@ ----------------------------------------------
@       Gabriel Malone | Week 6 Lab | CS210
@ ----------------------------------------------        
        .text
        .global main@main instead of start for C

main:   stmfd sp!, {lr} @ link register on stack
@ ----------------------------------------------
@   Get user input for the X value to * by 2^Y
@ ----------------------------------------------
display:    mov R0, #1   @ tell linux write term         
            ldr R1, =msg1    @ adr what to write
            mov R2, #18          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read0:      ldr R0, =input @<-r0 address of "%d"
            ldr R1, =x           @ dest of input
            bl scanf          @ get 'x' from usr

echo:       ldr R0, =msg2    @ show prompt for Y 
            ldr R1, =x     @ with cur val of 'x'
            ldr R1, [R1]   @ dereference mem add
            bl printf

read1:      ldr R0, =input @<-r0 address of "%d"
            ldr R1, =y           @ dest of input
            bl scanf          @ get 'y' from usr 
@ ----------------------------------------------
leftshft:   ldr R0, =y    @ get x and y into reg
            ldr R1, =x
            ldr R0, [R0]         @ derrence both
            ldr R1, [R1]
            lsl R2, R1, R0 @ shft << by usr amnt 
            ldr R3, =res @ load mem adrss of res
            str R2, [R3] @ str @ mem adrs of res
@ ----------------------------------------------
echo2:      ldr R0, =outmsg 
            ldr R1, =res   @ with cur val of 'x'
            ldr R1, [R1]   @ dereference mem add
            bl printf
@ ----------------------------------------------
@    Get user input for the X value to % b 2^Y
@ ----------------------------------------------
displayb:   mov R0, #1   @ tell linux write term         
            ldr R1, =msg1    @ adr what to write
            mov R2, #18          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read0b:     ldr R0, =input @<-r0 address of "%d"
            ldr R1, =x           @ dest of input
            bl scanf          @ get 'x' from usr

echob:      ldr R0, =msg2a   @ show prompt for Y 
            ldr R1, =x     @ with cur val of 'x'
            ldr R1, [R1]   @ dereference mem add
            bl printf

read1b:     ldr R0, =input @<-r0 address of "%d"
            ldr R1, =y           @ dest of input
            bl scanf          @ get 'y' from usr 
@ ----------------------------------------------
rightshft:  ldr R0, =y    @ get x and y into reg
            ldr R1, =x
            ldr R0, [R0]         @ derrence both
            ldr R1, [R1]
            lsr R2, R1, R0 @ shft >> by usr amnt 
            ldr R3, =res @ load mem adrss of res
            str R2, [R3] @ str @ mem adrs of res
@ ----------------------------------------------
echo2b:     ldr R0, =outmsg 
            ldr R1, =res   @ with cur val of 'x'
            ldr R1, [R1]   @ dereference mem add
            bl printf
@ ----------------------------------------------
@            XOR Register swap 
@ ----------------------------------------------
displayc:   mov R0, #1   @ tell linux write term         
            ldr R1, =msg3    @ adr what to write
            mov R2, #17          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read1c:     ldr R0, =input @<-r0 address of "%d"
            ldr R1, =x           @ dest of input
            bl scanf          @ get 'x' from usr

echo1c:     mov R0, #1   @ tell linux write term         
            ldr R1, =msg4    @ adr what to write
            mov R2, #14          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read2c:     ldr R0, =input @<-r0 address of "%d"
            ldr R1, =y           @ dest of input
            bl scanf          @ get 'x' from usr
@ ----------------------------------------------
XORswitch:  ldr R0, =outmsg2 
            ldr R1, =x  
            ldr R2, =y
            ldr R1, [R1]     @ deref to get vals
            ldr R2, [R2]
            eor R1, R1, R2  @ see comment at end                
            eor R2, R1, R2 @ for xor algo example                 
            eor R1, R1, R2                       
            bl printf
@ ----------------------------------------------            
@  in R1 combine info of xy e.g. 10(x) xor 12(y) 
@       1010(x) eor 1100(y) = 0110 & put into R1 
@    R2 xor's result 0110 with og val in R2 1100
@  1100 eor 0110 = 1010 which was the original x
@      R1 then xors what is currently in R1 0110 
@       with val in R2 1010 = 1100 = og y. wowz. 
@ ----------------------------------------------
@            Subtraction via addition
@ ----------------------------------------------
display1d:  mov R0, #1   @ tell linux write term         
            ldr R1, =msg5    @ adr what to write
            mov R2, #25          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read1d:     ldr R0, =input @<-r0 address of "%d"
            ldr R1, =x           @ dest of input
            bl scanf          @ get 'x' from usr

display2d:  mov R0, #1   @ tell linux write term         
            ldr R1, =msg4    @ adr what to write
            mov R2, #14          @ length of msg
            mov R7, #4     @ tell linux to write
            svc 0       @ hand things over to OS

read2d:     ldr R0, =input @<-r0 address of "%d"
            ldr R1, =y           @ dest of input
            bl scanf          @ get 'y' from usr

addinvese:  ldr R0, =y         @ load y mem addr
            ldr R0, [R0]      @ deref to get val 
            ldr R1, =x         @ load x mem addr
            ldr R1, [R1]      @ deref to get val 
            mvn R0, R0         @ 1s compliment y
            add R0, R0, #1     @ 2s compliment y
            add R1, R1, R0     @ add the inverse
            ldr R3, =res           @ save result
            str R1, [R3]

output:     ldr R0, =outmsg3     @ print x y res
            ldr R1, =x
            ldr R1, [R1]
            ldr R2, =y 
            ldr R2, [R2]
            ldr R3, =res
            ldr R3, [R3]
            bl printf
@ ----------------------------------------------
exit:       mov     r0, #0            @ return 0
            ldmfd   sp!, {lr}    @ pop lnk rgstr
            mov     pc, lr    @ link rgstr to pc
@ ----------------------------------------------
            .data
@ ----------------------------------------------
msg1:       .asciz         "\nEnter a number x:"
msg2:       .asciz      "for %d * 2^y, enter Y:"
msg2a:      .asciz      "for %d / 2^y, enter Y:"
msg3:       .asciz          "\nEnter a number: "
msg4:       .asciz              "and one more: "
msg5:       .asciz  "\nsubtraction - enter num:"
outmsg:     .asciz  "\nresult: %d\n" @ like in C
outmsg2:    .asciz  "lo, they swiched: %d, %d\n"
outmsg3:    .asciz           "%d - %d = %d ! \n"
input:      .asciz                          "%d" 
            .align  2
x:          .word   0
y:          .word   0    
res:        .word   0

         