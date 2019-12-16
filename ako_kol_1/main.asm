.686
.model flat

extern _MessageBoxA@16 : proc
extern _ExitProcess@4 : proc

public _main

.data
tekst	dw 'ar', 'ch', 'it', 'ek', 'tu', 'ra', 0

.code
_main PROC
	push	0
	push	OFFSET tekst
	lea		eax, dword ptr [tekst+6]
	push	eax
	push	0
	call	_MessageBoxA@16
	add		esp, 20

	mov		esi, OFFSET tekst
zamiana:
	mov		ax, [esi]
	xchg	al, ah
	mov		[esi], ax
	add		esi, 2
	cmp		ax, 0
	jne		zamiana

	push	0
	push	OFFSET tekst
	lea		eax, dword ptr [tekst+6]
	push	eax
	push	0
	call	_MessageBoxA@16
	add		esp, 20

	push	0
	call	_ExitProcess@4
_main ENDP
END