.686
.model flat

public _odejmij_jeden

.code

_odejmij_jeden PROC
	push	ebp
	mov		ebp, esp

	mov		ebx, [ebp+8]
	mov		ebx, [ebx]
	mov		eax, [ebx]
	dec		eax
	mov		[ebx], eax	

	pop		ebp
	ret
_odejmij_jeden ENDP
END