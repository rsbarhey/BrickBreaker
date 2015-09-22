.section 	.text
.globl 		drawZero

drawZero:

	push 	{lr}

		ycoor	.req	r0
		xcoor	.req	r1
		height	.req	r2
		width	.req	r3
		colour	.req	r5
		addr 	.req	r4

		mov 	r11, 	xcoor
		mov 	r10, 	ycoor

		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	


		/*top horizontal block*/
		// ldr 	ycoor, =80
		// ldr 	xcoor, =943
		ldr 	height, =3 						// width of each number is 3 pixels					
		ldr 	width, =20
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		

		/*bottom horizontal block*/
		// ldr 	ycoor, =140
		// ldr 	xcoor, =943
		add 	ycoor, 	#60 					// (x,y+60)
		ldr 	height, =3 						// width of each number is 3 pixels					
		ldr 	width, =20
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	


		/*top right vertical block*/
		// ldr 	ycoor, =80
		// ldr 	xcoor, =963
		add 	xcoor,	#20 					// (x+20,y)
		ldr 	height, =33 						// width of each number is 3 pixels					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	


		/*top left vertical block*/
		// ldr 	ycoor, =80
		// ldr 	xcoor, =943
		ldr 	height, =33 						// width of each number is 3 pixels					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	


		/*bottom left vertical block*/
		// ldr 	ycoor, =110
		// ldr 	xcoor, =943
		add 	ycoor, 	#30 					//(x,y+30)
		ldr 	height, =33 						// width of each number is 3 pixels					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	


		/*bottom right vertical block*/
		// ldr 	ycoor, =110
		// ldr 	xcoor, =963
		add 	ycoor, #30
		add 	xcoor, #20 						// (x+20,y+30)
		ldr 	height, =33 						// width of each number is 3 pixels					
		ldr 	width, =3
		ldr 	colour, =0x0000					// blocj colour for the numbers
		ldr	addr, [r7, #32]
		bl	drawShape

		mov 	ycoor, 	r10 
		mov 	xcoor, 	r11		// reset ycoor and xcoor	


	pop 	{pc}