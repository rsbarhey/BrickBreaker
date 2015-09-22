.section .text
.globl	GG

GG:
	push	{r0-r11, lr}

	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4
	mov	r10, #0				// setting r10 check near the end of file for it's purpose
/*
	
*/


// draw border
	ldr	ycoor, =391
	ldr	xcoor, =291
	ldr	height, =67
	ldr	width, =297
	ldr	colour, =0xaaaa
	bl	drawShape

	ldr	ycoor, =395
	ldr	xcoor, =295
	ldr	height, =59
	ldr	width, =289
	ldr	colour, =0x8888
	bl	drawShape
//----------------------------------------------
//draw game over
//draw the line on the left
drG:
	ldr	ycoor, =405
	ldr	xcoor, =300
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
//draw the line on the top
	ldr	ycoor, =441
	ldr	xcoor, =300
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape
// draw the line on the bottom
	ldr	ycoor, =405
	ldr	xcoor, =300
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape
// draw the line on the right
	ldr	ycoor, =426
	ldr	xcoor, =321
	ldr	height, =15
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape

// draw the line on the middle
	ldr	ycoor, =426
	ldr	xcoor, =315
	ldr	height, =4
	ldr	width, =9
	ldr	colour, =0x0
	bl	drawShape
//draw A
drA:
//draw the line on the left
	ldr	ycoor, =405
	ldr	xcoor, =335
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
//draw the line on the top
	ldr	ycoor, =405
	ldr	xcoor, =335
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape
//draw the line on the right
	ldr	ycoor, =405
	ldr	xcoor, =356
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
// draw the line on the middle
	ldr	ycoor, =426
	ldr	xcoor, =335
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape

drM:
// draw the line on the left
	ldr	ycoor, =405
	ldr	xcoor, =370
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
// draw the line on the right
	ldr	ycoor, =405
	ldr	xcoor, =391
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape

// draw diagonal pixels
	ldr	ycoor, =409
	ldr	xcoor, =374
	mov	r6, #1
lm:	
	ldr	height, =4
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	add	ycoor, #4
	add	xcoor, #4
	sub	r6, #1
	cmp	r6, #0
	bge	lm
		
	ldr	ycoor, =409
	ldr	xcoor, =387
	mov	r6, #1
lm1:	
	ldr	height, =4
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	add	ycoor, #4
	sub	xcoor, #4
	sub	r6, #1
	cmp	r6, #0
	bge	lm1

// draw E
drE:

// draw the line on the left
	ldr	ycoor, =405
	ldr	xcoor, =405
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
// draw the line on the top
	ldr	ycoor, =405
	ldr	xcoor, =405
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape

// draw the line on the bottom
	ldr	ycoor, =441
	ldr	xcoor, =405
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape
// draw the line on the middle 
	ldr	ycoor, =426
	ldr	xcoor, =405
	ldr	height, =4
	ldr	width, =18
	ldr	colour, =0x0
	bl	drawShape

// draw W
drW:
	ldr	ycoor, =405
	ldr	xcoor, =485
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape

	ldr	ycoor, =405
	ldr	xcoor, =506
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape


	ldr	ycoor, =437
	ldr	xcoor, =489
	mov	r6, #1
lW1:	
	ldr	height, =4
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	sub	ycoor, #4
	add	xcoor, #4
	sub	r6, #1
	cmp	r6, #0
	bge	lW1
		
	ldr	ycoor, =409
	ldr	xcoor, =387
	mov	r6, #1

	ldr	ycoor, =437
	ldr	xcoor, =502
	mov	r6, #1
lW2:	
	ldr	height, =4
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	sub	ycoor, #4
	sub	xcoor, #4
	sub	r6, #1
	cmp	r6, #0
	bge	lW2
		

	
doneW:

// draw O
drO:
// this loop draws the line on the left and right
	ldr	ycoor, =405
	ldr	xcoor, =520
	mov	r6, #1
lo:
	ldr	height,=40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	ldr	ycoor, =405
	ldr	xcoor, =541
	sub	r6, #1
	cmp	r6, #0
	bge	lo

//this loop draw the line on the top and bottom
	ldr	ycoor, =405
	ldr	xcoor, =520
	mov	r6, #1
