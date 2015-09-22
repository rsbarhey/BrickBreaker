.section .text
.globl 	wipe


wipe:
		push {lr}
	

/*
	if (r10(y) > 110)
	{
		y=110
	}
	else
	{
		y=10
	}

	while(x>current)
	{
		current+=100

	}
	x=current

	wipe(x,y)

	We get y as r10
	We get x as r11.

	first we compare whether the contact happened in the first row or the second row
	hence y =10 or y =110. 

	The Outter hit-boxes are 100x100 pixels. Everytime the ball comes in contact with a block, we figure out 
	the blocks hitbox and wipe out the hitbox.

		
*/

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4
		current	.req 	r8
		next 	.req 	r9
		

		mov 	height, #100
		mov 	width,	#100
		ldr 	colour, =0xff11
		ldr 	addr, [r7,#32]
		ldr 	current, =30
		ldr 	next, 	 =130


		ldr 	xcoor,	=30
		ldr 	ycoor, 	=10

		

		


firstIf:
		
		cmp 	r10,	#110
		bhs 	secondRow

firstRow:
		
		b 		while

secondRow:
		ldr 	ycoor, 	=210



while:

		cmp 	r11, current
		bhi 	secondTest			// branch on r11 > current
		b unDraw
	
secondTest:
		cmp 	r11, next
		blo 	unDraw 				// branch on r11 < next
		add 	current, 	#100
		add 	next,		#100
		b 		while
unDraw:

		mov 	xcoor, 	current 	// x = current
		bl 	drawShape



		pop		{ pc}
		mov 	pc, lr 



