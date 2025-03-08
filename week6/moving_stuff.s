@
@ Examples of the MOV instruction.
@
		.global _start
	
_start:		movw	R2, #0x6E3A		
			mov		R1, R2		

			mov		r1, r2, lsl #1	
			mov		r1, r2, lsr #1	
			mov		r1, r2, asr #1	
			mov		r1, r2, ror #1	

			lsl		r1, r2, #1		
			lsr		r1, r2, #1		
			asr		r1, r2, #1		
			ror		r1, r2, #1		

			mov		r1, #0xAB000000  

			@mov    r1, #0xABCDEF11 @ Too big for #imm16
            movw    r1, #0xEF11     @ fixing line 32
            movt    r1, #0xABCD     @ just split ABCD EF11 in half and place seperately 
           

			mvn		r1, #4			@ move not: one's complement --> 0x00000004 goes to 0xFFFFFFFB (inverted)
			mov		r1, #0xffffffff	@ will assemble to mvn. why? --> 
                                    @ 0xFFFFFFFF is too big and can't be rotated with fixup
                                    @ its opposite 0x0000000 can fit, though. 
                                    @ 0x00000000 will convert to 0xFFFFFFF with movn
    
