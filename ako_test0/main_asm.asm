.686
.model flat

public _mul_mat_asm

.code

_mul_mat_asm PROC
	push	ebp							; zapisanie zawartosci ebp na stosie
	mov		ebp, esp					; kopiowanie zawartosci esp do ebp
	push	esi
	push	edi
	push	ecx

	; n [ebp+8]
	; A* [ebp+12]
	; B* [ebp+16]
	; C* [ebp+20]

	sub		esp, 8
	mov		[esp], dword ptr 0
	mov		[esp+4], dword ptr 0

dalej:
	mov		esi, [ebp+12]
	mov		edi, [ebp+16]
	mov		ebx, [ebp+20]

	mov		ecx, [esp]
	cmp		ecx, 0
	jz skip_ptl_i
	mov		eax, [ebp+8]
	mov		edx, 4
	mul		edx
ptl_i:
	add		esi, eax
	add		ebx, eax
	loop ptl_i
skip_ptl_i:

	mov		ecx, [esp+4]
	cmp		ecx, 0
	jz skip_ptl_j
ptl_j:
	add		edi, 4
	add		ebx, 4
	loop ptl_j
skip_ptl_j:

	mov		[ebx], word ptr 0
	mov		ecx, [ebp+8]
ptl:
	mov		eax, [esi]
	mov		edx, [edi]
	mul		edx
	mov		edx, [ebx]
	add		edx, eax
	mov		[ebx], edx

	add		esi, 4
	mov		eax, [ebp+8]
	mov		edx, 4
	mul		edx
	add		edi, eax

	loop ptl
	

kol_kolumna:
	mov		eax, [esp]
	inc		eax
	cmp		eax, [ebp+8]
	jge		kol_wiersz
	mov		[esp], eax
	jmp		dalej
	
kol_wiersz:
	mov		[esp], dword ptr 0
	mov		eax, [esp+4]
	inc		eax
	cmp		eax, [ebp+8]
	jge		koniec
	mov		[esp+4], eax
	jmp		dalej
	
	

koniec:
	add		esp, 8
	pop		ecx
	pop		edi
	pop		esi
	pop		ebp
	ret
_mul_mat_asm ENDP
END