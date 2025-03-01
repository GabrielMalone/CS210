
.text	
@ ---------------------------------------------------
    .global     barfoo
    .global     foobar					
    .global		_start			
@ ---------------------------------------------------								
_start:		 
						
exit:	
@ ---------------------------------------------------
.data
    .align  2                       @ since first variable is a word, want to align w/in 4 byte boundary
@ ---------------------------------------------------
foo:        .word   1,2,3           @ next variable is byte so no alignment needed
bar:        .byte   'A','B','C','D' @ next variable is byte so no alignment needed
barfoo:     .byte   'g'             @ next variable is a word, align w/in 4 byte boundary
            .align  2       
foobar:     .word   9
@ ---------------------------------------------------

    