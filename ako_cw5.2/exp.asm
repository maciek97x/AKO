.686
.model flat

public _nowy_exp

.code

_nowy_exp proc
	push	ebp
	mov		ebp, esp

	finit
	
	mov		ecx, 19
	
	fld1
	fld1
	fld1
	fld1
	fld dword PTR [ebp+8]
	fld1
	; stos -> (0) = 1 (1) = x (2) = 1 (3) = 1 (4) = 1 (5) = 1
ptl:
	; plan -> (0) = x^n/n! (1) = x (2) = x^n (3) = n (4) = n! (5) = 1+x/1+x^2/2!...
	fld		st(1)
	fmulp	st(3), st(0)
	fld		st(3)
	fmulp	st(5), st(0)
	fadd	st(3), st(0)
	fmul	st(0), st(2)
	fdiv	st(0), st(4)
	faddp	st(5), st(0)
	fld1
	loop	ptl

	mov		ecx, 5
ptl_2:
	fstp st(0)
	loop ptl_2

	pop		ebp
	ret
_nowy_exp endp
end