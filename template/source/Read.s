.section .text
.global _Read

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


_Read:
	push	{lr}
	ldr	r1, =AUX_MU_LSR_REG
	
r_wait:
	ldr	r0, [r1]		
	
	tst	r0, #0b1
	
	beq	r_wait			// wait until it's set

	ldr	r1, =AUX_MU_IO_REG	// gettin the input
	ldr	r0, [r1]		// loading the input

	pop	{lr}

	mov	pc, lr






