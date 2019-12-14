.686
.model flat

extern __read : PROC
extern __write : PROC
extern _malloc : PROC

public _read_int32
public _print_int32
public _int32_to_str
public _printf_asm

.code

_read_int32 PROC
	push	ebp
	mov		ebp, esp
	push	esi
	push	ebx
	mov		ebx, [ebp+8]
	
	sub		esp, 10
	mov		esi, esp

	push	dword PTR 10
	push	esi
	push	dword PTR 0
	call	__read

	add		esp, 12

	mov		eax, 0
	mov		ebx, 10
pobieraj_znaki:
	mov		cl, [esi]
	inc		esi
	cmp		cl, 10
	je		koniec

	sub		cl, 30h
	movzx	ecx, cl
	mul		ebx
	add		eax, ecx
	jmp		pobieraj_znaki

koniec:
	mov		ebx, [ebp+8]
	mov		[ebx], eax
	add		esp, 10

	pop		ebx
	pop		esi
	pop		ebp
	ret
_read_int32 ENDP

_print_int32 PROC
	push	ebp
	mov		ebp, esp
	push	esi
	push	edi
	push	ebx
	
	mov		edi, esp
	mov		esi, esp
	sub		esp, 10
	
	mov		eax, [ebp+8]
	mov		ebx, 10
dziel:
	xor		edx, edx
	div		ebx
	add		dl, 30h
	mov		[edi], dl
	dec		edi
	cmp		eax, 0
	jne		dziel
	
	mov		eax, esi
	sub		eax, edi
	push	eax
	inc		edi
	push	edi
	push	dword PTR 1
	call	__write

	add		esp, 12

	add		esp, 10

	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret
_print_int32 ENDP

_int32_to_str PROC
	push	ebp
	mov		ebp, esp
	push	esi
	push	edi
	push	ebx
	
	mov		edi, esp
	mov		esi, esp
	sub		esp, 10
	
	mov		eax, [ebp+8]
	mov		ebx, 10
dziel:
	xor		edx, edx
	div		ebx
	add		dl, 30h
	mov		[edi], dl
	dec		edi
	cmp		eax, 0
	jne		dziel
	
	mov		eax, esi
	sub		eax, edi
	inc		eax
	mov		ebx, 4
	mul		ebx
	push	eax
	call	_malloc
	add		esp, 4
	mov		ecx, eax
	inc		edi
zapisuj:
	mov		bl, [edi]
	mov		[ecx], bl
	inc		edi
	inc		ecx
	cmp		edi, esi
	jle		zapisuj
	
	mov		[ecx], byte ptr 0

	add		esp, 10

	pop		ebx
	pop		edi
	pop		esi

	pop		ebp
	ret
_int32_to_str ENDP

_printf_asm PROC
	push	ebp
	mov		ebp, esp

	pop		ebp
	ret
_printf_asm ENDP
END