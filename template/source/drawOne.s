.section 	.text
.globl 		drawOne

drawOne:

	push 	{lr}

		/*int drawOne(xcoor,ycoor)
		{
			drawShape();
		}*/
		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4


		 // ldr 	ycoor, =80
		 // ldr 	xcoor, =943
		ldr 	height, =63					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		
		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11					// reset ycoor and xcoor
		
	pop 	{pc}