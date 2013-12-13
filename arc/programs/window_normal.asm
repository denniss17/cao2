! main
! This is a small programm which calculates 1+2+4+8 in 4 nested calls
! Expected result: 15 in %r24 (4 rightmost bits 1)
	.begin
	.org 0
	ld [x], %r24
	call a
	halt


! Called routine
a: 	addcc %r8, 1, %r24	! Add 1 to the parameter and pass it to the next call
	call b			! Call the next routine
	addcc %r24, %r0, %r8	! Return the value to the previous call
	jmpl %r15+4, %r0	! Go back to te previous call
b: 	addcc %r8, 2, %r24
	call c
	addcc %r24, %r0, %r8
	jmpl %r15+4, %r0
c: 	addcc %r8, 4, %r24
	call d
	addcc %r24, %r0, %r8
	jmpl %r15+4, %r0
d:	addcc %r8, 8, %r24
	addcc %r24, %r0, %r8
	jmpl %r15+4, %r0
	.org 128
x:	0
	.end
