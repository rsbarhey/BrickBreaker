.section .text
.globl gameScreen


gameScreen:

	push {r0-r11,lr}

	ycoor	.req	r0
	xcoor	.req	r1
	height	.req	r2
	width	.req	r3
	colour	.req	r5
	addr 	.req	r4

	ldr 	ycoor, =0
	ldr 	xcoor, =0
	ldr 	height, =767					//must use 767 X 1023 since we're starting at 0,0
	ldr 	width, =1023
	ldr 	colour, =0xaaaa					// nice greenish colour
	ldr	addr, [r7, #32]

	bl	drawShape


	ldr	ycoor, =10
	ldr	xcoor, =10
	ldr	height, =747
	ldr	width, =1003
	ldr	colour, =0xff11
	bl	drawShape

	ldr	ycoor, =10
	ldr	xcoor, =843
	ldr	height, =747
	ldr	width, =170
	ldr	colour, =0xb4
	bl	drawShape					// draw blue box on the right side
	
	bl	drawPeddle

	bl	drawBlocks
	pop {r0-r11,pc}




