! main
	.begin
	.org 0
	ld [x], %r24
	call a
	halt


! Called routine
a: 	addcc %r8, 1, %r24
	call b
	jmpl %r15+4, %r0
b:	addcc %r8, 1, %r24
	jmpl %r15+4, %r0
! data
	.org 40
x:	0
	.end
