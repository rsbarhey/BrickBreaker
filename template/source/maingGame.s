.section	.init
.globl		MainGame

/*Uses drawshap to draw the "ball" */
MainGame:
	
		push	{r0-r11,lr}


		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4



/* Animation. 
   First draw the ball at (x,y)
   wait for 40k cycles
   Undraw the ball at (x,y)
   Repeat
*/




/*Animation +/-
	Infinite animation. 
	
	The ball may have four vectors of directions 
	Decreasing y and decreasing x values ( negativeY_negativeX_loop(NyNx))
	Decreasing y and increasing x values ( negativeY_positiveX_loop(NyPx))
	Increasing y and increasing x values ( positiveY_positiveX_loop(PyPx))
	Increasing y and decreasing x values ( positiveY_negativeX_loop(PyNx))

	Ball starts on NyNx then depanding on the nature of the collision it will change
	its course.

	Ball checks pixels just ahead of its corners to detect collision. COllision is detected as such:
	If colour of the next pixel != colour of the background
		do collision logic.

	The ppixels checked depend on the vector of movement. For example for PyPx we check pixels just below the ball
	and pixels directly to the right of the ball.	

	*IMPORTANT*
	
	*IMPORTANT*

	Ball will bounce forever like this.
	To call this method succeshfully create a canvas with background of #ff11 first
	then call this method
*/

	
		mov 	r10, 	#3

		//preloading score
		ldr 	r10, 	=score
		mov 	r11, 	#0
		strb 	r11, 	[r10]
		bl 		drawScore
		//preloading number of lives
		ldr 	r10, 	=lives
		mov 	r11, 	#4
		strb 	r11, 	[r10]

/*COLLISIONS

	The center of the ball is at (2,2) ( since the ball is 5x5. Coordinates are relative to the ball in this case). or in other words
	(ycoor+2,xcoor+2)
	Vector of movement changes if center+2 encounters one of the bouncable colours


*/


start_game_from_start:
		push 	{r10,r11}
l1:
		ldr 	r10, 	=lives
		ldrb 	r11, 	[r10]
		sub 	r11, 	#1
		strb 	r11, 	[r10]