lo1:
	ldr	height, =4
	ldr	width, =25
	ldr	colour, =0x0
	bl	drawShape
	ldr	ycoor, =441
	ldr	xcoor, =520
	sub	r6, #1
	cmp	r6, #0
	bge	lo1


// Draw N

drN:
	ldr	ycoor, =405
	ldr	xcoor, =555
	mov	r6, #1
lN:
	ldr	height, =40
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	ldr	ycoor, =405
	ldr	xcoor, =576
	sub	r6, #1
	cmp	r6, #0
	bge	lN


	ldr	ycoor, =405
	ldr	xcoor, =555
	ldr	r6, =576
	ldr	r8, =441
lN1:
	cmp	ycoor, r8
	beq	doneN
	ldr	height, =4
	ldr	width, =4
	ldr	colour, =0x0
	bl	drawShape
	add	ycoor, #3
	add	xcoor, #2
	cmp	xcoor, r6
	blt	lN1
	
doneN:
// this part prints "PREES A"
	
	ldr	colour, =0x0
loopMessage:
drP:
// draw the line on the left
	ldr	ycoor, =500
	ldr	xcoor, =390
	ldr	height, =15
	ldr	width, =2
	bl	drawShape
// draw the line on the top
	ldr	ycoor, =500
	ldr	xcoor, =390
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
// draw the line on the middle
	ldr	ycoor, =508
	ldr	xcoor, =390
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
// draw the line on the right
	ldr	ycoor, =500
	ldr	xcoor, =398
	ldr	height, =8
	ldr	width, =2
	bl	drawShape

// draw R
drR2:
	ldr	ycoor, =500
	ldr	xcoor, =402
	ldr	height, =15
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =500
	ldr	xcoor, =402
	ldr	height, =2
	ldr	width, =10
	bl	drawShape

	ldr	ycoor, =508
	ldr	xcoor, =402
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
	
	ldr	ycoor, =500
	ldr	xcoor, =410
	ldr	height, =8
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =508
	ldr	xcoor, =407
	ldr	height, =4
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =512
	ldr	xcoor, =409
	ldr	height, =3
	ldr	width, =2
	bl	drawShape


// draw e
drE3:
	ldr	ycoor, =500
	ldr	xcoor, =414
	ldr	height, =15
	ldr	width, =2
	bl	drawShape
	
	ldr	ycoor, =500
	ldr	xcoor, =414
	mov	r6, #1
	
le:
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
	ldr	ycoor, =513
	ldr	xcoor, =414
	sub	r6, #1
	cmp	r6, #0
	bge	le

	ldr	ycoor, =508
	ldr	xcoor, =414
	ldr	height, =2
	ldr	width, =7
	bl	drawShape

// Draw S
drS1:
	ldr	ycoor, =500
	ldr	xcoor, =426
	ldr	height, =8
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =508
	ldr	xcoor, =434
	ldr	height, =7
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =500
	ldr	xcoor, =426
	mov	r6, #2
	ldr	r9, =508
lS1:
	ldr	width, =10
	ldr	height, =2
	bl	drawShape
	cmp	ycoor, r9
	ldr	ycoor, =508
	
	
	ldreq	ycoor, =513
	sub	r6, #1
	cmp	r6, #0
	bge	lS1
// drawS
drS:
	ldr	ycoor, =500
	ldr	xcoor, =438
	ldr	height, =8
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =508
	ldr	xcoor, =446
	ldr	height, =7
	ldr	width, =2
	bl	drawShape

	ldr	ycoor, =500
	ldr	xcoor, =438
	mov	r6, #2
	ldr	r9, =508
lS:
	ldr	width, =10
	ldr	height, =2
	bl	drawShape
	cmp	ycoor, r9
	ldr	ycoor, =508
	
	
	ldreq	ycoor, =513
	sub	r6, #1
	cmp	r6, #0
	bge	lS

// draw A
drA2:
	ldr	ycoor, =500
	ldr	xcoor, =462
	mov	r6, #1
lA:
	ldr	height, =15
	ldr	width, =2
	bl	drawShape
	ldr	ycoor, =500
	ldr	xcoor, =470
	sub	r6, #1
	cmp	r6, #0
	bge	lA


	ldr	ycoor, =508
	ldr	xcoor, =462
	mov	r6, #1
