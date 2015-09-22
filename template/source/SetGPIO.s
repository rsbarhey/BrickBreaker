.section    .text
.globl     SetGPIO

/*
* source of this code is Lecure slides
*/

	.equ	GPIOFSEL0,	0x20200000

// takes r2, as pin number, and r1 as value to write
SetGPIO:

	pinNum	.req	r0
	pinVal	.req	r1

	push {r0-r11, lr}

	mov	r2, pinNum
	.unreq	pinNum
	pinNum	.req	r2
	ldr	r0, =GPIOFSEL0
	gpioAdr	.req	r0
	pinBank	.req	r3

	lsr	pinBank, pinNum, #5
	lsl	pinBank, #2
	add	gpioAdr, pinBank
	.unreq	pinBank

	and	pinNum, #31

	setBit	.req	r3
	mov	setBit, #1
	lsl	setBit, pinNum
	.unreq	pinNum

	teq	pinVal, #0
	.unreq	pinVal
	streq	setBit, [gpioAdr, #40]
	strne	setBit, [gpioAdr, #28]

	.unreq	setBit
	.unreq	gpioAdr

	
	pop {r0-r11, pc}

