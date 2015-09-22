.section .text
.globl ReadSNES


/*
* source of this code the lecture slides
*/

.equ	LAT, 9			// gpio line
.equ	DAT, 10			// gpio line
.equ	CLK, 11			// gpio line
.equ	HCYC, 6			// half cycle
.equ	FCYC, 12		// full cycle

ReadSNES:

	push	{r1-r11,lr}

	bitMask		.req	r4
	buttonWord	.req	r5


	mov	bitMask, #1
	mov	buttonWord, #0


	mov	r0, #CLK
	mov	r1, #1
	bl	SetGPIO

	mov	r0, #LAT
	mov	r1, #1
	bl	SetGPIO

	mov	r0, #FCYC
	bl	WaitLoop
	
	mov	r0, #LAT
	mov	r1, #0
	bl	SetGPIO

clkLoop:
	mov	r0, #HCYC
	bl	WaitLoop

	mov	r0, #CLK
	mov	r1, #0
	bl	SetGPIO

	mov	r0, #HCYC
	bl	WaitLoop

	mov	r0, #DAT
	bl	GetGPIO

	teq	r0, #0
	orrne	buttonWord, bitMask

	mov	r0, #CLK
	mov	r1, #1
	bl	SetGPIO
	
	lsl	bitMask, #1

	cmp	bitMask, #65536
	blo	clkLoop

	mov	r0, buttonWord
	
	pop {r1-r11, pc}

WaitLoop:
	push {r1, lr}

	mov	r1, #0
loop:
	cmp	r1, r0
	bge	donewait
	add	r1, #1
	b	loop

donewait:
	pop {r1, pc}

