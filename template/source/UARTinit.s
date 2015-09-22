.section    .text
.globl     _UARTinit


    
.equ	GPPUD,			0x20200094
.equ	GPPUDCLK0,		0x20200098

.equ	AUX_ENABLES,	0x20215004
.equ	AUX_MU_IO_REG,	0x20215040
.equ	AUX_MU_IER_REG,	0x20215044
.equ	AUX_MU_IIR_REG,	0x20215048
.equ	AUX_MU_LCR_REG,	0x2021504C
.equ	AUX_MU_MCR_REG,	0x20215050
.equ	AUX_MU_LSR_REG,	0x20215054
.equ	AUX_MU_MSR_REG,	0x20215058
.equ	AUX_MU_SCRATCH,	0x2021505C
.equ	AUX_MU_CNTL_REG,0x20215060
.equ	AUX_MU_STAT_REG,0x20215064
.equ	AUX_MU_BAUD_REG,0x20215068

_UARTinit:
	push {lr}

	
_1:
	//1 - enable miniUART
	ldr	r1, =AUX_ENABLES
	ldr	r0, [r1]
	mov	r2, #0b1		// set right 
	bic	r0, r2
	orr	r0, r2
	str	r0, [r1]
	ldr	r0, [r1]		// debugging purp


_2:
	//2 - Disable interruprs
	ldr	r1, =AUX_MU_IER_REG
	ldr	r0, [r1]
	and	r0, #0
	str	r0, [r1]
	ldr	r0, [r1]

_3:
	//3 - Disable recieving Transmitting
	ldr	r1, =AUX_MU_CNTL_REG
	ldr	r0, [r1]
	mov	r2, #0b11
	bic	r0, r2			// setting last 2 bits to 0
	str	r0, [r1]

_4:
	//4-set symbol with 8 bits
	ldr	r1, =AUX_MU_LCR_REG
	ldr	r0, [r1]
	mov	r2, #0b11		// MODIFIED
	orr	r0, r2			// setting last bit to 1
	str	r0, [r1]

_5:
	//5 - set RTS line high
	ldr	r1, =AUX_MU_MCR_REG
	ldr	r0, [r1]
	mov	r2, #0b10
	bic	r0, r2
	str	r0, [r1]

_5_1:
	ldr	r1, =AUX_MU_IER_REG
	ldr	r0, [r1]
	and	r0, #0
	str	r0, [r1]
	ldr	r0, [r1]
	
_6:
	//6 - Clear the input and output Bufffers
	ldr 	r1, =AUX_MU_IIR_REG
	ldr 	r0, [r1]
	mov	r2, #0b0110
	orr	r0, r2
	eor	r0, #0b1		// MODIFIED
	str	r0, [r1]
_7:
	//7- Set the Baud rate
	ldr	r1, =AUX_MU_BAUD_REG
	ldr	r0, [r1]
	ldr	r2, =270		// if this break it's here
	str	r2, [r1]


_8:	
	//8- set RXD 15 and TXD 14 to alt func 5.

	/* So, turns out that in order to change GPIO lines we need to access 0x20200004*/

	ldr	r1, =0x20200004		//adress of the 10-19 GPIO lines 
	ldr	r0, [r1]		//r0 = 10-19GPIO
	mov	r2, #0b00111111		//set 111 for GPIO14 and 111 for GPIO15
	lsl	r2, #12			//mov bitmask 12 positons left to align with GPIO 14-15( positions 12-17 in bits)
	bic	r0, r2			// bitclear  bits 12-17 in r0
	
	mov	r2, #0b010010		// 010 = alt function 5
	lsl	r2, #12			//shift bitmask 12 positon to align with bits 12-17
	orr	r0, r2			//change bits 12-17 to 010 010, while leavign everything else unchanged
	str	r0, [r1]		//store back
	
_9:
	//9- Disable pull-up/pulldown for rxd (15) and TXD 14 GPIO lines
	ldr	r1, =GPPUD		// get pud reg
	ldr	r0, [r1]
	mov	r2, #0b11		// set 11 to clear bits [0:1]
	bic	r0, r2			// clear bitc [0:1]
	str	r0, [r1]

	
	bl	wait_150		// wait 150 cycles
	
_9_1:
	ldr	r1, =GPPUDCLK0		// 
	ldr	r0, [r1]		// get the reg0 of GPIO pull up/down, page 101, dude
	mov	r2, #0b1		//MODIFIED		
	lsl	r2, #14			// shift 14 positins to align with bits [14:15] in the rego of pull up/down
	bic	r0, r2			// clear the [14:15] with bitmask in r2
	orr	r0, r2			// set [14:15] to 1 1
	str	r0, [r1]		// mov back into reg
	
	
	bl	wait_150		// wait 150 cycles
	

_9_2:
	ldr	r0, [r1]		// get the reg0 of GPIO pull up/down, page 101, dude
	mov	r2, #0b1		//MODIFIED		
	lsl	r2, #14			// shift 14 positins to align with bits [14:15] in the rego of pull up/down
	bic	r0, r2			// clear the [14:15] with bitmask in r2
	str	r0, [r1]		// mov back into reg
	
_10:
	//10 - Enable receiving/ Transmitting
	ldr	r1, =AUX_MU_CNTL_REG	// get cntrl reg 
	ldr	r0, [r1]
	mov	r2, #0b11		// we need to modify bits [0:1] page 17 not 16. Lied to us like that...
	bic	r0, r2			
	orr	r0, r2			//yolo
	str	r0, [r1]





	pop	{lr}
	mov	pc, lr
	

wait_150:
	
	mov	r0, #151
	mov	r1, #0
cmp_150_loop:
	sub	r0, #1
	cmp	r1, r0
	bne	cmp_150_loop
	
	mov	pc, lr
