.686
.model flat

public _iteracja

.code

_iteracja proc
	push	ebp
	mov		ebp, esp
	mov		al, [ebp+8]
	sal		al, 1
	
	jc		zakoncz
	inc		al
	push	eax
	call	_iteracja
	add		esp, 4
	pop		ebp
	ret

zakoncz:
	rcr		al, 1
	pop		ebp
	ret
_iteracja endp
end