.686
.model flat

extern _malloc : proc

public _szukaj_elem_min

.code

_szukaj_elem_min proc
	push	ebp
	mov		ebp, esp
	push	esi
	push	ebx

	mov		esi, [ebp+8]
	mov		ecx, [ebp+12]

	mov		ebx, [esi]
	mov		eax, esi
	add		esi, 4
	dec		ecx
szukaj:
	mov		edx, [esi]
	cmp		edx, ebx
	jge		nie_mniejszy

	mov		eax, esi
	mov		ebx, [esi]
nie_mniejszy:
	add		esi, 4
	loop	szukaj

	pop		ebx
	pop		esi
	pop		ebp
	ret
_szukaj_elem_min endp
end