/*undraw life*/
		ldr 	ycoor,	=540
		ldr	xcoor,	=930
		ldr 	height, =5					
		ldr 	width,  =5
		ldr 	colour, =0xff11				// black
		ldr		addr, [r7, #32]
		
/*number of lives left*10, then add that to the originial offset of the undraw
that way the balls will be indrawn in sequence*/
	e:
		mov 	r10, #0
		add 	r10, 	r11, lsl #3
		lsl 	r11, 	#1
		add 	r10, 	r11
		/*add score*10 to the ofset*/
		add 	xcoor, 	r10
		bl 		drawShape


/*check if no lives left*/
		ldr 	r10, 	=lives
		ldrb 	r11, 	[r10]
		cmp 	r11, 	#0
		pop 	{r10,r11}
		beq 	return 
			

		// Undraw Peddle from previous life

		ldr	ycoor,	=737
		ldr	xcoor,	=10
		ldr	height, =15
		ldr	width,	=832
		ldr	colour,	=0xff11
		bl	drawShape


		/*draw Peddle back at the initial position */
		bl	drawPeddle	
		// ldr 	ycoor,	=731					// first draw the ball on the peddle before checking for input
		// ldr	xcoor,	=425
		// ldr 	height, =5					//must use 767 X 1023 since were starting at 0,0
		// ldr 	width,  =5
		// ldr 	colour, =0x0000				
		// ldr	addr, [r7, #32]
		// bl	drawShape
		// Detect SNES press A to release the ball

		push	{r0-r2}						// saving r0-r2 in the stack, for integration purposes
		ldr	r9, =370					// the value of where the peddle starts
	getInputgame0:
		bl 		waiting
		bl	ReadSNES					// check for ipnut from snes
		
		mov	r2,	#1
		lsl	r2,	#8					// check if A is pressed on the snes controller
		push	{r0}
		and	r0, r0, r2
		cmp	r0,	r2
		pop 	{r0}
		bne	startit						// if A is pressed go to startit 

		mov 	r2, #1
		lsl		r2, #6
		push	{r0}
		and		r0, r0, r2
		cmp 	r0, r2
		pop 	{r0}
		bne 	moveitLgame0

		mov 	r2, #1
		lsl 	r2, #7
		and 	r0, r0, r2
		cmp 	r0, r2
		bne 	moveitRgame0

		b	getInputgame0

moveitRgame0:
		//bl 		waiting
		add 	r1, #2
		mov 	r1, r9
		bl 	movePeddleR
		mov 	r9, r1
		b 		getInputgame0
moveitLgame0:
		//bl 		waiting
		mov 	r1, r9
		bl 	movePeddleL
		mov 	r9, r1
		b 		getInputgame0
startit:								// ball will move here
		pop	{r0- r2}

		//preloading values of the ball. 
		ldr 	ycoor,	=731
		add	xcoor,	r9, #60
		ldr 	height, =5					
		ldr 	width,  =5
		ldr 	colour, =0x0000				// black
		ldr		addr, [r7, #32]
		


scr:
		// /*increment score by 1*/
		// ldr 	r10, 	=score
		// ldrb 	r11, 	[r10]
		// add 	r11, 	#1
		
		/*finish incrementing score by 1*/

positiveY_positiveX_loop:

			ldr 	colour, =0x0000				// colour of the black ball
			bl 		drawShape
			ldr		r11,		=30000			// smoothe wait
			mov		r10,		#0
	waitLoop:
			cmp		r11,		r10
			add 	r10, 	#1
			bhi		waitLoop

			ldr 	colour, =0xff11 			// colour of "undraw ball"

			bl 		drawShape
calc:

/* Compare ycoor with 763, if it is more than that then loop to start_game_from_start, 
which will set the ball at the origini, provided the player has any loves left*/
			ldr 	r11, 	=748
			cmp 	ycoor, 	r11
			bhs 	start_game_from_start

		getInputgame:							// get input while the ball move, check for left or right pads pressed
			push	{r0, r1}
			mov	r1, r9					// moving the intial value of the peddle to r1 which is needed for moving
			bl	ReadSNES
			push	{r2}					// pudhing r2 for integration purposes until we go out of here
			mov	r2,	#1				
			lsl	r2,	#6				// check if left is pressed
			push	{r0}					// saving up r0, because we modifing it down to figure which button was pressed
			and	r0, r0, r2
			cmp	r0,	r2
			pop	{r0}					// poping it again before taking the branch, it still has the value returned from ReadSNES
			bne	moveitLgame				// if left pressed move peddle left
			
			mov	r2, #1
			lsl	r2, #7					// check if right is pressed
			and	r0, r0, r2
			cmp	r0,	r2
			
			bne	moveitRgame				// move peddle right when the right on snes is pressed
			
			b	next



		moveitLgame:

			bl	movePeddleL				// takes r1 (where the peddle is) and move it left
			mov	r9, r1					// in r1 is the new position of the peddle, update r9 to current position
			b	next					// b next
		moveitRgame:

			bl	movePeddleR				// same as above instead it moves the peddle to the right
			mov	r9, r1
			b	next


		next:
			pop	{r2}					// poping r2
			pop	{r0, r1}				// poping r0-r1 for integration purposes			
// /*CHEKING FOR COLLISION ON THE BOTTOM OF THE BALL*/
// 			/*cheking whether the bottom left corner touches anything*/
// 			/* checking coordinate (x,(y+6))     					 */
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r10, 	#6					// r10 = y+6 aka next pixel after the ball
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			ldr 	r8, 	=0xffff 			// ccolour of the blocks.
			
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]

			cmp 	r6, r8						// branch if touches the blocks
			beq 	wab_np						// wipe and bounce

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks



			bne 	negativeY_positiveX_loop	// bounce of everything but the blocks
			
// 			/*cheking whther the bottom right corner touches anything*/
// 			/* checking coordinate ((x+5),(y+6))					 */

			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r10, 	#6					// r10 = y+5 aka next pixel after the ball
			add 	r11, 	#5 					// r11 = x+6
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_np						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks

			bne 	negativeY_positiveX_loop	// bounce of everything but the blocks

// /*CHEKING FOR COLLISION ON THE RIGHT SIDE OF THE BALL*/

			/* checking whether the top right of the ball is touching anything*/
			/* checking coordinate ((x+6),y)								  */
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

p:			
			add 	r11, 	#6 					// r11 = x+6
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	positiveY_negativeX_loop	// 

			// checking whether the bottom right of the ball is touching anything
			/* checking coordinate ((x+6),(y+5))								 */
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r10, 	#5 					// y = y+5
			add 	r11, 	#6 					// x = x+6
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	positiveY_negativeX_loop	// 


			add 	ycoor, 	#1 					// y++
			add 	xcoor, 	#1 					// x++

			b 		positiveY_positiveX_loop

negativeY_positiveX_loop:
			

			ldr 	colour, =0x0000				// colour of the black ball
			bl 		drawShape
			ldr		r11,		=30000			// smoothe wait
			mov		r10,		#0
	waitLoop_np:
			cmp		r11,		r10
			add 	r10, 	#1
			bhi		waitLoop_np

			ldr 	colour, =0xff11 			// colour of "undraw ball"

			bl 		drawShape
	getInputgame2:
			push	{r0, r1}
			mov	r1, r9					// updated value of the peddle is put in r1
			bl	ReadSNES
			push	{r2}
			mov	r2,	#1				// this the same as getInputgame
			lsl	r2,	#6
			push	{r0}
			and	r0, r0, r2
			cmp	r0,	r2
			pop	{r0}
			bne	moveitLgame2
			
			mov	r2, #1
			lsl	r2, #7
			and	r0, r0, r2
			cmp	r0,	r2
			
			bne	moveitRgame2
			
			b	next2



		moveitLgame2:

			bl	movePeddleL
			mov	r9, r1
			b	next2
		moveitRgame2:

			bl	movePeddleR
			mov	r9, r1
			b	next2


		next2:
			pop	{r2}	
			pop	{r0, r1}
// // calc2:
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x
 			

// /*CHEKING FOR COLLISION ON THE RIGHT OF THE BALL*/
// 			/*cheking whether the top right corner touches anything*/
// 			/* checking coordinate ((x+6),y)     					 */

			add 	r11, 	#6					// r11 = x+6 aka next pixel after the ball
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2	
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_nn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	negativeY_negativeX_loop	// colour of the background


// 			/*cheking whether the top left corner touches anything*/
// 			/* checking coordinate ((x+6),(y+5))     			  */
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r11, 	#6					// r11 = x+6 aka next pixel after the ball
			add 	r10, 	#5 					// r10 = y+5
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_nn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	negativeY_negativeX_loop	// colour of the background


// /*CHEKING FOR COLLISION ON TOP OF THE BALL*/
// 			/*cheking whether the top right corner touches anything*/
// 			/* checking coordinate ((x),(y-1))     					 */



cal3:

			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			sub 	r10, 	#1 					// r10 = y-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]

			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pp						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	positiveY_positiveX_loop	// colour of the background

// 			/*cheking whether the top right corner touches anything*/
// 			/* checking coordinate ((x+5),(y-1))     					 */


			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r11, 	#5					// 
			sub 	r10, 	#1 					// r10 = y-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2

			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pp						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	positiveY_positiveX_loop	// colour of the background

			sub 	ycoor, 	#1 					// y--
			add 	xcoor, 	#1 					// x++

			b 		negativeY_positiveX_loop

		
negativeY_negativeX_loop:
		
			
			ldr 	colour, =0x0000				// colour of the black ball
			bl 		drawShape
			ldr		r11,		=30000			// smoothe wait
			mov		r10,		#0
	waitLoop_nn:
			cmp		r11,		r10
			add 	r10, 	#1
			bhi		waitLoop_nn

			ldr 	colour, =0xff11 			// colour of "undraw ball"

			bl 		drawShape
	getInputgame3:
			push	{r0, r1}
			mov	r1, r9
			bl	ReadSNES
			push	{r2}
			mov	r2,	#1
			lsl	r2,	#6
			push	{r0}
			and	r0, r0, r2
			cmp	r0,	r2
			pop	{r0}
			bne	moveitLgame3
			//--------------------------- Same as getInputgame
			mov	r2, #1
			lsl	r2, #7
			and	r0, r0, r2
			cmp	r0,	r2
			
			bne	moveitRgame3
			
			b	next3



		moveitLgame3:

			bl	movePeddleL
			mov	r9, r1
			b	next3
		moveitRgame3:

			bl	movePeddleR
			mov	r9, r1
			b	next3


		next3:
			pop	{r2}	
			pop	{r0, r1}

/*CHEKING FOR COLLISION ON TOP OF THE BALL*/
			/*cheking whether the top right corner touches anything*/
			/* checking coordinate ((x),(y-1))     					 */
calc4:
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			sub 	r10, 	#1 					// r10 = y-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]

			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	positiveY_negativeX_loop	// colour of the background

			/*cheking whether the top right corner touches anything*/
			 // checking coordinate ((x+5),(y-1))     					 

			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r11, 	#5 					// r11 = x+5
			sub 	r10, 	#1 					// r10 = y-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]

			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks

			bne 	positiveY_negativeX_loop	// colour of the background

// /*CHEKING FOR COLLISION ON LEFT OF THE BALL*/
// 			/*cheking whether the top right corner touches anything*/
// 			/* checking coordinate ((x-1),y)     					 */

			
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			sub 	r11, 	#1 					// r11 = x-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
		
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]

			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_np						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks

			bne 	negativeY_positiveX_loop	// colour of the background