lA2:
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
	ldr	ycoor, =500
	ldr	xcoor, =462
	sub	r6, #1
	cmp	r6, #0
	bge	lA2


// draw B
drB:
	ldr	xcoor, =482
	ldr	ycoor, =500
	ldr	height, =15
	ldr	width, =2
	bl	drawShape

	ldr	xcoor, =482
	ldr	ycoor, =500
	ldr	height, =2
	ldr	width, =8
	bl	drawShape

	ldr	ycoor, =506
	ldr	xcoor, =482
	ldr	height, =2
	ldr	width, =8
	bl	drawShape

	ldr	ycoor, =513
	ldr	xcoor, =482
	ldr	height, =2
	ldr	width, =8
	bl	drawShape

	ldr	ycoor, =502
	ldr	xcoor, =490
	ldr	width, =2
	ldr	height, =4
	bl	drawShape

	ldr	ycoor, =508
	ldr	xcoor, =490
	ldr	width, =2
	ldr	height, =5
	bl	drawShape

// Draw U
drU:
	ldr	ycoor, =500
	ldr	xcoor, =494
	mov	r6, #1
lU:
	ldr	height, =14
	ldr	width, =2
	bl	drawShape
	add	xcoor, #8
	sub	r6, #1
	cmp	r6, #0
	bge	lU

	ldr	ycoor, =513
	ldr	xcoor, =495
	ldr	height, =2
	ldr	width, =8
	bl	drawShape

// draw two T's
drT:
	ldr	ycoor, =500
	ldr	xcoor, =506
	mov	r6, #1
lT:
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
	add	xcoor, #4
	ldr	height, =15
	ldr	width, =2
	bl	drawShape
	sub	r6, #1
	add	xcoor, #8
	cmp	r6, #0
	bge	lT

drO2:
	ldr	ycoor, =500
	ldr	xcoor, =530
// this loop draws the line on the left and right
	mov	r6, #1
lo3:
	ldr	height,=15
	ldr	width, =2
	bl	drawShape
	ldr	ycoor, =500
	ldr	xcoor, =538
	sub	r6, #1
	cmp	r6, #0
	bge	lo3

//this loop draw the line on the top and bottom
	ldr	ycoor, =500
	ldr	xcoor, =530
	mov	r6, #1
lo4:
	ldr	height, =2
	ldr	width, =10
	bl	drawShape
	ldr	ycoor, =513
	ldr	xcoor, =530
	sub	r6, #1
	cmp	r6, #0
	bge	lo4

// draw N

drN2:
	ldr	ycoor, =500
	ldr	xcoor, =542
	mov	r6, #1
lN2:
	ldr	height, =15
	ldr	width, =2
	bl	drawShape
	ldr	ycoor, =500
	ldr	xcoor, =549
	sub	r6, #1
	cmp	r6, #0
	bge	lN2


	ldr	ycoor, =500
	ldr	xcoor, =542
	ldr	r6, =550
	ldr	r8, =512
lN3:
	cmp	ycoor, r8
	bgt	doneN2
	ldr	height, =2
	ldr	width, =2
	bl	drawShape
	add	ycoor, #2
	add	xcoor, #1
	cmp	xcoor, r6
	blt	lN3

doneN2:
	
//-----------------------------------------------------------------------
getInput:
	bl	ReadSNES
	ldr	r2, =0b111111111111				// check if any buttom is pressed
	//lsl	r2, #8						// checking if A is pressed
	and	r0, r0,r2
	cmp	r0, r2

	bne	re						// if A pressed go to re


	
	add	r10, #1
	cmp	r10, #200					// r10 makes the new colour stays for 100 cycles without wasting it in a waiting loop
	addeq	colour, #0xff					// doing nothing, when we ga back to "overwrite" press A it will be written with this
	moveq	r10, #0						// colour, resetting r10 and chageing colour takes place only when r10 = 70	
	
	b	loopMessage					// here go back and redraw press A with new colour
re:

	//bl	NewGame
	pop {r0-r11, pc}


	pop	{r0-r11, pc}
