
/****************************************************************************************
 *                                                                                      *
 *  ----------------------------------------------------------------------------------  *
 *  |    0    |    1    |    2    |    3    |    4     |    5    |    6    |    7    |  *
 *  ----------------------------------------------------------------------------------  *
 *  |   0x0   |   0x8   |   0x10  |   0x18  |   0x20   |   0x28  |   0x30  |   0x38  |  *
 *  ----------------------------------------------------------------------------------  *
 *  |   x18   |   x19   |   x20   |   x21   |   x22    |   x23   |   x24   |   x25   |  *
 *  ----------------------------------------------------------------------------------  *
 *  ----------------------------------------------------------------------------------  *
 *  |    8    |    9    |   10    |   11    |    12    |    13   |    14   |    15   |  *
 *  ----------------------------------------------------------------------------------  *
 *  |   0x40  |   0x48  |   0x50  |  0x58   |   0x60   |   0x68  |   0x70  |   0x78  |  *
 *  ----------------------------------------------------------------------------------  *
 *  |   x26   |   x27   |   x28   |  x29    |    LR    |    SP   |   sp    |   size  |  *
 *  ----------------------------------------------------------------------------------  *
 *  ----------------------------------------------------------------------------------  *
 *  |    16   |         |         |         |          |         |         |         |  *
 *  ----------------------------------------------------------------------------------  *
 *  |   0x80  |         |         |         |          |         |         |         |  *
 *  ----------------------------------------------------------------------------------  *
 *  |   RIP   |         |         |         |          |         |         |         |  *
 *  ----------------------------------------------------------------------------------  *
 *                          															*
 * **************************************************************************************/



.text
.globl make_fcontext
.type make_fcontext,@function
.align 16
make_fcontext:
	mov x5, x0	
	sub x5, x5 , 0x88
	and x5, x5 , #-16

	str x0, [x5, 0x70]
	str x1, [x5, 0x78]
	str x2, [x5, 0x80]
	
	/*sub x6, x5, 0x10 */
	str x5, [x5, 0x68]

	mov x0, x5
	LDR x7, =finish
    str x7, [x5, 0x60]
	ret

finish:
	/* RSP points to same address as RSP on entry of context function + 0x8 */
	eor   x0,     x0,         x0       /* exit code is zero */
	bl     exit                   /* exit application */
/*	bl     exit@plt                   /* exit application */
	/*hlt */


.size make_fcontext,.-make_fcontext

