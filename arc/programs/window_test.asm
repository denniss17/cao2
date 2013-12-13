	.org 0
	.begin
	! Normal (double) call
	ld [x], %r24
	call a
	! Underflow
	jmpl %r0, 16, %r0
	! Overflow
	call c
	halt


! Called routine
a:	addcc %r8, 1, %r24
	call b
	jmpl %r15+4, %r0
b:	addcc %r8, 1, %r24
	jmpl %r15+4, %r0

c: 	addcc %r8, 1, %r24
	call d
	jmpl %r15+4, %r0
d: 	addcc %r8, 1, %r24
	call e
	jmpl %r15+4, %r0
e: 	addcc %r8, 1, %r24
	call f
	jmpl %r15+4, %r0
f: 	addcc %r8, 1, %r24
	call g
	jmpl %r15+4, %r0
g: 	addcc %r8, 1, %r24
	call h
	jmpl %r15+4, %r0
h: 	addcc %r8, 1, %r24
	call i
	jmpl %r15+4, %r0
i: 	addcc %r8, 1, %r24
	call j
	jmpl %r15+4, %r0
j: 	addcc %r8, 1, %r24
	call k
	jmpl %r15+4, %r0
k: 	addcc %r8, 1, %r24
	call l
	jmpl %r15+4, %r0
l: 	addcc %r8, 1, %r24
	call m
	jmpl %r15+4, %r0
m: 	addcc %r8, 1, %r24
	jmpl %r15+4, %r0
! data
	.org 256
x:	0
	.end
