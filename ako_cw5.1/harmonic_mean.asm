.686
.model flat

public _srednia_harm

.code
_srednia_harm proc
	push	ebp
	mov		ebp, esp
	push	esi	

	finit
	
	mov		esi, [ebp+8]
	mov		ecx, [ebp+12]
	fldz
	; stos -> (0) = 0
ptl:
	fld1
	; stos -> (0) = 1 (1) = 0(lub poprzedni wynik)
	lea		eax, [esi+4*ecx - 4]
	fld		dword PTR [eax]
	; stos -> (0) = a_n (1) = 1 (2) = 0(lub poprzedni wynik)
	fdivp	st(1), st(0)
	; stos -> (0) = 1/a_n (1) = 0(lub poprzedni wynik)
	faddp	st(1), st(0)
	; stos -> (0) = 1/a_n + 0(lub poprzedni wynik)
	loop	ptl
	
	; stos -> (0) = suma
	fild	dword PTR [ebp+12]
	; stos -> (0) = n (1) = suma
	fxch
	; stos -> (0) = suma (1) = n
	fdivp	st(1), st(0)
	; stos -> (0) = n/suma
	
	pop		esi
	pop		ebp
	ret
_srednia_harm endp
end