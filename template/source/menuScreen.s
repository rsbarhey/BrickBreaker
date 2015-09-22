.section .text
.globl menuScreen


menuScreen:
	push {r0-r11,lr}
//restart:
	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4


	ldr	r8, =0xaaaa
	ldr	r9, =0x0
//------------------------------Drawing the border play------------------------------------------
highlight:
	ldr	ycoor, =391
	ldr	xcoor, =291
	ldr	height, =67
	ldr	width, =397
	mov	colour, r8
	bl	drawShape

	ldr	ycoor, =395
	ldr	xcoor, =295
	ldr	height, =59
	ldr	width, =389
	ldr	colour,=0xffff
	bl	drawShape 

//------------------------------Drawing the border for quit----------------------------------------

	ldr	ycoor, =474
	ldr	xcoor, =291
	ldr	height, =68
	ldr	width, =397
	mov	colour, r9
	bl	drawShape

	ldr	ycoor, =479
	ldr	xcoor, =295
	ldr	height, =59
	ldr	width, =389
	ldr	colour, =0xffff
	bl	drawShape
//-------------------------------------------------------------------------------------------------
	.unreq	height
	.unreq	width
	.unreq	colour
	.unreq	addr
	.unreq	ycoor
	.unreq	xcoor
	height	.req	r2
	width	.req	r3
	ycoor	.req	r4
	xcoor 	.req	r5

	mov	r0, r7			// for integration purposes mov the value of r7 into r0


	
	bl	drawP
	//ldr	r1, =P
	mov	height, #50			// Height = 100 of the block height is basically number of rows i ?
	mov	width, #100		// Width = 100 for this block Width is basically number of columns j ?
	mov	ycoor, #400		// index i in the fb ( where we will start copying at)
	mov	xcoor, #300		// index j in the fb ( where we will start copying at)
	bl	copy


	bl	drawL
	//ldr	r1, =L
	mov	height, #50			// Height = 100 of the block height is basically number of rows i ?
	mov	width, #100		// Width = 100 for this block Width is basically number of columns j ?
	mov	ycoor, #400		// index i in the fb ( where we will start copying at)
	mov	xcoor, #400		// index j in the fb ( where we will start copying at)
	bl	copy


	bl	drawA
	//ldr	r1, =A
	mov	height, #50			// Height = 100 of the block height is basically number of rows i ?
	mov	width, #100		// Width = 100 for this block Width is basically number of columns j ?
	mov	ycoor, #400		// index i in the fb ( where we will start copying at)
	mov	xcoor, #500		// index j in the fb ( where we will start copying at)
	bl	copy


	bl	drawY
	//ldr	r1, =Y
	mov	height, #50			// Height = 100 of the block height is basically number of rows i ?
	mov	width, #100		// Width = 100 for this block Width is basically number of columns j ?
	mov	ycoor, #400		// index i in the fb ( where we will start copying at)
	mov	xcoor, #600		// index j in the fb ( where we will start copying at)
	bl	copy

	bl	drawT
	//ldr	r1, =T
	mov	height, #50
	mov	width, #100
	ldr	ycoor, =480
	ldr	xcoor, =600
	bl 	copy

	bl	drawI	
	//ldr	r1, =I
	mov	height, #50
	mov	width, #100
	ldr	ycoor, =480
	ldr	xcoor, =500	
	bl 	copy


	bl	drawU
	//ldr	r1, =U
	mov	height, #50
	mov	width, #100
	ldr	ycoor, =480
	ldr	xcoor, =400
	bl 	copy
	

	bl	drawQ
	//ldr	r1, =Q
	mov	height, #50
	mov	width, #100
	ldr	ycoor, =480
	ldr	xcoor, =300
	bl 	copy
	
	.unreq	height
	.unreq	width
	.unreq	ycoor
	.unreq	xcoor

	mov	r7, r0			// for integration purposes move the value of r0 back into r7
	push	{r0}
getInput:
	bl	ReadSNES

	mov	r2, #1
	lsl	r2, #5
	push	{r0}
	and	r0, r0, r2
	cmp	r0, r2
	pop	{r0}
	bne	movdown	
	mov	r2, #1
	lsl	r2, #4 			
	push	{r0}
	and	r0, r0, r2
	cmp	r0, r2
	pop	{r0}
	bne	movup
	mov	r2, #1
	lsl	r2, #8 			// 3 was start, not 4
	and	r0, r0,r2
	cmp	r0, r2

	bne	don

	b	getInput
movup:
	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4
	ldr	r9, =0x0
	ldr	r8, =0xaaaa
// highlight the line on top
	ldr	ycoor, =391
	ldr	xcoor, =291
	ldr	height, =3
	ldr	width, =397
	mov	colour, r8
	bl	drawShape
// highlight the line on the left
	ldr	ycoor, 	=391
	ldr	xcoor, 	=291
	ldr	height, =67
	ldr	width, 	=3
	mov	colour,	r8
	bl	drawShape
// highlight the line on the buttom
	ldr	ycoor, =455
	ldr	xcoor, =291
	ldr	height, =3
	ldr	width, =397
	mov	colour, r8
	bl	drawShape
