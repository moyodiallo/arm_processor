/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/
	.text
	.globl	_start 
_start:               
	mov r5, #3
	cmp r5, r5
	b	_good
	b	_bad

_bad :
	add r0, r0, r0
_good :
	add r1, r1, r1
