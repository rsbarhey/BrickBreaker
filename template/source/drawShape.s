.section .text
.globl drawShape



/*
	@params:
		ycoor	=	r0
		xcoor	=	r1
		height	=	r2
		width	=	r3
		colour	=	r5
		addr 	=	r4

	pushes everything on to the stack, otherwise breaks


	@method

		public void drawShape( y, x, height, width)
		{
			for(i=0;i<=height;i++)
			{
				for(j=0;j<=width;j++)
				{
					FrameBuffAddr = 
					draw(FrameBuffAddr);
				}
			}
		}


*/
drawShape:
	
	push	{r0-r11,lr}

	i	.req	r0
	j	.req	r1
	height	.req	r2
	width	.req	r3
	addr	.req	r4
	add	height,	i
	add	width,	j				// width is always more than x by width 
	mov	r12,	j				// saving original value of j 

	ldr	addr, [r7, #32]
	// ldrh	r5, =0x0a0a

for1:
	cmp	i,	height				// i>height ? end, continue
	bhi	end
	add	i,	#1					// i++
	mov	j,	r12					// restoring j back to its orignial value
for2:
	cmp	j,	width
	bhi	for1
	sub	i,	#1					// i--, because it was incremented previously. 
	ldr	r9,	=1024
	mul	r9,	i					// r9 = i*1024
	mov	r10,	r9				// r10= r9
	add	r10,	j				// r10 = r10+j
	mov	r9,	#2					// r9 =2
	mul	r10,	r9				// r10 = r10*2
	mov	r9,	addr
	add	r9,	r10					// addr = addr+r10
	strh	r5,	[r9]		


	add	i,	#1					//incremented i to original before manipulation
	add	j,	#1					// j++
	b	for2					// go back through forloop#2 inner loop
end:

	pop		{r0-r11, pc}

	
