/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/
	.text
	.globl	_start 
_start:               
	cmp r4, r4
	beq 	_goto
	addeq r5, r5, #3
_goto:	cmp r4, r4
	b	_good
	b	_bad

_bad :
	add r0, r0, r0
_good :
	add r1, r1, r1
