/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/
	.text
	.globl	_start 
_start:               
	mov r4, #8
	mov r7, #12
	add r5, r4, lsl #2
	cmp r7, r5
	b	_good
	b	_bad

_bad :
	add r0, r0, r0
	add r0, r0, r0
_good :
	add r1, r1, r1
	add r1, r1, r1
