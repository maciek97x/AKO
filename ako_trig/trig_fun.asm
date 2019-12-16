.686
.model flat

public _pi
public _sin
public _cos
public _tan
public _cot
public _atan
public _asin
public _acos
public _acot

.code
_pi proc
	fldpi
	ret
_pi endp

_sin proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	fsin

	pop		ebp
	ret
_sin endp

_cos proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	fcos

	pop		ebp
	ret
_cos endp

_tan proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	;fld		st(0)
	;fsin
	;fxch
	;fcos
	;fdivp
	fptan
	fstp	st(0)

	pop		ebp
	ret
_tan endp

_cot proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	fld		st(0)
	fcos
	fxch
	fsin
	fdivp

	pop		ebp
	ret
_cot endp

_atan proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	fld1
	fpatan

	pop		ebp
	ret
_atan endp

_asin proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	fld1
	fld		st(1)
	fld		st(0)
	; stos -> (0) = x (1) = x (2) = 1 (3) = x
	fmulp
	; stos -> (0) = x^2 (1) = 1 (2) = x
	fsubp
	; stos -> (0) = 1 - x^2 (1) = x
	fsqrt
	; stos -> (0) = sqrt(1 - x^2) (1) = x
	fdivp
	; stos -> (0) = x/sqrt(1 - x^2)
	fld1
	fpatan
	; stos -> (0) = atan(x/sqrt(1 - x^2))

	pop		ebp
	ret
_asin endp

_acos proc
	push	ebp
	mov		ebp, esp

	fld1
	fld		dword PTR [ebp+8]
	fld		st(0)
	; stos -> (0) = x (1) = x (2) = 1
	fmulp
	; stos -> (0) = x^2 (1) = 1
	fsubp
	; stos -> (0) = 1 - x^2
	fsqrt
	; stos -> (0) = sqrt(1 - x^2)
	fld		dword PTR [ebp+8]
	; stos -> (0) = x (1) = sqrt(1 - x^2)
	fdivp
	; stos -> (0) = sqrt(1 - x^2)/x
	fld1
	fpatan
	; stos -> (0) = atan(x/sqrt(1 - x^2))
	; dla x < 0 trzeba dodac pi do wyniku
	; ladujemy x i 0, a nastepnie porowujemy
	fld		dword PTR [ebp+8]
	fldz
	fcomi	st(0), st(1)
	; jak nie trzeba dodawac pi to usuwamy x i 0 ze stosu
	jbe		usun
	
	; w przeciwnym razie usuwamy x i 0 ze stosu, ladujemy pi
	; i dodajemy do wyniku
	fstp	st(0)
	fstp	st(0)
	fldpi
	faddp
	jmp		koniec

usun:
	fstp	st(0)
	fstp	st(0)
koniec:

	pop		ebp
	ret
_acos endp

_acot proc
	push	ebp
	mov		ebp, esp

	fld		dword PTR [ebp+8]
	fld1
	fpatan
	; stos -> (0) = atan(x)
	fchs
	; stos -> (0) = -atan(x)
	fldpi
	; stos -> (0) = pi (1) = -atan(x)
	fld1
	fld1
	faddp
	; stos -> (0) = 2 (1) = pi (2) = -atan(x)
	fdivp
	; stos -> (0) = pi/2 (1) = -atan(x)
	faddp
	; stos -> (0) = pi/2 - atan(x)

	pop		ebp
	ret
_acot endp
end