// highlight the line on the right

	ldr	ycoor, 	=391
	ldr	xcoor, 	=685
	ldr	height, =67
	ldr	width, 	=3
	mov	colour,	r8
	bl	drawShape

// unhighlight the border of quit

// unhighlight the top line for quit
	ldr	ycoor, =474
	ldr	xcoor, =291
	ldr	height, =4
	ldr	width, =397
	mov	colour, r9
	bl	drawShape
// unhighlight the line on the left
	ldr	ycoor, =474
	ldr	xcoor, =291
	ldr	height, =68
	ldr	width, =3
	mov	colour, r9
	bl	drawShape
// unhighlight the line on the right
	ldr	ycoor, =474
	ldr	xcoor, =685
	ldr	height, =68
	ldr	width, =3
	mov	colour, r9
	bl	drawShape

// unhighlight the line on the bottom
	ldr	ycoor, =539
	ldr	xcoor, =291
	ldr	height, =3
	ldr	width, =397
	mov	colour, r9
	bl	drawShape
	b	getInput
	//pop	{r0}
	//b	highlight
movdown:
	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4
	ldr	r8, =0x0
	ldr	r9, =0xaaaa

	
// highlight border for quit

// highlight the top line for quit
	ldr	ycoor, =474
	ldr	xcoor, =291
	ldr	height, =4
	ldr	width, =397
	mov	colour, r9
	bl	drawShape
// highlight the line on the left
	ldr	ycoor, =474
	ldr	xcoor, =291
	ldr	height, =68
	ldr	width, =3
	mov	colour, r9
	bl	drawShape
// highlight the line on the right
	ldr	ycoor, =474
	ldr	xcoor, =685
	ldr	height, =68
	ldr	width, =3
	mov	colour, r9
	bl	drawShape

// highlight the line on the bottom
	ldr	ycoor, =539
	ldr	xcoor, =291
	ldr	height, =3
	ldr	width, =397
	mov	colour, r9
	bl	drawShape
//unhighlight play border

	ldr	ycoor, =391
	ldr	xcoor, =291
	ldr	height, =3
	ldr	width, =397
	mov	colour, r8
	bl	drawShape
// unhighlight the line on the left
	ldr	ycoor, 	=391
	ldr	xcoor, 	=291
	ldr	height, =67
	ldr	width, 	=3
	mov	colour,	r8
	bl	drawShape
// unhighlight the line on the buttom
	ldr	ycoor, =455
	ldr	xcoor, =291
	ldr	height, =3
	ldr	width, =397
	mov	colour, r8
	bl	drawShape
// unhighlight the line on the right

	ldr	ycoor, 	=391
	ldr	xcoor, 	=685
	ldr	height, =67
	ldr	width, 	=3
	mov	colour,	r8
	bl	drawShape

	b	getInput
	//pop	{r0}
	//b	highlight

//---------------------------------------------------------------------------------------
	/*branch here when we hit start in the menu screen*/
don:
	push	{r6,r8-r11}			// saving the registers into the stack to avoid messing any value

	ldr	r9, [r7, #32]			// pointer of the framebuffer
	ldr	r8, =0xaaaa
	ldr	r10, =294			// j
	ldr	r11, =394			// i
	ldr	r6, =1024
	mul	r6, r11				// calculating the offsets
	add	r6, #392			
	mov	r10, #2
	mul	r6, r10
	add	r9, r6
	ldrh	r6, [r9]			// load the pixel from the border of play to check it's colour if it's 0xaaaa then play is highlighted
	cmp	r8, r6				// comparing
	pop	{r6,r8-r11}			// poping before branching
	pop	{r0}				// poping r0 was pushed for getting input above
	beq	start				// if play is highlighted go to start to start the game
	b	quit				// else quit the game

start:	
	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4

	
//----------------------------------------------------------------------------------------------
// deleting the boxes of play and quit
	ldr	ycoor, =391
	ldr	xcoor, =291
	ldr	height, =67
	ldr	width, =397
	ldr	colour, =0xff11
	bl	drawShape

	ldr	ycoor, =474
	ldr	xcoor, =291
	ldr	height, =68
	ldr	width, =397
	ldr	colour, =0xff11
	bl	drawShape

	bl 	waitingloop				// waiting after the a is pressed so the ball won't release quickly
	bl	MainGame
	// bl	gameOver			// debuging game over
	//bl	GG
	pop	{r0-r11,pc}
//----------------------------------------------------------------------------------------------
// branch here if play not highlighted (quit is highlighted in this case)
quit:
	ldr	ycoor, =0
	ldr	xcoor, =0
	ldr	height, =768
	ldr	width, =1024
	ldr	colour, =0x0
	bl	drawShape

	mov	r12, #1
	pop	{r0-r11,pc}

waitingloop:
	push {r0, r1, lr}
	mov 	r0, #0
	ldr 	r1, =3000000
inWaiting:
	add 	r0, #1
	cmp 	r0, r1
	blt 	inWaiting

	pop {r0, r1, pc}

.section .data

pointer:
	.rep	1600
	.hword	0x0
	.endr





