			.text
			.global _start

_start:		mov		r1, #1

			@ these numbers are fine for an immediate as second operand
			add		r0, r1, #256
			add		r0, r1, #260

			@ this number is not. Uncomment to see the error
			@ add	r0, r1, #257

			@ HUH? Study: https://alisdair.mcdiarmid.org/arm-immediate-value-encoding/

			@ fetch it from ram instead
			@ld		r2, =load_then
			@add	r0, r1, r2

			@ or move it into a register
			@ 257 is ok for an immediate here due to the instruction
			@ the mov instruction has more space for immediate values
			mov		r2, #257
			add		r0, r1, r2

exit:		mov		r7, #1
			svc		0

			.data
load_then:	.word	257
