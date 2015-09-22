.section 	.text
.globl 	drawHeart

drawHeart:
	

/*The heart is drawn by first drawing the background square and then chipping away at it
using smaller squares. The heart is ASYMMETRICAL BY DESIGN*/
		push 	{r0-r11, lr}

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4

		//base square
		ldr 	ycoor, =500
		ldr 	xcoor, =925
		ldr 	height, =35					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =35
		ldr 	colour, =0xf111					// colour of the base square
		ldr	addr, [r7, #32]
		bl	drawShape
		mov 	r8, 	#0
		mov 	r11, 	xcoor
		mov 	r10, 	ycoor


	


		// start cutting away
		ldr 	ycoor, =534
		ldr 	xcoor, =925
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =16
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl	drawShape

for11:
		sub 	ycoor, 	#2
		sub 	width,	#2
		bl 		drawShape
		add 	r8, 	#1
		cmp 	r8, 	#35
		bls 	for11
		
		ldr 	ycoor, =534
		ldr 	xcoor, =943
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =17
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl	drawShape
		mov 	r8, 	#0
for12:
		sub 	ycoor, 	#2
		sub 	width,	#2
		add 	xcoor,	$2
		bl 		drawShape
		add 	r8, 	#1
		cmp 	r8, 	#35
		bls 	for12
r:
		/*roundy part1*/
		ldr 	ycoor, =500
		ldr 	xcoor, =925
		ldr 	height, =4					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =4
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*roundy partc*/
		ldr 	ycoor, =500
		ldr 	xcoor, =942
		ldr 	height, =4					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape


		/*roundy part2*/
		ldr 	ycoor, =500
		ldr 	xcoor, =956
		ldr 	height, =4					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =4
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*details*/
		ldr 	ycoor, =504
		ldr 	xcoor, =925
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*details*/
		ldr 	ycoor, =504
		ldr 	xcoor, =958
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*details top roundy part left*/
		ldr 	ycoor, =500
		ldr 	xcoor, =930
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*details top roundy part left*/
		ldr 	ycoor, =500
		ldr 	xcoor, =939
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*details top roundy part right */
		ldr 	ycoor, =500
		ldr 	xcoor, =945
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape

		/*details top roundy part right*/
		ldr 	ycoor, =500
		ldr 	xcoor, =954
		ldr 	height, =2					//must use 767 X 1023 since we're starting at 0,0
		ldr 	width, =2
		ldr 	colour, =0xff11					// colour of the background used to undraw
		ldr	addr, [r7, #32]
		bl 	drawShape





		pop 	{r0-r11, pc}
