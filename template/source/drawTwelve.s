.section 	.text
.globl 		drawTwelve

drawTwelve:

	push 	{lr}

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4

		mov 	r11, 	xcoor
		mov 	r10, 	ycoor
		
		/*draw one*/
		sub 	xcoor, #30 				//(x-30,y)
		
		bl 		drawOne
	
		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	



		bl 	drawTwo

	pop 	{pc}