			.text
			.global _start

@ add two 64 bit numbers. Requires 2 registers
@ and adding in "chunks" while preserving any potential carry
@ to view the results run in the debugger

_start:		mov		r2, #0xffffffff		                                                        @ num1 low order word 
			mov		r3, #0x1			                                                       @ num1 high order word
            @ first 64 bit number ^ 
			mov		r4, #0xffffffff		                                                        @ num2 low order word
			mov		r5, #0xff			                                                       @ num2 high order word
            @ second 64 bit number ^
			adds	r0, r2, r4      @ add low orders, set flags, this will note if there is a carry,confirmed line 37
			                                             @ ffffffff + ffffffff will overflow and so carry will be set 
            adcs	r1, r3, r5			                                                 @ add high orders with carry
                                  @ thus, have added the two 64 bit numbers togher ^ stored in r1 (high) and r0 (low)
                                                                                                @   (gdb) print/x $r0
                                                                                                @     $4 = 0xfffffffe
                                                                                                @   (gdb) print/x $r1
                                                                                                @          $5 = 0x101
                                                                                                @____________________
                                                                                                @ =     0x101FFFFFFFE
exit:		                                                                                
            mov     r0, #0                                            @ reset register 0 so we can exit without error
            mov		r7, #1
			svc		0


@ Disassembly of section .text:

@ 00010054 <_start>:    
@    10054:	e3e02000 	mvn	r2, #0                                       @ move changed to mvn to get FFFFFFF to fit
@    10058:	e3a03001 	mov	r3, #1                                                                       @ no change
@    1005c:	e3e04000 	mvn	r4, #0                                       @ move changed to mvn to get FFFFFFF to fit
@    10060:	e3a050ff 	mov	r5, #255	; 0xff                      @ asembler added its own comment that 255 = 0xff
@    10064:	e0920004 	adds	r0, r2, r4      
@    10068:	e0b31005 	adcs	r1, r3, r5                              @  check the CPSR to see if carry flag set :
                                                                   @  0xa000010 = 1010 0000 0000 0000 0000 0001 0000
                                                                            @ bit 29^ = 1 = set, thus carry
@ 0001006c <exit>:
@    1006c:	e3a07001 	mov	r7, #1
@    10070:	ef000000 	svc	0x00000000