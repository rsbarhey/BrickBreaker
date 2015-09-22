.section .text
.globl drawT



drawT:

	push {lr}

	ldr	r7, =T
	mov	r1, #8			// index i
	mov	r2, #49			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
drawT1:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7, r4]
	add	r1, #1
	cmp	r1, #50
	blt	drawT1

	ldr	r7, =T
	mov	r1, #8			// index i
	mov	r2, #18			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0

drawT3:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7, r4]
	add	r2, #1
	cmp	r2, #82
	blt	drawT3

	ldr	r1, =T
	pop {pc}

.section .data

T:
	.rep	5000
	.hword	0xffff
	.endr

