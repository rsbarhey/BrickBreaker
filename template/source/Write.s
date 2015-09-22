.section .text
.globl _Write

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


_Write:
	ldr	r1, =AUX_MU_LSR_REG
while:
	ldr 	r2, [r1]
	tst	r2, #0b00100000		// 0x20
	beq	while			// the loop test if they are equal. WIll branch only when they are NOT equal aka when bit 5 is not set.
	//mov	r0, #1			// hardcoding a 1 in r0
	ldr	r1, =AUX_MU_IO_REG
	str	r0, [r1]
	//mov	r0, #1			//debugging line
	




	mov	pc, lr
