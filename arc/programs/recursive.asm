! main
	.begin
	.org 0
	ld [x], %r24
	call rec
	halt


! Called routine
rec: 	addcc %r8, -1, %r24
	bneg done
	call rec
done:	jmpl %r15+4, %r0
! data
	.org 40
x:	2
	.end
