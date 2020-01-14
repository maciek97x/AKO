.686
.model flat

public _zaokr_do_calk

.code

_zaokr_do_calk proc
	push	ebp
	mov		ebp, esp

	mov		edx, [ebp+8]
	;--------------------------------
	bt		edx, 31
	jc		ujemna
	shr		edx, 7
	adc		edx, 0
	shl		edx, 7
	jmp		koniec
ujemna:
	neg		edx
	shr		edx, 7
	adc		edx, 0
	shl		edx, 7
	neg		edx
koniec:
	;--------------------------------
	mov		eax, edx

	pop		ebp
	ret
_zaokr_do_calk endp
end