// 			/*cheking whether the top right corner touches anything*/
// 			/* checking coordinate ((x-1),(y+5))     					 */

			
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			sub 	r11, 	#1 					// r11 = x-1
			add 	r10, 	#5 					// r10 = y+5
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_np						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	negativeY_positiveX_loop	// colour of the background
		
			
			sub 	ycoor, 	#1 					// y--
			sub 	xcoor, 	#1 					// x--

			b negativeY_negativeX_loop

		

positiveY_negativeX_loop:

			ldr 	colour, =0x0000				// colour of the black ball
			bl 		drawShape
			ldr		r11,		=30000			// smoothe wait
			mov		r10,		#0
	waitLoop_pn:
			cmp		r11,		r10
			add 	r10, 	#1
			bhi		waitLoop_pn

			ldr 	colour, =0xff11 			// colour of "undraw ball"

			bl 		drawShape
	getInputgame4:
			push	{r0, r1}
			mov	r1, r9
			bl	ReadSNES
			push	{r2}
			mov	r2,	#1
			lsl	r2,	#6
			push	{r0}
			and	r0, r0, r2
			cmp	r0,	r2
			pop	{r0}
			bne	moveitLgame4
			//----------------------------------- same as getInputgame
			mov	r2, #1
			lsl	r2, #7
			and	r0, r0, r2
			cmp	r0,	r2
			
			bne	moveitRgame4
			
			b	next4



		moveitLgame4:

			bl	movePeddleL
			mov	r9, r1
			b	next4
		moveitRgame4:

			bl	movePeddleR
			mov	r9, r1
			b	next4


		next4:
			pop	{r2}	
			pop	{r0, r1}
