/*
*	Assignment 3 - ARM, miniUART interface.
*	Authors: Ragheeb Barheyan, Nik Ryzhenkov
*	
*/

.section    .init
.globl     _start


_start:
    b       main
    


.section .text




main:
    mov     sp, #0x8000
	
	bl		EnableJTAG





//------------------------------


	bl	SNESinit
	bl	InitFrameBuffer
	ldr	r6, [r0,#32]
	mov	r7, r0

restart:
	bl	NewGame				
	
	bl	menuScreen
	

	cmp	r12, #1
	bne	restart
	


//-------------------------------------------------------------------------------------------------

	mov	r2, #1			// debugging


// ------------------------------------------------------------------------
	

haltLoop$:
	b		haltLoop$


.section .data

//------------------------------------------------
	
/*general use input buffer*/
buff:
	.rep	256
	.byte	0x0
	.endr	
_unknown_command:
	.asciz "Unknown Command \r\n>>>"
breakout:
	.asciz"breakout" 				// 8 characters long