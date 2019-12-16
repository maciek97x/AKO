.686
.model flat

extern __read : PROC
extern __write : PROC
extern _malloc : PROC

public _read_int32
public _print_int32
public _print_str
public _print_chr
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

_print_str PROC
	push	ebp
	mov		ebp, esp
	push	edi
	push	esi

	mov		esi, [ebp+8]
	mov		edi, esi

licz_znaki:
	mov		bl, [esi]
	inc		esi
	cmp		bl, 0
	jne		licz_znaki
	
	mov		eax, esi
	sub		eax, edi
	push	eax
	push	edi
	push	dword PTR 1
	call	__write
	add		esp, 12

	pop		esi
	pop		edi
	pop		ebp
	ret
_print_str ENDP

_print_chr PROC
	push	ebp
	mov		ebp, esp
	
	mov		eax, ebp
	add		eax, 8
	push	dword PTR 1
	push	eax
	push	dword PTR 1
	call	__write
	add		esp, 12

	pop		ebp
	ret
_print_chr ENDP

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
	push	esi
	push	edi
	push	ebx

	mov		esi, [ebp+8]
	mov		edi, ebp
	add		edi, 12

ptl:
	mov		bl, [esi]
	cmp		bl, 25h						; 25h - ascii %
	je		jest_procent
	cmp		bl, 0
	je		koniec
	
	push	dword PTR 1
	push	esi
	push	dword PTR 1
	call	__write
	add		esp, 12

	inc		esi
	jmp		ptl
	
jest_procent:
	inc		esi
	mov		bl, [esi]
	cmp		bl, 64h						;64h - ascii d
	je		liczba
	cmp		bl, 73h						;73h - ascii s
	je		string
	cmp		bl, 63h						;63h - ascii c
	je		char
	jmp		ptl

liczba:
	push	[edi]
	call	_print_int32
	add		esp, 4
	add		edi, 4
	inc		esi
	jmp		ptl

string:
	push	[edi]
	call	_print_str
	add		esp, 4
	add		edi, 4
	inc		esi
	jmp		ptl

char:
	push	[edi]
	call	_print_chr
	add		esp, 4
	add		edi, 4
	inc		esi
	jmp		ptl

koniec:
	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret
_printf_asm ENDP
END