/* Compare ycoor with 763, if it is more than that then loop to start_game_from_start, 
which will set the ball at the origini, provided the player has any loves left*/
			ldr 	r11, 	=748
			cmp 	ycoor, 	r11
			bhs 	start_game_from_start

//*CHEKING FOR COLLISION ON LEFT OF THE BALL*/
			/*cheking whether the top right corner touches anything*/
			/* checking coordinate ((x-1),y)     					 */

			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			sub 	r11, 	#1 					// r11 = x-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]

			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pp						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks

			bne 	positiveY_positiveX_loop	// colour of the background

			/*cheking whether the top right corner touches anything*/
			 /*checking coordinate ((x-1),(y+5))  */   					 

			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r10, 	#5 					// r11 = y+5
			sub 	r11, 	#1 					// r11 = x-1
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_pp						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	positiveY_positiveX_loop	// colour of the background

// // /*CHEKING FOR COLLISION ON THE BOTTOM OF THE BALL*/
// // 			/*cheking whether the bottom left corner touches anything*/
// // 			/* checking coordinate (x,(y+6))     					 */
	
			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r10, 	#6					// r10 = y+6 aka next pixel after the ball
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_nn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	negativeY_negativeX_loop	// colour of the background
			
// 			/*cheking whther the bottom right corner touches anything*/
// 			/* checking coordinate ((x+5),(y+6))					 */

			mov 	r11, 	xcoor				// r11 = y
			mov 	r10, 	ycoor 				// r10 = x

			add 	r10, 	#6					// r10 = y+6 aka next pixel after the ball
			add 	r11, 	#5 					// r11 = x+5
			ldr 	r6, 	=1024
			mul 	r10, 	r6 					// r11*1024 === y*1024
			add 	r11, 	r10					// r11=r11+r10 === r11 = ((y+6)*1024)+x
			mov 	r8, 	#2
			mul 	r11, r8						// r11=r11*r8 === r11=r11*2
			
			add 	r11, 	addr				// r11=addr+offset from of the corner(x,y+6)

			ldrh 	r6, 	[r11]
			ldr 	r8, 	=0xffff 			// colour of the blocks
			cmp 	r6, r8						// branch if touches anything other than

			beq  	wab_nn						// branch if touches the block

			ldr 	r8, 	=0xff11				// ccolour of everything else but the blocks
			cmp 	r6, r8						// branch if touches anything but the blocks
			bne 	negativeY_negativeX_loop	// colour of the background
			
			
			add 	ycoor, 	#1 					// y++
			sub 	xcoor, 	#1 					// x--

			b 	positiveY_negativeX_loop
			
		

