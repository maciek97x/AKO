.686
.model flat

public _szukaj_max

.code

_szukaj_max	PROC
	push	ebp							; zapisanie zawartosci ebp na stosie
	mov		ebp, esp					; kopiowanie zawartosci esp do ebp

	mov		eax, [ebp+8]				; liczba x
	cmp		eax, [ebp+12]				; porowanie x i y
	jge		x_wieksza					; skok gdy x >= y
; x < y
	mov		eax, [ebp+12]				; y
	cmp		eax, [ebp+16]				; porownanie y i z
	jge		y_wieksza					; skok gdy y >= z

; y < z (z najwieksza)
wpisz_z:
	mov		eax, [ebp+16]					; z

zakoncz:
	pop		ebp
	ret

x_wieksza:
	cmp		eax, [ebp+16]				; porownanie x i z
	jge		zakoncz						; skok, gdy x >= z
	jmp		wpisz_z

y_wieksza:
	mov		eax, [ebp+12]				; y
	jmp		zakoncz

_szukaj_max ENDP
END