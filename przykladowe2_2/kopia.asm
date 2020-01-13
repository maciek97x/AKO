.686
.model flat

extern _malloc : proc

public _kopia_tablicy

.code

_kopia_tablicy proc
	push	ebp
	mov		ebp, esp
	push	ebx
	push	esi
	push	edi

	mov		esi, [ebp+8]
	mov		ecx, [ebp+12]

	shl		ecx, 5
	push	ecx
	call	_malloc
	pop		ecx
	mov		edi, eax
	shr		ecx, 5

wpisuj:
	mov		edx, [esi]
	bt		edx, 0
	jnc		wpisz_0
	mov		[edi], edx
	jmp		dalej
wpisz_0:
	mov		[edi], dword ptr 0
dalej:
	add		esi, 4	
	add		edi, 4	
	loop	wpisuj

	pop		edi
	pop		esi
	pop		ebx
	pop		ebp
	ret
_kopia_tablicy endp
end