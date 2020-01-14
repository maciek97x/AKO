.686
.model flat

public _kwadrat

.code

_kwadrat proc
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	
	mov		eax, [ebp+8]
	mov		ebx, 0
	bt		eax, 0
	adc		ebx, 0
	mov		esi, ebx

licz:
	cmp		ebx, eax
	je		koniec
	add		ebx, 2
	mov		ecx, ebx
	dec		ecx
	add		ecx, ecx
	add		ecx, ecx
	add		esi, ecx
	jmp		licz

koniec:
	mov		eax, esi

	pop		esi
	pop		ebx
	pop		ebp
	ret
_kwadrat endp
end