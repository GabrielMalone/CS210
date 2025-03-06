@ ---------------------------------------------------
@ Task 3 - Gabriel Malone 
@ ---------------------------------------------------
.text
.global _start
        _start:
.data
@  removed the initial .align as I don't think it was necessary for the first byte variable
@ ---------------------------------------------------
@ declare variables 
@ --------------------------------------------------- boundary | padding
a:  .byte  0    @ 1 byte  0x00 assigned to 'a'              1
    .align 2    @ align to next 4 bytes for upcoming word   4    + 3
b:  .word  32   @ 4 bytes 0x00000020 assigned to 'b'        8
                @ byte next, no alignment needed
c:  .byte  3    @ 1 byte  0x03 assigned to 'c'              9
    .align 1    @ half word next 2 byte alignment needed    10   + 1
d:  .hword 45   @ 2 bytes 002D assigned to 'd'              12
                @ half word next, already aligning with hword
e:  .hword 0    @ 2 bytes 0x0000 assigned to 'e'            14
                @ byte next, no alignment needed
f:  .byte  0    @ 1 byte  0x00 assigned to 'f'              15
    .align 2    @ word next 4 byte alignment needed         16   + 1
g:  .word  128  @ 4 bytes 0x0080 assigned to 'g'n           20
@ ---------------------------------------------------
@  15 bytes + 5 padding = 20 bytes total 
@ ---------------------------------------------------

@ ---------------------------------------------------
@ re order so that no align directives necessary 
@ ---------------------------------------------------
    .data       @ initial alignment not needed since starting at 0
b:  .word  32   @ 4 bytes 0x00000020 assigned to 'b'
                @ no padding needed for following word since already mult of 4
g:  .word  128  @ 4 bytes 0x0080 assigned to 'g'
d:  .hword 45   @ 2 bytes 002D assigned to 'd'
                @ no padding needed for following h word since already mult of 2
e:  .hword 0    @ 2 bytes 0x0000 assigned to 'e'
                @ only bytes remain, no padding needed for them
a:  .byte  0    @ 1 byte  0x00 assigned to 'a'
c:  .byte  3    @ 1 byte  0x03 assigned to 'c'
f:  .byte  0    @ 1 byte  0x00 assigned to 'f'
@ ---------------------------------------------------
@ 15 bytes needed with no alignments
@ ---------------------------------------------------