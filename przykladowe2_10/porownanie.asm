.686
.model flat

public _porownaj

.code

_porownaj proc
	push	ebp
	mov		ebp, esp
	push	edi
	push	esi

	mov		esi, [ebp+8]
	mov		edi, [ebp+12]
	mov		eax, 0
	;--------------------------------
	bt		edi, 31
	jc		edi_wieksza
	shl		edi, 1
	cmp		edi, esi
	jb		esi_wieksza
	shr		edi, 1
	jmp		edi_wieksza

esi_wieksza:
	shr		edi, 1
	stc
	jmp		koniec

edi_wieksza:
	clc

koniec:
	;--------------------------------
	adc		eax, 0
	
	pop		esi
	pop		edi
	pop		ebp
	ret
_porownaj endp
end