.686
.model flat
public _liczba_przeciwna
.code

_liczba_przeciwna PROC
	push	ebp
	mov		ebp, esp
	
	mov		ebx, [ebp+8]
	mov		eax, 0
	sub		eax, [ebx]
	mov		[ebx], eax

	pop		ebp
	ret
_liczba_przeciwna ENDP
END