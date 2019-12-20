.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.data

linie	dd 421, 422, 443
		dd 442, 444, 427, 432

.code

_main PROC
	;xor		eax, eax
	;sub		eax, 0FFFFFFFFh
	
	;mov		ax, 1
	;add		ax, 0FFFFh

	mov		eax, 02F43253h	
	mov		ebx, 12332434h
	mov		edx, 83223151h

	shl		eax, 1
	rcl		ebx, 1
	rcl		edx, 1
	jnc		koniec
	bts		eax, 0
koniec:
	nop

	mov		eax, 02F43253h	
	mov		ebx, 12332434h
	mov		edx, 83223151h

	bt		edx, 31
	rcl		eax, 1
	rcl		ebx, 1
	rcl		edx, 1
	nop

	rol		edx, 16

	mov		cl, 0
	mov		edx, 0
	mov		ebx, 2
ptl:
	div		ebx
	cmp		edx, 0
	je		jest_zero
	inc		cl
jest_zero:
	mov		edx, 0
	cmp		eax, 0
	jne		ptl
	nop


	mov		esi, (OFFSET linie)+4
	mov		ebx, 4
	mov		edx, [ebx] [esi]

	mov		cl, 0
	mov		ebx, 10
ptl2:
	cmp		eax, 0
	je		koniec2
	mov		edx, 0
	div		ebx
	add		cl, dl
	jmp		ptl2
koniec2:
	push	0
	call	_ExitProcess@4
_main ENDP

END