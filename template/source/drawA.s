.section .text
.globl drawA


drawA:

	push {lr}

	
	mov	r1, #0			// i	
	mov	r2, #0			// j
	ldr	r6, =A		
	mov	r3, #100		// r3 = m
	add	r2, #48
	mov	r7, #2			// r7 =element size			
	
drawA1:	// 2d array [100][100]
	mov	r4, #0x0000
	mul	r5, r1, r3		// r5 = r1*r3  (m*i)
	add	r5, r2			// r5 = (r1*r3) + r2  (m*i)+j
	mul	r5, r5, r7		// r5 now is offset at i,j
	strh	r4, [r6, r5]
	add	r1, #1
	sub	r2, #1
	cmp	r2, #0
	bge	drawA1

	mov	r1, #0			// i	
	mov	r2, #0			// j		
	mov	r3, #100		// r3 = m
	add	r2, #48
drawA2:
	mov	r4, #0x0000
	mul	r5, r1, r3		// r5 = r1*r3  (m*i)
	add	r5, r2			// r5 = (r1*r3) + r2  (m*i)+j
	mul	r5, r5, r7		// r5 now is offset at i,j
	strh	r4, [r6, r5]
	add	r1, #1
	add	r2, #1
	cmp	r1, #50
	bge	done
	cmp	r2, #100
	blt	drawA2

done:


	mov	r1, #30			// i = 30
	mov	r2, #19			// j = 19
	mov 	r8, #0			// lenght
loop:
	mul	r5, r1, r3		// r5 = r1*r3  (m*i)
	add	r5, r2			// r5 = (r1*r3) + r2  (m*i)+j
	mul	r5, r5, r7		// r5 now is offset at i,j
	strh	r4, [r6, r5]
	add	r2, #1
	add	r8, #1
	cmp	r8, #60
	blt	loop

	ldr	r1, =A

	pop {pc}



.section .data

A:
	.rep	5000
	.hword	0xcccc
	.endr
