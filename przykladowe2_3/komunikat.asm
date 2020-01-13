.686
.model flat

extern _malloc : proc

.code 

_komunikat proc
	push	ebp
	mov		ebp, esp
	push	esi
	push	edi
	push	ebx

	mov		esi, [ebp+8]

	mov		ecx, 0
	mov		edi, esi

licz_znaki:
	mov		bl, [edi]
	cmp		bl, 0
	je		koniec
	inc		edi
	inc		ecx
	jmp		licz_znaki
koniec:

	add		ecx, 6
	push	ecx
	call	_malloc
	pop		ecx
	sub		ecx, 6
	mov		edi, eax

przepisz_znaki:
	mov		dl, [esi]
	mov		[edi], dl
	inc		esi
	inc		edi
	loop	przepisz_znaki

	mov		[edi], byte ptr 'B'
	inc		edi
	mov		[edi], byte ptr 'l'
	inc		edi
	mov		[edi], byte ptr 'a'
	inc		edi
	mov		[edi], byte ptr 'd'
	inc		edi
	mov		[edi], byte ptr '.'
	inc		edi
	mov		[edi], byte ptr 0

	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret
_komunikat endp
end