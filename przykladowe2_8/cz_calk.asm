.686
.model flat

public _sprawdz_calk

.code
_sprawdz_calk proc
	push	ebp
	mov		ebp, esp

	mov		eax, 0
	mov		ebx, [ebp+8]

	;--------------------------------
	bsr		ecx, ebx
	cmp		ecx, 6
	jg		wpisz_1
	clc
	jmp		dalej
wpisz_1:
	stc
dalej:
	;--------------------------------

	adc		eax, 0	
	pop		ebp
	ret
_sprawdz_calk endp
end