return:
/*add game over screen bl*/
		bl	gameOver
		pop		{r0-r11, pc}
return2:
		bl	GG
		pop		{r0-r11, pc}	
		
wab_pn:
		push 	{r0-r11}
		mov 	r11, 	xcoor				// r11 = y
		mov 	r10, 	ycoor 				// r10 = x
		bl 		wipe
		

		/*increment score by 1*/
		ldr 	r10, 	=score
		ldrb 	r11, 	[r10]
		add 	r11, 	#1
		strb 	r11, 	[r10]
		bl 		drawScore
		/*finish incrementing score by 1*/
		cmp	r11, #16
		pop 	{r0-r11}
		beq	return2
		b 	positiveY_negativeX_loop	// loop back to the appropriate vector label

wab_pp:
		push 	{r0-r11}
		mov 	r11, 	xcoor				// r11 = y
		mov 	r10, 	ycoor 				// r10 = x
		bl 		wipe


		/*increment score by 1*/
		ldr 	r10, 	=score
		ldrb 	r11, 	[r10]
		add 	r11, 	#1
		strb 	r11, 	[r10]
		bl 		drawScore
		/*finish incrementing score by 1*/
		cmp	r11, #16
		pop 	{r0-r11}
		beq	return2
		b 	positiveY_positiveX_loop	// loop back to the appropriate vector label
wab_nn:
		push 	{r0-r11}
		mov 	r11, 	xcoor				// r11 = y
		mov 	r10, 	ycoor 				// r10 = x
		bl 		wipe
		

		
		/*increment score by 1*/
		ldr 	r10, 	=score
		ldrb 	r11, 	[r10]
		add 	r11, 	#1
		strb 	r11, 	[r10]
		bl 		drawScore
		/*finish incrementing score by 1*/
		cmp	r11, #16
		pop 	{r0-r11}
		beq	return2
		b 	negativeY_negativeX_loop	// loop back to the appropriate vector label

wab_np:
		push 	{r0-r11}
		mov 	r11, 	xcoor				// r11 = y
		mov 	r10, 	ycoor 				// r10 = x
		bl 		wipe 
	

		/*increment score by 1*/
		ldr 	r10, 	=score
		ldrb 	r11, 	[r10]
		add 	r11, 	#1
		strb 	r11, 	[r10]
		bl 		drawScore
		/*finish incrementing score by 1*/
		cmp	r11, #16
		pop 	{r0-r11}
		beq	return2
		b 	negativeY_positiveX_loop	// loop back to the appropriate vector label


waiting:
		push	{r0, r1, lr}

		mov 	r0, #0
		ldr 	r1, =30000
waitingin:
		add 	r0, #1
		cmp 	r0, r1
		blt		waitingin


		pop 	{r0, r1, pc}

.section .data
lives:
	.byte 4
score:
	.byte 0 
