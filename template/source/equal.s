.section .text
.globl _equal

_equal:
	push {r3,r4,r5,r6,r7,lr}
	mov	r5, #0					// intializing the r5 (index) to 0

_cmp:
	ldrb	r6, [r2, r5]				// accessing arrays by index with r5
	ldrb	r7, [r1, r5]				// accessing arrays by index with r5

	cmp	r6, r7					// compare led_on[r5] with buff[r5]
	bne	_noteq					// if they are not equal just branch to the next test loop

	add	r5, #1					// increment the index
	cmp	r5, r3					// comparing check if r5(index) is less than the lenght of led_on, MODIFIED it was r4
	blt	_cmp

	
	cmp 	r5, r4					// There is a chance that our buffer start with for example the substring "led on" without this
	bne	_noteq					// as long as it starts with substring "led on" it's equal with the string "led on" which is not
							// true
	
	
						
	b	_eq					// we hit this instruction only a string in the buffer is equal to the string we compare to
_eq:
	mov	r0, #1					// if they are equal we return a 1 in r0 meaning True

	pop	{r3,r4,r5,r6,r7,lr}
	mov	pc, lr
_noteq:							// will branch here if they are not equal
	mov	r0, #0					// set r0 to 0 meaning False
	pop	{r3,r4,r5,r6,r7,lr}
	mov	pc, lr
