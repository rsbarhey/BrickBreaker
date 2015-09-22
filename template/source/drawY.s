.section .text
.globl drawY

drawY:
	push	{lr}

	ldr	r7, =Y
	mov	r1, #30			// index i
	mov	r2, #49			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
drawY1:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7,r4]
	add	r1, #1
	cmp	r1, #50
	blt	drawY1

	ldr	r7, =Y
	mov	r1, #30			// index i
	mov	r2, #49			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
drawY2:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5
	
	strh	r6, [r7, r4]
	sub	r1, #1
	sub	r2, #1
	
	cmp	r1, #0
	blt	done1
	cmp	r2, #0
	bge	drawY2

done1:
	ldr	r7, =Y
	mov	r1, #30			// index i
	mov	r2, #49			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0

drawY3:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5
	
	strh	r6, [r7, r4]
	sub	r1, #1
	add	r2, #1

	cmp	r1, #0
	blt	doneY
	cmp	r2, #100
	blt	drawY3
	
	
doneY:
	ldr	r1, =Y
	
	pop {pc}


.section .data

Y:
	.rep	5000
	.hword	0xcccc
	.endr

