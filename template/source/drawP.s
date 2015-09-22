.section .text
.globl drawP




drawP:


	push {lr}

	ldr	r7, =P
	mov	r1, #0			// index i
	mov	r2, #0			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
	
	mov	r2, #0			// we want to start drawing at column 0 and row 0

drawP1:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7,r4]
	add	r1, #1
	cmp	r1, #50
	blt	drawP1
	

	mov	r1, #0			// index i
	mov	r2, #0			// index j
	mov	r3, #100		// m
	mov	r5, #2			// element size
	mov	r6, #0x0		// color
	mov	r2, #0			// start drawain at column 0
	mov	r1, #0			// start at row 0
drawP2:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7, r4]
	add	r2, #1
	cmp	r2, #65
	blt	drawP2

	
	mov	r1, #0			// index i
	mov	r2, #0			// index j
	mov	r3, #100		// m (number of columns)
	mov	r5, #2			// element size
	mov	r6, #0x0
	
	mov	r2, #64			// we want to start drawing at column 64 and row 0


drawP3:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7,r4]
	add	r1, #1
	cmp	r1, #24
	blt	drawP3

	mov	r1, #0			// index i
	mov	r2, #0			// index j
	mov	r3, #100		// m
	mov	r5, #2			// element size
	mov	r6, #0x0		// color
	mov	r2, #0			// start drawain at column 0
	mov	r1, #23			// start at row 23
drawP4:
	mul	r4, r3, r1		// m*i
	add	r4, r2			// (m*i)+j
	mul	r4, r5

	strh	r6, [r7, r4]
	add	r2, #1
	cmp	r2, #65
	blt	drawP4


	ldr	r1, =P

	pop {pc}


.section .data


	P:
	.rep	5000
	.hword	0xcccc
	.endr

