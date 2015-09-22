
.section .text
.globl	drawU


drawU:

	push {lr}

	ldr	r7, =U
	mov	r1, #8			// index i
	mov	r2, #20			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
drawU1:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7, r4]
	add	r1, #1
	cmp	r1, #50
	blt	drawU1
	cmp	r2, #75
	beq	doneU
	mov	r2, #75
	mov	r1, #8
	b 	drawU1
doneU:
	ldr	r7, =U
	mov	r1, #49			// index i
	mov	r2, #20			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
drawU2:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7, r4]
	add	r2, #1
	cmp	r2, #75
	blt	drawU2
	

	ldr	r1, =U

	pop {pc}


.section .data

U:
	.rep	5000
	.hword	0xffff
	.endr

