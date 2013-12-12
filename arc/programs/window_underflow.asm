! main
	.begin
	.org 0
	ld [x], %r24
	addcc %r0, 4, %r15
	jmpl %r15+4, %r0
	halt
! data
	.org 140
x:	0
	.end
