.section 	.text
.globl 		drawThree

drawThree:

	push 	{lr}

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4

		/*top horizontal block*/
		ldr 	ycoor, =80
		ldr 	xcoor, =943
		ldr 	height, =3 						// width of each number is 3 pixels					
		ldr 	width, =20
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		/*midle horizontal block*/
		ldr 	ycoor, =110
		ldr 	xcoor, =943
		ldr 	height, =3 						// width of each number is 3 pixels					
		ldr 	width, =20
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		/*bottom horizontal block*/
		ldr 	ycoor, =140
		ldr 	xcoor, =943
		ldr 	height, =3 						// width of each number is 3 pixels					
		ldr 	width, =20
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		/*top vertical block*/
		ldr 	ycoor, =80
		ldr 	xcoor, =963
		ldr 	height, =33 						// width of each number is 3 pixels					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		/*bottom vertical block*/
		ldr 	ycoor, =110
		ldr 	xcoor, =963
		ldr 	height, =33 						// width of each number is 3 pixels					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

	pop 	{pc}