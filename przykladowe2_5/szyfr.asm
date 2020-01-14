.686
.model flat

public _szyfruj

.code

_szyfruj proc
	push	ebp
	mov		ebp, esp
	push	esi
	push	ebx

	mov		esi, [ebp+8]
	mov		eax, 52525252h

szyfruj:
	mov		dl, [esi]
	cmp		dl, 0
	je		koniec
	
	xor		dl, al
	mov		[esi], dl
	inc		esi
	
	mov		edx, eax
	shl		edx, 1
	shr		edx, 31
	shl		eax, 1
	adc		dl, 0
	bt		edx, 0
	adc		eax, 0
	jmp		szyfruj

koniec:
	pop		ebx
	pop		esi
	pop		ebp
	ret
_szyfruj endp
end