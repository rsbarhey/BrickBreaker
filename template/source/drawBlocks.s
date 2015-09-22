.section .text
.globl drawBlocks


drawBlocks:

	push {r0-r11,lr}

	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4

	ldr 	ycoor, =40				// start drawing rows of blocks at 102, each bloack is 60x20 
	ldr 	xcoor, =40				// start drawing at colomn 12.
	ldr 	height, =40				//must use 767 X 1023 since we're starting at 0,0
	ldr 	width, =75
	ldr 	colour, =0xffff				// nice greenish colour
	ldr		addr, [r7, #32]
	mov 	r8, 	#0 				// a counter for 8 blocks
	mov 	r9, 	#0 				// a counter for 2 rows


row_loop:

column_loop:

	bl 		drawShape

	add 	xcoor, 	#100
	
	add 	r8,		#1 				// r8++
	cmp 	r8, 	#8
	blo 	column_loop 			// r8<8 back to column loop

	mov 	r8, 	#0
	ldr 	xcoor, 	=40 			// ressetting xcoor for the new line 
	add 	ycoor, 	#200
	add 	r9, 	#1
	cmp 	r9, 	#2
	blo 	row_loop

/*DRAWING INNER BLOCKS*/
	ldr 	ycoor, =43				// start drawing rows of blocks at 102, each bloack is 60x20 
	ldr 	xcoor, =43				// start drawing at colomn 12.
	ldr 	height, =35				//must use 767 X 1023 since we're starting at 0,0
	ldr 	width, =70
	ldr 	colour, =0xf3bf			// nice greenish colour
	ldr		addr, [r7, #32]
	mov 	r8, 	#0 				// a counter for 8 blocks
	mov 	r9, 	#0 				// a counter for 2 rows


row_loop2:

column_loop2:

	bl 		drawShape

	add 	xcoor, 	#100
	
	add 	r8,		#1 				// r8++
	cmp 	r8, 	#8
	blo 	column_loop2 			// r8<8 back to column loop

	mov 	r8, 	#0
	ldr 	xcoor, 	=43 			// ressetting xcoor for the new line 
	add 	ycoor, 	#200
	add 	r9, 	#1
	cmp 	r9, 	#2
	blo 	row_loop2

	ldr 	ycoor, =46				// start drawing rows of blocks at 102, each bloack is 60x20 
	ldr 	xcoor, =46				// start drawing at colomn 12.
	ldr 	height, =30				//must use 767 X 1023 since we're starting at 0,0
	ldr 	width, =65
	ldr 	colour, =0x0000			// nice greenish colour
	ldr		addr, [r7, #32]
	mov 	r8, 	#0 				// a counter for 8 blocks
	mov 	r9, 	#0 				// a counter for 2 rows












	
// loop:
// 	ldr 	height, =20				// height of the block
// 	ldr 	width, =60				// width of the block
// 	ldr 	colour, =0x0 			// border of the block
// 	ldr		addr, [r7, #32]			
// 	bl		drawShape				// drawing a the first box. which eventually will become the border

// 	add 	ycoor, #4				// drawing inner box starts at y+4
// 	add 	xcoor, #4				// drawing inner box starts at x+4
// 	sub 	height, #8				// sub the height by 8 so the outer box on bottom be seen
// 	sub 	width, 	#8				// sub the width by 8 so the otter box on the right can be seen
// 	ldr 	colour, =0xf000 		// colour red of the inner box
// 	ldr		addr, [r7, #32]
// 	bl		drawShape				// draw inner box

// 	add	xcoor, #100					// CONTROLS SPACE BETWEEN the next block in the same row by adding the width to x coordinate
// 	ldr	ycoor, =50					// Y-DISTANCE FROM THE CEILING reset y to beginning of the row of the bloack
// 	// cmp	xcoor, #800					// compare if the beginning of the block exceeds x=800
// 	// blt	loop

/*
* These are basically copies of the previous loop
* adjusting the to the next row of the blocks (draws four more rwos of blocks)
*/
// 	ldr 	ycoor, =126
// 	ldr 	xcoor, =12
// 	mov	r6, #0
// loop2:
// 	ldr 	height, =20				//must use 767 X 1023 since we're starting at 0,0
// 	ldr 	width, =60
// 	ldr 	colour, =0x0 			// nice greenish colour
// 	ldr		addr, [r7, #32]
// 	bl		drawShape

// 	add 	ycoor, #4
// 	add 	xcoor, #4
// 	sub 	height, #8					//must use 767 X 1023 since we're starting at 0,0
// 	sub 	width, 	#8
// 	ldr 	colour, =0xf000 				// nice greenish colour
// 	ldr		addr, [r7, #32]
// 	bl		drawShape

// 	add		xcoor, #60
// 	ldr		ycoor, =126
// 	cmp		xcoor, #800
// 	blt		loop2


// 	ldr 	ycoor, =150
// 	ldr 	xcoor, =12
// 	mov		r6, #0
// loop3:
// 	ldr 	height, =20					//must use 767 X 1023 since we're starting at 0,0
// 	ldr 	width, =60
// 	ldr 	colour, =0x0 				// nice greenish colour
// 	ldr		addr, [r7, #32]
// 	bl		drawShape

// 	add 	ycoor, #4
// 	add 	xcoor, #4
// 	sub 	height, #8					//must use 767 X 1023 since we're starting at 0,0
// 	sub 	width, 	#8
// 	ldr 	colour, =0xf000					// nice greenish colour
// 	ldr		addr, [r7, #32]
// 	bl		drawShape

// 	add		xcoor, #60
// 	ldr		ycoor, =150
// 	cmp 	xcoor, #800
// 	blt		loop3

// 	ldr 	ycoor, =174
// 	ldr 	xcoor, =12
// 	mov		r6, #0
// loop4:
// 	ldr 	height, =20					//must use 767 X 1023 since we're starting at 0,0
// 	ldr 	width, =60
// 	ldr 	colour, =0x0 				// nice greenish colour
// 	ldr		addr, [r7, #32]
// 	bl		drawShape

// 	add 	ycoor, #4
// 	add 	xcoor, #4
// 	sub 	height, #8					//must use 767 X 1023 since we're starting at 0,0
// 	sub 	width, 	#8
// 	ldr 	colour, =0xf000					// nice greenish colour
// 	ldr		addr, [r7, #32]
// 	bl		drawShape

// 	add	xcoor, #60
// 	ldr	ycoor, =174
// 	cmp	xcoor, #800
// 	blt	loop4

// 	ldr 	ycoor, =198
// 	ldr 	xcoor, =12
// 	mov	r6, #0
// loop5:
// 	ldr 	height, =20					//must use 767 X 1023 since we're starting at 0,0
// 	ldr 	width, =60
// 	ldr 	colour, =0x0 				// nice greenish colour
// 	ldr	addr, [r7, #32]
// 	bl	drawShape

// 	add 	ycoor, #4
// 	add 	xcoor, #4
// 	sub 	height, #8					//must use 767 X 1023 since we're starting at 0,0
// 	sub 	width, 	#8
// 	ldr 	colour, =0xf000					// nice greenish colour
// 	ldr	addr, [r7, #32]
// 	bl	drawShape

// 	add	xcoor, #60
// 	ldr	ycoor, =198
// 	cmp	xcoor, #800
// 	blt	loop5



	

	
	pop {r0-r11,pc}


