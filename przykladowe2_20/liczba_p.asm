.686
.model flat

extern _GetSystemInfo@4 : proc

public _liczba_procesorow

.code
_liczba_procesorow proc
	push	ebp
	mov		ebp, esp

	sub		esp, 36
	push	esp
	call	_GetSystemInfo@4
	mov		eax, [esp+20]
	add		esp, 36

	pop		ebp
	ret
_liczba_procesorow endp
end