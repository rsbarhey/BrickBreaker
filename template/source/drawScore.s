.section .text
.globl 	drawScore

drawScore:
	push 	{r11,lr}


	/*wipe out the score box */

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4

		/*draw one*/
		ldr 	ycoor, =80
		ldr 	xcoor, =910
		ldr 	height, =70					
		ldr 	width, =60
		ldr 	colour, =0xff11					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		ldr 	ycoor, =80
		ldr 	xcoor, =943
	/*which score to draw*/
lrt:
	cmp 	r11, #0
	beq 	d0 
	cmp 	r11, #1
	beq 	d1
	cmp 	r11, #2
	beq 	d2
	cmp 	r11, #3
	beq 	d3
	cmp 	r11, #4
	beq 	d4
	cmp 	r11, #5
	beq 	d5
	cmp 	r11, #6
	beq 	d6
	cmp 	r11, #7
	beq 	d7
	cmp 	r11, #8
	beq 	d8
	cmp 	r11, #9
	beq 	d9
	cmp 	r11, #10
	beq 	d10
	cmp 	r11, #11
	beq 	d11
	cmp 	r11, #12
	beq 	d12
	cmp 	r11, #13
	beq 	d13
	cmp 	r11, #14
	beq 	d14
	cmp 	r11, #15
	beq 	d15
	cmp 	r11, #16
	beq 	d16

d0:
	bl 	drawZero
	pop 	{r11,pc}
d1:
	bl 	drawOne
	pop 	{r11,pc}
d2:
	bl 	drawTwo
	pop 	{r11,pc}


d3:
	bl 	drawThree
	pop 	{r11,pc}
d4:
	bl 	drawFour
	pop 	{r11,pc}
d5:
	bl 	drawFive
	pop 	{r11,pc}
d6:
	bl 	drawSix
	pop 	{r11,pc}
d7:
	bl 	drawSeven
	pop 	{r11,pc}
d8:
	bl drawEight
	pop 	{r11,pc}
d9:	
	bl drawNine
	pop 	{r11,pc}
d10:
	bl 	drawTen
	pop 	{r11,pc}
d11:
	bl 	drawEleven
	pop 	{r11,pc}
d12:
	bl 	drawTwelve
	pop 	{r11,pc}
d13:
	bl 	drawtt
	pop 	{r11,pc}
d14:
	bl 	drawft
	pop 	{r11,pc}
d15:
	bl drawfteen
	pop 	{r11,pc}	
d16:
	bl 	drawst
	
	pop 	{r11,pc}
