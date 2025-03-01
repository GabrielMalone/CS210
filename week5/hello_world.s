			.text						@ code section
			.global		_start			@ entry point

										@ configure linux write call
_start:		mov			R0, #1			@ 1 = StdOut
			ldr			R1, =hello		@ offset of string
			mov			R2, #13			@ length of string
			mov			R7, #4			@ linux syscall "write"
			svc			0				@ switch to supervisor mode

										@ configure linux exit call
exit:		mov			R0, #0			@ return 0
			mov			R7, #1			@ 1 = exit
			svc			0				@ switch to supervisor mode

			.data						@ data section
hello:		.ascii		"Hello World!\n"@ define a string
length:		.byte		length - hello
