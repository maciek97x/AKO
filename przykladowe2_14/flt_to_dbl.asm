.686
.model flat

public _float_to_double

.code

_float_to_double proc
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi	
	push	edi	

	mov		esi, [ebp+8]
	mov		edi, [ebp+12]
	;--------------------------------
	mov		eax, [esi]
	mov		ebx, eax
	shl		ebx, 1
	shr		ebx, 24
	add		ebx, 1023
	sub		ebx, 127
	shl		ebx, 20
	mov		ecx, eax
	shr		ecx, 3
	and		ecx, 0FFFFFh
	rol		ecx, 1
	bt		eax, 31
	rcr		ecx, 1
	or		ecx, ebx
	mov		[edi+4], ecx
	mov		ebx, eax
	shl		ebx, 29
	mov		[edi], ebx
	;--------------------------------
	pop		edi
	pop		esi
	pop		ebx
	pop		ebp
	ret
_float_to_double endp
end