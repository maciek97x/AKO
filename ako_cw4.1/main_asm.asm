.686
.model flat

public _szukaj4_max

.code

_szukaj4_max	PROC
	push	ebp							; zapisanie zawartosci ebp na stosie
	mov		ebp, esp					; kopiowanie zawartosci esp do ebp

	mov		eax, [ebp+8]				; liczba x
	cmp		eax, [ebp+12]
	jg		por_z
	mov		eax, [ebp+12]
por_z:
	cmp		eax, [ebp+16]
	jg		por_t
	mov		eax, [ebp+16]
por_t:
	cmp		eax, [ebp+20]
	jg		zakoncz
	mov		eax, [ebp+20]
	
zakoncz:
	pop		ebp
	ret

_szukaj4_max ENDP
END