public dodaj7_64

.code

dodaj7_64 PROC
	push	rbx					; przechowanie rejestrow
	push	rsi

	mov		rax, 0
	add		rax, rcx
	add		rax, rdx
	add		rax, r8
	add		rax, r9
	mov		rbx, [rbp+40]
	add		rax, rbx
	mov		rbx, [rbp+48]
	add		rax, rbx
	mov		rbx, [rbp+56]
	add		rax, rbx

	pop		rsi
	pop		rbx
	ret
dodaj7_64 ENDP
END