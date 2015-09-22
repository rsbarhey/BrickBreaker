.section .text
.globl	NewGame

NewGame:
	push	{r0-r11,lr}

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4



// draw background
background:

		ldr 	ycoor, =0
		ldr 	xcoor, =0
		ldr 	height, =767					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =1023
		ldr 	colour, =0xf3f2					// nice greenish colour
		ldr	addr, [r7, #32]
		bl	drawShape

		/*border*/
		ldr 	ycoor, =10
		ldr 	xcoor, =10
		ldr 	height, =747					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =1003
		ldr 	colour, =0xff11					// nice greenish colour
		ldr	addr, [r7, #32]
		bl	drawShape

		/*invisible wall on the right*/
		ldr 	ycoor, =10
		ldr 	xcoor, =843
		ldr 	height, =747					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =10
		ldr 	colour, =0xf3f2					// ALMOST hte colour of the BG
		ldr	addr, [r7, #32]
		// ldr 	colour, =0x0000					// black

		bl	drawShape

		/*Heart*/
		bl 	drawHeart
		/*Blocks*/
		bl 	drawBlocks
		/*peddle*/
		bl 	drawPeddle
		/*Three Balls one for every life*/
		ldr 	ycoor,	=540
		ldr		xcoor,	=930
		ldr 	height, =5					
		ldr 	width,  =5
		ldr 	colour, =0x0000				// black
		ldr		addr, [r7, #32]
		bl 		drawShape

		ldr 	ycoor,	=540
		ldr		xcoor,	=940
		ldr 	height, =5					
		ldr 	width,  =5
		ldr 	colour, =0x0000				// black
		ldr		addr, [r7, #32]
		bl 		drawShape

		ldr 	ycoor,	=540
		ldr		xcoor,	=950
		ldr 	height, =5					
		ldr 	width,  =5
		ldr 	colour, =0x0000				// black
		ldr		addr, [r7, #32]
		bl 		drawShape


	pop		{r0-r11,pc}
