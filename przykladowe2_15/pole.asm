.686
.model flat

public _pole_kola

.code
_pole_kola proc
	push	ebp
	mov		ebp, esp
	
	mov		eax, [ebp+8]
	push	eax
	finit
	fld		dword ptr [eax]
	fld		st(0)
	fmulp
	fldpi
	fmulp
	fstp	dword ptr [eax]

	add		esp, 4
	
	pop		ebp
	ret
_pole_kola endp
end