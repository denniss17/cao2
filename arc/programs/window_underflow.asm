! main
	.begin
	.org 0
	addcc %r0, 4, %r15
	jmpl %r15+0, %r0
	halt
	.end
